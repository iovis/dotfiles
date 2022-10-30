-- Extract from .env
local database_url = vim.fn.DotenvGet("DATABASE_URL")
local driver = vim.fn.split(database_url, ":")[1]

return {
  settings = {
    sqls = {
      lowercaseKeywords = true,
      connections = {
        {
          driver = driver,
          dataSourceName = database_url,
        },
      },
    },
  },
}
