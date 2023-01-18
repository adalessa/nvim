return {
    "ThePrimeagen/git-worktree.nvim",
    keys = {
        { "<leader>gt", function() require("telescope").extensions.git_worktree.git_worktrees() end },
        { "<leader>gn", function() require("telescope").extensions.git_worktree.create_git_worktree() end },
    },
    config = function()
        require("git-worktree").setup({})
        require("telescope").load_extension("git_worktree")
    end,
}
