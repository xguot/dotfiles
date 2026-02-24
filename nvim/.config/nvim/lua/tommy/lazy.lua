vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h", "hpp" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = false
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local view = vim.fn.winsaveview()
        vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
        vim.fn.winrestview(view)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.wrap = true
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.lua",
    callback = function()
        local view = vim.fn.winsaveview()
        vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
        vim.fn.winrestview(view)
    end,
})

return require("lazy").setup({
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    svelte = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                },
                format_on_save = {
                    timeout_ms = 2000,
                    lsp_fallback = true,
                },
            })
        end,
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
            { "onsails/lspkind-nvim" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
                local opts = { buffer = bufnr, noremap = true, silent = true }
                vim.keymap.set("n", ";d", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
                vim.keymap.set("n", "<leader>ld", require("telescope.builtin").diagnostics, { desc = "List diagnostics" })
            end)

            local capabilities = lsp_zero.get_capabilities()

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd", "eslint", "lua_ls", "rust_analyzer", "pyright",
                    "jdtls", "solargraph", "html", "marksman", "ltex",
                    "ocamllsp", "gopls",
                },
                handlers = {
                    function(server_name)
                        local config = { capabilities = capabilities }
                        if server_name == "eslint" then
                            config.on_attach = function(client, bufnr)
                                client.server_capabilities.documentFormattingProvider = true
                                client.server_capabilities.documentRangeFormattingProvider = true
                                lsp_zero.default_keymaps({ buffer = bufnr })
                            end
                            config.settings = { format = true }
                        end
                        require("lspconfig")[server_name].setup(config)
                    end,

                    lua_ls = function()
                        require("lspconfig").lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = "LuaJIT" },
                                    diagnostics = { globals = { "vim" } },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                        checkThirdParty = false,
                                    },
                                    format = { enable = true },
                                    telemetry = { enable = false },
                                },
                            },
                        })
                    end,

                    ruby_lsp = function()
                        require("lspconfig").ruby_lsp.setup({
                            capabilities = capabilities,
                            init_options = {
                                formatter = "rubocop",
                                enabledFeatures = {
                                    "codeActions", "diagnostics", "documentHighlights",
                                    "documentSymbols", "formatting", "hover",
                                    "onTypeFormatting", "selectionRanges", "semanticHighlighting",
                                },
                            },
                        })
                    end,

                    ocamllsp = function()
                        require("lspconfig").ocamllsp.setup({
                            capabilities = capabilities,
                            cmd = { "ocamllsp" },
                        })
                    end,

                    sourcekit = function()
                        require("lspconfig").sourcekit.setup({
                            capabilities = capabilities,
                            cmd = { "sourcekit-lsp" },
                            root_dir = require("lspconfig.util").root_pattern(
                                "Package.swift",
                                ".git",
                                "*.xcodeproj",
                                "*.xcworkspace"
                            ),
                        })
                    end,
                },
            })

            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "nvim_lua" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>pf", function() require("telescope.builtin").find_files() end,                                      desc = "Find Files" },
            { "<leader>pg", function() require("telescope.builtin").git_files() end,                                       desc = "Git Files" },
            { "<leader>ps", function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end, desc = "Grep String" },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "c", "lua", "vim", "vimdoc", "python", "ruby",
                    "ocaml", "svelte", "typescript", "javascript",
                    "html", "css", "go", "gomod", "markdown", "markdown_inline",
                    "swift",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            })
        end,
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

            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

            vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
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
        "xeluxee/competitest.nvim",
        dependencies = "MunifTanjim/nui.nvim",
        config = function()
            require("competitest").setup({
                received_problems_path = function(task, file_extension)
                    local home = os.getenv("HOME")
                    local contest_id = "unknown_contest"
                    local problem_id = task.name

                    if task.url then
                        local c, p = task.url:match("contest/(%d+)/problem/([%w%p]+)")
                        if c and p then
                            contest_id, problem_id = c, p
                        else
                            c, p = task.url:match("problem/(%d+)/([%w%p]+)")
                            if c and p then
                                contest_id, problem_id = c, p
                            end
                        end
                    end
                    if problem_id == task.name then
                        local p = task.name:match("^(%w+)%.")
                        if p then problem_id = p end
                    end
                    return string.format("%s/code/codeforces/%s/%s.%s", home, contest_id, problem_id, file_extension)
                end,
                received_contest_problems_path = function(task, file_extension)
                    local home = os.getenv("HOME")
                    local contest_id = "unknown_contest"
                    local problem_id = task.name

                    if task.url then
                        local c, p = task.url:match("contest/(%d+)/problem/([%w%p]+)")
                        if c and p then
                            contest_id, problem_id = c, p
                        end
                        local c2, p2 = task.url:match("problem/(%d+)/([%w%p]+)")
                        if c2 and p2 then
                            contest_id, problem_id = c2, p2
                        end
                    end
                    if problem_id == task.name then
                        local p = task.name:match("^(%w+)%.")
                        if p then problem_id = p end
                    end
                    return string.format("%s/code/codeforces/%s/%s.%s", home, contest_id, problem_id, file_extension)
                end,
                template_file = "$(HOME)/code/codeforces/template.rb",
                received_files_extension = "rb",
                runner_ui = { interface = "popup" },
            })
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
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
            { "<leader>dv", "<cmd>Gvdiffsplit!<cr>", desc = "Diff Vertical" },
        },
    },
    "christoomey/vim-tmux-navigator",
    "ThePrimeagen/vim-be-good",

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
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        ft = { "markdown" },
        opts = {
            latex = {
                enabled = true,
                converter = 'latex2text',
            },
            win_options = {
                conceallevel = { default = vim.o.conceallevel, rendered = 3 },
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
})
