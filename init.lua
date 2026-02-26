-- minimal neovim config with mini.nvim
-- packages managed with `mini.deps` (NOTE: switch to vim.pack.add() in 0.12+)
--
-- ------------------------------------------------------------------------------

-- First time setup for 'mini.nvim', clone manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/nvim-mini/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps'
require('mini.deps').setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- (now)----------------------------------------------
now(function()
  vim.g.mapleader = ' '

  vim.o.mouse = 'a'
  -- vim.o.swapfile = false
  -- vim.o.updatetime = 1000
  vim.o.backup = false
  vim.o.undofile = true
  vim.o.confirm = true
  -- vim.o.showmode = true
  vim.o.autoindent = true
  vim.o.expandtab = true
  vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
  vim.o.tabstop = 2 -- Show tab as this number of spaces
  vim.o.scrolloff = 16

  -- delete or keep ??
  -- vim.o.softtabstop = 2
  vim.o.switchbuf = 'usetab'
  vim.o.breakindentopt = 'list:-1'  -- Add padding for lists (if 'wrap' is set)
  vim.o.colorcolumn    = '+1'       -- Draw column on the right of maximum width
  vim.o.list           = true       -- Show helpful text indicators
  vim.o.formatoptions = 'rqnl1j'   -- Improve comment editing
  vim.o.spelloptions  = 'camel'    -- Treat camelCase word parts as separate words
  vim.o.virtualedit   = 'block'    -- Allow going past end of line in blockwise mode
  vim.o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part
  -- Pattern for a start of 'numbered' list (used in `gw`). This reads as
  -- "Start of list item is: at least one special character (digit, -, +, *)
  -- possibly followed by punctuation (. or `)`) followed by at least one space".
  vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]
  -- Built-in completion
  vim.o.complete    = '.,w,b,kspell'     -- Use less sources
  vim.o.completeopt = 'menuone,noselect' -- Use custom behavior

  vim.cmd('colorscheme randomhue')
end)

now(function()
  require("mini.basics").setup({
    options = {
      basic = true,
      extra_ui = true,
      win_borders = "bold",
    },
    mappings = {
      basic = true,
      windows = true,
    },
    autocommands = {
      basic = true,
      relnum_in_visual_mode = true,
    },
  })
end)

now(function() require('mini.icons').setup() end)
now(function() require('mini.notify').setup() end)
now(function() require('mini.starter').setup() end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.sessions').setup() end)
now(function() require('mini.tabline').setup() end)

now(function()
  require('mini.misc').setup()
  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
  MiniMisc.setup_termbg_sync()
end)

-- (later)--------------------------------------------

later(function() require('mini.ai').setup() end)
later(function() require('mini.align').setup() end)
later(function() require('mini.comment').setup() end)
later(function() require('mini.operators').setup() end)
later(function() require('mini.splitjoin').setup() end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.trailspace').setup() end)
later(function() require('mini.indentscope').setup() end)
later(function() require('mini.bracketed').setup() end)
later(function() require('mini.bufremove').setup() end)
later(function() require('mini.pick').setup() end)
later(function() require('mini.visits').setup() end)
later(function() require('mini.extra').setup() end)
later(function() require('mini.jump').setup() end)


later(function() require('mini.cursorword').setup() end)
later(function() require('mini.cmdline').setup() end)
later(function() require("mini.map").setup() end)
-- later(function() require('mini.colors').setup() end)
-- later(function() require('mini.animate').setup() end)

-- TODO:
-- later(function() require('mini.jump2d').setup() end)
-- later(function() require('mini.hipatterns').setup() end)
-- fix map ??
-- git?
-- completion
-- treesitter + lsp

later(function() require('mini.files').setup({
  mappings = {
    close       = '<ESC>',
    go_in       = '<Right>',
    go_in_plus  = '<CR>',
    go_out      = '<Left>',
    go_out_plus = '<S-Left>',
    show_help   = 'h',
  },
  windows = {
    preview = true,
    border = "rounded",
    width_preview = 80,
  },
})
end)

later(function() require('mini.pairs').setup({ modes = { insert = true, command = true, terminal = false } }) end)

later(function()
  require('mini.move').setup({
    mappings = {
      left = '<S-Left>',
      right = '<S-Right>',
      up = '<S-Up>',
      down = '<S-Down>',
      line_left = '<S-Left>',
      line_right = '<S-Right>',
      line_up = '<S-Up>',
      line_down = '<S-Down>',
    }
  })
end)

later(function()
  local miniclue = require('mini.clue')
  miniclue.setup({
    triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
      { mode =   'n',        keys = '\\' },       -- mini.basics
      { mode = { 'n', 'x' }, keys = '[' },        -- mini.bracketed
      { mode = { 'n', 'x' }, keys = ']' },
      { mode =   'i',        keys = '<C-x>' },    -- Built-in completion
      { mode = { 'n', 'x' }, keys = 'g' },        -- `g` key
      { mode = { 'n', 'x' }, keys = "'" },        -- Marks
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'n', 'x' }, keys = '"' },        -- Registers
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode =   'n',        keys = '<C-w>' },    -- Window commands
      { mode = { 'n', 'x' }, keys = 's' },        -- `s` key
      { mode = { 'n', 'x' }, keys = 'z' },        -- `z` key
    },
    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
    window = {
      delay = 300
    }
  })
end)

