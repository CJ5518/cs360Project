# Documentation for helpers

## Email

Usage:

```lua
local send_email = require("helpers.email").send_email;
local out, res = send_email("address@gmail.com", "Subject", "Body");
```


## RandomString

Usage:

```lua
local getRandomString = require("randomString").getRandomString;
local str = getRandomString(INTEGER_LENGTH);
```