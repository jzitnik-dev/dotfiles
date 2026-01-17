local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier.with({
    filetypes = {
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptreact",
      "css",
      "html",
      "json",
      "markdown",
    },
  }),
  formatting.stylua,
  formatting.rustfmt,
  -- diagnostics.shellcheck,
}

null_ls.setup({
  sources = sources,
})