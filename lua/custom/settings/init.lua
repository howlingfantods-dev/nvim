-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Escape from insert mode by typing 'jk'
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })

-- Set clipboard to use system clipboard on startup
vim.opt.clipboard = 'unnamedplus'

vim.opt.conceallevel = 1

-- Ensure clipboard is set correctly after plugins load
vim.defer_fn(function()
  vim.opt.clipboard = 'unnamedplus'
end, 100)

-- Re-apply clipboard setting when focusing Neovim or entering a buffer
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained' }, {
  callback = function()
    vim.opt.clipboard = 'unnamedplus'
  end,
})

-- Override the gf key with our custom function
vim.api.nvim_set_keymap('n', 'gf', ':lua OpenFileOrURL()<CR>', { noremap = true, silent = true })

-- Override the gf key with our custom function
vim.api.nvim_set_keymap('n', 'gf', ':lua OpenFileOrURL()<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>dt', function()
  vim.api.nvim_put({ os.date '%Y-%m-%d' }, 'c', true, true)
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>rr', function()
  for name, _ in pairs(package.loaded) do
    if name:match '^my_config' then -- Adjust this prefix to match your Lua modules
      package.loaded[name] = nil
    end
  end
  vim.cmd 'source $MYVIMRC'
  print 'Neovim config fully reloaded!'
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*/vimwiki/School/main.cpp',
  callback = function()
    vim.fn.system('cp ' .. vim.fn.expand '%:p' .. ' ~/vimwiki/School/main.txt')
  end,
})

-- Make line numbers default
vim.opt.number = true
-- Enable relative line numbers
-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight matches as you type during search
vim.opt.incsearch = true

-- Do not highlight all matches after search
vim.opt.hlsearch = false

-- Decrease update time
vim.opt.updatetime = 250

-- Set delay time for triggering plugins and showing messages in milliseconds
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 18

-- Set the number of spaces a tab character represents
vim.opt.tabstop = 4
-- Set the number of spaces inserted for a tab in insert mode
vim.opt.softtabstop = 4
-- Convert tabs to spaces
vim.opt.expandtab = true
-- Set the number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2
-- Set the maximum width of text before it wraps
vim.opt.textwidth = 80

-- Display a vertical line at column 80 as a guide
vim.opt.colorcolumn = '80'

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.keymap.set('n', '<leader>c', ':CsvViewToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>g', ':Goyo<CR>', { noremap = true, silent = true })

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Disable curly braces key mappings
vim.api.nvim_set_keymap('n', '{', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '}', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '{', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '}', '<Nop>', { noremap = true, silent = true })

-- Disable square brackets key mappings
vim.api.nvim_set_keymap('n', '[', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '[', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ']', '<Nop>', { noremap = true, silent = true })

-- Move selected lines down with 'J' in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
-- Move selected lines up with 'K' in visual mode
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Disable the 'Q' and 'q' commands in normal mode (Ex mode)
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'q', '<nop>')

-- Disable nvim suspension
vim.api.nvim_set_keymap('n', '<C-z>', '<Nop>', { noremap = true, silent = true })

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Create a directory for your definitions if it doesn't exist
local definitions_dir = vim.fn.expand '~/Books/definitions/'
vim.fn.mkdir(definitions_dir, 'p')

-- dict look up
function show_dict_definition()
  -- Get the word under the cursor
  local word = vim.fn.expand '<cword>'

  if word == '' then
    print 'No word under cursor'
    return
  end

  -- Run the dict command and capture output
  local cmd = 'dict ' .. vim.fn.shellescape(word)
  local output = vim.fn.system(cmd)

  -- Check if command was successful
  if vim.v.shell_error ~= 0 then
    print('Dict command failed or no definition found for: ' .. word)
    return
  end

  -- Split output into lines
  local lines = vim.split(output, '\n')

  -- Create floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.7)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' Dictionary: ' .. word .. ' ',
    title_pos = 'center',
  }

  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Set up close keymap
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', {
    callback = function()
      vim.api.nvim_win_close(win, true)
    end,
    noremap = true,
    silent = true,
  })

  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '', {
    callback = function()
      vim.api.nvim_win_close(win, true)
    end,
    noremap = true,
    silent = true,
  })
end

-- Set up the keymap
vim.keymap.set('n', '<leader>d', show_dict_definition, {
  desc = 'Show dictionary definition for word under cursor',
})

vim.keymap.set('n', '<leader>wr', ':set wrap!<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>td', function()
  vim.cmd('edit ' .. vim.fn.expand '~/.todo.md')
end, { noremap = true, silent = true, desc = 'Open todo.md' })
