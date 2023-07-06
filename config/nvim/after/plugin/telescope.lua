local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>sw', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, {desc = 'Search for string'})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>of", builtin.oldfiles, {desc = 'Recent files'})
vim.keymap.set("n", "<leader>bu", builtin.buffers, {desc = 'Existing buffers'})
vim.keymap.set("n", "<leader>swl", builtin.live_grep, {desc = 'Live grep'})
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {desc = 'Search diagnostics'})
vim.keymap.set("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, {desc = ' Fuzzy find in current buffer'})
