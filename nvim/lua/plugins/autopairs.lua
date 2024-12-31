return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local npairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")

        npairs.setup({
            check_ts = true, -- Enable treesitter
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
                java = false,
            },
            disable_filetype = { "TelescopePrompt", "vim" },
            fast_wrap = {
                map = "<M-e>", -- Alt+e to wrap with brackets/quotes
                chars = { "{", "[", "(", '"', "'" },
                pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "Search",
                highlight_grey = "Comment"
            },
            enable_check_bracket_line = true, -- Don't add pairs if it already has a close pair in the same line
            ignored_next_char = "[%w%.]",     -- Will ignore alphanumeric and `.` symbol
            enable_afterquote = true,         -- add bracket pairs after quote
            enable_moveright = true,
        })

        -- Add spaces between parentheses
        local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
        npairs.add_rules {
            Rule(' ', ' ')
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({
                        brackets[1][1] .. brackets[1][2],
                        brackets[2][1] .. brackets[2][2],
                        brackets[3][1] .. brackets[3][2],
                    }, pair)
                end)
        }
        for _, bracket in pairs(brackets) do
            npairs.add_rules {
                Rule(bracket[1] .. ' ', ' ' .. bracket[2])
                    :with_pair(function() return false end)
                    :with_move(function(opts)
                        return opts.prev_char:match('.%' .. bracket[2]) ~= nil
                    end)
                    :use_key(bracket[2])
            }
        end
    end,
}
