# My Neovim Config
A minimal Neovim config built around [mini.nvim][mini]. *Heavily* inspired by [echasnovski/nvim][1] and [pkazmier/nvim][2].

[mini]: https://nvim-mini.org/mini.nvim/
[1]: https://github.com/echasnovski/nvim
[2]: https://github.com/pkazmier/nvim

Configured for `NVIM v0.11.6`, this includes:
- The `mini.nvim` suite
- `nvim-treesitter`, with:
    - `nvim-treesitter-textobjects`
    - `nvim-treesitter-context`
- LSP with `lspconfig` and `Mason`
- `friendly-snippets`

**Packages managed with `mini.deps`.**

> [!NOTE]
> Nvim 0.12+ offers `vim.pack.add()` and an included `undotree` plugin.

