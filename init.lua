-- ( init )----------------------------------------------

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


-- ( now )----------------------------------------------
now(function()
  vim.g.mapleader = ' '

  vim.o.mouse = 'a'
  vim.o.backup = false
  vim.o.undofile = true
  vim.o.confirm = true
  vim.o.autoindent = true
  vim.o.expandtab = true
  vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
  vim.o.tabstop = 2 -- Show tab as this number of spaces
  vim.o.scrolloff = 20
  vim.o.virtualedit = 'block' -- Allow going past end of line in blockwise mode
  vim.o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part
  vim.o.spelloptions = 'camel' -- Treat camelCase word parts as separate words

  -- FIXME: delete or keep ??
  vim.o.switchbuf = 'usetab'
  vim.o.breakindentopt = 'list:-1'  -- Add padding for lists (if 'wrap' is set)
  vim.o.colorcolumn    = '+1'       -- Draw column on the right of maximum width
  vim.o.list           = true       -- Show helpful text indicators
  vim.o.formatoptions = 'rqnl1j'   -- Improve comment editing
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

now(function()
  -- Don't show 'Text' suggestions
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
  end
  require('mini.completion').setup()

  -- FIXME: https://nvim-mini.org/mini.nvim/doc/mini-completion.html#module-helpfulmappings
  -- require('mini.completion').setup({
  --   lsp_completion = { source_func = 'omnifunc', auto_setup = false, process_items = process_items },
  -- })

  -- -- Set up LSP part of completion
  -- local on_attach = function(args) vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end
  -- _G.Config.new_autocmd('LspAttach', '*', on_attach, 'Custom `on_attach`')
  -- if vim.fn.has('nvim-0.11') == 1 then vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() }) end

  -- vim.lsp.on_type_formatting.enable()
  -- vim.o.autocomplete = true
end)


-- ( later )--------------------------------------------

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
later(function() require('mini.visits').setup() end)
later(function() require('mini.extra').setup() end)
later(function() require('mini.jump').setup() end)
later(function() require('mini.cursorword').setup() end)

later(function() require('mini.git').setup() end)
later(function() require('mini.diff').setup() end)

-- later(function() require('mini.colors').setup() end)
-- later(function() require('mini.animate').setup() end)

later(function()
  -- disable `shellcmd` autocomplete
  local block_compltype = { shellcmd = true }
  require('mini.cmdline').setup({
    autocomplete = {
      predicate = function()
        return not block_compltype[vim.fn.getcmdcompltype()]
      end,
    },
  })
end)

later(function()
  local jump2d = require('mini.jump2d')
  jump2d.setup({
    spotter = jump2d.gen_spotter.pattern('[^%s%p]+'),
    labels = 'qwerasdfzxcv',
    view = { dim = true, n_steps_ahead = 2 },
  })
end)

later(function()
  require('mini.pick').setup()
  vim.ui.select = MiniPick.ui_select
end)

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

later(function()
  local map = require('mini.map')
  local gen_integr = map.gen_integration
  map.setup({
    symbols = { encode = map.gen_encode_symbols.dot('4x2') },
    integrations = { gen_integr.builtin_search(), gen_integr.diff(), gen_integr.diagnostic() },
  })
  for _, key in ipairs({'n', 'N', '*', '#'}) do
    vim.keymap.set('n', key, key .. 'zv<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>')
  end
end)

later(function()
  local hipatterns = require('mini.hipatterns')
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
      hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
      todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
      note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

later(function()
  require('mini.keymap').setup()
  MiniKeymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
  MiniKeymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
  MiniKeymap.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
  MiniKeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

later(function()
  local latex_patterns = { 'latex/**/*.json', '**/latex.json' }
  local lang_patterns = {
    tex = latex_patterns,
    plaintex = latex_patterns,
    -- Recognize special injected language of markdown tree-sitter parser
    markdown_inline = { 'markdown.json' },
  }
  local gen_loader = require('mini.snippets').gen_loader
  require('mini.snippets').setup({
    snippets = {
      gen_loader.from_file('~/.config/nvim/snippets/global.json'),
      gen_loader.from_lang({ lang_patterns = lang_patterns }),
    },
    mappings = {
      expand = '<C-Down>',
      jump_next = '<C-Right>',
      jump_prev = '<C-Left>',
    },
  })
  MiniSnippets.start_lsp_server()
end)


-- ( plugins )--------------------------------------------

later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })

  -- Ensure installed
  local ensure_languages = {
    'bash', 'c', 'cpp', 'css', 'diff', 'go',
    'html', 'javascript', 'json', 'rust', 'ruby', 'perl', 'python',
    'regex', 'toml', 'lua', 'vimdoc'
  }
  local isnt_installed = function(lang) return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0 end
  local to_install = vim.tbl_filter(isnt_installed, ensure_languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  -- Ensure enabled
  local filetypes = vim.iter(ensure_languages):map(vim.treesitter.language.get_filetypes):flatten():totable()
  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  vim.api.nvim_create_autocmd('FileType', {pattern = filetypes, callback = ts_start, desc = 'Ensure enabled tree-sitter'})
end)

-- FIXME: mason, lspconfig, etc.
-- now(function()
--   -- Use other plugins with `add()`. It ensures plugin is available in current
--   -- session (installs if absent)
--   add({
--     source = 'neovim/nvim-lspconfig',
--     -- Supply dependencies near target plugin
--     depends = { 'williamboman/mason.nvim' },
--   })
-- end)


later(function() add({ source = 'https://github.com/rafamadriz/friendly-snippets' }) end)

