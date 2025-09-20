return {
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle UndoTree panel" },
        },
        config = function()
        end,
        -- cmd = { "UndotreeToggle", "UndotreePersistUndo" },
    },
}

