----Utils
local u = require("config.utils")

local within_session = function()
  return not u.is_empty(vim.v.this_session)
end

local session_loading = function()
  return vim.g.SessionLoad ~= nil
end

---@param buffer number: buffer ID.
---@return boolean `true` if this buffer could be restored later on loading.
local is_restorable = function(buffer)
  if #vim.bo[buffer].bufhidden ~= 0 then
    return false
  end

  local buftype = vim.bo[buffer].buftype
  if #buftype == 0 then
    -- Normal buffer, check if it listed.
    if not vim.bo[buffer].buflisted then
      return false
    end
    -- Check if it has a filename.
    if #vim.api.nvim_buf_get_name(buffer) == 0 then
      return false
    end
  elseif buftype ~= "terminal" and buftype ~= "help" then
    -- Buffers other then normal, terminal and help are impossible to restore.
    return false
  end

  return true
end

----Commands
local start_session = function()
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

u.command("SessionStart", start_session)
vim.keymap.set("n", "yoS", start_session, {
  desc = "Load or create session for the current directory",
})

----Autocommands
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
    if not within_session() then
      return
    end

    -- Remove all non-file and utility buffers because they cannot be saved.
    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buffer) and not is_restorable(buffer) then
        vim.api.nvim_buf_delete(buffer, { force = true })
      end
    end

    persist_session()
  end,
})
