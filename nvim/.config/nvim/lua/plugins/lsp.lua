return {
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
        vim.keymap.set("n", "<leader>ld", require("telescope.builtin").diagnostics, { desc = "List diagnostics" })
      end)

      local capabilities = lsp_zero.get_capabilities()

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "eslint",
          "lua_ls",
          "rust_analyzer",
          "pyright",
          "jdtls",
          "solargraph",
          "html",
          "marksman",
          "gopls",
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

          gopls = function()
            require("lspconfig").gopls.setup({
              capabilities = capabilities,
              settings = {
                gopls = {
                  completeUnimported = true,
                  usePlaceholders = true,
                  staticcheck = true,
                  gofumpt = true,
                  analyses = {
                    unusedparams = true,
                    shadow = true,
                  },
                  hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    parameterTypes = true,
                  },
                },
              },
            })
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
                  "codeActions",
                  "diagnostics",
                  "documentHighlights",
                  "documentSymbols",
                  "formatting",
                  "hover",
                  "onTypeFormatting",
                  "selectionRanges",
                  "semanticHighlighting",
                },
              },
            })
          end,

          pyright = function()
            require("lspconfig").pyright.setup({
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                  },
                },
              },
            })
          end,

          matlab_ls = function()
            require("lspconfig").matlab_ls.setup({
              capabilities = capabilities,
              settings = {
                MATLAB = {
                  installPath = "/Applications/MATLAB_R2025b.app",
                  indexWorkspace = true,
                  telemetry = false,
                },
              },
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
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      mappings = false,
      lsp = {
        init_options = {
          editDelay = 10,
          hasWidgets = true,
        },
      },
      ft = {
        nomodifiable = {},
      },
      abbreviations = {
        enable = true,
        extra = {
          wknight = "♘",
        },
        leader = "\\",
      },
      infoview = {
        autoopen = true,
        width = 1 / 3,
        height = 1 / 3,
        orientation = "auto",
        horizontal_position = "bottom",
        separate_tab = false,
        indicators = "auto",
      },
      progress_bars = {
        enable = true,
        character = "│",
        priority = 10,
      },
      goal_markers = {
        unsolved = " ⚒ ",
        accomplished = "🎉",
      },
      stderr = {
        enable = true,
        height = 5,
        on_lines = nil,
      },
    },
  },
}
