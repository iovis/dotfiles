return {
  "jake-stewart/multicursor.nvim",
  enabled = false,
  event = "VeryLazy",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    -- Add or skip cursor above/below the main cursor.
    vim.keymap.set({ "n", "x" }, "<up>", function()
      mc.lineAddCursor(-1)
    end)

    vim.keymap.set({ "n", "x" }, "<leader><up>", function()
      mc.lineSkipCursor(-1)
    end)

    vim.keymap.set({ "n", "x" }, "<down>", function()
      mc.lineAddCursor(1)
    end)

    vim.keymap.set({ "n", "x" }, "<leader><down>", function()
      mc.lineSkipCursor(1)
    end)

    -- Add or skip adding a new cursor by matching word/selection
    vim.keymap.set({ "n", "x" }, "<c-n>", function()
      mc.matchAddCursor(1)
    end)

    vim.keymap.set({ "n", "x" }, "<c-p>", function()
      mc.matchAddCursor(-1)
    end)

    -- Add all matches in the document
    vim.keymap.set({ "n", "x" }, "<leader>*", mc.matchAllAddCursors)

    -- Easy way to add and remove cursors using the main cursor.
    vim.keymap.set({ "n", "x" }, "<c-x>", mc.toggleCursor)

    vim.keymap.set("n", "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        -- Default <esc> handler.
      end
    end)

    -- bring back cursors if you accidentally clear them
    vim.keymap.set("n", "<leader>gv", mc.restoreCursors)

    -- Split visual selections by regex.
    vim.keymap.set("x", "'s", mc.splitCursors)

    -- Append/insert for each line of visual selections.
    vim.keymap.set("x", "I", mc.insertVisual)
    vim.keymap.set("x", "A", mc.appendVisual)

    -- match new cursors within visual selections by regex.
    vim.keymap.set("x", "M", mc.matchCursors)

    -- Rotate visual selection contents.
    vim.keymap.set("x", "<leader>t", function()
      mc.transposeCursors(1)
    end)
    vim.keymap.set("x", "<leader>T", function()
      mc.transposeCursors(-1)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { link = "Cursor" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
