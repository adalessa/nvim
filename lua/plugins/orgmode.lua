return {
  "nvim-orgmode/orgmode",
  keys = {
    { "<Leader>oa" },
    { "<Leader>oc" },
  },
  ft = { "org" },
  config = function()
    require("orgmode").setup_ts_grammar()
    require("orgmode").setup {
      org_agenda_files = { "~/my-orgs/**/*" },
      org_default_notes_file = "~/my-orgs/refile.org",
    }
    require("cmp").setup { sources = { { name = "orgmode" } } }
  end,
}
