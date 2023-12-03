return {
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

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("n", "  New",  ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "  File", ":Telescope find_files <CR>"),
      dashboard.button("o", "  Old",  ":Telescope oldfiles <CR>"),
      dashboard.button("s", "  Sett", ":cd ~/.config/nvim | :Neotree focus source=filesystem position=float toggle<CR>"),
      -- dashboard.button("s", "  Sett", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
      -- dashboard.button( "f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
      -- dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
      -- dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    }

    dashboard.section.footer.val = {
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
}
