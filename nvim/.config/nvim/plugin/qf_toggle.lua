local qf_toggle = function()
  if vim.fn.getqflist({ winid = 1 }).winid == 0 then
    vim.cmd("botright copen")
  else
    vim.cmd("cclose")
  end
end

vim.keymap.set("n", "ç", qf_toggle, { desc = "QuickFix Toggle" })
