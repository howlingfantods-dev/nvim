vim.keymap.set('n', '<leader>nn', ':Obsidian new_from_template<CR>', { desc = 'New note from template' })

vim.keymap.set('n', '<leader>na', ':Obsidian tags active<CR>', { desc = 'Find active notes' })
vim.keymap.set('n', '<leader>ww', function()
  vim.cmd 'ObsidianQuickSwitch Main'
end, { desc = 'Quick switch to Main' })

-- local function jump_to_or_create_todo()
--   local client = require('obsidian').get_client()
--
--   -- Search for notes with "Todo" alias using the vault search
--   local found_note = nil
--
--   -- Get all notes in the vault
--   local notes = client:find_notes ''
--
--   -- Look for a note with "Todo" alias
--   for _, note in ipairs(notes) do
--     if note.aliases then
--       for _, alias in ipairs(note.aliases) do
--         if alias == 'Todo' then
--           found_note = note
--           break
--         end
--       end
--     end
--     if found_note then
--       break
--     end
--   end
--
--   if found_note then
--     -- Jump to the todo note
--     vim.cmd('edit ' .. tostring(found_note.path))
--   else
--     -- No todo note found, create one
--     vim.cmd 'ObsidianTemplate todo'
--
--     -- Add the metadata after template loads
--     vim.defer_fn(function()
--       local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--       local new_lines = {}
--       local in_frontmatter = false
--       local frontmatter_end = 0
--
--       -- Find existing frontmatter or create it
--       for i, line in ipairs(lines) do
--         if i == 1 and line == '---' then
--           in_frontmatter = true
--           table.insert(new_lines, line)
--         elseif in_frontmatter and line == '---' then
--           -- Insert our metadata before closing frontmatter
--           table.insert(new_lines, 'aliases: [Todo]')
--           table.insert(new_lines, 'tags: [active]')
--           table.insert(new_lines, line)
--           frontmatter_end = i
--           break
--         elseif in_frontmatter then
--           table.insert(new_lines, line)
--         end
--       end
--
--       -- If no frontmatter exists, create it
--       if not in_frontmatter then
--         new_lines = {
--           '---',
--           'aliases: [Todo]',
--           'tags: [active]',
--           '---',
--           '',
--         }
--         frontmatter_end = 5
--       end
--
--       -- Add the rest of the content
--       for i = frontmatter_end + 1, #lines do
--         table.insert(new_lines, lines[i])
--       end
--
--       vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
--     end, 100)
--   end
-- end
--
-- vim.keymap.set('n', '<leader>td', jump_to_or_create_todo, { desc = 'Jump to or create Todo' })

local function create_leetcode_problem()
  -- Prompt for problem number
  vim.ui.input({ prompt = 'Enter LeetCode problem number: ' }, function(problem_id)
    if not problem_id or problem_id == '' then
      return
    end
    -- Make API request
    local curl = require 'plenary.curl'
    local api_url = 'https://leetcode-api-pied.vercel.app/problems'
    print 'Fetching problem data...'
    curl.get(api_url, {
      callback = function(response)
        vim.schedule(function()
          if response.status ~= 200 then
            print('Error fetching problem data: ' .. response.status)
            return
          end
          local success, data = pcall(vim.json.decode, response.body)
          if not success then
            print 'Error parsing API response'
            return
          end

          -- Check if data exists and is an array
          if not data or type(data) ~= 'table' then
            print 'Invalid API response'
            return
          end

          -- Find the problem by frontend_id
          local problem = nil
          for _, p in ipairs(data) do
            if p.frontend_id == problem_id then
              problem = p
              break
            end
          end

          if not problem then
            print('Problem ' .. problem_id .. ' not found')
            return
          end

          -- Generate filename with problems directory
          local filename = 'problems/' .. problem.frontend_id .. '-' .. problem.title_slug .. '.md'
          -- Create new note in problems directory
          vim.cmd('ObsidianNew ' .. filename)
          -- Wait a bit for the file to be created, then populate it
          vim.defer_fn(function()
            -- Create the content directly instead of using template substitution
            local content = {
              '# ' .. problem.frontend_id .. '. ' .. problem.title,
              '',
              '**Difficulty**: ' .. problem.difficulty,
              '**Date**: ' .. os.date '%Y-%m-%d',
              '## Problem Statement',
              problem.url,
              '## Notes',
              '',
            }
            -- Set buffer content
            vim.api.nvim_buf_set_lines(0, 0, -1, false, content)
            print('Created problem: ' .. problem.frontend_id .. '. ' .. problem.title)
          end, 200)
        end)
      end,
    })
  end)
