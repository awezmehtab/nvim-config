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
        if count >= 3000 then
            break
        end
    end
    f:close()
    return cwd
end

local function session_title(path)
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

local function scan_sessions()
    local base = vim.env.CLAUDE_CONFIG_DIR
    if not base then
        vim.notify("CLAUDE_CONFIG_DIR is not set", vim.log.levels.ERROR)
        return {}
    end
    local proj_dir = base .. "/projects"
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

function M.pick()
    local lines, by_line = {}, {}
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
            table.insert(lines, line)
            by_line[line] = s
        end
    end

    require("fzf-lua").fzf_exec(lines, {
        prompt = "Claude sessions> ",
        actions = {
            ["default"] = function(selected)
                local s = by_line[selected[1]]
                if not s then
                    return
                end
                vim.cmd("tabnew")
                vim.cmd(
                    "term cd "
                        .. vim.fn.shellescape(s.cwd)
                        .. " && claude --resume "
                        .. vim.fn.shellescape(s.id)
                )
                vim.t.tabname = "claude"
                vim.cmd.redrawtabline()
                vim.cmd("startinsert")
            end,
        },
    })
end

return M
