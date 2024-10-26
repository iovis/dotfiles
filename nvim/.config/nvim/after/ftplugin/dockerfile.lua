local tux = require("tux")

---Returns the current working directory as a name for the Docker tag
---@return string
local function container_name_from_cwd()
  local cwd = assert(vim.uv.cwd())
  return vim.fn.fnamemodify(cwd, ":t")
end

vim.keymap.set("n", "s<cr>", function()
  local container = container_name_from_cwd()
  local cmd = ("podman run %s"):format(container)

  tux.run(cmd)
end, { buffer = true })

vim.keymap.set("n", "m<cr>", function()
  local tag = container_name_from_cwd()
  local dockerfile_folder = vim.fn.expand("%:.:h")
  local cmd = ("podman build -t %s %s"):format(tag, dockerfile_folder)

  tux.run(cmd)
end, { buffer = true })
