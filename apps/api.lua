local lapis = require("lapis");
local app = lapis.Application();

local db = require("lapis.db");
local email = require("helpers.email");
local Users = require("models.Users");
local accounts = require("helpers.accounts");



--Signing up

app:post("signupAction", "/signupAction", function(self)
	self:write(self.POST.userType);
	if self.POST.userType == "Vendor" then
		self:write("Woopsie! Vendorski areski notski allowedski yetski!");
	else
		if Users:exists_email(self.POST.email) then
			--Somebody with that email already exists
			return {
				status = 401,
				json = {
					message = "A user already exists with that email"
				}
			};
		else
			--We are good to make the account
			local user = accounts.makeNewUser(self, self.POST.email, self.POST.password, self.POST.userType);
			self:write(tostring(user.UserID));
		end
	end
end)


-- Logging in and out

app:post("loginAction", "/loginAction", function(self)
	local user = accounts.tryLogIn(self, self.POST.email, self.POST.password, "User");
	if not user then
		return {
			status = 401
		}
	else
		return {
			redirect_to = "/dashboard";
		}
	end
end)

app:match("logout", "/logout", function(self)
	accounts.logOut(self);
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