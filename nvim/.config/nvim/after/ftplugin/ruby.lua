vim.cmd.compiler("ruby")

vim.keymap.set("n", "m<cr>", ":!ctags<cr>", { buffer = true })
vim.keymap.set("n", "<leader>b", vim.lsp.buf.format, { buffer = true })

---- Solargraph
-- Reset with: bundle exec solargraph clear && bundle exec yard gems --rebuild
vim.keymap.set(
  "n",
  "<leader>sy",
  ":TuxBg! ctags && bundle exec solargraph bundle && bundle exec yard gems<cr>",
  { buffer = true }
)

vim.keymap.set(
  "n",
  "<leader>sr",
  ":TuxBg! ctags && bundle exec solargraph clear && bundle exec solargraph download-core && bundle exec solargraph bundle && bundle exec yard gems --rebuild<cr>",
  { buffer = true }
)

---- quick testing
vim.keymap.set("n", "<leader>sd", ":TestFile --format documentation<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sp", ":TestNearest -strategy=test_prof<cr>", { buffer = true })

---- runnables
if string.match(vim.fn.expand("%"), "_spec.rb") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux rspec %<cr>", { buffer = true })
elseif string.match(vim.fn.expand("%"), "bin/console") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bin/console<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux ruby %<cr>", { buffer = true })
end

---- Autorun rspec tests (EXPERIMENTAL)
local run_rspec = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.fn.expand("%")
  local ns = vim.api.nvim_create_namespace("rspec")

  -- Clear virtual text and diagnostics
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  vim.diagnostic.reset(ns, bufnr)

  if not vim.g.autotest then
    return
  end

  local failed_tests = {}

  -- Create buffer local command to show rspec failure
  vim.api.nvim_buf_create_user_command(bufnr, "RspecOutput", function()
    local line = vim.fn.line(".")

    for _, test in ipairs(failed_tests) do
      if test.line_number == line then
        vim.cmd("10new")

        vim.bo.bufhidden = "wipe"
        vim.bo.buflisted = false
        vim.bo.buftype = "nofile"
        vim.bo.filetype = "rspec"

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

        return
      end
    end

    print("No RSpec output for this line")
  end, {})

  vim.keymap.set("n", "+R", ":RspecOutput<cr>", { buffer = true })

  -- Run rspec
  vim.fn.jobstart({
    -- "spring",
    "rspec",
    "--format",
    "json",
    file,
  }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      local ok, json = pcall(vim.json.decode, data[1])

      if not ok then
        vim.notify("Error parsing the RSpec output", vim.log.levels.ERROR)
        return
      end

      -- threshold to show timing the spec took
      local threshold = 0.01 -- second(s)

      for _, example in ipairs(json.examples) do
        local run_time = ""

        if example.run_time > threshold then
          run_time = string.format(" (%.2fs)", example.run_time)
        end

        -- example.status = passed|failed|pending
        if example.status == "passed" then
          vim.api.nvim_buf_set_extmark(bufnr, ns, example.line_number - 1, 0, {
            virt_text = {
              { "✓ pass", "DiffAdded" },
              { run_time, "Comment" },
            },
          })
        elseif example.status == "failed" then
          table.insert(failed_tests, example)

          vim.api.nvim_buf_set_extmark(bufnr, ns, example.line_number - 1, 0, {
            virt_text = {
              { "✗ failed", "DiagnosticVirtualTextError" },
              { run_time, "Comment" },
            },
          })
        elseif example.status == "pending" then
          vim.api.nvim_buf_set_extmark(bufnr, ns, example.line_number - 1, 0, {
            virt_text = {
              { "■ pending", "DiagnosticVirtualTextWarn" },
              { run_time, "Comment" },
            },
          })
        end
      end
    end,
    on_exit = function()
      local failed = {}

      for _, test in ipairs(failed_tests) do
        table.insert(failed, {
          bufnr = bufnr,
          lnum = test.line_number - 1,
          col = 0,
          severity = vim.diagnostic.severity.ERROR,
          source = "rspec",
          message = test.full_description,
          user_data = {},
        })
      end

      vim.diagnostic.set(ns, bufnr, failed, {
        virtual_text = false,
      })
    end,
  })
end

if string.match(vim.fn.expand("%"), "_spec.rb") then
  local rspec_augroup = vim.api.nvim_create_augroup("rspec_runner", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Run rspec on save",
    buffer = vim.api.nvim_get_current_buf(),
    group = rspec_augroup,
    callback = run_rspec,
  })
end

-- " Load failing tests in a scratch window
-- nmap <silent> <buffer> +R :Redir !cat tmp/rspec-failures.txt<cr>
--       \ :g/\(passed\\|pending\)/d<cr>
--       \ :v/spec/d<cr>
--       \ :%s/\[\d.*<cr>
--       \ :sort u<cr>
--       \ :%norm! Irspec <cr>
-- " }}} quick testing "
--
-- " sorbet {{{ "
-- " nnoremap <silent> <buffer> <leader>sr :Tux bin/tapioca gems && bin/tapioca dsl && bin/tapioca todo && bin/tapioca check-shims && bundle exec spoom bump<cr>
-- " nnoremap <silent> <buffer> <leader>st :e! sorbet/rbi/todo.rbi<cr>
-- " nnoremap <silent> <buffer> m<cr> :Tux bundle exec srb tc<cr>
-- "
-- " nnoremap <buffer> +T :e sorbet/rbi/shims/<c-r>%<cr>
-- " }}} sorbet "
