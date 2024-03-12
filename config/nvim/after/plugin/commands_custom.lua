local run_commands = {
    python = "tmux splitw -h 'python3 %; read -n 1 -s -r -p \"Press any key to close...\"'",
    tex = "tmux neww 'latexmk -pdf -pvc %:p'",
    markdown = "pandoc % -o %:p:r.pdf",
}
local custom_diagnostics = {
    tex = "cexpr system('chktex -q -v0 '.expand('%').' && lacheck '.expand('%'))",
}

vim.api.nvim_create_user_command("Run", function()
    local filetype = vim.bo.filetype
    for file, command in pairs(run_commands) do
        if filetype == file then
            vim.cmd("w")
            vim.cmd("!"..command)
            break
        end
    end
end, {})

vim.api.nvim_create_user_command("CDiag", function()
    local filetype = vim.bo.filetype
    for file, command in pairs(custom_diagnostics) do
        if filetype == file then
            vim.cmd(command)
            break
        end
    end
end, {})

vim.keymap.set("n", "\\r", function() vim.cmd("Run") end, {desc="Run the file", remap=false})
vim.keymap.set("n", "\\q", function() vim.cmd("CDiag") end, {desc="Run custom diagnostics", remap=false})
