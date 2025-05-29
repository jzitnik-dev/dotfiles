local none_ls = require("null-ls")

none_ls.setup({
  formatters = {
    prettier = {
      command = "prettier",
      args = { "--stdin-filepath", "$FILENAME" },
      filetypes = { "javascript", "typescript", "css", "html", "json", "markdown" },
    },
    stylua = {
      command = "stylua",
      args = { "-" },
      filetypes = { "lua" },
    },
    rustfmt = {
      command = "rustfmt",
      args = { "--emit=stdout" },
      filetypes = { "rust" },
    },
  },

  linters = {
    shellcheck = {
      command = "shellcheck",
      args = { "--format=gcc", "-" },
      filetypes = { "sh", "bash" },
      parse_stderr = false,
      offset_line = 0,
      offset_column = 0,
      source = "shellcheck",
      severity = "warning",
    },
  },
})
