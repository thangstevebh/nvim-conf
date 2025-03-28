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
    lazy = true,
    cmd = "ToggleTerm",
    keys = {
      { "<c-\\>", "<cmd>ToggleTerm<cr>", mode = "n", desc = "Toggle terminal" },
      {
        "<leader>tf",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 0, LazyVim.root.get(), "float")
        end,
        desc = "ToggleTerm (float root_dir)",
      },
      {
        "<leader>th",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 15, LazyVim.root.get(), "horizontal")
        end,
        desc = "ToggleTerm (horizontal root_dir)",
      },
      {
        "<leader>tv",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, vim.o.columns * 0.4, LazyVim.root.get(), "vertical")
        end,
        desc = "ToggleTerm (vertical root_dir)",
      },
      {
        "<leader>tn",
        "<cmd>TermNew<cr>",
        desc = "New term",
      },
      {
        "<leader>tr",
        "<cmd>ToggleTermSetName<cr>",
        desc = "Set term name",
      },
      {
        "<leader>ts",
        "<cmd>TermSelect<cr>",
        desc = "Select term",
      },
      {
        "<leader>T",
        function()
          require("toggleterm").toggle(1, 100, vim.loop.cwd(), "tab")
        end,
        desc = "ToggleTerm (tab cwd_dir)",
      },
    },
    config = function()
      local highlights = require("rose-pine.plugins.toggleterm")
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        hide_numbers = false,
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
        float_opts = {
          border = "curved",
          title_pos = "right",
        },
        winbar = {
          enable = false,
          name_formatter = function(term)
            return term.name
          end,
        },
        highlights = {
          FloatBorder = {
            guifg = "#d65d0e",
          },
        },
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "LazyFile",
    config = function()
      vim.cmd([[:hi IlluminatedWordRead guibg=#d5c4a1 gui=underline cterm=underline guisp=#d65d0e blend=5]])
      vim.cmd([[:hi IlluminatedWordWrite guibg=#d5c4a1 gui=underline cterm=underline guisp=#cc241d blend=5]])
    end,
  },
  -- {
  --   "mistricky/codesnap.nvim",
  --   build = "make",
  --   keys = {
  --     { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
  --     { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
  --   },
  --   opts = {
  --     save_path = "~/Pictures",
  --     has_breadcrumbs = true,
  --     bg_theme = "summer",
  --     watermark = "THA",
  --     show_workspace = true,
  --   },
  -- },
}
