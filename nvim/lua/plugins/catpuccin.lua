return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    -- Track transparency state
    local bg_transparent = false

    -- Define the toggle function
    local toggle_transparency = function()
      bg_transparent = bg_transparent
      require("catppuccin").setup({
        transparent_background = bg_transparent,
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end

    -- Initial setup with same config
    toggle_transparency()
    
    -- Set up keymap
    vim.keymap.set("n", "<leader>z", toggle_transparency, { noremap = true, silent = true })
  end,
}

