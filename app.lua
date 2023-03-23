local lapis = require("lapis");
local app = lapis.Application();
app:enable("etlua");
app.layout = require "views.layout"

local db = require("lapis.db");

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

app:post("loginAction", "/loginAction", function(self)
	if self.POST.userType == "User" then
		local res = db.query("SELECT UserID, FirstName FROM Users WHERE Password = ? AND Email = ?;", self.POST.password, self.POST.email);
		if (res[1]) then
			self.session.userInfo = {FirstName = res[1]["FirstName"]};
			return {render = "dashboard"};
		else
			self:write("Login failed");
			return;
		end
	end
	self:write("Login failed");
end)

app:match("logout", "/logout", function(self)
	self.session.userInfo = nil;
	return {render = "index"};
end)

app:post("signupUserFinal", "/signupUserFinal", function(self)
	--[[local res = db.query("SELECT * FROM Users")
	for i,v in pairs(res) do
		self:write("<br> " .. tostring(i) .. ": " .. tostring(v));
		for i2, v2 in pairs(v) do
			self:write("<br>&emsp;" .. tostring(i2) .. ": " .. tostring(v2));
		end
	end--]]
	db.query("INSERT INTO Users (FirstName, Email, Password) VALUES (?,?,?)", 
		self.POST.FirstName, self.session.signupInfo.email, self.session.signupInfo.password
	);
	local userInfo = {};
	userInfo.FirstName = self.POST.FirstName;
	userInfo.email = self.session.signupInfo.email;
	self.session.userInfo = userInfo;
	self.session.signupInfo = nil;
	return {render = "dashboard"};
end)

app:match("/*", function(self)
	return {render = self.params.splat};
end)

app:match("/service/:service_id", function(self)
	self.service_id = self.params.service_id;
	return {render = "servicePage"}
end)

return app;
