vim.g.mapleader = ","
-- nnoremap ,<space> :nohlsearch<CR>
vim.keymap.set('n', ',<space>', '<Cmd>nohlsearch<CR>') --, opts)
vim.keymap.set({ "n", "x" }, "H", "^", { desc = "Go to start line" })
vim.keymap.set({ "n", "x" }, "L", "g_", { desc = "Go to end line" })
vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select All" })

vim.keymap.set("n", "<C-j>", ":wincmd h<CR>", { silent = true, desc = "Focus Right" })
vim.keymap.set("n", "<C-k>", ":wincmd l<CR>", { silent = true, desc = "Focus Left" })
vim.keymap.set("n", "<C-l>", ":wincmd j<CR>", { silent = true, desc = "Focus Bottom" })
vim.keymap.set("n", "<C-;>", ":wincmd k<CR>", { silent = true, desc = "Focus Top" })
vim.keymap.set("n", "<leader>gn", ":Neogit<CR>", { silent = true })

