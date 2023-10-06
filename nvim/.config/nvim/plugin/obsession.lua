---- Utils
local u = require("config.utils")

---@return boolean
local within_session = function()
  return not u.is_empty(vim.v.this_session)
end

local session_loading = function()
  return vim.g.SessionLoad ~= nil
end

---- Commands
local restore_session = function()
  if within_session() then
    print("Already in a session!")
    return
  end

  ---@diagnostic disable-next-line param-type-mismatch
  local ok, _ = pcall(vim.cmd, "source Session.vim")

  if not ok then
    print("creating session")
    vim.cmd("mksession!")
  end
end

u.command("RestoreSession", restore_session)

vim.keymap.set("n", "yoo", restore_session, { desc = "Load or create session for the current directory" })

---- Autocommands
local persist_session = function()
  if within_session() and not session_loading() then
    local ok, result = pcall(vim.cmd, "mksession!")

    if not ok and not result:match("E11") then
      print(result)
    end
  end
end

local obsession_augroup = vim.api.nvim_create_augroup("obsession", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Autosave session",
  group = obsession_augroup,
  pattern = "*",
  callback = persist_session,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  desc = "Autosave session",
  group = obsession_augroup,
  pattern = "*",
  callback = function()
    require("neo-tree.sources.manager").close_all()
    vim.cmd.DBUIClose()

    persist_session()
  end,
})
