local map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(vim.split(mode, ""), lhs, rhs, opts)
end

local L = function(key) return "<Leader>" .. key end
local C = function(cmd) return "<Cmd>" .. cmd .. "<CR>" end

-- ( Basic Mappings )---------------------------------------------------------------------------

-- Exit terminal window
vim.keymap.set('t', '<C-h>', [[<C-\><C-N><C-w>h]])

map("i",   "<A-Space>", C"normal ciw ",                                                "Just one space")
map("n",   "z=",        C"Pick spellsuggest",                                          "Spelling suggestions")
map("nxo", "sj",        C"MiniJump2d.start(MiniJump2d.builtin_opts.single_character)", "Single Jump2d")

-- ( Frequently Used Pickers )---------------------------------------------------------------------------

map("n", L" ", C"Pick files",                                         "Find files")
map("n", L",", C"Pick buffers",                                       "Switch buffer")
map("n", L"/", C"Pick buf_lines scope='current'", "Lines (current)")

-- ( Buffer )---------------------------------------------------------------------------

local new_scratch_buffer = function()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

map("n", L"ba", C"b#",                          "Alternate buffer")
map("n", L"bd", C"lua MiniBufremove.delete()",  "Delete buffer")
map("n", L"bD", C"%bd|e#|bd#",                  "Delete other buffers")
map("n", L"bs", new_scratch_buffer,             "New scratch buffer")
map("n", L"bt", C"lua MiniTrailspace.trim()",   "Trim trailspace")
map("n", L"bu", C"lua MiniBufremove.unshow()",  "Unshow buffer")
map("n", L"bw", C"lua MiniBufremove.wipeout()", "Wipeout buffer")

-- ( Explore )---------------------------------------------------------------------------

local explore_at_file = C'lua MiniFiles.open(vim.api.nvim_buf_get_name(0))'
local explore_quickfix = function()
  vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and 'cclose' or 'copen')
end
local explore_locations = function()
  vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and 'lclose' or 'lopen')
end

map("n", L"ed", C"lua MiniFiles.open()",          "Directory (cwd)")
map("n", L"ef", explore_at_file,                  "Directory (file)")
map("n", L'ei', C'edit $MYVIMRC',                 'init.lua')
map("n", L"en", C"lua MiniNotify.show_history()", "Notifications")
map("n", L"eq", explore_quickfix,                 "Quickfix")
map("n", L"el", explore_locations,                "Locations")

-- ( Find )---------------------------------------------------------------------------

map("n", L"f/", C"Pick history scope='/'",                 '"/" history')
map("n", L"f:", C"Pick history scope=':'",                 '":" history')
map("n", L"fa", C"Pick git_hunks scope='staged'",          "Added hunks (all)")
map("n", L"fA", C"Pick git_hunks path='%' scope='staged'", "Added hunks (buf)")
map("n", L"fb", C"Pick buffers",                           "Buffers")
map("n", L"fc", C"Pick git_commits",                       "Commits (all)")
map("n", L"fC", C"Pick git_commits path='%'",              "Commits (buf)")
map("n", L"fd", C"Pick diagnostic scope='all'",            "Diagnostic (workspace)")
map("n", L"fD", C"Pick diagnostic scope='current'",        "Diagnostic (buf)")
map("n", L"ff", C"Pick files",                             "Files")
map("n", L"fg", C"Pick grep_live",                         "Grep live")
map("n", L"fG", C"Pick grep pattern='<cword>'",            "Grep current word")
map("n", L"fh", C"Pick help",                              "Help tags")
map("n", L"fH", C"Pick hl_groups",                         "Highlight groups")
map("n", L"fl", C"Pick buf_lines scope='all'",             "Lines (all)")
map("n", L"fL", C"Pick buf_lines scope='current'",         "Lines (buf)")
map("n", L"fm", C"Pick git_hunks",                         "Modified hunks (all)")
map("n", L"fM", C"Pick git_hunks path='%'",                "Modified hunks (buf)")
map("n", L"fr", C"Pick resume",                            "Resume")
map("n", L"fR", C"Pick lsp scope='references'",            "References (LSP)")
map("n", L"fs", C"Pick lsp scope='workspace_symbol_live'", "Symbols workspace live")
map("n", L"fS", C"Pick lsp scope='document_symbol'",       "Symbols document")
map("n", L"fT", C"Pick colorschemes",                      "Search colorschemes")
map("n", L"fv", C"Pick visit_paths cwd=''",                "Visit paths (all)")
map("n", L"fV", C"Pick visit_paths",                       "Visit paths (cwd)")

