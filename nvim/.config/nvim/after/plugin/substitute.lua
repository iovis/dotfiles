-- Test String: a:+[^"s:,]#_(&-)~@d\d.f*{<fas?>}a$s!d=fa

---@alias mode "char" | "line" | "V" | "v"

---Get the text covered by the motion
---@param mode mode
---@return string
local capture_motion_text = function(mode)
  local saved_unnamed_register = vim.fn.getreg("@")

  if mode == "char" then
    vim.cmd("normal! `[v`]y")
  else
    vim.cmd("normal! y")
  end

  local search_term = vim.fn.escape(vim.fn.getreg("@"), "()[]{}/\\@<>&$%?+.*=^~")
  vim.fn.setreg("@", saved_unnamed_register)

  return search_term
end

---Check if the motion is within the same line
---@param mode mode
---@return boolean
local is_same_line = function(mode)
  if mode == "char" then
    return (vim.fn.getpos("'[")[2] - vim.fn.getpos("']")[2]) == 0
  end

  -- `< and `> won't work here because you have to exit visual mode
  -- for those to get registered
  return (vim.fn.getpos("v")[2] - vim.fn.getpos(".")[2]) == 0
end

---Type the string as if it were the user typing it
---@param command string
---@param search_term string?
local type_command = function(command, search_term)
  local generated_command = string.format(command, search_term)
  local escaped_termcodes = vim.api.nvim_replace_termcodes(generated_command, true, false, true)

  vim.api.nvim_feedkeys(escaped_termcodes, "t", true)
end

---Will take a motion `mode` and build a substitute command based on it
---@param mode mode
function SubstituteMotion(mode)
  ---- Normal modes
  if mode == "char" then
    if is_same_line(mode) then
      -- Something like `iw`
      local search_term = capture_motion_text(mode)
      type_command([[:%%s/\v%s//g<left><left>]], search_term)
    else
      -- Something like `if`
      type_command([[:'[,']s/\v//g<left><left><left>]])
    end
  elseif mode == "line" then
    -- Something like `2j`
    type_command([[:'[,']s/\v//g<left><left><left>]])
  ---- Visual modes
  elseif mode == "V" then
    type_command([[:s/\v//g<left><left><left>]])
  elseif mode == "v" then
    if is_same_line(mode) then
      local search_term = capture_motion_text(mode)
      type_command([[:%%s/\v%s//g<left><left>]], search_term)
    else
      type_command([[:s/\v//g<left><left><left>]])
    end
  else
    vim.notify("Unrecognized type: " .. mode, vim.log.levels.ERROR)
  end
end

----Keymaps
vim.keymap.set("n", "s", function()
  vim.opt.operatorfunc = "v:lua.SubstituteMotion"
  return "g@"
end, { expr = true, desc = "Substitute motion" })

vim.keymap.set("n", "ss", function()
  type_command([[:%%s/\v//g<left><left><left>]])
end, { expr = true, desc = "Substitute in the whole document" })

vim.keymap.set("x", "s", function()
  -- can't use vim.fn.visualmode() because it returns the "last" visual mode used,
  -- meaning it breaks on the first one
  SubstituteMotion(vim.fn.mode())
end, { desc = "Substitute motion" })
