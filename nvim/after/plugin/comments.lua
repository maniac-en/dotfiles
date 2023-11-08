require("Comment").setup({
  mappings = {
    basic = true,
    extra = true,
  }
})

local comment_ft = require("Comment.ft")

-- add an extra space whilst commenting in lua
comment_ft.set("lua", { "--%s", "--[[%s]]" })
