vim.opt.guicursor = "a:block"

vim.opt.nu = true
vim.opt.relativenumber = true

-- 4-space
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.textwidth = 0
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.formatoptions = "j"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

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

-- Terminal
local terminal_palette = {
    "#000000", "#5f8787", "#d0dfee", "#5f81a5",
    "#888888", "#999999", "#aaaaaa", "#c1c1c1",
    "#404040", "#5f8787", "#d0dfee", "#5f81a5",
    "#888888", "#999999", "#aaaaaa", "#c1c1c1"
}

for i, hex in ipairs(terminal_palette) do
    vim.g["terminal_color_" .. (i - 1)] = hex
end
