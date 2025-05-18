return {
    {
        'ellisonleao/gruvbox.nvim',
        lazy = false,
        name = 'gruvbox',
        priority = 1000,
        config = function()
            require('plugins.theme.gruvbox')
            vim.cmd('colorscheme gruvbox')
        end,
    },

    -- UTILS --
    {
        'sudormrfbin/cheatsheet.nvim',
        enabled = false,
        keys = {
            { '<space>cs', '<cmd>Cheatsheet<cr>', desc = 'Cheatsheet' },
            { '<space>ce', '<cmd>CheatsheetEdit<cr>', desc = 'Cheatsheet Edit' },
        },
        dependencies = {
            { 'nvim-telescope/telescope.nvim' },
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
        },
        opts = {
            bundled_plugin_cheatsheets = {
                disabled = { 'gitsigns.nvim' },
            },
        },
    },
    {
        'chrisgrieser/nvim-alt-substitute',
        enabled = false,
        opts = true,
        -- lazy-loading with `cmd =` does not work well with incremental preview
        event = 'CmdlineEnter',
    },

    -- COLORS --
    {
        'uga-rosa/ccc.nvim',
        keys = {
            { '<leader>cc', '<cmd>CccPick<cr>', desc = 'Color Picker' },
        },
        opts = {
            win_opts = {
                border = 'single',
            },
        },
    },
    {
        'brenoprata10/nvim-highlight-colors',
        enabled = true,
        event = 'BufReadPre',
        opts = {
            render = 'virtual', ---@usage 'background'|'foreground'|'virtual'
            virtual_symbol = '',
        },
        config = true,
    },

    -- WRITING --
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = '1.*',
        opts = {
            invert_colors = 'auto',
        },
    },
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = 'markdown',
        build = function()
            vim.fn['mkdp#util#install']()
        end,
    },
    {
        'Myzel394/easytables.nvim',
        ft = 'markdown',
        config = true,
    },
    {
        'Kicamon/markdown-table-mode.nvim',
        ft = 'markdown',
        config = true,
    },
    {
        'OXY2DEV/markview.nvim',
        enabled = true,
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local presets = require('markview.presets').headings
            require('markview').setup({
                markdown = {
                    headings = presets.glow,
                },
                typst = {
                    enable = false,
                },
                preview = {
                    icon_provider = 'devicons', -- "mini" or "devicons" or "internal"
                },
            })
        end,
    },

    -- MOTION
    -- {
    --     'smoka7/hop.nvim',
    --     version = '*',
    --     keys = {
    --         { '<space><space>', '<cmd>HopWord<cr>', desc = 'Hop Word' },
    --         { '<leader>ha', '<cmd>HopAnywhere<cr>', desc = 'Hop Anywhere' },
    --         { '<leader>hc', '<cmd>HopCamelCase<cr>', desc = 'Hop CamelCase' },
    --         { '<leader>hh', '<cmd>HopPattern<cr>', desc = 'Hop Pattern' },
    --         { '<leader>hl', '<cmd>HopLine<cr>', desc = 'Hop Line' },
    --         { '<leader>hn', '<cmd>HopNodes<cr>', desc = 'Hop Nodes' },
    --         { '<leader>hp', '<cmd>HopPasteChar1<cr>', desc = 'Hop Paste' },
    --         { '<leader>hv', '<cmd>HopVertical<cr>', desc = 'Hop Vertical' },
    --         { '<leader>hy', '<cmd>HopYankChar1<cr>', desc = 'Hop Yank' },
    --         { '<leader>h1', '<cmd>HopChar1<cr>', desc = 'Hop 1 Char' },
    --         { '<leader>h2', '<cmd>HopChar2<cr>', desc = 'Hop 2 Chars' },
    --     },
    --     config = true,
    -- },

    -- DEBUG --
    {
        'mfussenegger/nvim-dap',
        cmd = { 'DapToggleBreakpoint' },
        keys = {
            { '<leader>db', '<cmd>DapToggleBreakpoint<cr>', desc = 'Add Breakpoint' },
        },
        dependencies = {
            'theHamsta/nvim-dap-virtual-text',
            opts = {
                commented = true,
                virt_text_pos = 'eol',
            },
        },
        config = function()
            require('plugins.dap.debug_adapter')
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            { '<leader>du', '<cmd>lua require("dapui").toggle()<CR>', desc = 'DAP UI Toggle' },
        },
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
        config = true,
    },

    -- REST HTML --
    {
        'diepm/vim-rest-console',
        enabled = false,
        ft = 'rest',
    },
}
