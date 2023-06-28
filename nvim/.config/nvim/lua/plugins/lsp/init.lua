local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "b0o/schemastore.nvim",
    "folke/neodev.nvim",
    -- "lvimuser/lsp-inlayhints.nvim",
    "simrat39/rust-tools.nvim",
    {
      "williamboman/mason.nvim",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
      },
    },
  },
}

function M.config()
  ---- Initialize servers
  local lsp_servers = {
    -- "angularls",
    "bashls",
    "clangd",
    "cssls",
    "dockerls",
    "emmet_ls",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "marksman",
    "pyright",
    "rust_analyzer",
    "solargraph",
    -- "sorbet",
    "svelte",
    "taplo",
    "tsserver",
    -- "vimls",
    "zls",
  }

  require("neodev").setup({})

  require("mason").setup({
    ui = {
      border = "rounded",
      keymaps = {
        apply_language_filter = "Ñ",
      },
    },
  })

  require("mason-lspconfig").setup({})

  ---- LSP Settings files loading
  local config = require("plugins.lsp.config")
  local scan = require("plenary.scandir")

  local lsp_settings_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp/settings"
  local lsp_settings_files = scan.scan_dir(lsp_settings_path, { depth = 0 })

  local lsp_settings = {}

  for _, file in ipairs(lsp_settings_files) do
    local language = file:match("([^/]+).lua$")

    lsp_settings[language] = require("plugins.lsp.settings." .. language)
  end

  ---- LSP Server init
  for _, server in ipairs(lsp_servers) do
    local opts = {
      on_attach = config.on_attach,
      capabilities = config.capabilities,
    }

    -- Autoloading of plugins.lsp.settings.*
    if lsp_settings[server] then
      opts = vim.tbl_deep_extend("force", lsp_settings[server], opts)
    end

    if server == "clangd" then
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997226723
      opts.capabilities.offsetEncoding = { "utf-16" }
    end

    require("lspconfig")[server].setup(opts)
  end

  ---- Rust
  -- DAP config
  -- local extension_path = require("mason-registry").get_package("codelldb"):get_install_path()
  -- local codelldb_path = extension_path .. "/extension/adapter/codelldb"
  -- local liblldb_path = extension_path .. "/extension/lldb/lib/liblldb.dylib"

  local opts = {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    standalone = false,
  }

  opts = vim.tbl_deep_extend("force", lsp_settings["rust_analyzer"], opts)

  require("rust-tools").setup({
    server = opts,
    -- dap = {
    --   adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    -- },
  })
end

return M
