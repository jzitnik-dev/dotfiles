-- Configs
vim.opt.colorcolumn = "80"
vim.wo.relativenumber = true


-- Shortcuts
vim.api.nvim_set_keymap('n', 'mp', ':MarkdownPreview<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ms', ':MarkdownPreviewStop<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gl', ':Neogit<CR>', { noremap = true, silent = true })

