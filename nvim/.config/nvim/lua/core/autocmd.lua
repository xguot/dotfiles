---@diagnostic disable: undefined-global
local my_augroup = vim.api.nvim_create_augroup("NvimCoreSettings", { clear = true })

-- Terminal behavior
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.cmd.startinsert()
	end,
})

-- CSO2
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*/code/cso2/*",
	group = course_group,
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = true
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
