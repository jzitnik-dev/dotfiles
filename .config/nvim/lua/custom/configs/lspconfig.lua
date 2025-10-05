local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

local servers = {
  "html", "cssls", "clangd", "ts_ls", "jsonls", "rust_analyzer", "eslint", "svelte", "tailwindcss"
}

for _, lsp in ipairs(servers) do
    -- For all other LSPs
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
end

lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "*.hujson" },
          schema = {
            allowTrailingCommas = true,
          },
        },
      },
    },
  },
}
local function get_python_path()
    local cwd = vim.fn.getcwd()
    local venv_python = cwd .. "/.venv/bin/python"        -- Linux/macOS
    local venv_python_win = cwd .. "\\.venv\\Scripts\\python.exe" -- Windows

    if vim.loop.fs_stat(venv_python) then
        return venv_python
    elseif vim.loop.fs_stat(venv_python_win) then
        return venv_python_win
    else
        return vim.fn.exepath("python") -- fallback to system python
    end
end

lspconfig.pyright.setup({
    settings = {
        python = {
            pythonPath = get_python_path(),
        },
    },
})
