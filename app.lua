local lapis = require("lapis");
local app = lapis.Application();
app:enable("etlua");
app.layout = require "views.layout"

local db = require("lapis.db");
local email = require("helpers.email");
local Users = require("models.Users");

--Signing up

app:post("signupAction", "/signupAction", function(self)
	if self.POST.userType == "User" then
		if Users:exists_email(self.POST.email) then
			--TODO
			self:write("This user already exists!");
		else
			local user = Users:new(self.POST.email, self.POST.password);
			self.session.isLoggedIn = true;
			self.session.userID = user.UserID;
			return {redirect_to = "/dashboard"};
		end
	end
	--TODO
	self:write("Sorry! Vendors are currently not allowed to exist")
end)


-- Logging in and out

app:post("loginAction", "/loginAction", function(self)
	if self.POST.userType == "User" then
		local res = db.query("SELECT UserID, FirstName FROM Users WHERE Password = ? AND Email = ?;", self.POST.password, self.POST.email);
		if (res[1]) then
			self.session.userInfo = {FirstName = res[1]["FirstName"]};
			return {redirect_to = "/dashboard"};
		else
			self:write("Login failed");
			return;
		end
	end
	self:write("Login failed");
end)

app:match("logout", "/logout", function(self)
	self.session.isLoggedIn = nil;
	self.session.userID = nil;
	return {redirect_to  = "/"};
end)

--Updating user info

app:post("updateUserInfo", "/updateUserInfo", function(self)
	if self.session.isLoggedIn then
		local user = Users:find(self.session.userID);
		user.FirstName = self.POST.FirstName;
		user.LastName = self.POST.LastName;
		user.PhoneNumber = self.POST.PhoneNumber;
		user.AnnualIncome = self.POST.AnnualIncome;
		user:update("FirstName", "LastName", "PhoneNumber", "AnnualIncome");
		return {redirect_to = "/dashboard"};
	else
		self:write("Something went wrong, sorry! (updateUserInfo)");
	end
end)

--------------------------------------------------
-- Routes that go to pages --
--------------------------------------------------

--Index page
app:get("index", "/", function(self)
	if self.session.isLoggedIn then
		return {redirect_to = "dashboard"};
	end
	return {render = "index"};
end)

app:match("index2", "/index", function(self)
	return {redirect_to = "/"};
end)

--Dashboard
app:get("dashboard", "/dashboard", function(self)
	if not self.session.isLoggedIn then
		return {redirect_to = "/"};
	end
	return {render = "dashboard"};
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
