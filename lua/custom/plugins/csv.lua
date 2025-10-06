return {
  'hat0uma/csvview.nvim',
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = {
      --- @type integer
      async_chunksize = 50,
      --- @type CsvView.Options.Parser.Delimiter
      delimiter = {
        default = ',',
        ft = {
          tsv = '\t',
        },
      },

      --- @type string
      quote_char = '"',

      --- @type string[]
      comments = {},
      keymaps = {
        textobject_field_inner = { 'if', mode = { 'o', 'x' } },
        textobject_field_outer = { 'af', mode = { 'o', 'x' } },
        jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
        jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
        jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
        jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
      },
    },
    cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
  },
}
