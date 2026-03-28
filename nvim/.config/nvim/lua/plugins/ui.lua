return {
    "ThePrimeagen/vim-be-good",
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
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
