return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local comment = require("Comment")
    local ts_integration = require("ts_context_commentstring.integrations.comment_nvim")

    comment.setup({
      pre_hook = ts_integration.create_pre_hook(),
    })

    -- Simple, standard keymaps only
    local opts = { noremap = true, silent = true }
    local api = require("Comment.api")

    -- Line comment toggle (standard vim convention)
    vim.keymap.set("n", "gcc", api.toggle.linewise.current, opts)
    vim.keymap.set("v", "gc", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
      api.toggle.linewise(vim.fn.visualmode())
    end, opts)

    -- Block comment toggle (standard vim convention)
    vim.keymap.set("n", "gbc", api.toggle.blockwise.current, opts)
    vim.keymap.set("v", "gb", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
      api.toggle.blockwise(vim.fn.visualmode())
    end, opts)
  end,
}

