vim.keymap.set("i", "(", "()<left>")
vim.keymap.set("i", "{", "{}<left>")
vim.keymap.set("i", "[", "[]<left>")
vim.keymap.set("i", "<C-s>`", "``<left>")
vim.keymap.set("i", "<C-s>'", "''<left>")
vim.keymap.set("i", '<C-s>"', '""<left>')
vim.keymap.set("n", ";w(", "viwc()<C-c>P")
vim.keymap.set("n", ";w{", "viwc{}<C-c>P")
vim.keymap.set("n", ";w[", "viwc[]<C-c>P")
vim.keymap.set("n", ";wi", "viwc**<C-c>P")
vim.keymap.set("n", ";wb", "viwc**<C-c>pa**<C-c>")
vim.keymap.set("v", ";w(", "di()<C-c>P")
vim.keymap.set("v", ";w{", "di{}<C-c>P")
vim.keymap.set("v", ";w[", "di[]<C-c>P")
vim.keymap.set("v", ";wi", "di**<C-c>P")
vim.keymap.set("v", ";wb", "di**<C-c>pa**<C-c>")
vim.cmd[[
inoremap <C-j> <C-[>:call search('[>)\]}`"'']', 'W')<CR>a
]]
