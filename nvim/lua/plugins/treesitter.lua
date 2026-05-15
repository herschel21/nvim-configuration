return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false, -- new nvim-treesitter does not support lazy-loading
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		-- Install parsers (async; no-op if already installed)
		require("nvim-treesitter").install({
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
		})

		-- Enable treesitter highlighting and indentation per filetype
		local ts_group = vim.api.nvim_create_augroup("treesitter_setup", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = ts_group,
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		-- Incremental selection using built-in Neovim 0.12 treesitter API
		vim.keymap.set("n", "<C-space>", function()
			local node = vim.treesitter.get_node()
			if not node then return end
			local sr, sc, er, ec = node:range()
			vim.fn.cursor(sr + 1, sc + 1)
			vim.cmd("normal! v")
			vim.fn.cursor(er + 1, ec)
		end, { desc = "Select treesitter node" })

		vim.keymap.set("x", "<C-space>", function()
			local node = vim.treesitter.get_node()
			if not node then return end
			local parent = node:parent()
			if not parent then return end
			local sr, sc, er, ec = parent:range()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
			vim.fn.cursor(sr + 1, sc + 1)
			vim.cmd("normal! v")
			vim.fn.cursor(er + 1, ec)
		end, { desc = "Expand treesitter selection to parent node" })

		vim.keymap.set("x", "<bs>", function()
			local node = vim.treesitter.get_node()
			if not node then return end
			local child = node:child(0)
			if not child then return end
			local sr, sc, er, ec = child:range()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
			vim.fn.cursor(sr + 1, sc + 1)
			vim.cmd("normal! v")
			vim.fn.cursor(er + 1, ec)
		end, { desc = "Shrink treesitter selection to child node" })

		-- Textobject keymaps (new API)
		local to_select = require("nvim-treesitter-textobjects.select")
		vim.keymap.set({ "x", "o" }, "af", function()
			to_select.select_textobject("@function.outer", "textobjects")
		end, { desc = "Select outer function" })
		vim.keymap.set({ "x", "o" }, "if", function()
			to_select.select_textobject("@function.inner", "textobjects")
		end, { desc = "Select inner function" })
		vim.keymap.set({ "x", "o" }, "ac", function()
			to_select.select_textobject("@class.outer", "textobjects")
		end, { desc = "Select outer class" })
		vim.keymap.set({ "x", "o" }, "ic", function()
			to_select.select_textobject("@class.inner", "textobjects")
		end, { desc = "Select inner class" })
	end,
}
