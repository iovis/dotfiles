local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local config = require("plugins.lsp.config")

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
  }

  -- Register extra settings for a <language> in plugins.lsp.<language>.lua
  local settings_for = function(language)
    if server.name == language then
      opts = vim.tbl_deep_extend("force", require("plugins.lsp." .. language), opts)
    end
  end

  settings_for("jsonls")
  settings_for("sumneko_lua")
  settings_for("solargraph")

  server:setup(opts)
end)

local u = require("utils")
u.nmap("<leader>li", "<cmd>LspInstallInfo<cr>")
