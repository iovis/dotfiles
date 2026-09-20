----Utils
local function session_path()
  if vim.v.this_session == "" then
    return nil
  end

  return vim.v.this_session
end

local function within_session()
  return session_path() ~= nil
end

---@param buffer number: buffer ID.
---@return boolean `true` if this buffer could be restored later on loading.
local function is_restorable(buffer)
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
---@param path string
---@return boolean
local function write_session(path)
  local ok, err = pcall(vim.api.nvim_cmd, {
    cmd = "mksession",
    bang = true,
    args = { path },
  }, {})

  if not ok then
    vim.notify(("Failed to save session %s:\n%s"):format(path, err), vim.log.levels.WARN)
  end

  return ok
end

local function start_session()
  if within_session() then
    vim.notify("Already in a session", vim.log.levels.INFO)
    return
  end

  local path = vim.fn.fnamemodify("Session.vim", ":p")

  if vim.uv.fs_stat(path) == nil then
    if write_session(path) then
      vim.notify(("Created session: %s"):format(path), vim.log.levels.INFO)
    end
    return
  end

  local ok, err = pcall(vim.api.nvim_cmd, {
    cmd = "source",
    args = { path },
  }, {})

  if ok then
    vim.v.this_session = path
    return
  end

  -- A generated session sets these near its beginning, so reset them if
  -- sourcing fails partway through. This prevents a later save from
  -- overwriting the broken session.
  vim.v.this_session = ""
  vim.g.SessionLoad = nil
  vim.notify(("Failed to load session %s; the file was preserved:\n%s"):format(path, err), vim.log.levels.ERROR)
end

vim.api.nvim_create_user_command("SessionStart", start_session, {})
vim.keymap.set("n", "yos", "<cmd>SessionStart<cr>")

----Autocommands
local function persist_session()
  local path = session_path()

  if path ~= nil then
    write_session(path)
  end
end

local obsession_augroup = vim.api.nvim_create_augroup("obsession", { clear = true })

vim.api.nvim_create_autocmd("VimLeavePre", {
  desc = "Save session on exit",
  group = obsession_augroup,
  pattern = "*",
  callback = function()
    if not within_session() then
      return
    end

    -- Remove all non-file and utility buffers because they cannot be saved.
    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buffer) and not is_restorable(buffer) then
        pcall(vim.api.nvim_buf_delete, buffer, { force = true })
      end
    end

    persist_session()
  end,
})
