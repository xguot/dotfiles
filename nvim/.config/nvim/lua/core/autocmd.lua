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

-- 2-space
vim.api.nvim_create_autocmd("FileType", {
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
	pattern = { "c", "go" },
	callback = function()
		vim.opt_local.tabstop = 8
		vim.opt_local.shiftwidth = 8
		vim.opt_local.softtabstop = 0
		vim.opt_local.expandtab = false
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
		vim.keymap.set("n", "j", "gj", { buffer = true })
		vim.keymap.set("n", "k", "gk", { buffer = true })
	end,
})
