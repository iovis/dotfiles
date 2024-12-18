---- Insert mode
-- Exit
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("i", "KJ", "<esc>")
vim.keymap.set("i", "Kj", "<esc>")

-- Quick expansions
vim.keymap.set("i", "<m-,>", "<c-o>A,")
vim.keymap.set("i", "<m-.>", "<c-o>A.")
vim.keymap.set("i", "<m-;>", "<c-o>A;")
vim.keymap.set("i", "<m-:>", "<c-o>A:")

-- Append character and open new line
local line_ending = {
  c = ";",
  cpp = ";",
  javascript = ";",
  python = ":",
  rust = ";",
  typescript = ";",
  zig = ";",
}

vim.keymap.set("i", "<m-cr>", function()
  local char = line_ending[vim.bo.filetype] or ""

  return ("<c-o>A%s<cr>"):format(char)
end, { expr = true })

-- Movement
vim.keymap.set("i", "<m-left>", "<s-left>")
vim.keymap.set("i", "<m-right>", "<s-right>")

vim.keymap.set("i", "<c-a>", "<home>")
vim.keymap.set("i", "<c-e>", "<end>")

vim.keymap.set("i", "<m-O>", "<esc>O")
vim.keymap.set("i", "<m-o>", "<esc>o")

---- Terminal mode
vim.keymap.set("t", "KJ", [[<c-\><c-n>]])

