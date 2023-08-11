require("Comment").setup{
    -- binds to toggle comments in NORMAL mode
    toggler = {
        -- Comment the current line
        line = '<leader>cl',
        -- Comment the current block
        block = '<leader>cbb',
    },
    -- These are like operators that we can follow up with {number}{motion} in VISUAL and NORMAL mode
    opleader = {
        line = '<leader>cc',
        block = '<leader>cb',
    },
    -- These are extra mappings
    extra = {
        -- New line above as comment
        above = '<leader>cO',
        -- New line below as comment
        below = '<leader>co',
        -- Start adding comment at the end of the line
        eol = '<leader>cA',
    },
}
