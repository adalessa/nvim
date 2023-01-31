return {
  "phaazon/mind.nvim",
  branch = "v2.2",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "MindOpenMain", "MindOpenProject" },
  config = function()
    local dirs = {}
    if vim.fn.isdirectory "/mnt/nas/alpha/mind/data" == 1 then
      dirs = {
        state_path = "/mnt/nas/alpha/mind/mind.json",
        data_dir = "/mnt/nas/alpha/mind/data",
      }
    end
    require("mind").setup { persistence = dirs }
  end,
}
