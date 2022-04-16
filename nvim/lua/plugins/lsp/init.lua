local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local config = require("plugins.lsp.config")
local scan = require("plenary.scandir")

local lsp_settings_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp/settings/"
local paths = scan.scan_dir(lsp_settings_path, { depth = 0 })

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
  }

  -- Autoloading of plugins.lsp.settings.*
  for _, file in ipairs(paths) do
    local language = file:match("([^/]+).lua$")

    if server.name == language then
      opts = vim.tbl_deep_extend("force", require("plugins.lsp.settings." .. language), opts)
    end
  end

  if server.name == "rust_analyzer" then
    require("rust-tools").setup({
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
    })

    server:attach_buffers()
  else
    server:setup(opts)
  end
end)

vim.keymap.set("n", "<leader>li", "<cmd>LspInstallInfo<cr>")
