return {
  -- Using lazy.nvim
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --     terminal_colors = true,
  --     undercurl = true,
  --     underline = true,
  --     bold = true,
  --     italic = {
  --       strings = true,
  --       emphasis = true,
  --       comments = true,
  --       operators = false,
  --       folds = true,
  --     },
  --     strikethrough = true,
  --     invert_selection = false,
  --     invert_signs = false,
  --     invert_tabline = false,
  --     invert_intend_guides = false,
  --     inverse = true,
  --     contrast = "soft", -- can be "hard", "soft" or empty string
  --     palette_overrides = {},
  --     overrides = {},
  --     dim_inactive = true,
  --     transparent_mode = true,
  --   },
  --   config = function()
  --     vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#FF6363" })
  --     vim.o.background = "dark"
  --     vim.cmd([[colorscheme gruvbox]])
  --     vim.cmd([[:hi SpellBad cterm=underline gui=undercurl guisp=#8ec0 blend=10]])
  --   end,
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "dawn", -- main, moon, or dawn
        dim_inactive_windows = true,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = true,
          transparency = true, -- Enable setting the background opacity
        },

        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },

        palette = {
          -- Override the builtin palette per variant
          -- moon = {
          --     base = '#18191a',
          --     overlay = '#363738',
          -- },
        },

        highlight_groups = {
          Comment = { fg = "muted" },
          VertSplit = { fg = "muted", bg = "muted" },
          Visual = { fg = "pine", bg = "text", inherit = false, blend = 20 },
          DiagnosticUnnecessary = { bg = "#ea9a97", fg = "muted", blend = 20 },
          String = { fg = "#5E936C" },
        },
        highlight = {
          SpellBad = {
            fg = "rose",
            bg = "muted",
            blend = 20,
          },
        },

        before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          -- if highlight.undercurl then
          -- 	highlight.undercurl = true
          -- end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          -- 	highlight.fg = palette.gold
          -- end
        end,
      })
      vim.cmd("colorscheme rose-pine-dawn")
    end,
  },
}
