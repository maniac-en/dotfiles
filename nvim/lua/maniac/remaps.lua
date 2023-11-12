local map = function(mode, lhs, rhs, desc, silent, expr)
  silent = silent or false
  expr = expr or false
  if desc then
    desc = "MANIAC_GENERIC: " .. desc
  end
  vim.keymap.set(mode, lhs, rhs, { remap = false, silent = silent, expr = expr, desc = desc })
end
-- Set the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','

map("x", "<Space>", '<Nop>', "[<Space>] Purposely mapped to nothing", true, false)
for _, m in ipairs({ "Q", "<left>", "<right>", "<up>", "<down>" }) do
  map("n", m, '<Nop>', "[" .. m .. "] Purposely mapped to nothing", true, false)
end

map("n", "<c-o>", "<c-o>zz", "[<c-o>] Jumplist-previous with cursor in middle of buffer", false, false)
map("n", "<TAB>", "<TAB>zz", "[<TAB>] Jumplist-new with cursor in middle of buffer", false, false)
map("n", "n", "nzzzv", "[n] Next search hit with cursor in middle of buffer", false, false)
map("n", "N", "Nzzzv", "[N] Previous search hit with cursor in middle of buffer", false, false)
map("n", "<C-d>", "<C-d>zz", "[<C-d>] Scroll downwards with cursor in middle of buffer", false, false)
map("n", "<C-u>", "<C-u>zz", "[<C-u>] Scroll upwards with cursor in middle of buffer", false, false)

map("n", "ts", ":split<SPACE>", "[ts] [T]ab [S]plit; it's not really a tab", false, false)
map("n", "tv", ":vsplit<SPACE>", "[tv] [T]ab split [V]ertical; it's not really a tab", false, false)
map("n", "tn", ":tabe<SPACE>", "[tn] [T]ab [N]ew", false, false)
map("n", "tc", vim.cmd.tabclose, "[tc] [T]ab [C]lose", true, false)

map("t", "<ESC>", "<C-\\><C-n>", "[<ESC>] [Esc]ape into normal mode in terminal", false, false)
map("n", "<SPACE>", ":noh<BAR>:echo<CR>", "[<SPACE>] Stop highlighting text with <SPACE>", false, false)
map("n", "<BS>", "%", "[<BS>] Jump matching pairs using Backspace", true, false)
map("n", "<leader>ev", ":tabedit " .. vim.fn.expand("$HOME") .. "/.config/nvim<CR>",
  "[<leader>ev] Tab edit [E]dit Neo[V]im", true, false)
map("n", "J", "mzJ`z", "[J] Retain cursor position whilst joining lines", false, false)
map("s", "w!!", "w !sudo tee > /dev/null %", "[w!!] SudoWrite", false, false)
map("x", "<leader>p", "\"_dP", "[<leader>p] Retain yanked content whilst pasting in visual mode", false, false)
map("n", "<leader>ts", "/\\v\\s+$<CR>", "[<leader>ts] Show [T]railing [S]paces", true, false)
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", "[<leader>cd] [CD] to current buffer's curret working directory", false,
  false)
map("x", "<C-y>", "\"+y", "[<C-y>] Copy to system clipboard", true, false)
map({ "n", "x" }, "j", "v:count == 0 ? \"gj\" : \"j\"", "[j] Better navigation around wrapped lines", true, true)
map({ "n", "x" }, "k", "v:count == 0 ? \"gk\" : \"k\"", "[k] Better navigation around wrapped lines", true, true)
map({ "n", "x" }, "0", "v:count == 0 ? \"g0\" : \"0\"", "[0] Better navigation around wrapped lines", true, true)
map({ "n", "x" }, "$", "v:count == 0 ? \"g$\" : \"$\"", "[$] Better navigation around wrapped lines", true, true)
map("x", "<leader>s", ":sort u<CR>", "[<leader>s] Sort selection uniquely", true, false)
map("x", "J", ":m '>+1<CR>gv=gv", "[J] Move selected lines up/down with indentation", false, false)
map("x", "K", ":m '<-2<CR>gv=gv", "[K] Move selected lines up/down with indentation", false, false)
map("n", "<C-j>", ":cnext<CR>", "[<C-j>] Next quickfix hit", false, false)
map("n", "<C-k>", ":cprevious<CR>", "[<C-k>] Prev quickfix hit", false, false)
