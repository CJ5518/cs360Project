# Documentation for helpers

## Email

Usage:

```lua
local email = require("helpers.email");
local out, res = email.send_email("address@gmail.com", "Subject", "Body");
```


## RandomString

Usage:

```lua
local getRandomString = require("randomString").getRandomString;
local str = getRandomString(INTEGER_LENGTH);
```