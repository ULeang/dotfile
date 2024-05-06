return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- nvim >= 0.10.0
        vim.lsp.inlay_hint.enable(true)

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        local wk = require("which-key")
        wk.register({
          ["<leader>ed"] = { vim.diagnostic.open_float, "Diagnostic" },
          ["[d"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
          ["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
          ["<leader>q"] = { vim.diagnostic.setloclist, "setloclist" },
        }, opts)
        wk.register({
          ["g"] = {
            D = { vim.lsp.buf.declaration, "Declaration" },
            d = { vim.lsp.buf.definition, "Definition" },
            i = { vim.lsp.buf.implementation, "Implementation" },
            k = { vim.lsp.buf.signature_help, "Signature Help" },
            r = { vim.lsp.buf.references, "References" },
          },
          ["<leader>"] = {
            w = {
              name = "workspace",
              a = { vim.lsp.buf.add_workspace_folder, "Add Folder" },
              r = { vim.lsp.buf.remove_workspace_folder, "Remove Folder" },
              l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List Folder" },
            },
            D = { vim.lsp.buf.type_definition, "Type Definition" },
          },
          ["<leader>rn"] = { vim.lsp.buf.rename, "Rename" },
          ["<leader>ft"] = { function() vim.lsp.buf.format { async = true } end, "Format" },
          ["<C-;>"] = { vim.lsp.buf.hover, "Hover" };
        }, opts)
        wk.register({
          ["<leader>ca"] = { vim.lsp.buf.code_action, "Code Action" },
        },{ buffer = ev.buf, mode = { "n", "v" } })
      end,
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig').clangd.setup {
      capabilities = capabilities
    }
    require('lspconfig').verible.setup{
      cmd = {
        "verible-verilog-ls"
      },
      root_dir = function() return vim.loop.cwd() end
    }
  end
}
