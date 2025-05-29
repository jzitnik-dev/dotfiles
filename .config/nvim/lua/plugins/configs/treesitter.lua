local options = {
  ensure_installed = { "lua" },

  highlight = {
    enable = true,
    use_languagetree = true,
    disable = function(lang, buf)
      local disabled_langs = { "text" }
      return vim.tbl_contains(disabled_langs, lang)
    end,
  },

  indent = { enable = true },
}

return options
