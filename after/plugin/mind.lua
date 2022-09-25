local ok, mind = pcall(require, "mind")
if not ok then
	return
end

mind.setup({
	persistence = {
		state_path = "/mnt/nas/alpha/mind/mind.json",
        data_dir = "/mnt/nas/alpha/mind/data"
	},
})
