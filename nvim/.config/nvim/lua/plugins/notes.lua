return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons", 'nvim-mini/mini.nvim', 'nvim-mini/mini.icons' },
        ft = { "markdown" },
        opts = {
            enabled = true,
            render_modes = { "n", "c", "t", "i" },
            win_config = {
                concealcursor = "nc",
            },
            latex = {
                enabled = true,
                converter = 'utftex',
            },
            html = { enabled = false },
            yaml = { enabled = false },
            win_options = {
                conceallevel = { default = vim.o.conceallevel, rendered = 2 },
            },
        },
    },
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            default = {
                dir_path = "assets",
            },
        },
        keys = {
            { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image" },
        },
    },
    {
        "dhruvasagar/vim-table-mode",
        ft = { "markdown", "org" },
        cmd = "TableModeToggle",
        keys = {
            { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle Table Mode" },
        },
    },
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_syntax_enabled = 0
            vim.g.vimtex_view_method = "skim"
            vim.g.vimtex_compiler_latexmk = {
                out_dir = 'build',
            }
        end
    },
}
