local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local config = require('plugins.lsp.config')
local u = require('utils')

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
  }

  if server.name == 'jsonls' then
    opts = vim.tbl_deep_extend(
      'force',
      require('plugins.lsp.settings.jsonls'),
      opts
    )
  end

  if server.name == "sumneko_lua" then
    opts = vim.tbl_deep_extend(
      'force',
      require('plugins.lsp.settings.sumneko_lua'),
      opts
    )
  end

  server:setup(opts)
end)
