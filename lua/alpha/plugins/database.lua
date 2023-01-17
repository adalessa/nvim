return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        "tpope/vim-dadbod",
        "kristijanhusak/vim-dadbod-completion",
        "tpope/vim-dotenv",
    },
    config = function ()
        require("alpha.database")
    end
}
