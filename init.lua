pcall(require, "impatient")

if require("alpha.first_load")() then
	return
end

require("alpha.settings")

require("alpha.globals")
require("alpha.disable_builtin")
require("alpha.plugins")
require("alpha.telescope.setup")
require("alpha.telescope.mappings")
require("alpha.dap")
require("alpha.neovide")
