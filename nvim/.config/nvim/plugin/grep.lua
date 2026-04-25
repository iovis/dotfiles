local u = require("config.utils")

local has_rg = u.is_executable("rg")
local rg_base_cmd = {
  "rg",
  "--hidden",
  "--vimgrep",
  "--smart-case",
  "-g",
  "!Session.vim",
  "-g",
  "!.git",
  "-g",
  "!.gitattributes",
  "-g",
  "!node_modules",
}

---@param cmd string[]
---@return string
local function shell_command(cmd)
  return vim
    .iter(cmd)
    :map(function(arg)
      return vim.fn.shellescape(arg)
    end)
    :join(" ")
end

if has_rg then
  vim.o.grepprg = shell_command(rg_base_cmd)
  vim.o.grepformat = "%f:%l:%c:%m"
end

vim.keymap.set("n", "g<space>", ":Grep -F<space>")
vim.api.nvim_create_user_command("Grep", function(opts)
  vim.cmd("silent grep! " .. opts.args)
  vim.cmd("botright cwindow")
end, { nargs = "+", complete = "file" })

---@param args string[]
---@param pattern? string
local function rg(args, pattern)
  if not has_rg then
    vim.notify("rg is not executable", vim.log.levels.ERROR)
    return
  end

  args = vim.deepcopy(args)
  if pattern then
    vim.list_extend(args, { "--", pattern })
  end

  local cmd = vim.deepcopy(rg_base_cmd)
  vim.list_extend(cmd, args)
  local result = vim.system(cmd, { text = true }):wait()
  local title = "rg " .. table.concat(args, " ")

  if result.code == 0 then
    vim.fn.setqflist({}, "r", {
      title = title,
      lines = vim.split(result.stdout or "", "\n", { trimempty = true }),
      efm = vim.o.grepformat,
    })
    vim.cmd("botright cwindow")
  elseif result.code == 1 then
    vim.fn.setqflist({}, "r", { title = title, items = {} })
    vim.cmd.cclose()
    vim.notify("No matches", vim.log.levels.INFO)
  else
    local stderr = vim.trim(result.stderr or "")
    local message = stderr ~= "" and stderr or ("rg exited with code " .. result.code)

    vim.notify(message, vim.log.levels.ERROR, { title = title })
  end
end

---@param mode string
---@return boolean
local function is_visual_mode(mode)
  return mode == "v" or mode == "V" or mode == "\22"
end

---@return string?
local function visual_selection()
  local mode = vim.fn.mode()
  if not is_visual_mode(mode) then
    return nil
  end

  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode })
  local text = table.concat(lines, "\n")

  if text == "" then
    return nil
  end

  if text:find("\n", 1, true) then
    vim.notify("Multiline selections are not supported for grep", vim.log.levels.WARN)
    return nil
  end

  return text
end

---@param text string
local function highlight_literal(text)
  vim.fn.setreg("/", "\\V" .. text:gsub("\\", "\\\\"))
  vim.o.hlsearch = true
end

---@param word string
local function highlight_word(word)
  vim.fn.setreg("/", "\\<" .. vim.fn.escape(word, "\\") .. "\\>")
  vim.o.hlsearch = true
end

local rg_types ---@type table<string, boolean>?

---@return table<string, boolean>
local function get_rg_types()
  if rg_types then
    return rg_types
  end

  rg_types = {}
  if not has_rg then
    return rg_types
  end

  local result = vim.system({ "rg", "--type-list" }, { text = true }):wait()
  if result.code ~= 0 then
    return rg_types
  end

  for _, line in ipairs(vim.split(result.stdout or "", "\n", { trimempty = true })) do
    local type_name = line:match("^([^:]+):")

    if type_name then
      rg_types[type_name] = true
    end
  end

  return rg_types
end

local rg_type_aliases = {
  bash = "sh",
  dockerfile = "docker",
  eruby = "ruby",
  javascript = "js",
  javascriptreact = "js",
  jsonc = "json",
  markdown = "md",
  typescript = "ts",
  typescriptreact = "ts",
  zsh = "sh",
}

---@param filetype string
---@return string?
local function rg_type_for_filetype(filetype)
  if filetype == "" then
    return nil
  end

  local rg_type = rg_type_aliases[filetype] or filetype
  if get_rg_types()[rg_type] then
    return rg_type
  end
end

---@param args string[]
---@return string[]
local function within_ft(args)
  local rg_type = rg_type_for_filetype(vim.bo.filetype)
  if rg_type then
    vim.list_extend(args, { "-t", rg_type })
  end

  return args
end

vim.keymap.set("n", "K", function()
  local word = vim.fn.expand("<cword>")
  if word == "" then
    return
  end

  highlight_word(word)
  rg({ "-w" }, word)
end, { desc = "Grep word" })

vim.keymap.set("x", "K", function()
  local search_term = visual_selection()
  if not search_term then
    return
  end

  highlight_literal(search_term)
  rg({ "-F" }, search_term)
end)

vim.keymap.set("n", "<leader>fw", function()
  local word = vim.fn.expand("<cword>")
  if word == "" then
    return
  end

  highlight_word(word)
  rg(within_ft({ "-w" }), word)
end, { desc = "Find word in current filetype" })

vim.keymap.set("x", "<leader>fw", function()
  local search_term = visual_selection()
  if not search_term then
    return
  end

  highlight_literal(search_term)
  rg(within_ft({ "-F" }), search_term)
end, { desc = "Find word in current filetype" })
