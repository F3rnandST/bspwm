-- local null_ls = require('null-ls')

-- local formatting = null_ls.builtins.formatting

-- null_ls.setup({
--   sources = {
--     formatting.prettier, formatting.black, formatting.gofmt, formatting.shfmt,
--     formatting.clang_format, formatting.cmake_format, formatting.dart_format,
--     formatting.lua_format.with({
--       extra_args = {
--         '--no-keep-simple-function-one-line', '--no-break-after-operator', '--column-limit=100',
--         '--break-after-table-lb', '--indent-width=2'
--       }
--     }), formatting.isort, formatting.codespell.with({ filetypes = { 'markdown' } })
--   },
-- })


local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    formatting.prettier, formatting.black, formatting.gofmt, formatting.shfmt,
    formatting.clang_format, formatting.cmake_format, formatting.dart_format,
    formatting.lua_format.with({
      extra_args = {
        '--no-keep-simple-function-one-line', '--no-break-after-operator', '--column-limit=100',
        '--break-after-table-lb', '--indent-width=2'
      }
    }), formatting.isort, formatting.codespell.with({ filetypes = { 'markdown' } })
  },
  on_attach = function(client)
    -- if client.resolved_capabilities.document_formatting then
    --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
    -- end
      -- if client.server_capabilities.document_highlight then
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end
    illuminate.on_attach(client)
  -- end
    vim.cmd [[
      augroup document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
})
