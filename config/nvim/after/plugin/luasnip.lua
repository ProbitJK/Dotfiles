local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.cmd[[
inoremap <silent> <C-p> <cmd>lua require'luasnip'.jump(-1)<Cr>
inoremap <silent> <C-n> <cmd>lua require'luasnip'.jump(1)<Cr>
snoremap <silent> <C-p> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <C-n> <cmd>lua require'luasnip'.jump(1)<Cr>
]]
