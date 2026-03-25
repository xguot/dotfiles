return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        keys = {
            { "<leader>ff", function() require("telescope.builtin").find_files({ hidden = true }) end, desc = "Find Files" },
            {
                "<leader>fs",
                function()
                    require("telescope.builtin").live_grep({
                        additional_args = function()
                            return {
                                "--hidden" }
                        end
                    })
                end,
                desc = "Live Grep"
            },
            { "<leader>fc", function() require("telescope.builtin").git_commits() end,                 desc = "Git Commits" },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    fzf = {}
                }
            })
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "c", "lua", "vim", "vimdoc", "python", "ruby",
                    "svelte", "typescript", "javascript",
                    "html", "css", "go", "gomod", "markdown", "markdown_inline",
                    "swift", "latex", "tsx"
                },
                sync_install = false,
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                keymaps = {
                    ["<C-h>"] = false,
                    ["<C-l>"] = false,
                    ["<C-k>"] = false,
                    ["<C-j>"] = false,
                    ["<leader>pf"] = false,
                    ["<leader>pg"] = false,
                    ["<leader>ps"] = false,
                },
                columns = { "icon", "permissions", "size" },
                view_options = { show_hidden = true, natural_order = true },
                float = { padding = 2, border = "rounded" },
            })

            vim.api.nvim_create_autocmd("BufEnter", {
                callback = function()
                    if vim.bo.filetype ~= "" and vim.bo.filetype ~= "oil" then
                        pcall(vim.treesitter.start)
                    end
                end,
            })
        end,
    },
    {
        "mbbill/undotree",
        keys = { { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle UndoTree" } },
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Gvdiffsplit", "Git" },
        keys = {
            { "<leader>gs", vim.cmd.Git,             desc = "Git Status" },
            { "<leader>gd", "<cmd>Gvdiffsplit!<cr>", desc = "Git Diff Vertical" },
            { "<leader>gb", "<cmd>Git blame<cr>",    desc = "Git Blame" },
        },
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<leader>q", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>w", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>e", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>r", function() harpoon:list():select(4) end)

            vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
        end,
    },
}
