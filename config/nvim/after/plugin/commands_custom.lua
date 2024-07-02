-- Run commands to execute current file
local run_commands = {
    python = "tmux splitw -h 'python3 " .. vim.fn.expand('%:p') .. "; read -n 1 -s -r -p \"Press any key to close this pane\"'",
    tex = "tmux neww 'latexmk -pdf -pvc " .. vim.fn.expand('%:p') .. "'",
    markdown = "pandoc " .. vim.fn.expand('%:p') .. " -o " ..vim.fn.fnamemodify(vim.fn.expand('%:p'), ':r') .. ".pdf",
    sh = "tmux splitw -h 'bash " .. vim.fn.expand('%:p') .. "; read -n 1 -s -r -p \"Press any key to close this pane\"'",
}
vim.api.nvim_create_user_command("Run", function()
    local filetype = vim.bo.filetype
    local command = run_commands[filetype]
    if command then
        vim.cmd("w")
        vim.fn.system(command)
    else
        print("No run command associated with current filetype")
    end
end, {})
vim.keymap.set("n", "\\r", function() vim.cmd("Run") end, {desc="Run the file", remap=false, silent=true})


-- Diagnostic commands to obtain diagnostics for current file
local custom_diagnostics = {
    tex = "cexpr system('chktex -q -v0 '.expand('%:p').' && lacheck '.expand('%:p').' && proselint '.expand('%:p'))",
}
vim.api.nvim_create_user_command("CDiag", function()
    local filetype = vim.bo.filetype
    local command = custom_diagnostics[filetype]
    if command then
        vim.cmd("w")
        vim.cmd(command)
    else
        print("No custom diagnostics command associated with current filetype")
    end
end, {})
vim.keymap.set("n", "\\q", function() vim.cmd("CDiag") end, {desc="Run custom diagnostics", remap=false, silent=true})
