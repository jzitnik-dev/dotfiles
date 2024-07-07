-- Configs
vim.opt.colorcolumn = "80"
vim.wo.relativenumber = true

-- Shortcuts
vim.api.nvim_set_keymap("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gl", ":Neogit<CR>", { noremap = true, silent = true })
