local ok, bqf = pcall(require, "bqf")
if not ok then
  print("bqf not found!")
  return
end

bqf.setup({
  filter = {
    fzf = {
      extra_opts = {
        "--bind",
        "ctrl-p:page-down,ctrl-n:page-up,alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all",
      },
    },
  },
  func_map = {
    ptoggleauto = "p",
  },
})