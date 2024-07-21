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
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local wk = require("which-key")
        wk.add({
          {
            buffer = ev.buf,
            {
              mode = "n",
              { "<leader>ed", vim.diagnostic.open_float, desc = "Diagnostic" },
              { "[d", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
              { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
              { "<leader>q", vim.diagnostic.setloclist, desc = "setloclist" },
              { "gD", vim.lsp.buf.declaration, desc = "Declaration" },
              { "gd", vim.lsp.buf.definition, desc = "Definition" },
              { "gi", vim.lsp.buf.implementation, desc = "Implementation" },
              { "gk", vim.lsp.buf.signature_help, desc = "Signature Help" },
              { "gr", vim.lsp.buf.references, desc = "References" },
              { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
              { "<leader>ft", function() vim.lsp.buf.format { async = true } end, desc = "Format" },
              { "<C-;>", vim.lsp.buf.hover, desc = "Hover" },
              { "<leader>w", group = "Workspace" },
              { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add Folder" },
              { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Folder" },
              { "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List Folder" },
              { "<leader>D", vim.lsp.buf.type_definition, desc = "Type Definition" },
            },
            {
              mode = { "n", "v" },
              { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
            },
          },
        })
      end,
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig').clangd.setup {
      capabilities = capabilities
    }
    require('lspconfig').verible.setup {
      capabilities = capabilities,
      cmd = {
        "verible-verilog-ls"
      },
      root_dir = function() return vim.loop.cwd() end
    }
    require('lspconfig').zls.setup {
      capabilities = capabilities
    }
  end
}
