local lapis = require("lapis");
local app = lapis.Application();
app:enable("etlua");
app.layout = require "views.layout"

local db = require("lapis.db");


--Signing up

app:post("signupAction", "/signupAction", function(self)
	self.session.signupInfo = self.POST;
	if self.POST.userType == "User" then
		return {render = "signupUser"}
	end
	return {render = "signupVendor"}
end)

app:post("signupUserFinal", "/signupUserFinal", function(self)
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


-- Logging in and out

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
	return {redirect_to  = "/"};
end)

--------------------------------------------------
-- Routes that go to pages --
--------------------------------------------------

--Index page
app:get("index", "/", function()
	return {render = "index"};
end)

--Service page
app:match("/service/:service_id", function(self)
	self.service_id = self.params.service_id;
	return {render = "servicePage"}
end)

--A catch-all, probably not good for prod but easy for adding lots of new pages
app:match("/*", function(self)
	return {render = self.params.splat};
end)

return app;
