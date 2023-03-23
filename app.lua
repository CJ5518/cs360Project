local lapis = require("lapis");
local app = lapis.Application();
app:enable("etlua");
app.layout = require "views.layout"

app:get("index", "/", function()
	return {render = "index"};
end)

app:post("signupAction", "/signupAction", function(self)
	self.session.signupInfo = self.POST;
	if self.POST.userType == "User" then
		return {render = "signupUser"}
	end
	return {render = "signupVendor"}
end)

app:post("signupUserFinal", "/signupUserFinal", function(self)

end)

app:match("/*", function(self)
	return {render = self.params.splat};
end)

app:match("/service/:service_id", function(self)
	self.service_id = self.params.service_id;
	return {render = "servicePage"}
end)

return app;
