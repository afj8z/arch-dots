local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "
map("n", "<leader>", "<nop>")
map("v", "<leader>", "<nop>")

map("n", "<leader>o", ":update<CR> :source<CR>", { desc = "Source nvim config changes" })
map('n', '<leader>w', '<Cmd>write<CR>')
map("n", "<leader>q", ":quit<CR>")
map({ "n", "v" }, "<leader>c", "1z=")
map({ 'n', 'v' }, '<leader>n', ':norm ')

map("v", "<leader>s", [["hy:%s/<C-r>h/<C-r>h/gI<Left><Left><left>]])
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

map({ "n", "v", "x" }, "<leader>li", ":set invlist<CR>", { desc = "Toggle [l]istchars in/visible" })
map({ "n", "v", "x" }, "<leader>/", ":noh<CR>")

map("n", "<leader>e", ":Oil<CR>")
map("n", "<leader>lf", vim.lsp.buf.format)

-- buffer nav
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Previous buffer" })
map("n", "<leader>bb", ":e #<CR>")
map("n", "<leader>bs", ":vert sf #<CR>")

-- improve commands with motions
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map({ "n", "v", "x" }, "<leader>v", ":e $MYVIMRC<CR>")
