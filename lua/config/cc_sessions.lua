local M = {}

local function human_size(bytes)
    if bytes >= 1e6 then
        return string.format("%.1fM", bytes / 1e6)
    end
    return string.format("%dK", math.ceil(bytes / 1e3))
end

-- The session's working directory, from the first record that has one.
local function session_cwd(path)
    local f = io.open(path, "r")
    if not f then
        return nil
    end
    local cwd, count = nil, 0
    for line in f:lines() do
        count = count + 1
        local ok, d = pcall(vim.json.decode, line)
        if ok and type(d) == "table" and type(d.cwd) == "string" then
            cwd = d.cwd
            break
        end
        if count >= 3000 then break end
    end
    f:close()
    return cwd
end

local function sidecar_title(path)
    local f = io.open(path:sub(1, -7) .. "/custom-title.json", "r")
    if not f then
        return nil
    end
    local ok, d = pcall(vim.json.decode, f:read("*a"))
    f:close()
    return ok and type(d) == "table" and d.customTitle or nil
end

local function session_title(path)
    local sidecar = sidecar_title(path)
    if sidecar then
        return sidecar
    end
    local f = io.open(path, "rb")
    if not f then
        return nil
    end
    local size = f:seek("end")
    f:seek("set", math.max(0, size - 65536))
    local chunk = f:read("*a")
    f:close()
    local ai, custom
    for key, val in chunk:gmatch('"(%a+Title)":"([^"]*)"') do
        if key == "aiTitle" then
            ai = val
        elseif key == "customTitle" then
            custom = val
        end
    end
    return custom or ai
end

local function config_dir()
    return vim.env.CLAUDE_CONFIG_DIR or vim.fs.normalize("~/.claude")
end

local function scan_sessions()
    local proj_dir = config_dir() .. "/projects"
    local sessions = {}
    for name in vim.fs.dir(proj_dir) do
        local dir = proj_dir .. "/" .. name
        for fname, ftype in vim.fs.dir(dir) do
            if ftype == "file" and fname:match("%.jsonl$") then
                local path = dir .. "/" .. fname
                local stat = vim.uv.fs_stat(path)
                if stat then
                    table.insert(sessions, {
                        id = fname:sub(1, -7),
                        path = path,
                        mtime = stat.mtime.sec,
                        size = stat.size,
                    })
                end
            end
        end
    end
    table.sort(sessions, function(a, b)
        return a.mtime > b.mtime
    end)
    return sessions
end

local function open_claude(dir, args)
    vim.cmd("tabnew")
    vim.cmd("term cd " .. vim.fn.shellescape(dir) .. " && claude " .. args)
    vim.t.tabname = "cc"
    vim.cmd.redrawtabline()
end

local function rename(s)
    local name = vim.fn.input("Rename session: ")
    if name == "" then
        return
    end
    vim.system(
        { "claude", "-p", "/rename " .. name, "--resume", s.id },
        { cwd = s.cwd }
    ):wait()
end

local function delete(s)
    local msg = "Delete session " .. s.id:sub(1, 8) .. "?"
    if vim.fn.confirm(msg, "&Yes\n&No", 2) ~= 1 then
        return
    end
    vim.system(
        { config_dir() .. "/scripts/delete-session.sh", s.id, s.cwd, "--yes" }
    ):wait()
end

local function create_in(dir)
    dir = vim.fn.fnamemodify(vim.fn.expand(dir), ":p")
    if vim.fn.isdirectory(dir) == 0 then
        if vim.fn.confirm("Create " .. dir .. "?", "&Yes\n&No", 2) ~= 1 then
            return M.pick()
        end
        vim.fn.mkdir(dir, "p")
    end
    vim.ui.input({ prompt = "Session name: " }, function(name)
        local args = name and name ~= "" and "-n " .. vim.fn.shellescape(name)
            or ""
        open_claude(dir, args)
    end)
end

local function create()
    local cwd = vim.fn.getcwd()
    local cmd = "echo " .. vim.fn.shellescape(cwd)
        .. "; fd -t d --hidden --max-depth 4 . "
        .. vim.fn.shellescape(vim.env.HOME)
    require("fzf-lua").fzf_exec(cmd, {
        prompt = "Directory> ",
        actions = {
            ["default"] = function(selected, opts)
                local dir = selected[1] or opts.last_query
                if not dir or dir == "" then
                    return M.pick()
                end
                create_in(dir)
            end,
        },
    })
end

function M.pick()
    local by_line = {}
    local function contents(cb)
        by_line = {}
        for _, s in ipairs(scan_sessions()) do
            local cwd = session_cwd(s.path)
            if cwd then
                s.cwd = cwd
                local line = string.format(
                    "%s  %6s  %-28s %s  [%s]",
                    os.date("%m-%d %H:%M", s.mtime),
                    human_size(s.size),
                    vim.fn.fnamemodify(cwd, ":~"),
                    session_title(s.path) or "(untitled)",
                    s.id:sub(1, 8)
                )
                by_line[line] = s
                cb(line)
            end
        end
        cb(nil)
    end

    local function on_session(fn)
        return function(selected)
            local s = by_line[selected[1]]
            if s then
                fn(s)
            end
        end
    end

    require("fzf-lua").fzf_exec(contents, {
        prompt = "Claude sessions> ",
        actions = {
            ["default"] = on_session(function(s)
                open_claude(s.cwd, "--resume " .. vim.fn.shellescape(s.id))
            end),
            ["ctrl-r"] = { fn = on_session(rename), reload = true },
            ["ctrl-x"] = { fn = on_session(delete), reload = true },
            ["ctrl-n"] = function()
                if _G.fzf_lua_stopinsert_hack then
                    return _G.fzf_lua_stopinsert_hack(create)
                end
                create()
            end,
        },
    })
end

return M
