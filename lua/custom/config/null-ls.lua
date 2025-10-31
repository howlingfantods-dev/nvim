-- NOTE: none-ls is currently disabled in favor of:
-- - nvim-lint (for linting)
-- - conform.nvim (for formatting)
-- If you want to use none-ls, configure sources here.
-- Otherwise, you can remove the none-ls plugin from custom/plugins/init.lua

return {
  sources = {},
  -- Uncomment below to add none-ls sources
  -- sources = {
  --   null_ls.builtins.formatting.prettier,
  --   null_ls.builtins.diagnostics.eslint_d,
  -- },
}
