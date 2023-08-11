require("telescope").setup {
    extensions = {
        file_browser = {
            theme = "ivy",
            select_buffer = true,
            hijack_netrw = false,
        },
    },
}

require("telescope").load_extension "file_browser"

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Find files in current folder'})
vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = 'Find files in current git repository'})
vim.keymap.set("n", "<leader>bu", builtin.buffers, {desc = 'Existing buffers'})
vim.keymap.set("n", "<leader>sw", function ()
    builtin.grep_string({search = vim.fn.input("Find word > ")});
end, {desc = "Search for string (faster than live grep)"})
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {desc = 'Live grep'})
vim.keymap.set("n", "<leader>rg", builtin.registers, {desc = 'Existing vim registers'})
vim.keymap.set("n", "<leader>jl", builtin.jumplist, {desc = 'Jumplists'})
vim.keymap.set("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, {desc = ' Fuzzy find in current buffer'})
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h<CR>", {noremap = true, desc = 'Open the file browser'})
