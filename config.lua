local config = require("lapis.config")

config("development", {
  server = "nginx",
  code_cache = "off",
  num_workers = "1",
  sqlite = {
    database = "dev_database.sqlite"
  }
})
