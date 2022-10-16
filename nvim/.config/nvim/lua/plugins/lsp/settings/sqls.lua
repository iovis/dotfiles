return {
  settings = {
    sqls = {
      connections = {
        {
          driver = "postgresql",
          dataSourceName = "postgresql://localhost/rubicon_development",
          -- dataSourceName = "postgres://postgres:password@localhost/newsletter",
        },
      },
    },
  },
}
