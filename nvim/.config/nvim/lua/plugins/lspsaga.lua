local ok, lspsaga = pcall(require, "lspsaga")
if not ok then
  print("lspsaga not found!")
  return
end

lspsaga.init_lsp_saga({
  code_action_icon = "•",
  code_action_lightbulb = {
    sign = false,
  },
  finder_action_keys = {
    open = "<cr>",
  },
  show_outline = {
    jump_key = "<cr>",
  },
  symbol_in_winbar = {
    enable = false,
  },
})
