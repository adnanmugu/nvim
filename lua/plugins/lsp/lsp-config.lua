return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufReadPost', 'BufNewFile' },
    depedencies = {
        { 'mason-org/mason.nvim' },
        { 'mason-org/mason-lspconfig.nvim' },
        { 'saghen/blink.cmp' },
    },
    config = function()
    end,
}
