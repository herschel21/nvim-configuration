return {
	"lervag/vimtex",
	ft = "tex",
	config = function()
		vim.g.vimtex_view_method = "zathura" -- Change to your PDF viewer
		vim.g.vimtex_compiler_method = "latexmk"
	end,
}
