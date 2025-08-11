-- Configs
vim.opt.colorcolumn = "80"
vim.wo.relativenumber = true

-- Shortcuts
vim.api.nvim_set_keymap("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gl", ":Neogit<CR>", { noremap = true, silent = true })

vim.opt.spell = false
vim.opt.spelllang = { "en_us", "cs" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  command = "setlocal tabstop=4 shiftwidth=4 expandtab"
})
