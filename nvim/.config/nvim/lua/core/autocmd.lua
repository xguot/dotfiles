---@diagnostic disable: undefined-global
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

-- Python
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = true
		vim.opt_local.colorcolumn = "0"
	end,
})

-- LaTex \ Markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "tex", "latex", "markdown" },
	callback = function()
		vim.opt_local.textwidth = 0
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en_us" }
		vim.keymap.set('n', 'j', 'gj', { buffer = true })
		vim.keymap.set('n', 'k', 'gk', { buffer = true })
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
