local ok, comment = pcall(require, "Comment")
if not ok then
  print("Comment not found!")
  return
end

comment.setup()
