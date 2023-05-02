-- TODO: Do a file bookmark plugin similar to muxi

--[[
Example payload
```json
{
  "/Users/david/.dotfiles": {
    "j": {
      "file": "nvim/.config/nvim/after/plugin/muxi.lua",
      "pos": [3, 5]
    }
  }
}
```
]]

if false then
  vim.cmd("messages clear")
  -----------------------------------------

  ---- Managing files
  -- :h uv_fs_t
  local function read_file_sync(path)
    local fd = vim.loop.fs_open(path, "r", 438)
    local data = nil

    if fd then
      local stat = assert(vim.loop.fs_fstat(fd))
      data = assert(vim.loop.fs_read(fd, stat.size, 0))
      assert(vim.loop.fs_close(fd))
    end

    return data
  end

  local function write_file_sync(path, data)
    local fd = assert(vim.loop.fs_open(path, "w", 438))

    assert(vim.loop.fs_write(fd, data))
    assert(vim.loop.fs_close(fd))
  end

  ---- Init muxi
  print("---- Init muxi")

  -- TODO: read from file
  local muxi_path = vim.fn.stdpath("data") .. "/muxi.json"

  local data = read_file_sync(muxi_path)
  print("synchronous read", data)

  local muxi = data and vim.json.decode(data) or {}

  vim.print(muxi)

  ---- Initialize muxi table for current directory
  print("---- Init current directory")
  local cwd = vim.loop.cwd()

  if not cwd then
    vim.notify("[muxi] ERROR: no current directory", vim.log.levels.ERROR)
    return
  end

  if not muxi[cwd] then
    muxi[cwd] = {}
  end

  -- Seems like lua does references, not copy. Good to know
  local current = muxi[cwd]

  vim.print(muxi)

  ---- Save bookmark for current file
  print("---- Save key")
  local key = "j"

  -- muxi[pwd][key] = {
  current[key] = {
    file = vim.fn.expand("%"),
    pos = vim.api.nvim_win_get_cursor(0),
  }

  vim.print(muxi)

  ---- Navigating to bookmark
  print("---- Navigating to key")

  local pos = current[key].pos

  vim.print(pos)
  vim.api.nvim_win_set_cursor(0, pos)

  ---- Cleaning up a bookmark
  print("---- Clean up key")
  current[key] = nil

  vim.print(muxi)

  ---- Cleaning up a workspace
  print("---- Clean up workspace")

  if vim.tbl_isempty(muxi[cwd]) then
    muxi[cwd] = nil
  end

  vim.print(muxi)

  ---- JSON encode the muxi table
  print("---- JSON encode")

  local json = vim.json.encode(muxi)
  vim.print(json)

  ---- Save to file
  print("---- Write to file")
  write_file_sync(muxi_path, json)

  -----------------------------------------
  vim.cmd("R! messages")
end
