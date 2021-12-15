require('bqf').setup({
  filter = {
    fzf = {
      extra_opts = { '--bind', 'ctrl-p:page-down,ctrl-n:page-up,alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all' }
    }
  },
  func_map = {
    ptoggleauto = 'p'
  }
})