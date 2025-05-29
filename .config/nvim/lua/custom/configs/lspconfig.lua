local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

local servers = {
  "html", "cssls", "clangd", "ts_ls", "jsonls", "pyright", "rust_analyzer", "eslint", "svelte", "tailwindcss"
}

for _, lsp in ipairs(servers) do
    -- For all other LSPs
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
end


