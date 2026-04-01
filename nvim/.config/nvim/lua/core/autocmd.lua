---@diagnostic disable: undefined-global
local my_augroup = vim.api.nvim_create_augroup("NvimCoreSettings", { clear = true })

-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd.startinsert()
  end,
})

-- 2-space
vim.api.nvim_create_autocmd("FileType", {
  group = my_augroup,
  pattern = {
    "lua",
    "ruby",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "0"
  end,
})

-- 8-tab
vim.api.nvim_create_autocmd("FileType", {
  group = my_augroup,
  pattern = { "c", "go" },
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 0
    vim.opt_local.expandtab = false
  end,
})

-- LaTex / Markdown / gitcommit
vim.api.nvim_create_autocmd("FileType", {
  group = my_augroup,
  pattern = { "tex", "latex", "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }

    if vim.bo.filetype == "gitcommit" then
      vim.opt_local.textwidth = 72
      vim.opt_local.colorcolumn = "73"
    else
      vim.opt_local.textwidth = 0
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.keymap.set("n", "j", "gj", { buffer = true })
      vim.keymap.set("n", "k", "gk", { buffer = true })
    end
  end,
})

-- Format
vim.api.nvim_create_autocmd("FileType", {
  group = my_augroup,
  pattern = "*",
  callback = function(args)
    local formatters = {
      lua = "stylua -",
      go = "gofmt",
      javascript = "npx prettier --stdin-filepath %",
      typescript = "npx prettier --stdin-filepath %",
      javascriptreact = "npx prettier --stdin-filepath %",
      typescriptreact = "npx prettier --stdin-filepath %",
      svelte = "npx prettier --stdin-filepath %",
      css = "npx prettier --stdin-filepath %",
      html = "npx prettier --stdin-filepath %",
      json = "npx prettier --stdin-filepath %",
      yaml = "npx prettier --stdin-filepath %",
      markdown = "npx prettier --stdin-filepath %",
      python = "ruff format -",
      c = "clang-format",
      cpp = "clang-format",
    }

    local ft = vim.bo[args.buf].filetype
    if formatters[ft] then
      vim.bo[args.buf].formatprg = formatters[ft]
    end
  end,
})

vim.keymap.set("n", "<leader>f", function()
  local view = vim.fn.winsaveview()
  vim.cmd("normal! gggqG")
  vim.fn.winrestview(view)
end)

vim.keymap.set("v", "<leader>f", "gq")
