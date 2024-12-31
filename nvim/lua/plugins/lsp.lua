-- File: lua/plugins/lsp.lua

return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(bufnr, ...)
            end
            -- Set omnifunc option
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
            local opts = { noremap = true, silent = true }

            buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            buf_set_keymap("n", "gi", "<cmd>lua require('plugins.lsp_utils').go_to_implementation()<CR>", opts)
            buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            buf_set_keymap("n", "<space>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

            -- Print the capabilities of the connected language server
            print("Language server capabilities for " .. client.name .. ":")
            for capability, value in pairs(client.server_capabilities) do
                print(capability, value)
            end
        end

        -- Setup language servers
        local servers = { "pyright", "clangd", "jdtls"}
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                on_attach = on_attach,
                flags = {
                    debounce_text_changes = 150,
                },
            })
        end
    end,
}
