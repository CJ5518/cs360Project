local lapis = require("lapis");
local app = lapis.Application();

app:enable("etlua");
app.layout = require "views.layout"

app:include("apps.web");
app:include("apps.api");

return app;