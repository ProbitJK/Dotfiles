return{
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require("telescope").setup{
                extensions = {
                    file_browser = {
                        hidden = true,
                        show_git = true,
                        select_buffer = true,
                        hijack_netrw = false,
                    },
                },
            }
            require("telescope").load_extension("file_browser")
            vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h<CR>", {noremap = true, desc = 'Open the file browser'})
        end
}
