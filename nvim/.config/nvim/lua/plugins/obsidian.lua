return {
  "epwalsh/obsidian.nvim",
  version = "*",
  event = "VeryLazy",
  keys = {
    { "<leader>uo", "<cmd>ObsidianQuickSwitch<cr>" },
    { "<leader>ud", "<cmd>ObsidianSearch<cr>" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("obsidian").setup({
      disable_frontmatter = true,
      open_app_foreground = true,
      finder = "fzf-lua",
      workspaces = {
        { name = "personal", path = "~/vaults/io" },
      },
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["yox"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        ["s<cr>"] = {
          action = function()
            vim.cmd.ObsidianOpen()
          end,
          opts = { buffer = true },
        },
        ["s<space>"] = {
          action = function()
            return ":ObsidianNew "
          end,
          opts = { buffer = true, expr = true },
        },
      },
      note_id_func = function(title)
        if title then
          return title
        else
          return ("%s New Note"):format(os.date("%Y-%m-%d"))
        end
      end,
    })
  end,
}
