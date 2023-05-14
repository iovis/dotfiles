return {
  "kevinhwang91/nvim-ufo",
  -- enabled = false,
  event = "VeryLazy",
  dependencies = {
    "kevinhwang91/promise-async",
    "luukvbaal/statuscol.nvim",
  },
  init = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function()
    local ufo = require("ufo")

    local fold_text = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = ("  %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0

      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)

        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)

          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end

          break
        end

        curWidth = curWidth + chunkWidth
      end

      table.insert(newVirtText, { suffix, "Comment" })

      return newVirtText
    end

    ufo.setup({
      fold_virt_text_handler = fold_text,
    })

    vim.keymap.set("n", "zM", ufo.closeAllFolds)
    vim.keymap.set("n", "zR", ufo.openAllFolds)

    vim.keymap.set("n", "zm", ufo.closeFoldsWith)
    vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)

    vim.keymap.set("n", "<leader>lf", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.cmd([[Lspsaga peek_definition]])
      end
    end)
  end,
}
