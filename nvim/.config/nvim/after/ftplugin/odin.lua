local u = require("config.utils")
local tux = require("tux")

vim.keymap.set("n", "s<cr>", "<cmd>Tux odin run .<cr>", { buf = 0 })
vim.keymap.set("n", "m<cr>", "<cmd>Tux odin build . -o:speed<cr>", { buf = 0 })
vim.keymap.set("n", "<leader>sr", "<cmd>Tux odin run . -o:speed<cr>", { buf = 0 })

-- Debugging
vim.keymap.set("n", "d<cr>", function()
  tux.pane("odin build . -debug -out:debug")
  tux.pane('lldb -o "b main::main" -o "run" -- ./debug && rm -f ./debug', { focus = true })
end, { buf = 0, desc = "[odin] Debug program" })

vim.keymap.set("n", "<leader>sl", function()
  local file = vim.fn.shellescape(vim.fn.expand("%:p"))
  local breakpoint = ("breakpoint set --file %s --line %d"):format(file, vim.fn.line("."))
  local debug_cmd = ("lldb -o %s -o run -- ./debug && rm -f ./debug"):format(vim.fn.shellescape(breakpoint))

  tux.pane("odin build . -debug -out:debug")
  tux.pane(debug_cmd, { focus = true })
end, { buf = 0, desc = "[odin] Debug current line" })

-- Testing
vim.keymap.set("n", "<leader>sa", "<cmd>Tux odin test . -all-packages<cr>", {
  desc = "[odin] Test suite",
  buf = 0,
})

vim.keymap.set("n", "<leader>so", function()
  local package_path = vim.fn.expand("%:h")
  tux.run(("odin test %s"):format(vim.fn.shellescape(package_path)))
end, { buf = 0, desc = "[odin] Test package" })

local test_query = vim.treesitter.query.parse(
  "odin",
  [[
    (procedure_declaration
      (attributes
        (attribute
          (identifier) @attribute))
      (identifier) @test_name
      (#eq? @attribute "test"))
    ]]
)

local package_query = vim.treesitter.query.parse(
  "odin",
  [[
    (package_declaration
      (identifier) @package_name)
    ]]
)

local function capture_text(query, node, capture_name)
  for id, capture in query:iter_captures(node, 0) do
    if query.captures[id] == capture_name then
      return vim.treesitter.get_node_text(capture, 0)
    end
  end
end

vim.keymap.set("n", "<leader>si", function()
  local declaration = u.ts.find_ancestor(vim.treesitter.get_node(), { "procedure_declaration" })
  local test_name = declaration and capture_text(test_query, declaration, "test_name")

  if not test_name then
    vim.notify("Cursor is not inside an Odin test", vim.log.levels.WARN)
    return
  end

  local package_name = capture_text(package_query, u.ts.root_node("odin"), "package_name")
  if not package_name then
    vim.notify("Could not find the Odin package name", vim.log.levels.WARN)
    return
  end

  local selector = ("-tests:%s.%s"):format(package_name, test_name)
  tux.run(("odin test . -all-packages -define:ODIN_TEST_FANCY=false -- %s"):format(vim.fn.shellescape(selector)))
end, { buf = 0, desc = "[odin] Test nearest" })

if u.has_justfile() then
  vim.keymap.set("n", "<leader>sr", "<cmd>Tux just run_release<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>st", "<cmd>Tux just watch_test<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>sw", "<cmd>Tux just watch<cr>", { buf = 0 })

  vim.keymap.set("n", "d<cr>", function()
    tux.pane("just debug", { focus = true })
  end, { buf = 0, desc = "Tux just debug" })

  vim.keymap.set("n", "<leader>sl", function()
    local file = vim.fn.shellescape(vim.fn.expand("%:p"))
    local breakpoint = ("breakpoint set --file %s --line %d"):format(file, vim.fn.line("."))
    local debug_cmd = ("just debug_test -o %s -o run"):format(vim.fn.shellescape(breakpoint))

    tux.pane(debug_cmd, { focus = true })
  end, { buf = 0, desc = "Tux just debug_test (current line)" })
end
