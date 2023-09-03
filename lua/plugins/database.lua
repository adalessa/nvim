return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
    "tpope/vim-dotenv",
  },
  keys = { { "<leader><leader>db", ":tab DBUI<cr>", desc = "Open Database client" } },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_force_echo_notifications = 1
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_winwidth = 80

    vim.g.db_ui_table_helpers = {
      mysql = {
        Count = "select count(1) from {optional_schema}{table}",
        Explain = "EXPLAIN {last_query}",
      },
      sqlite = {
        Describe = "PRAGMA table_info({table})",
      },
    }
  end,
}
