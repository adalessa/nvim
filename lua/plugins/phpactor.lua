local phpactor = function ()
  vim.ui.select({
    "class_inflect",
    "context_menu",
    "expand_class",
    "generate_accessor",
    "change_visibility",
    "copy_class",
    "import_class",
    "import_missing_classes",
    "move_class",
    "navigate",
    "new_class",
    "transform",
    "update",
    "config",
    "status",
    "cache_clear",
  }, {
    prompt = "Phpactor Action",
  }, function(choice)
    if choice == nil or choice == "" then
      return
    end

    -- TODO: add option for new class in same directory
    if choice == "new_class" then
      return vim.ui.input({
        prompt = "New Class",
      }, function(value)
        if value == nil then
          return
        end
        -- TODO: check filename generation to validate the path
        require("phpactor").rpc("new_class", { text_value = vim.fn.getcwd() .. '/' .. value .. ".php" })
      end)
    end

    require("phpactor").rpc(choice, {})
  end)
end

return {
  "adalessa/phpactor.nvim",
  cmd = { "PhpActor" },
  keys = {
    { "<leader>pa", phpactor, desc = "PhpActor options" },
    { "<leader>pc", ":PhpActor context_menu<cr>", desc = "PhpActor context menu" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    install = {
      bin = 'phpactor'
    },
    lspconfig = {
      enabled = false,
    },
  },
}
