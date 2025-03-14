return {
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup({})
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({})
    end,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            kind = "Copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      local highlights = require("rose-pine.plugins.toggleterm")
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        size = 20,
        shade_filetypes = {},
        direction = "float",
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        terminal_mappings = true,
        persist_size = true,
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_otps = {
          border = "curved",
          winblend = 2,
          width = 1,
          height = 1,
        },
        winbar = {
          enable = false,
          name_formatter = function(term)
            return term.name
          end,
        },
        highlights = highlights,
      })
    end,
  },
  {
    "mistricky/codesnap.nvim",
    build = "make",
    keys = {
      { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
    opts = {
      save_path = "~/Pictures",
      has_breadcrumbs = true,
      bg_theme = "summer",
      watermark = "THA",
      show_workspace = true,
    },
  },
}
