-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Use vim.keymap.set

vim.api.nvim_set_keymap("n", "<leader>cpc", ":CopilotChat<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cpe", ":CopilotChatExplain<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cpf", ":CopilotChatFix<CR>", { noremap = true, silent = true })
