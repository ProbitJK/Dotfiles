return{
    'danymat/neogen',
    version = '*',
    config = function()
        local neogen = require('neogen')
        neogen.setup({
            enabled = true,
            snippet_engine = 'luasnip',
        })
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<leader>nfun', '<cmd>lua require("neogen").generate({ type = "func" })<CR>', opts)
        vim.keymap.set('n', '<leader>ncla', '<cmd>lua require("neogen").generate({ type = "class" })<CR>', opts)
        vim.keymap.set('n', '<leader>nfil', '<cmd>lua require("neogen").generate({ type = "file" })<CR>', opts)
    end,
}
