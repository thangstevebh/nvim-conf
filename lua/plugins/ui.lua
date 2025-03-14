return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = LazyVim.config.icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "snacks_layout_box",
          },
        },
        ---@param opts bufferline.IconFetcherOpts
        get_element_icon = function(opts)
          return LazyVim.config.icons.ft[opts.filetype]
        end,
      },
    },
    config = function()
      local p = require("rose-pine.palette")

      require("bufferline").setup({
        -- highlights = {
        --   -- fill = {
        --   -- 	fg = p.text,
        --   -- 	bg = "#575279",
        --   -- },
        --   buffer_visible = {
        --     fg = p.subtle,
        --     bg = p.base,
        --   },
        --   buffer_selected = {
        --     fg = p.rose,
        --     bold = true,
        --     italic = true,
        --   },
        --   tab_selected = {
        --     fg = p.text,
        --     bg = p.overlay,
        --   },
        -- },
        options = {
          mode = "tabs",
          -- separator_style = "slant",
          show_buffer_close_icons = false,
          show_close_icon = true,
          termguicolors = true,
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    options = { theme = "gruvbox" },
  },

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    opts = function()
      local tsc = require("treesitter-context")
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map("<leader>ut")
      return { mode = "cursor", max_lines = 3 }
    end,
  },

  {
    "xiyaowong/transparent.nvim",
    config = function()
      local transparent = require("transparent").setup({
        groups = { -- table: default groups
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLineNr",
          "EndOfBuffer",
          "NormalFloat",
          "Pmenu",
          "Float",
        },
        extra_groups = {
          "IndentBlanklineChar",

          -- make floating windows transparent
          "LspFloatWinNormal",
          "Normal",
          "NormalFloat",
          "FloatBorder",
          "TelescopeNormal",
          "TelescopeBorder",
          "TelescopePromptBorder",
          "SagaBorder",
          "SagaNormal",
          -- "NeoTreeFileName",
        }, -- table: additional groups that should be cleared
        exclude_groups = {

          "NeoTreeFileName",
        }, -- table: groups you don't want to clear
      })
    end,
  },
}
