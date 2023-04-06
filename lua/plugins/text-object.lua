return {
	"chrisgrieser/nvim-various-textobjs",
  enabled = false,
  event = "VeryLazy",
	config = function ()
		require("various-textobjs").setup({ useDefaultKeymaps = true })
	end,
}
