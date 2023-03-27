local lapis = require("lapis");
local app = lapis.Application();

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

app:get("passwordResetRequest", "/passwordResetRequest", function(self)
	return {json = {thingy = "Sup"}};
end)

--Updating user info

app:post("updateUserInfoAction", "/updateUserInfoAction", function(self)
	if self.session.isLoggedIn then
		local user = Users:find(self.session.userID);
		user.FirstName = self.POST.FirstName == "" and user.FirstName or self.POST.FirstName;
		user.LastName = self.POST.LastName == "" and user.LastName or self.POST.LastName;
		user.PhoneNumber = self.POST.PhoneNumber == "" and user.PhoneNumber or self.POST.PhoneNumber;
		user.AnnualIncome = self.POST.AnnualIncome == "" and user.AnnualIncome or self.POST.AnnualIncome;
		user:update("FirstName", "LastName", "PhoneNumber", "AnnualIncome");
		return {redirect_to = "/dashboard"};
	else
		self:write("Something went wrong, sorry! (updateUserInfo)");
	end
end)

return app;