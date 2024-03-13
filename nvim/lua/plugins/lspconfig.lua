return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local wk = require("which-key")
    wk.register({
      ["<leader>ed"] = { vim.diagnostic.open_float, "Diagnostic" },
      ["[d"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
      ["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
      ["<leader>q"] = { vim.diagnostic.setloclist, "setloclist" },
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
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
            K = { vim.lsp.buf.hover, "Man" },
          },
          ["<leader>rn"] = { vim.lsp.buf.rename, "Rename" },
          ["<leader>ft"] = { function() vim.lsp.buf.format { async = true } end, "Format" },
        }, opts)
        wk.register({
          ["<leader>ca"] = { vim.lsp.buf.code_action, "Code Action" },
        },{ buffer = ev.buf, mode = { "n", "v" } })
      end,
    })
    require("lspconfig").pyright.setup{}
    require("lspconfig").clangd.setup{
      on_attach = function()
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
      end
    }
  end
}