-- ( Git )---------------------------------------------------------------------------

local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

map("n",  L"ga", C"Git diff --cached",                "Added diff")
map("n",  L"gA", C"Git diff --cached -- %",           "Added diff (buf)")
map("nx", L"gb", C"lua MiniGit.show_range_history()", "Range history")
map("n",  L"gc", C"Git commit",                       "Commit")
map("n",  L"gC", C"Git commit --amend",               "Commit amend")
map("n",  L"gd", C"Git diff",                         "Diff")
map("n",  L"gD", C"Git diff -- %",                    "Diff (buf)")
map("n",  L"gl", C(git_log_cmd),                      "Log")
map("n",  L"gL", C(git_log_buf_cmd),                  "Log (buf)")
map("n",  L"go", C"lua MiniDiff.toggle_overlay()",    "Toggle overlay")
map("nx", L"gs", C"lua MiniGit.show_at_cursor()",     "Show at cursor")

-- ( Language )---------------------------------------------------------------------------

map("nx", L"la", C"lua vim.lsp.buf.code_action()",     "Actions")
map("n",  L"ld", C"lua vim.diagnostic.open_float()",   "Diagnostic popup")
-- FIXME: formatting
-- map("nx", L"lf", C"lua require('conform').format()",   "Format")
map("n",  L"li", C"lua vim.lsp.buf.implementation()",  "Implementation")
map("n",  L"lI", C"LspInfo",                           "LSP info")
map("n",  L"lh", C"lua vim.lsp.buf.hover()",           "Hover")
map("n",  L"ll", C"lua vim.lsp.codelens.run()",        "Run codelens")
map("n",  L"lL", C"lua vim.lsp.codelens.refresh()",    "Refresh & display codelens")
map("n",  L"lr", C"lua vim.lsp.buf.rename()",          "Rename")
map("n",  L"lR", C"lua vim.lsp.buf.references()",      "References")
map("n",  L"ls", C"lua vim.lsp.buf.definition()",      "Source definition")
map("n",  L"lt", C"lua vim.lsp.buf.type_definition()", "Type definition")

-- ( Map )---------------------------------------------------------------------------

map("n", L"mf", C"lua MiniMap.toggle_focus()", "Focus")
map("n", L"mr", C"lua MiniMap.refresh()",      "Refresh")
map("n", L"ms", C"lua MiniMap.toggle_side()",  "Switch sides")
map("n", L"mt", C"lua MiniMap.toggle()",       "Toggle map")

-- ( Other )---------------------------------------------------------------------------

map("n", L"om", C"Mason",                  "Mason")
map("n", L"os", C"lua MiniStarter.open()", "Open MiniStarter")
map("n", L"ou", C"DepsUpdate",             "Update deps")
map("n", L"oc", C"DepsClean",              "Clean deps")
map("n", L"ot", C"belowright terminal",    "Open Terminal")

-- ( Session )---------------------------------------------------------------------------

map("n", L"sd", C"lua MiniSessions.select('delete')",              'Delete session')
map("n", L"sl", C"lua MiniSessions.select('read')",                'Load session')
map("n", L"sn", C"lua MiniSessions.write(vim.fn.input('Name: '))", 'New session')
map("n", L"ss", C"lua MiniSessions.write()",                       'Save session')

-- ( Visits )---------------------------------------------------------------------------

local make_pick_core = function(cwd, desc)
  return function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    local local_opts = { cwd = cwd, filter = 'core', sort = sort_latest }
    MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
  end
end

map("n", L"va", C"Pick visit_labels cwd=''",              "All labels")
map("n", L"vc", make_pick_core('', 'Core visits (all)'),  "Core visits (all)")
map("n", L"vC", make_pick_core(nil, 'Core visits (cwd)'), "Core visits (cwd)")
map("n", L"vl", C"lua MiniVisits.add_label()",            "Add label")
map("n", L"vL", C"lua MiniVisits.remove_label()",         "Remove label")
map("n", L"vv", C"lua MiniVisits.add_label('core')",      "Add core label")
map("n", L"vV", C"lua MiniVisits.remove_label('core')",   "Remove core label")

-- ( Window )---------------------------------------------------------------------------

map("n", L"wr", C"lua MiniMisc.resize_window()", "Resize to default width")
map("n", L"wz", C"lua MiniMisc.zoom()",          "Zoom window")
