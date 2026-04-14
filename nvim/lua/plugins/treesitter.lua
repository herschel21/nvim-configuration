return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		-- In nvim-treesitter v1.0.0+, the 'configs' module is removed.
		-- Basics like highlighting and indentation are now handled automatically 
        -- or via the new simplified API.
        
        -- If you are using a newer version of nvim-treesitter, you can configure 
        -- it via the new 'nvim-treesitter.parsers' or similar modules if needed, 
        -- but most users can just rely on defaults.
        
        -- To maintain backward compatibility with plugins that still expect setup(),
        -- we check if the old module exists.
		-- Configuration for nvim-treesitter v1.0.0+ and older versions
		local configs = nil
		local ok_old, configs_old = pcall(require, "nvim-treesitter.configs")
		if ok_old then
			configs = configs_old
		else
			local ok_new, configs_new = pcall(require, "nvim-treesitter")
			if ok_new then
				configs = configs_new
			end
		end

		if configs then
			configs.setup({
				ensure_installed = {
					"c",
					"cpp",
					"lua",
					"vim",
					"vimdoc",
					"python",
					"bash",
					"markdown",
					"markdown_inline",
					"json",
					"yaml",
					"gitcommit",
					"git_rebase",
				},
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						scope_incremental = "<Tab>",
						node_decremental = "<S-Tab>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
				},
			})
		end
	end,
}
