vim.opt.guicursor = "a:block"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 0
vim.opt.expandtab = false

vim.opt.textwidth = 0
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.formatoptions = "j"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Grammar
vim.opt.spelllang = "en_us"
vim.opt.conceallevel = 2

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Digraphs
local digraphs = {
	-- UI
	{ 'sq', '▪' }, -- Step / Item
	{ 'st', '✦' }, -- Highlight / Init
	{ 'tr', '❯' }, -- Prompt pointer
	{ 'ok', '✓' }, -- Success
	{ 'xx', '✗' }, -- Error / Fail
	{ 'wa', '▲' }, -- Warning
	{ 'in', 'ℹ' }, -- Info
	{ 'as', '✱' }, -- Heavy asterisk (Checkpoint / New Best)
	{ 'bs', '★' }, -- Solid star (Best model)

	-- Deep Learning
	{ 'pd', '∂' }, -- Partial derivative
	{ 'gr', '∇' }, -- Gradient (Nabla)
	{ 'ep', 'ε' }, -- Epsilon / Error
	{ 'la', 'λ' }, -- Lambda
	{ 'de', 'Δ' }, -- Delta / Change
	{ 'sm', '∑' }, -- Summation
	{ 'it', '∫' }, -- Integral

	-- Logic
	{ 'df', '≡' }, -- Defined as / Identical
	{ 'nq', '≠' }, -- Not equal
	{ 'ap', '≈' }, -- Approximately
	{ 'rt', '→' }, -- Right arrow
	{ 'rb', '⇒' }, -- Implies
}

for _, d in ipairs(digraphs) do
	vim.fn.digraph_set(d[1], d[2])
end

if vim.fn.executable("wl-copy") == 1 then
	vim.g.clipboard = {
		name = "wl-utils",
		copy = {
			["+"] = "wl-copy",
			["*"] = "wl-copy",
		},
		paste = {
			["+"] = "wl-paste --no-newline",
			["*"] = "wl-paste --no-newline",
		},
		cache_enabled = true,
	}
end

-- Colorscheme
vim.cmd("syntax off")

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if status_ok then
	configs.setup({
		highlight = { enable = false },
	})
end

vim.cmd.colorscheme("quiet")
