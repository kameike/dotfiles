

-- 旧vimrcの読み込み
-- local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
-- vim.cmd.source(vimrc)


print("Hello user! Welcome to Neovim!")

-- キーマッピングの設定
vim.api.nvim_set_keymap('n', '<leader>ww', ':w<CR>', { noremap = true })

