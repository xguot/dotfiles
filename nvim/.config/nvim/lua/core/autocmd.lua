local my_augroup = vim.api.nvim_create_augroup("NvimCoreSettings", { clear = true })

-- Terminal
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

-- C / C++
vim.api.nvim_create_autocmd("FileType", {
    group = my_augroup,
    pattern = { "c", "cpp", "h", "hpp" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
    end,
})

-- Go
vim.api.nvim_create_autocmd("FileType", {
    group = my_augroup,
    pattern = { "go" },
    callback = function()
        vim.opt_local.tabstop = 8
        vim.opt_local.shiftwidth = 8
        vim.opt_local.softtabstop = 8
        vim.opt_local.expandtab = false
    end,
})

-- LaTeX / Markdown
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex", "markdown" },
    callback = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.formatoptions = "tcqja"
    end,
})

-- LaTeX
vim.api.nvim_create_autocmd("FileType", {
    group = my_augroup,
    pattern = "tex",
    callback = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.formatoptions:append("t")
        vim.opt_local.formatexpr = "" -- Disables VimTeX's custom formatter
    end,
})

-- JavaScript / TypeScript
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascriptreact", "typescriptreact" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,
})
