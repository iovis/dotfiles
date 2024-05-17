local u = require("config.utils")

---@class RSpecOutput
---@field examples RSpecTest[]
---@field summary RSpecSummary
---@field summary_line string Summary of the run

---@class RSpecSummary
---@field duration number Duration of the `rspec` command
---@field example_count number Number of tests
---@field failure_count number Number of failed tests
---@field pending_count number Number of pending tests
---@field errors_outside_of_examples_count number

---@class RSpecTest
---@field id string ID of the test
---@field description string Description of the test
---@field full_description string Full description of the test
---@field status "passed"|"failed"|"pending" Result of the test
---@field file_path string
---@field line_number number First line of the test
---@field run_time number
---@field pending_message? string
---@field exception? RSpecException Output of the failed test

---@class RSpecException
---@field message string
---@field class string
---@field backtrace string[]

---@class RSpec
---@field filename string Filename of the test
---@field file_bufnr number Filename of the test
---@field threshold_in_seconds number Threshold to show spec time in virtual text
---@field output? RSpecOutput Output of `rspec` command
---@field failed_tests RSpecTest[] Failed tests
---@field private namespace number
---@field private notification_key string Fidget key
local RSpec = {}

---Create new RSpec instance for the current buffer
---@return RSpec
function RSpec:new()
  local rspec = {
    filename = vim.fn.expand("%"),
    file_bufnr = vim.api.nvim_get_current_buf(),
    threshold_in_seconds = 0.01,
    output = nil,
    failed_tests = {},
    namespace = vim.api.nvim_create_namespace("rspec"),
    notification_key = "rspec_job",
  }

  setmetatable(rspec, self)
  self.__index = self

  return rspec
end

---Determine RSpec command
---@param strategy "file"|"line" Strategy to use
---@return table command
function RSpec:command(strategy)
  local command = {}
  local file = vim.fn.expand("%")

  -- Use `spring` if available
  if u.is_executable("bin/spring") then
    table.insert(command, "bin/spring")
  end

  command = vim.fn.extend(command, {
    "rspec",
    "--format",
    "json",
  })

  if strategy == "file" then
    table.insert(command, file)
  elseif strategy == "line" then
    local line = vim.fn.line(".")
    local path = string.format("%s:%s", file, line)

    table.insert(command, path)
  end

  return command
end

---Parse RSpec JSON output (rspec --format json)
---@param data string[]
---@return boolean result
function RSpec:parse(data)
  if not data then
    return false
  end

  for _, line in ipairs(data) do
    local ok, json = pcall(vim.json.decode, line)

    if ok then
      self.output = json
      return true
    else
      print(line)
    end
  end

  return false
end

function RSpec:parse_failure()
  require("fidget").notify("Failed to parse output", vim.log.levels.ERROR, {
    annote = "error",
    group = "rspec",
    key = self.notification_key,
    data = "✗", -- Force group to finish progress
    ttl = 3,
  })
end

---Clear virtual text and diagnostics
function RSpec:clear()
  self.failed_tests = {}

  vim.api.nvim_buf_clear_namespace(self.file_bufnr, self.namespace, 0, -1)
  vim.diagnostic.reset(self.namespace, self.file_bufnr)

  pcall(vim.api.nvim_buf_del_user_command, self.file_bufnr, "RSpecOutput")
  pcall(vim.keymap.del, "n", "''", { buffer = true })
end

---Show progress popup
function RSpec:progress_start()
  require("fidget").notify("In progress...", vim.log.levels.WARN, {
    annote = vim.g.autotest,
    group = "rspec",
    key = self.notification_key,
    ttl = math.huge,
  })
end

---Close progress popup
function RSpec:progress_end()
  local message = "Completed"
  local annote = vim.g.autotest
  local log_level = vim.log.levels.INFO

  if self.output.summary then
    message = string.format("%s (%.2fs)", message, self.output.summary.duration)
  end

  if #self.failed_tests > 0 then
    log_level = vim.log.levels.ERROR
    annote = ("%d failed tests"):format(#self.failed_tests)
  end

  require("fidget").notify(message, log_level, {
    annote = annote,
    group = "rspec",
    key = self.notification_key,
    data = "✔", -- Force group to finish progress
    ttl = 3,
  })
end

---Create buffer local command to show RSpec output
function RSpec:create_buf_command()
  -- Mapping
  vim.keymap.set("n", "''", ":RSpecOutput<cr>", { buffer = true, silent = true })

  -- User command
  vim.api.nvim_buf_create_user_command(self.file_bufnr, "RSpecOutput", function()
    local line_number = vim.fn.line(".")

    local tests = self:failed_tests_for(line_number)

    if vim.tbl_isempty(tests) then
      vim.notify("No RSpec output for this line", vim.log.levels.ERROR)
      return
    end

    -- Prepare window
    vim.cmd("10new")

    vim.bo.bufhidden = "wipe"
    vim.bo.buflisted = false
    vim.bo.buftype = "nofile"
    vim.bo.filetype = "ruby"

    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = true,
      nowait = true,
    })

    -- Prepare body
    local lines = {}
    for _, test in ipairs(tests) do
      table.insert(
        lines,
        vim
          .iter({
            ("╭─ rspec %s"):format(test.id),
            ("╰─ (%.3fs)"):format(test.run_time),
            test.full_description,
            "",
            vim.fn.split(test.exception.message, "\n"),
            "",
          })
          :flatten(math.huge)
          :totable()
      )
    end

    -- Remove last separator
    lines = vim.iter(lines):flatten(math.huge):rskip(1):totable()

    -- Write body to buffer
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
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
  passed = { "[✔ pass]", "DiffAdded" },
  failed = { "[✗ failed]", "DiagnosticVirtualTextError" },
  pending = { "[■ pending]", "DiagnosticVirtualTextWarn" },
}

---Sets the virtual text for the provided test
---@private
---@param test RSpecTest
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
---@param test RSpecTest
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
---@param test RSpecTest
---@return string Runtime description if it goes above threshold
function RSpec:format_runtime_for(test)
  local run_time = ""

  if test.run_time > self.threshold_in_seconds then
    run_time = string.format(" (%.2fs)", test.run_time)
  end

  return run_time
end

---Find failed tests for the current line
---@private
---@param line_number number
---@return RSpecTest[]
function RSpec:failed_tests_for(line_number)
  local tests = {}

  for _, test in ipairs(self.failed_tests) do
    if test.line_number == line_number then
      table.insert(tests, test)
    end
  end

  return tests
end

return RSpec
