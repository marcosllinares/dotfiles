return {
	-- Harpoon plugin configuration
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = false,
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup({})
		end,
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon"):list():add()
				end,
				desc = "harpoon add file",
			},
			{
				"<leader>hh",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "harpoon native quick menu",
			},
			{
				"<leader>h1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "harpoon to file 1",
			},
			{
				"<leader>h2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "harpoon to file 2",
			},
			{
				"<leader>h3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "harpoon to file 3",
			},
			{
				"<leader>h4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "harpoon to file 4",
			},
		},
	},
    -- {
    --     "letieu/harpoon-lualine",
    --     dependencies = {
    --         {
    --             "ThePrimeagen/harpoon",
    --             branch = "harpoon2",
    --         }
    --     },
    -- },
}

