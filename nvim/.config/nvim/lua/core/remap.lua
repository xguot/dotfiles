vim.g.mapleader = " "

-- Oil file manager
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP')

-- Delete to void register
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Difference between <C-c> and <Esc>
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

-- Format buffer (LSP or Vim fallback)
vim.keymap.set("n", "<leader>f", function()
  local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/formatting" })
  if #clients > 0 then
    vim.lsp.buf.format({ async = false })
  else
    local view = vim.fn.winsaveview()
    vim.cmd("normal! gqap")
    vim.fn.winrestview(view)
  end
end, { desc = "Format buffer (LSP or Vim fallback)" })

-- Stay in visual mode while indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Split windows
vim.keymap.set("n", "<leader>|", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>-", vim.cmd.split)

-- Resize windows
local function resize(cmd, side, amt)
  local dir = vim.fn.winnr() == vim.fn.winnr(side) and amt or -amt
  vim.cmd(string.format("%s %s%d", cmd, dir > 0 and "+" or "", dir))
end

vim.keymap.set("n", "<leader>h", function()
  resize("vertical resize", "l", 10)
end)
vim.keymap.set("n", "<leader>l", function()
  resize("vertical resize", "l", -10)
end)
vim.keymap.set("n", "<leader>k", function()
  resize("resize", "j", 10)
end)
vim.keymap.set("n", "<leader>j", function()
  resize("resize", "j", -10)
end)

-- Digraphs
local digraphs = {
  -- UI
  { "sq", "▪" }, -- Step / Item
  { "di", "✦" }, -- Highlight / Init
  { "tr", "❯" }, -- Prompt pointer
  { "ok", "✓" }, -- Success
  { "no", "✗" }, -- Error / Fail
  { "wa", "▲" }, -- Warning
  { "in", "ℹ" }, -- Info
  { "as", "✱" }, -- Heavy asterisk (Checkpoint / New Best)
  { "st", "★" }, -- Solid star (Best model)

  -- Deep Learning
  { "pd", "∂" }, -- Partial derivative
  { "gr", "∇" }, -- Gradient (Nabla)
  { "ep", "ε" }, -- Epsilon / Error
  { "la", "λ" }, -- Lambda
  { "de", "Δ" }, -- Delta / Change
  { "sm", "∑" }, -- Summation
  { "it", "∫" }, -- Integral

  -- Logic
  { "df", "≡" }, -- Defined as / Identical
  { "nq", "≠" }, -- Not equal
  { "ap", "≈" }, -- Approximately
  { "rt", "→" }, -- Right arrow
  { "rb", "⇒" }, -- Implies
}

for _, d in ipairs(digraphs) do
  vim.fn.digraph_set(d[1], d[2])
end
