return {
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    event = "VeryLazy",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local opt = { noremap = true, silent = true }
      local builtin = require('telescope.builtin')
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          f = {
            name = "Telescope",
            f = { builtin.find_files, "Find Files" },
            g = { builtin.live_grep, "Live Grep" },
            b = { builtin.buffers, "Buffers" },
            h = { builtin.help_tags, "Help Tags" },
            r = { builtin.oldfiles, "Old Files" },
          },
        },
      }, opt)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-treesitter.configs').setup{
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = { query="@function.outer",desc = "Select outer part of a function" },
              ["if"] = { query="@function.inner",desc = "Select inner part of a function" },
              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        },
      }
    end,
  }
}
