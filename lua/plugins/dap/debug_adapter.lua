local dap = require('dap')

-- Signs
local sign = vim.fn.sign_define
-- 
sign('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })

--  ╭──────────────────────────────────────────────────────────╮
--  │                          PYTHON                          │
--  ╰──────────────────────────────────────────────────────────╯
dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = '/Users/ilias/.virtualenvs/debugpy/bin/python3',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch',
    name = 'Launch file',

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = '${file}', -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/Users/ilias/.virtualenvs/debugpy/bin/python3') == 1 then
        return cwd .. '/Users/ilias/.virtualenvs/debugpy/bin/python3'
      elseif vim.fn.executable(cwd .. '/Users/ilias/.virtualenvs/debugpy/bin/python3') == 1 then
        return cwd .. '/Users/ilias/.virtualenvs/debugpy/bin/python3'
      else
        return '/Users/ilias/.virtualenvs/debugpy/bin/python3'
      end
    end,
  },
}
--  ╭──────────────────────────────────────────────────────────╮
--  │                        JAVASCRIPT                        │
--  ╰──────────────────────────────────────────────────────────╯
dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = { '/Users/ilias/.config/js-debug/src/dapDebugServer.js', '${port}' },
  },
}
dap.configurations.javascript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    cwd = '${workspaceFolder}',
  },
}
