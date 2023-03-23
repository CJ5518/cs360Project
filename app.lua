local lapis = require("lapis");
local app = lapis.Application();
app:enable("etlua");
app.layout = require "views.layout"

app:get("index", "/", function()
	return {render = "index"};
end)

app:post("signupAction", "/signupAction", function(self) 
	for i, v in pairs(self.POST) do
		self:write(tostring(i) .. ": ", tostring(v));
	end
end)

app:match("/*", function(self)
	return {render = self.params.splat};
end)

app:match("/service/:service_id", function(self)
	self.service_id = self.params.service_id;
	return {render = "servicePage"}
end)

return app;