end

-- Add this keymap with your other keymaps
vim.keymap.set('n', '<leader>nl', create_leetcode_problem, { desc = 'New LeetCode problem' })
return {

  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,

  event = {
    'BufReadPre ' .. vim.fn.expand '~' .. '/Vaults/**/*.md',
    'BufNewFile ' .. vim.fn.expand '~' .. '/Vaults/**/*.md',
  },

  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'stream',
        path = '~/Vaults/stream/',
      },
      {
        name = 'software-and-game-development',
        path = '~/Vaults/software-and-game-development/',
      },
      {
        name = 'writing-and-reading',
        path = '~/Vaults/writing-and-reading/',
      },
    },

    templates = {
      folder = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      -- Custom substitutions
      substitutions = {
        yesterday = function()
          return os.date('%Y-%m-%d', os.time() - 86400)
        end,
        tomorrow = function()
          return os.date('%Y-%m-%d', os.time() + 86400)
        end,
      },
    },

    -- Optional, configure additional syntax highlighting / extmarks.
    -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
    ui = {
      enable = true, -- set to false to disable all additional syntax features
      update_debounce = 200, -- update delay after a text change (in milliseconds)
      max_file_length = 5000, -- disable UI features for files with more than this many lines
      -- Define how various check-boxes are displayed
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '', hl_group = 'ObsidianDone' },
        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        -- Replace the above with this if you don't have a patched font:
        -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

        -- You can also add more custom ones...
      },
      -- Use bullet marks for non-checkbox lists.
      bullets = { char = '•', hl_group = 'ObsidianBullet' },
      external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
      -- Replace the above with this if you don't have a patched font:
      -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = 'ObsidianRefText' },
      highlight_text = { hl_group = 'ObsidianHighlightText' },
      tags = { hl_group = 'ObsidianTag' },
      block_ids = { hl_group = 'ObsidianBlockID' },
      hl_groups = {
        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
        ObsidianTodo = { bold = true, fg = '#f78c6c' },
        ObsidianDone = { bold = true, fg = '#89ddff' },
        ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
        ObsidianTilde = { bold = true, fg = '#ff5370' },
        ObsidianImportant = { bold = true, fg = '#d73128' },
        ObsidianBullet = { bold = true, fg = '#89ddff' },
        ObsidianRefText = { underline = true, fg = '#c792ea' },
        ObsidianExtLinkIcon = { fg = '#c792ea' },
        ObsidianTag = { italic = true, fg = '#89ddff' },
        ObsidianBlockID = { italic = true, fg = '#89ddff' },
        ObsidianHighlightText = { bg = '#75662e' },
      },
    },

    note_frontmatter_func = function(note)
      local current_time = os.date '%Y-%m-%d %H:%M'

      -- Use the first alias as the title if aliases exist
      local title = note.title
      if note.aliases and #note.aliases > 0 then
        title = note.aliases[1]
      elseif note.title then
        note:add_alias(note.title)
      end

      local out = {
        title = title, -- This will now be the alias value
        id = note.id,
        aliases = note.aliases,
        tags = note.tags,
        created = current_time,
        modified = current_time,
      }

      -- Keep original created date, but update modified
      if note.metadata ~= nil and note.metadata.created then
        out.created = note.metadata.created
      end

      return out
    end,

    -- Auto-update modified time on save
    callbacks = {
      pre_write_note = function(client, note)
        if note.metadata then
          note.metadata.modified = os.date '%Y-%m-%d %H:%M'
        end
      end,
    },
  },
}
