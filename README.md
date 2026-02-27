# nvim-dotfiles
minimal neovim config with mini.nvim
packages managed with `mini.deps` (NOTE: switch to vim.pack.add() in 0.12+)

References:
- [mini.nvim](https://github.com/nvim-mini/mini.nvim)
- [mini.deps](https://nvim-mini.org/mini.nvim/scripts/init-deps-example.lua)
- [example1](https://gitlab.com/domsch1988/mvim/-/blob/main/init.lua)
- [example2](https://github.com/echasnovski/nvim/blob/master/plugin/10_options.lua)

# FUTURE TODO
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets/tree/main)
- `:lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)`
- `:lua MiniDiff.toggle_overlay()`
- single char jump sj<char> `vim.keymap.set({ 'n', 'x', 'o' }, 'sj', function() MiniJump2d.start(MiniJump2d.builtin_opts.single_character) end)`
