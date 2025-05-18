return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find Buffers' },
    { '<leader>fc', ":lua require'telescope.builtin'.commands{}<cr>", desc = 'List Commands' },
    { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'Find Diagnostics' },
    { '<leader>fe', '<cmd>Telescope file_browser<cr>', desc = 'File Browser' },
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Find Word' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Find Help' },
    { '<leader>fi', '<cmd>Telescope import<cr>', desc = 'Find Imports' },
    { '<leader>fj', '<cmd>Telescope emoji<cr>', desc = 'Find emoji' },
  },
  config = function()
    require('telescope').setup{}
      end
    }
