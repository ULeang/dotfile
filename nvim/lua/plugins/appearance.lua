return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set header
      dashboard.section.header.val = {
        "                                         ",
        "                                         ",
        "                                         ",
        " ██╗  ██╗ ██████╗ ██╗███████╗██╗  ██╗██╗ ",
        " ██║ ██╔╝██╔═══██╗██║██╔════╝██║  ██║██║ ",
        " █████╔╝ ██║   ██║██║███████╗███████║██║ ",
        " ██╔═██╗ ██║   ██║██║╚════██║██╔══██║██║ ",
        " ██║  ██╗╚██████╔╝██║███████║██║  ██║██║ ",
        " ╚═╝  ╚═╝ ╚═════╝ ╚═╝╚══════╝╚═╝  ╚═╝╚═╝ ",
        "                                         ",
        "                                         ",
        "                                         ",

        -- "                                                    ",
        -- " ██╗   ██╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗ ",
        -- " ██║   ██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝ ",
        -- " ██║   ██║███████╗██║     ██║   ██║██║  ██║█████╗   ",
        -- " ╚██╗ ██╔╝╚════██║██║     ██║   ██║██║  ██║██╔══╝   ",
        -- "  ╚████╔╝ ███████║╚██████╗╚██████╔╝██████╔╝███████╗ ",
        -- "   ╚═══╝  ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝ ",
        -- "                                                    ",

        -- "                                                     ",
        -- "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        -- "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        -- "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        -- "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        -- "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        -- "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        -- "                                                     ",
      }

      local configpath = vim.fn.stdpath("config")
      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("n", "  New",  "<cmd>enew <bar> startinsert<cr>"),
        dashboard.button("f", "  Find", "<cmd>Telescope find_files<cr>"),
        dashboard.button("o", "  Recent",  "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("g", "  Grep",  "<cmd>Telescope live_grep<cr>"),
        dashboard.button("s", "  Settings", "<cmd>cd " .. configpath .. " <bar> Neotree focus filesystem float toggle<cr>"),
        dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<cr>"),
        dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
        -- dashboard.button("s", "  Settings", ":cd ~/.config/nvim | Neotree focus filesystem float toggle<CR>"),
        -- dashboard.button( "f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
        -- dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
        -- dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
        -- dashboard.button("s", "  Sett", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
      }

      dashboard.section.footer.val = {
        "              ",
        "              ",
        "    -ULya-    ",
        "λkoishi kawaii",
        "λFrom Gensokyo",
      }
      dashboard.section.footer.opts.hl = "Keyword"

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
      -- return dashboard
    end,

    config = function(_ , dashboard)
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end
  },
  {
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme catppuccin-mocha]])
    end,
  },
  -- {
  --     "folke/tokyonight.nvim",
  --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --     priority = 1000, -- make sure to load this before all the other start plugins
  --     config = function()
  --       -- load the colorscheme here
  --       vim.cmd([[colorscheme tokyonight-moon]])
  --     end,
  -- },
}
