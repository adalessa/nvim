local keys = {}
local terms = 3
local binds = 5

table.insert(keys, {
  "<leader>ss",
  function()
    require("harpoon.ui").toggle_quick_menu()
  end,
})

table.insert(keys, {
  "<leader>sa",
  function()
    require("harpoon.mark").add_file()
  end,
})

table.insert(keys, {
  "<leader>st",
  function ()
    vim.api.nvim_command([[vsplit]])
    require("harpoon.term").gotoTerminal(1)
    vim.api.nvim_command([[startinsert]])
  end
})

for i = 1, terms do
  table.insert(keys, {
    string.format("<leader><leader>%s", i),
    function()
      require("harpoon.term").gotoTerminal(i)
    end,
  })
end

for i = 1, binds do
  table.insert(keys, {
    string.format("<leader>%s", i),
    function()
      require("harpoon.ui").nav_file(i)
    end,
  })
end

return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
  },
  keys = keys,
  opts = {
    global_settings = {
      enter_on_sendcmd = true,
    },
    projects = {
      ["$HOME/code/svelte/snippets"] = {
        term = {
          cmds = {
            "npm run dev",
          },
        },
      },
    },
  },
}
