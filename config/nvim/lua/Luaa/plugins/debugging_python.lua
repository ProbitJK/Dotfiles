return{
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
    },
    config = function()
        local path = "~/.virtualenvs/python_env_4_probit/bin/python3"
        require("dap-python").setup(path)
    end,
}
