vim.opt.guicursor = "a:block"

vim.opt.nu = true
vim.opt.relativenumber = true

-- PI is no 3
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

-- Blackboard white chalk
vim.cmd("syntax off")
vim.cmd.colorscheme("quiet")
