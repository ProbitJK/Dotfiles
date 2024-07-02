vim.g.mapleader = " "
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = 'Ensure that using <C-c> will always exit out of insert mode' })
vim.keymap.set({ 'n', 'i' }, "<C-s>", "<Esc>:w<CR>", { desc = 'Save file in buffer' })
vim.keymap.set("n", "<leader>re", ":e %<CR>", { desc = 'Reload current buffer' })
--vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, {desc = 'Open the native file explorer'})
vim.keymap.set("n", "<leader>sp", ":vsplit<CR><C-w>w:Telescope file_browser<CR>",
    { desc = 'Split the current tab vertically and open file explorer on the right' })
vim.keymap.set("n", "<leader>nt", vim.cmd.tabe, { desc = 'Open a new tab' })
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>[s", ":normal! mz[s1z=`z<CR>",
    { desc = 'Correct the first spelling error found when searching backwards from cursor position' })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Shift selected line down by one line' })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = 'Shift selected line up by one line' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll down half page and keep cursor centered' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll up half page and keep cursor centered' })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Find next instance of search and keep result at centered' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Find next instance of search and keep result at centered' })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = 'Go to split content below', noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = 'Go to split content above', noremap = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = 'Go to split content to left', noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = 'Go to split content to right', noremap = true })
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = 'Paste content and do not store deleted content in buffer' })
vim.keymap.set("n", "<leader>tms", "<cmd>silent !tmux neww tmux-sessionizer<CR>",
    { desc = 'Use tmux-sessionizer to launch tmux session' })
vim.keymap.set("n", "<leader>kb", "<cmd>silent !sioyek ~/.config/nvim/keybinds.pdf<CR>",
    { desc = 'Open the neovim custom keybinds help page that I wrote' })

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local opts = { buffer = ev.buf, noremap = true, silent = true }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup('TextFiles', {clear = true}),
    pattern = {"markdown", "tex"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
