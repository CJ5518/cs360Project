local lapis = require("lapis");
local app = lapis.Application();
app:enable("etlua");
app.layout = require "views.layout"

app:get("index", "/", function()
	return {render = "index"};
end)

app:get("dashboard", "/dashboard", function()
	return {render = "dashboard"};
end)

app:get("serviceCalc", "/servicecalculator", function()
	return {render = "serviceCalc"};
end)

app:get("login", "/login", function()
	return {render = "login"};
end)

app:get("signup", "/signup", function()
	return {render = "signup"};
end)

return app;
