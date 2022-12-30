local M = {
  "nvim-tree/nvim-tree.lua",
  enabled = false,
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  keys = {
    {
      "<leader>k",
      "<cmd>NvimTreeToggle<cr>",
    },
    {
      "-",
      "<cmd>NvimTreeFindFile<cr>",
    },
  },
  dependencies = "nvim-tree/nvim-web-devicons",
}

function M.config()
  local ok, tree = pcall(require, "nvim-tree")
  if not ok then
    print("nvim-tree not found!")
    return
  end

  local tree_cb = require("nvim-tree.config").nvim_tree_callback
  local u = require("user.utils")

  tree.setup({
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    disable_netrw = false,
    filters = {
      custom = {
        "*.pyc",
        "*.zwc",
        ".DS_Store",
        ".bundle",
        ".git",
        ".github",
        ".vscode",
        ".yardoc",
        "BqfPreviewBorder",
        "NvimTree",
        "Session.vim",
        "node_modules",
        "tags",
      },
    },
    git = {
      ignore = false,
    },
    renderer = {
      icons = {
        glyphs = {
          git = {
            untracked = "?",
          },
        },
      },
      indent_markers = {
        enable = true,
      },
    },
    view = {
      width = 35,
      -- relativenumber = true,
      mappings = {
        list = {
          { key = "x", cb = tree_cb("close_node") },
          { key = "C", cb = tree_cb("cd") },
          { key = "D", cb = tree_cb("cut") },
          { key = "J", cb = tree_cb("next_sibling") },
          { key = "K", cb = tree_cb("prev_sibling") },
        },
      },
    },
    update_cwd = true,
  })

  u.highlight("NvimTreeEndOfBuffer", { fg = "#181818" })
  u.highlight("NvimTreeWinSeparator", { fg = "#181818" })
  u.highlight("NvimTreeStatusLine", {})
end

return M
