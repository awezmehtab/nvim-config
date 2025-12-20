-- Hopefully has all the small plugins
return {
    {
        "folke/which-key.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter'
        opts = {
            -- delay between pressing a key and opening which-key (milliseconds)
            -- this setting is independent of vim.opt.timeoutlen
            delay = 0,
            triggers = {
                { "auto", mode = "nixsotc" },
                -- { "<leader>a", mode = { "n", "v" } }
            },
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = vim.g.have_nerd_font,
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    Up = "<Up> ",
                    Down = "<Down> ",
                    Left = "<Left> ",
                    Right = "<Right> ",
                    C = "<C-…> ",
                    M = "<M-…> ",
                    D = "<D-…> ",
                    S = "<S-…> ",
                    CR = "<CR> ",
                    Esc = "<Esc> ",
                    ScrollWheelDown = "<ScrollWheelDown> ",
                    ScrollWheelUp = "<ScrollWheelUp> ",
                    NL = "<NL> ",
                    BS = "<BS> ",
                    Space = "<Space> ",
                    Tab = "<Tab> ",
                    F1 = "<F1>",
                    F2 = "<F2>",
                    F3 = "<F3>",
                    F4 = "<F4>",
                    F5 = "<F5>",
                    F6 = "<F6>",
                    F7 = "<F7>",
                    F8 = "<F8>",
                    F9 = "<F9>",
                    F10 = "<F10>",
                    F11 = "<F11>",
                    F12 = "<F12>",
                },
            },
        },
    },

    -- Highlight todo, notes, etc in comments
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },


    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
        priority = 1000,
        enabled = true,
    },

    {
        "jiaoshijie/undotree",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        keys = { -- load the plugin only when using it's keybinding:
            { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
        },
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            vim.defer_fn(function()
                vim.cmd("ColorizerAttachToBuffer")
            end, 0)

            vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
                callback = function()
                    vim.cmd("ColorizerAttachToBuffer")
                end,
            })
        end,
    },

    {
        "skardyy/neo-img",
        build = ":NeoImg Install",
        config = function()
            require("neo-img").setup()
        end,
    },

    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    {
        "j-hui/fidget.nvim",
        opts = {
            -- Options related to LSP progress subsystem
            progress = {
                display = {
                    done_icon = "✔", -- Icon shown when all LSP tasks are complete
                    progress_icon = { "dots" }, -- Animation style
                },
            },
            -- Options related to notification subsystem
            notification = {
                window = {
                    winblend = 0, -- Background color opacity (0 = opaque)
                },
            },
        },
    }
}
