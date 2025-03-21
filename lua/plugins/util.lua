return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      explorer = { enabled = true, width = 40 },
      picker = {
        enabled = true,
      },
      animate = {
        speed = 100,
      },
      scope = {
        enabled = true,
      },
      bigfile = { enabled = true, size = 1.5 * 1024 * 1024 },
      words = {
        enabled = true,
        debounce = 200, -- time in ms to wait before updating
        notify_jump = false, -- show a notification when jumping
        notify_end = true, -- show a notification when reaching the end
        foldopen = true, -- open folds after jumping
        jumplist = true, -- set jump point before jumping
        modes = { "n", "i", "c" }, -- modes to show references
      },
      zen = {
        enabled = true,
        notify_end = true,
      },
      indent = {
        enabled = true,
      },
      dim = {
        enabled = true,
        scope = {
          min_size = 5,
          max_size = 20,
          siblings = true,
        },
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          easing = "outQuad",
          duration = {
            step = 20, -- ms per step
            total = 300, -- maximum duration
          },
        },
        -- what buffers to dim
        filter = function(buf)
          return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
        end,
      },
      input = {
        enabled = true,
      },
      styles = {
        enabled = true,
        minimal = {
          wo = {
            cursorcolumn = false,
            cursorline = false,
            cursorlineopt = "both",
            colorcolumn = "",
            fillchars = "eob: ,lastline:…",
            list = false,
            listchars = "extends:…,tab:  ",
            number = false,
            relativenumber = false,
            signcolumn = "no",
            spell = false,
            winbar = "",
            statuscolumn = "",
            wrap = false,
            sidescrolloff = 0,
          },
        },

        snacks_image = {
          relative = "editor",
          border = "rounded",
          focusable = true,
          backdrop = true,
          row = 0.5,
          col = 0.5,
        },
      },
      notifier = { enabled = true },
      dashboard = {
        preset = {
          header = [[
████████╗██╗  ██╗ █████╗ ██████╗ ██╗   ██╗██╗
╚══██╔══╝██║  ██║██╔══██╗██╔══██╗██║   ██║██║
   ██║   ███████║███████║██████╔╝██║   ██║██║
   ██║   ██╔══██║██╔══██║██╔══██╗██║   ██║██║
   ██║   ██║  ██║██║  ██║██████╔╝╚██████╔╝██║
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝

          ]],
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            {
              icon = " ",
              key = "s",
              desc = "Restore Session",
              action = "<Leader>qs",
            },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "startup", padding = 1 },
          { section = "keys", gap = 1, padding = 1 },
          {
            section = "terminal",
            cmd = "fortune -s | cowsay | lolcat ",
            hl = "header",
            pane = 2,
            padding = 1,
            indent = 4,
          },
          {
            pane = 2,
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
          },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = vim.fn.isdirectory(".git") == 1,
            cmd = "hub status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
        },
      },
    },
  },
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>qS",
        function()
          require("persistence").select()
        end,
        desc = "Select Session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
}
