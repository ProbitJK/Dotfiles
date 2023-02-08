local theme = {
    fill = { fg='#74c7ec', bg='#313244'},
    head = { fg='#74c7ec', bg='#1e1e2e'},
    current = { fg='#8839ef', bg='#cba6f7', style='bold'},
    tab = { fg='#313244', bg='#585b70'},
}
require('tabby.tabline').set(function(line)
    return {
        {
            { '  ', hl = theme.head },
            line.sep('', theme.head, theme.head),
            line.sep(' ', theme.fill, theme.fill),
        },
        line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current or theme.tab
            return {
                line.sep('', hl, theme.fill),
                tab.number(),
                line.sep(' ', hl, hl),
                tab.name(),
                hl = hl,
                line.sep('', hl, theme.fill),
                line.sep('  ', theme.fill, theme.fill),
            }
        end),
        line.spacer(),
        {
            line.sep('', theme.head, theme.fill),
            { '  ', hl = theme.head },
        },
        hl = theme.fill,
    }
end)
