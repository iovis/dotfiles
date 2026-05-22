return {
  -- Stop clangd from flooding the logs
  cmd = { "clangd", "--log=error" },
}
