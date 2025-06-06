return {
  -- Comment --
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { 'gc', mode = 'v' },
      { 'gb', mode = 'v' },
      { 'gcc' },
      { 'gbc' },
      { 'gco' },
      { 'gcO' },
      { 'gcA' },
    },
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
          require('ts_context_commentstring').setup({
            enable_autocmd = false,
          })
        end,
      },
    },
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        -- pre_hook = function()
          --     return vim.bo.commentstring
          -- end,
        })
      end,
    },

    -- Todo Comments
    {
      'folke/todo-comments.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      keys = {
        { '<leader>tq', '<cmd>TodoQuickFix<cr>', desc = 'Todo QuickFix' },
        { '<leader>tl', '<cmd>TodoLocList<cr>', desc = 'Todo LocList' },
        { '<leader>ts', '<cmd>TodoTelescope<cr>', desc = 'Todo Telescope' },
      },
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = {},
    },
  }
