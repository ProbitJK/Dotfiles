return{
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Find files in current folder', remap = false})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = 'Find files in current git repository', remap = false})
        vim.keymap.set("n", "<leader>bu", builtin.buffers, {desc = 'Existing buffers', remap = false})
        vim.keymap.set("n", "<leader>sw", function ()
            builtin.grep_string({search = vim.fn.input("Find word > ")});
        end, {desc = "Search for string (faster than live grep)", remap = false})
        vim.keymap.set("n", "<leader>lg", builtin.live_grep, {desc = 'Live grep', remap = false})
        vim.keymap.set("n", "<leader>fw", function()
            builtin.grep_string({search = vim.fn.expand("<cword>")});
        end, {desc = "Search for word under cursor", remap = false})
        vim.keymap.set("n", "<leader>fW", function()
            builtin.grep_string({search = vim.fn.expand("<cWORD>")});
        end, {desc = "Search for word under cursor", remap = false})
        vim.keymap.set("n", "<leader>rg", builtin.registers, {desc = 'Existing vim registers', remap = false})
        vim.keymap.set("n", "<leader>jl", builtin.jumplist, {desc = 'Jumplists', remap = false})
        vim.keymap.set("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, {desc = ' Fuzzy find in current buffer', remap = false})
    end
}
