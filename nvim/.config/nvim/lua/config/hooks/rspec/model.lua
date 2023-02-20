---@class RSpecOutput
---@field examples Test[]
---@field summary RSpecSummary
---@field summary_line string Summary of the run

---@class RSpecSummary
---@field duration number Duration of the `rspec` command
---@field example_count number Number of tests
---@field failure_count number Number of failed tests
---@field pending_count number Number of pending tests
---@field errors_outside_of_examples_count number

---@class Test
---@field id string ID of the test
---@field description string Description of the test
---@field full_description string Full description of the test
---@field status "passed"|"failed"|"pending" Result of the test
---@field file_path string
---@field line_number number First line of the test
---@field run_time number
---@field pending_message? string
---@field exception Exception? Output of the failed test

---@class Exception
---@field message string
---@field class string
---@field backtrace string[]

---@class RSpec
---@field filename string Filename of the test
---@field file_bufnr number Filename of the test
---@field time_threshold number Threshold to show spec time in virtual text
---@field output RSpecOutput Output of `rspec` command
---@field failed_tests Test[] Failed tests
---@field private popup_bufnr? number Buffer ID of the popup
---@field private namespace number
local RSpec = {
  namespace = vim.api.nvim_create_namespace("rspec"),
  output = {},
  failed_tests = {},
  popup_bufnr = nil,
  time_threshold = 0.01, -- seconds
}

---Create new RSpec instance for the current buffer
---@return RSpec
function RSpec:new()
  self.filename = vim.fn.expand("%")
  self.file_bufnr = vim.api.nvim_get_current_buf()

  return self
end

---Parse RSpec JSON output (rspec --format json)
---@param output string
function RSpec:parse(output)
  self.output = vim.json.decode(output)
end

---Clear virtual text and diagnostics
function RSpec:clear()
  self.failed_tests = {}

  vim.api.nvim_buf_clear_namespace(self.file_bufnr, self.namespace, 0, -1)
  vim.diagnostic.reset(self.namespace, self.file_bufnr)

  pcall(vim.api.nvim_buf_del_user_command, self.file_bufnr, "RspecOutput")
  pcall(vim.keymap.del, "n", "+R", { buffer = true })
end

---Create buffer local command to show RSpec output
-- TODO: nvim_create_buf() and nvim_open_win()?
-- TODO: Handle multiple tests in the same line (use ID?)
-- TODO: Add timings?
function RSpec:create_buf_command()
  vim.keymap.set("n", "+R", ":RspecOutput<cr>", { buffer = true, silent = true })

  vim.api.nvim_buf_create_user_command(self.file_bufnr, "RspecOutput", function()
    local line_number = vim.fn.line(".")

    local test = self:find_failed_test_for(line_number)

    if not test then
      vim.notify("No RSpec output for this line", vim.log.levels.ERROR)
      return
    end

    vim.cmd("10new")

    vim.bo.bufhidden = "wipe"
    vim.bo.buflisted = false
    vim.bo.buftype = "nofile"
    vim.bo.filetype = "diff"

    vim.api.nvim_buf_set_lines(
      vim.api.nvim_get_current_buf(),
      0,
      -1,
      false,
      vim.tbl_flatten({
        test.full_description,
        "",
        vim.fn.split(test.exception.message, "\n"),
      })
    )
  end, {})
end

---Set RSpec virtual text
function RSpec:set_virtual_text()
  for _, test in ipairs(self.output.examples) do
    self:set_virtual_text_line_for(test)

    if test.status ~= "passed" then
      table.insert(self.failed_tests, test)
    end
  end
end

local virtual_text_message = {
  passed = { "✓ pass", "DiffAdded" },
  failed = { "✗ failed", "DiagnosticVirtualTextError" },
  pending = { "■ pending", "DiagnosticVirtualTextWarn" },
}

---Sets the virtual text for the provided test
---@private
---@param test Test
function RSpec:set_virtual_text_line_for(test)
  vim.api.nvim_buf_set_extmark(self.file_bufnr, self.namespace, test.line_number - 1, 0, {
    hl_mode = "combine",
    virt_text = {
      virtual_text_message[test.status],
      { self:format_runtime_for(test), "Comment" },
    },
  })
end

---Set RSpec diagnostics
function RSpec:set_diagnostics()
  local diagnostics = {}

  for _, test in ipairs(self.failed_tests) do
    table.insert(diagnostics, self:format_test_for_diagnostic(test))
  end

  vim.diagnostic.set(self.namespace, self.file_bufnr, diagnostics, {
    virtual_text = false,
  })
end

---Format a test for diagnostics
---@private
---@param test Test
---@return table diagnostics
function RSpec:format_test_for_diagnostic(test)
  local message
  local severity

  if test.status == "failed" then
    message = test.full_description
    severity = vim.diagnostic.severity.ERROR
  elseif test.status == "pending" then
    message = string.format("%s: %s", test.full_description, test.pending_message)
    severity = vim.diagnostic.severity.WARN
  end

  return {
    bufnr = self.file_bufnr,
    lnum = test.line_number - 1,
    col = 0,
    severity = severity,
    source = "rspec",
    message = message,
    user_data = {},
  }
end

---Format runtime of test
---@private
---@param test Test
---@return string Runtime description if it goes above threshold
function RSpec:format_runtime_for(test)
  local run_time = ""

  if test.run_time > self.time_threshold then
    run_time = string.format(" (%.2fs)", test.run_time)
  end

  return run_time
end

---Find failed test for current line
---@private
---@param line_number number
---@return Test|nil
function RSpec:find_failed_test_for(line_number)
  for _, test in ipairs(self.failed_tests) do
    if test.line_number == line_number then
      return test
    end
  end
end

return RSpec
