return {
	"chrisgrieser/nvim-various-textobjs",
  event = "VeryLazy",
	config = function ()
		require("various-textobjs").setup({ useDefaultKeymaps = true })
	end,
}
