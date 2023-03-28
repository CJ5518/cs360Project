local lapis = require("lapis");
local app = lapis.Application();
local accounts = require("helpers.accounts");

app:before_filter(function(self)
	self.user = accounts.isLoggedIn(self);
end)


app:enable("etlua");
app.layout = require "views.layout"

app:include("apps.web");
app:include("apps.api");

return app;