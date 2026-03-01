# Nvim Dotfiles
minimal neovim config with mini.nvim
packages managed with `mini.deps` 

References:
- [mini.nvim](https://github.com/nvim-mini/mini.nvim)
- [mini.deps](https://nvim-mini.org/mini.nvim/scripts/init-deps-example.lua)
- [example1](https://gitlab.com/domsch1988/mvim/-/blob/main/init.lua)
- [example2](https://github.com/echasnovski/nvim/blob/master/plugin/10_options.lua)
- [example3](https://github.com/pkazmier/nvim)

## TO-DO
- Setup keymaps
- Update clues
- Revisit FIXMEs

> [!NOTE]
> switch to vim.pack.add() in 0.12+
> also bubilt-in undotree plugin

``` lua
-- jump2d find from 1 character input
MiniJump2d.start(MiniJump2d.builtin_opts.single_character)`

-- toggle inline diff
MiniDiff.toggle_overlay()`

-- Mini.Extra pickers
```
