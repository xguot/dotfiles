return {
    "ThePrimeagen/vim-be-good",
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        "EdenEast/nightfox.nvim",
        name = "nightfox",
        priority = 1000,
        config = function()
            require("nightfox").setup({ options = { transparent = true } })
            vim.cmd.colorscheme("nordfox")
        end,
    },
    {
        "hiphish/rainbow-delimiters.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local hooks = require("ibl.hooks")
            local highlight = {
                "NordDeepBlue", "NordMediumBlue", "NordFrostBlue",
                "NordCyan", "NordLightBlue",
            }

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "NordDeepBlue", { fg = "#5e81ac" })
                vim.api.nvim_set_hl(0, "NordMediumBlue", { fg = "#81a1c1" })
                vim.api.nvim_set_hl(0, "NordFrostBlue", { fg = "#88c0d0" })
                vim.api.nvim_set_hl(0, "NordCyan", { fg = "#8fbcbb" })
                vim.api.nvim_set_hl(0, "NordLightBlue", { fg = "#a3be8c" })
            end)

            require("ibl").setup({
                indent = { char = "┆", highlight = highlight },
                scope = { enabled = false },
            })
        end,
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
        config = function()
            require('dashboard').setup({
                theme = 'hyper',
                disable_move = false,
                shortcut_type = 'letter',
                shuffle_letter = false,
                change_to_vcs_root = false,
                hide = {
                    statusline = true,
                    tabline = true,
                    winbar = true,
                },
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                        { desc = ' Config', group = '@property', action = 'edit $MYVIMRC', key = 'c' },
                    },
                    packages = { enable = true },
                    project = { enable = true, limit = 8, action = 'Telescope find_files cwd=' },
                    mru = { enable = true, limit = 10, cwd_only = false },
                    footer = {},
                }
            })
        end,
    },
}
