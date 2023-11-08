local run_commands = {
    python = "tmux splitw -h 'python3 %'",
    tex = "tmux neww 'latexmk -pdf -pvc %:p'",
    markdown = "pandoc % -o %:p:r.pdf",
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

vim.keymap.set("n", "\\r", function() vim.cmd("Run") end, {desc="Run the file", remap=false})
