return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                background = { dark = "mocha" },
                transparent_background = true,
                float = {
                    transparent = false,
                    solid = false,
                },
                show_end_of_buffer = false,
                term_colors = true,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.55,
                },
                default_integrations = true,
                auto_integrations = true,
            })
            vim.cmd.colorscheme "catppuccin"
        end,
    }
}
