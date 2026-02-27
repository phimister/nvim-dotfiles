# nvim-dotfiles
minimal neovim config with mini.nvim
packages managed with `mini.deps` (NOTE: switch to vim.pack.add() in 0.12+)

References:
- [mini.nvim](https://github.com/nvim-mini/mini.nvim)
- [mini.deps](https://nvim-mini.org/mini.nvim/scripts/init-deps-example.lua)
- [example1](https://gitlab.com/domsch1988/mvim/-/blob/main/init.lua)
- [example2](https://github.com/echasnovski/nvim/blob/master/plugin/10_options.lua)

# TODO
- Configure LSP
- Setup keymaps
- Update clues
- Revisit FIXMEs

```
# jump2d find from 1 character input
:lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)`

# toggle inline diff
:lua MiniDiff.toggle_overlay()`
```
