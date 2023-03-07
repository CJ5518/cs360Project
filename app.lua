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

return app;
