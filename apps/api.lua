local lapis = require("lapis");
local app = lapis.Application();

local db = require("lapis.db");
local send_email = require("helpers.email").send_email;
local Users = require("models.Users");
local accounts = require("helpers.accounts");
local getRandomString = require("helpers.randomString").getRandomString;

app:before_filter(function(self)
	self.user = accounts.isLoggedIn(self);
end)


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
			return {redirect_to = "/dashboard"};
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

-----------------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------

app:post("passwordResetRequest", "/passwordResetRequest", function(self)
	local email = self.POST.email;
	local user = Users:find({["email"] = email});
	if user then
		--TODO (Maybe)
		--Send them a new password
		user.Password = getRandomString(30);
		local out, res = send_email(email, "MyHome - Password Reset", "Here's your new password: " .. user.Password);
		if out:find("Queued") then
			user:update("Password");
			return {
				status = 200,
				json = {
					message = "An email has been sent to the address you entered"
				}
			}
		else
			return {
				status = 500
			}
		end
	end
	return {
		status = 404,
		json = {
			message = "Could not find an account with the email you entered"
		}
	};
end)

--Updating user info

app:post("updateUserInfoAction", "/updateUserInfoAction", function(self)
	local user = accounts.isLoggedIn(self);
	if user then
		user.FirstName = self.POST.FirstName == "" and user.FirstName or self.POST.FirstName;
		user.LastName = self.POST.LastName == "" and user.LastName or self.POST.LastName;
		user.PhoneNumber = self.POST.PhoneNumber == "" and user.PhoneNumber or self.POST.PhoneNumber;
		user.AnnualIncome = self.POST.AnnualIncome == "" and user.AnnualIncome or self.POST.AnnualIncome;
		user:update("FirstName", "LastName", "PhoneNumber", "AnnualIncome");
		return {redirect_to = "/dashboard"};
	else
		self:write("Something went wrong, sorry! (updateUserInfoAction)");
	end
end)

return app;