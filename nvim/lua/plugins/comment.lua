return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  config = function()
    local comment = require("Comment")

    comment.setup({
      -- 🔥 Force correct comment style for C/C++
      pre_hook = function(ctx)
        local ft = vim.bo.filetype

        -- 🚨 HARD FORCE for C/C++
        if ft == "c" or ft == "cpp" or ft == "h" or ft == "hpp" then
          -- In nvim 0.12.0, ensures commentstring is exactly what we want
          return "// %s"
        end

        -- fallback to Treesitter for other languages
        local internal_ok, internal_ts_integration = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
        if internal_ok then
          local ret = internal_ts_integration.create_pre_hook()(ctx)
          if ret then
            return ret
          end
        end

        -- Final fallback to native commentstring (fixing the 'nil' error)
        return vim.bo.commentstring
      end,

      -- Keymaps (standard)
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },

      -- Cleaner behavior
      ignore = "^$",
    })

    -- 🔥 ABSOLUTE OVERRIDE (nothing beats this)
    vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
      pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
      callback = function()
        vim.bo.commentstring = "// %s"
      end,
    })

    -- Optional manual mappings (rock solid)
    local api = require("Comment.api")
    local opts = { noremap = true, silent = true }

    -- Line comment
    vim.keymap.set("n", "gcc", api.toggle.linewise.current, opts)
    vim.keymap.set("v", "gc", function()
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
        "nx",
        false
      )
      api.toggle.linewise(vim.fn.visualmode())
    end, opts)

    -- Block comment
    vim.keymap.set("n", "gbc", api.toggle.blockwise.current, opts)
    vim.keymap.set("v", "gb", function()
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
        "nx",
        false
      )
      api.toggle.blockwise(vim.fn.visualmode())
    end, opts)
  end,
}
