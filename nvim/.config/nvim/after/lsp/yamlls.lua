return {
  settings = {
    yaml = {
      schemas = require("schemastore").yaml.schemas(),
      schemaStore = {
        enable = false,
        url = "",
      },
    },
  },
}
