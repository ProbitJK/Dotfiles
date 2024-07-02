return{
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file, {desc = "Add file to harpoon list", remap = false})
        vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu, {desc = "Toggle harpoon menu", remap = false})
        vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, {desc = "Navigate to first file in harpoon list", remap = false})
        vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, {desc = "Navigate to second file in harpoon list", remap = false})
        vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, {desc = "Navigate to third file in harpoon list", remap = false})
        vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, {desc = "Navigate to fourth file in harpoon list", remap = false})
    end
}
