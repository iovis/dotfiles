return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DB",
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<cr>")
    vim.keymap.set("n", "d<space>", ":DB<space>")

    ----DBUI
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_force_echo_notifications = 1
    vim.g.db_ui_execute_on_save = 0
    vim.g.db_ui_env_variable_url = "DATABASE_URL"
    vim.g.db_ui_hide_schemas = {
      "information_schema",
      "pg_.*",
    }
  end,
}