-- Terminal popup
local terminal_popup_win = nil
vim.keymap.set({ "t", "n" }, [[<c-_>]], function()
  local current = vim.api.nvim_buf_get_name(0)

  if current:match([[^term://]]) then
    vim.cmd.fclose()
  else
    terminal_popup_win = require("config.utils").floating_term(terminal_popup_win)
  end
end, { desc = "Open floating term" })

---- Operator pending mode (text objects)
-- Whole WORD is kinda awkward to press
vim.keymap.set({ "o", "x" }, "ao", "aW")
vim.keymap.set({ "o", "x" }, "io", "iW")

---- Command mode
vim.keymap.set("c", "<m-p>", "<c-r>=fnameescape(expand('%:.:h')).'/'<cr>")

-- Fish's binding for edit command in editor
vim.keymap.set("c", "<m-e>", "<c-f>")
vim.keymap.set("c", ";", function()
  if vim.fn.getcmdpos() == 1 and vim.fn.getcmdtype() == ":" then
    -- open the command editor on the last line
    return "<c-f>k$"
  end

  return ";"
end, { expr = true })

vim.keymap.set("c", "/", function()
  if vim.fn.getcmdpos() == 1 and vim.fn.getcmdtype() == "/" then
    return "<c-f>k$"
  end

  return "/"
end, { expr = true })

-- Movement
vim.keymap.set("c", "<m-left>", "<s-left>")
vim.keymap.set("c", "<m-right>", "<s-right>")

vim.keymap.set("c", "<c-a>", "<c-b>")
vim.keymap.set("c", "<c-b>", "<nop>")

vim.keymap.set("c", "<c-j>", "<down>")
vim.keymap.set("c", "<c-k>", "<up>")

---- Normal mode
vim.keymap.set("n", "'", "<nop>")
vim.keymap.set("n", "<leader>a", "<nop>")
vim.keymap.set("n", "<leader>f", "<nop>")
vim.keymap.set("n", "<leader>s", "<nop>")
vim.keymap.set("n", "<leader>u", "<nop>")
vim.keymap.set("n", "<space>", "<nop>")

-- Buffers
vim.keymap.set("n", "<bs>", "<c-^>")

vim.keymap.set("n", "<leader>n", "<cmd>enew<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>%bdelete<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>%bdelete|e#|bd#<cr>")
vim.keymap.set("n", "<leader>B", "<cmd>bd!<cr>")

vim.keymap.set("n", "<leader>e", ":e!<space>")
vim.keymap.set("n", "<leader>E", ":e! <c-r>=fnameescape(expand('%:.:h')).'/'<cr>")
vim.keymap.set("n", "<leader>W", ":saveas <c-r>=fnameescape(expand('%:.:h')).'/'<cr>")

-- Editing
vim.keymap.set("n", "J", "m`J``")

vim.keymap.set("n", "<m-j>", "<cmd>m+<cr>==")
vim.keymap.set("n", "<m-k>", "<cmd>m-2<cr>==")
vim.keymap.set("x", "<m-j>", ":m'>+<cr>`<my`>mzgv=gv`yo`z", { silent = true })
vim.keymap.set("x", "<m-k>", ":m'<-2<cr>`>my`<mzgv=gv`yo`z", { silent = true })

vim.keymap.set("n", "<m-o>", "m`o<esc>``")
vim.keymap.set("n", "<m-O>", "m`O<esc>``")

-- vim.keymap.set("n", "<leader>fo", "gg=G")

vim.keymap.set("n", "g2", "m`:set shiftwidth=2 softtabstop=2 expandtab | retab<cr>gg=G``")
vim.keymap.set("n", "g4", "m`:set shiftwidth=4 softtabstop=4 expandtab | retab<cr>gg=G``")

vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Editor
vim.keymap.set({ "n", "x" }, ";", ":")
vim.keymap.set("n", "<leader>x", "<cmd>confirm qa<cr>")
vim.keymap.set("n", "<leader>X", "<cmd>qa!<cr>")
vim.keymap.set("n", "<leader>w", "<cmd>w!<cr>")

-- Macros
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("x", "Q", ":norm @q<cr>", { silent = true })

-- Movement
vim.keymap.set({ "n", "x" }, "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true })
vim.keymap.set({ "n", "x" }, "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true })

vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "$")

vim.keymap.set("n", "<s-up>", "[c", { remap = true })
vim.keymap.set("n", "<s-down>", "]c", { remap = true })

vim.keymap.set("n", "<c-p>", "<c-i>")

-- Panes
vim.keymap.set("n", "<leader>v", "<c-w>v")
vim.keymap.set("n", "<leader>h", "<c-w>s")

vim.keymap.set("n", "<leader>c", "<c-w>c")
vim.keymap.set("n", "<leader>0", "<c-w>=")
vim.keymap.set("n", "<leader>=", "<c-w>=")

vim.keymap.set("n", "<leader>H", "<c-w>H")
vim.keymap.set("n", "<leader>J", "<c-w>J")
vim.keymap.set("n", "<leader>K", "<c-w>K")
vim.keymap.set("n", "<leader>L", "<c-w>L")

vim.keymap.set("n", "M", "<c-w>o")
vim.keymap.set("n", "<leader>m", "<c-w>_<c-w>|")
vim.keymap.set("n", "<leader>_", "<c-w>_")
vim.keymap.set("n", "<leader>|", "<c-w>|")

-- Copy/Paste
vim.keymap.set("n", "Y", "y$")

vim.keymap.set("n", "p", [[p<cmd>execute ":silent normal! `[v`]="<cr>]])
vim.keymap.set("n", "P", [[P<cmd>execute ":silent normal! `[v`]="<cr>]])
vim.keymap.set("n", "gp", "p")
vim.keymap.set("n", "gP", "P")
vim.keymap.set("n", "zp", '"0p')
vim.keymap.set("n", "zP", '"0P')

vim.keymap.set("x", "p", "P") -- don't copy selected text to unnamed register
vim.keymap.set("x", "P", "p")

vim.keymap.set("x", "D", "yP`<^") -- Duplicate visual selection

vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set("n", "<leader>d", '"+d')
vim.keymap.set("n", "<leader>D", '"+d$')

vim.keymap.set("n", "yp", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("0", path)
  vim.notify('Yanked "' .. path .. '"')
end, { desc = "Yank current buffer's path" })

vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy current buffer's path to clipboard" })

vim.keymap.set("n", "yP", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("0", path)
  vim.notify('Yanked "' .. path .. '"')
end, { desc = "Yank current buffer's full path" })

vim.keymap.set("n", "<leader>yP", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy current buffer's full path to clipboard" })

vim.keymap.set("n", "yc", function()
  local path = vim.fn.expand("%:.") .. ":" .. vim.fn.line(".")
  vim.fn.setreg("0", path)
  vim.notify('Yanked "' .. path .. '"')
end, { desc = "Yank current buffer's path and line number" })

vim.keymap.set("n", "<leader>yc", function()
  local path = vim.fn.expand("%:.") .. ":" .. vim.fn.line(".")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy current buffer's path and line number to clipboard" })

-- Quickfix/Location list
vim.keymap.set("n", "<up>", "<cmd>cprevious<cr>")
vim.keymap.set("n", "<down>", "<cmd>cnext<cr>")

vim.keymap.set("n", "<leader><up>", "<cmd>cpfile<cr>")
vim.keymap.set("n", "<leader><down>", "<cmd>cnfile<cr>")

vim.keymap.set("n", "<left>", "<cmd>lprevious<cr>")
vim.keymap.set("n", "<right>", "<cmd>lnext<cr>")

vim.keymap.set("n", "<leader><left>", "<cmd>lpfile<cr>")
vim.keymap.set("n", "<leader><right>", "<cmd>lnfile<cr>")

-- Repeat
vim.keymap.set("n", "<leader>.", "@:")
vim.keymap.set("n", "<leader>,", "@@")
vim.keymap.set("x", ".", ":normal .<cr>", { silent = true })

-- Replace
vim.keymap.set("n", "R", "m`ciw<c-r>0<esc>``")
vim.keymap.set("x", "R", '"0p')

-- Search
vim.keymap.set("n", "<leader>;", function()
  vim.cmd.nohlsearch()
  vim.cmd.echon()
end, { desc = "Clear search highlights and command line output" })

vim.keymap.set("n", "*", [[:let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>]], { silent = true })
vim.keymap.set("x", "*", [[y:let @/= '\V' . escape(@@, '/\') <bar> set hls <bar> normal! /<cr>]], { silent = true })

-- Tabs
vim.keymap.set("n", "'q", "<cmd>tabonly<cr>")
vim.keymap.set("n", "<leader><", "<cmd>tabmove -1<cr>")
vim.keymap.set("n", "<leader>>", "<cmd>tabmove +1<cr>")
vim.keymap.set("n", "<leader>C", "<cmd>tabclose<cr>")
vim.keymap.set("n", "<leader>t", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<leader><tab>", function()
  local number_of_windows = #vim.api.nvim_tabpage_list_wins(0)

  if number_of_windows == 1 then
    vim.cmd("tab sbuffer")
  else
    vim.cmd.wincmd("T")
  end
end, { desc = "Tab with current buffer" })

-- Tags
vim.keymap.set("n", "t", "<c-]>", { remap = true })
vim.keymap.set("n", "T", "g]")

---- Quick File access
-- Config files
vim.keymap.set("n", "<leader>uf", "<cmd>EditFtplugin<cr>")
vim.keymap.set("n", "<leader>uF", ":EditFtplugin<space>")

-- Notes
vim.keymap.set("n", "<leader>un", ":e! notes/index.md<cr>")
vim.keymap.set("n", "<leader>N", function()
  local note = string.format("notes/%s.md", vim.fn.strftime("%F"))
  vim.cmd.edit(note)
end, { desc = "Open daily note" })

-- Project files
vim.keymap.set("n", "<leader>uC", "<cmd>e! CMakeLists.txt<cr>")
vim.keymap.set("n", "<leader>uc", "<cmd>e! Cargo.toml<cr>")
vim.keymap.set("n", "<leader>ue", "<cmd>e! .env<cr>")
vim.keymap.set("n", "<leader>ug", "<cmd>e! .gitignore<cr>")
vim.keymap.set("n", "<leader>uj", "<cmd>e! justfile<cr>")
vim.keymap.set("n", "<leader>up", "<cmd>e! package.json<cr>")

---- Toggle Settings
vim.keymap.set("n", "yoc", ":set cursorcolumn!<cr>")
vim.keymap.set("n", "yod", ":<c-r>=&diff ? 'windo diffoff' : 'windo diffthis'<cr><cr>")
vim.keymap.set("n", "yoh", ":set hlsearch!<cr>")
vim.keymap.set("n", "yoi", ":set list!<cr>")
vim.keymap.set("n", "yol", ":set cursorline!<cr>")
vim.keymap.set("n", "yon", ":set number!<cr>")
vim.keymap.set("n", "yor", ":set relativenumber!<cr>")
vim.keymap.set("n", "yos", ":setlocal spell! spelllang=en_us<cr>")
vim.keymap.set("n", "yow", ":setlocal wrap!<cr>")

vim.keymap.set("n", "yoC", function()
  if vim.o.conceallevel == 2 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end, { desc = "Toggle conceallevel" })

vim.keymap.set("n", "yoa", function()
  vim.g.autoformat = not vim.g.autoformat

  if vim.g.autoformat then
    vim.notify("Autoformat enabled")
  else
    vim.notify("Autoformat disabled")
  end
end, { desc = "Toggle autoformat" })

vim.keymap.set("n", "<leader>af", function()
  if vim.bo.textwidth == 0 then
    vim.bo.textwidth = 80
    vim.opt_local.formatoptions:append("a")
    vim.notify("Autowidth enabled [80]")
  else
    vim.bo.textwidth = 0
    vim.opt_local.formatoptions:remove("a")
    vim.notify("Autowidth disabled")
  end
end, { desc = "Toggle autowidth" })

vim.keymap.set("n", "yof", function()
  vim.g.foldcolumn = not vim.g.foldcolumn

  -- HACK: statuscol doesn't refresh properly
  local current_window = vim.api.nvim_get_current_win()
  vim.cmd("tabdo windo se nu!")
  vim.cmd("tabdo windo se nu!")
  vim.api.nvim_set_current_win(current_window)
  vim.cmd("redraw!")
end, { desc = "Toggle foldcolumn" })

vim.keymap.set("n", "yoz", function()
  if vim.o.scrolloff == vim.g.scrolloff then
    vim.o.scrolloff = 999
    vim.cmd.normal("zz")
  else
    vim.o.scrolloff = vim.g.scrolloff
  end
end, { desc = "Toggle scroll lock" })

---- Misc
vim.keymap.set("n", "'<cr>", "<cmd>so $VIMRUNTIME/syntax/hitest.vim<cr>")
vim.keymap.set("n", "<leader>P", ":R=")
vim.keymap.set("n", "<leader>M", "<cmd>10R messages<cr>G")
vim.keymap.set("n", "'M", function()
  vim.cmd("messages clear")
  vim.notify("messages cleared")
end, { desc = "Clear messages" })

---- Global substitutions
vim.keymap.set({ "n", "x" }, "'g", ":g/\\v")
vim.keymap.set({ "n", "x" }, "'v", ":v/\\v")
vim.keymap.set({ "n", "x" }, "'l", function()
  return ':luado return string.format("%s", line)' .. ("<left>"):rep(10)
end, { expr = true })
vim.keymap.set({ "n", "x" }, "'L", function()
  ----Notes:
  -- - Splitting line on a separator: vim.split(line, "<separator>")
  -- - Joining array of strings: table.concat(<table>, "<separator>")
  return ':luado return table.concat(vim.split(line, "", { trimempty = true }), "")' .. ("<left>"):rep(29)
end, { expr = true })
vim.keymap.set({ "n", "x" }, "'r", [[:rubydo $_ = "#{$_}"<left>]])

---- Quickfix toggle
vim.keymap.set("n", "\\", function()
  if vim.fn.getqflist({ winid = 1 }).winid == 0 then
    vim.cmd("botright copen")
  else
    vim.cmd("cclose")
  end
end, { desc = "QuickFix Toggle" })

---- Tmux quick switching
vim.keymap.set("n", "'V", "<cmd>VimPlugin<cr>")

---- Toggle autotest
vim.keymap.set("n", "<leader>TD", function()
  vim.g.autotest = nil
  vim.notify("Autotest disabled")
end, { desc = "Autotest disable" })

vim.keymap.set("n", "<leader>TL", function()
  vim.g.autotest = "line"
  vim.notify("Autotest line")
end, { desc = "Autotest line" })

vim.keymap.set("n", "<leader>TF", function()
  vim.g.autotest = "file"
  vim.notify("Autotest file")
end, { desc = "Autotest file" })

vim.keymap.set("n", "<leader>TT", function()
  vim.ui.select({ "file", "line", "disable" }, {
    prompt = "RSpec> ",
    format_item = function(item)
      local is_current = ""

      if vim.g.autotest == item or (vim.g.autotest == nil and item == "disable") then
        is_current = " (current)"
      end

      return item .. is_current
    end,
  }, function(choice)
    if choice == "disable" then
      vim.g.autotest = nil
    else
      vim.g.autotest = choice
    end
  end)
end, { desc = "Toggle autotest" })
