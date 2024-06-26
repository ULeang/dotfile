return {
  {
    "voldikss/vim-floaterm",
    config=function()
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          t = {
            name = "+term option",
            n = { "<cmd>FloatermNew<cr>", "New terminal"},
            t = { "<cmd>FloatermToggle<cr>", "Toggle terminal"},
            h = { "<cmd>FloatermPrev<cr>", "Prev terminal"},
            l = { "<cmd>FloatermNext<cr>", "Next terminal"},
            k = { "<cmd>FloatermKill<cr>", "Kill terminal"},
          }
        }})
      vim.g.floaterm_borderchars="─│─│╭╮╯╰"
    end
  },
  {
    'echasnovski/mini.files',
    version = false,
    config = function()
      local wk = require("which-key")
      wk.register({
        ["<leader>fm"] = { function()MiniFiles.open()end, "MiniFiles Open" },
      })
      require('mini.files').setup()
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- branch = "v3.x",
    -- event = VeryLazy,
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
    config = function ()
      local wk = require("which-key")
      wk.register({
        ["<leader>fe"] = { "<cmd>Neotree focus filesystem float toggle reveal<cr>", "Neotree float" },
        ["<leader>ge"] = { "<cmd>Neotree focus git_status left toggle reveal<cr>", "Neotree git" },
        ["\\"] = { "<cmd>Neotree focus filesystem left toggle reveal<cr>", "Neotree side" },
      })
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError",
        {text = " ", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn",
        {text = " ", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo",
        {text = " ", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint",
        {text = "", texthl = "DiagnosticSignHint"})

      require("neo-tree").setup({
        source_selector = {
          winbar = false,
          statusline = false,
        },
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil , -- use a custom function for sorting files and directories in the tree 
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖",-- this can only be used in the git_status source
              renamed   = "󰁕",-- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            }
          },
          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
          file_size = {
            enabled = true,
            required_width = 64, -- min width of window required to show this column
          },
          type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
          },
          symlink_target = {
            enabled = true,
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {},
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = { 
              "toggle_node", 
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            -- ['C'] = 'close_all_subnodes',
            ["z"] = "close_all_nodes",
            ["Z"] = "expand_all_nodes",
            ["a"] = { 
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "relative" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              --".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",  -- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              -- ["<bs>"] = "navigate_up",
              ["b"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              ["?"] = "show_help",
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
              ["<down>"] = "move_cursor_down",
              ["<C-n>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-p>"] = "move_cursor_up",
            },
          },

          commands = {} -- Add a custom command or override a global one using the same function name
        },
        buffers = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["d"] = "buffer_delete",
              ["b"] = "navigate_up",
              ["."] = "set_root",
              ["?"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              ["?"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
            }
          }
        }
      })
    end
  }
  -- {
  --   "simrat39/symbols-outline.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     local wk = require("which-key")
  --     wk.register({
  --       ["<leader>o"] = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
  --     })
  --     local opts = {
  --       highlight_hovered_item = true,
  --       show_guides = true,
  --       auto_preview = false,
  --       position = 'right',
  --       relative_width = true,
  --       width = 25,
  --       auto_close = false,
  --       show_numbers = false,
  --       show_relative_numbers = false,
  --       show_symbol_details = true,
  --       preview_bg_highlight = 'Pmenu',
  --       autofold_depth = nil,
  --       auto_unfold_hover = true,
  --       fold_markers = { '', '' },
  --       wrap = false,
  --       keymaps = { -- These keymaps can be a string or a table for multiple keys
  --         close = {"<Esc>", "q"},
  --         goto_location = "<Cr>",
  --         focus_location = "o",
  --         hover_symbol = "<C-space>",
  --         toggle_preview = "K",
  --         rename_symbol = "r",
  --         code_actions = "a",
  --         fold = "h",
  --         unfold = "l",
  --         fold_all = "W",
  --         unfold_all = "E",
  --         fold_reset = "R",
  --       },
  --       lsp_blacklist = {},
  --       symbol_blacklist = {},
  --       symbols = {
  --         File = { icon = "󰈙", hl = "@text.uri" },
  --         Module = { icon = "", hl = "@namespace" },
  --         Namespace = { icon = "", hl = "@namespace" },
  --         Package = { icon = "", hl = "@namespace" },
  --         Class = { icon = "󰠱", hl = "@type" },
  --         Method = { icon = "󰆧", hl = "@method" },
  --         Property = { icon = "󰜢", hl = "@method" },
  --         Field = { icon = "󰜢", hl = "@field" },
  --         Constructor = { icon = "", hl = "@constructor" },
  --         Enum = { icon = "ℰ", hl = "@type" },
  --         Interface = { icon = "", hl = "@type" },
  --         Function = { icon = "󰊕", hl = "@function" },
  --         Variable = { icon = "󰀫", hl = "@constant" },
  --         Constant = { icon = "󰏿", hl = "@constant" },
  --         String = { icon = "", hl = "@string" },
  --         Number = { icon = "#", hl = "@number" },
  --         Boolean = { icon = "⊨", hl = "@boolean" },
  --         Array = { icon = "", hl = "@constant" },
  --         Object = { icon = "⦿", hl = "@type" },
  --         Key = { icon = "", hl = "@type" },
  --         Null = { icon = "󰟢", hl = "@type" },
  --         EnumMember = { icon = "", hl = "@field" },
  --         Struct = { icon = "", hl = "@type" },
  --         Event = { icon = "", hl = "@type" },
  --         Operator = { icon = "", hl = "@operator" },
  --         TypeParameter = { icon = "", hl = "@parameter" },
  --         Component = { icon = "󰡀", hl = "@function" },
  --         Fragment = { icon = "", hl = "@constant" },
  --       },
  --     }
  --
  --     require("symbols-outline").setup(opts)
  --   end
  -- },
}
