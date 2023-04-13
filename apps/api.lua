local lapis = require("lapis");
local app = lapis.Application();

local db = require("lapis.db");
local send_email = require("helpers.email").send_email;
local Users = require("models.Users");
local Vendors = require("models.Vendors");
local Homes = require("models.Homes");
local homesHelper = require("helpers.homes");
local accounts = require("helpers.accounts");
local getRandomString = require("helpers.randomString").getRandomString;

-- I don't think the top-level before filter worked, it might but it's whatever
app:before_filter(function(self)
	self.account = accounts.isLoggedIn(self);
end)


--Signing up

app:post("signupAction", "/signupAction", function(self)
	--Check if this email is already in use
	local isOtherUser = false;
	if self.POST.userType == "Vendor" then
		isOtherUser = Vendors:exists_email(self.POST.email)
	elseif self.POST.userType == "User" then
		isOtherUser = Users:exists_email(self.POST.email)
	else
		error("Bad POST data to signupAction, userType is bad");
	end

	--If in use, return error code
	if isOtherUser then
		return {
			status = 401,
			json = {
				message = "A user already exists with that email"
			}
		};
	end

	--Otherwise, make a new account and send them to the dashboard
	local user = accounts.makeNewAccount(self, self.POST.email, self.POST.password, self.POST.userType);
	return {redirect_to = "/dashboard"};
end)


-- Logging in and out

app:post("loginAction", "/loginAction", function(self)
	local user;
	local succ, msg = pcall(function()
	user = accounts.tryLogIn(self, self.POST.email, self.POST.password, self.POST.userType);
	end)
	print(succ, msg);
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

--Log out

app:post("logout", "/logout", function(self)
	accounts.logOut(self);
end)
app:get("logout", "/logout", function(self)
	accounts.logOut(self);
	return {redirect_to = "index"};
end)


-- Reset password

app:post("passwordResetRequest", "/passwordResetRequest", function(self)
	local email = self.POST.email;
	--TODO (vendor support)
	local user = Users:find({["email"] = email});
	if user then
		--TODO (Maybe) (I think this was (adjust dumbness))
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
		else --Message did not send
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


--Update vendor info
--TODO (Make it work for vendors, file uploads)
--Very broken try not to use
app:post("updateVendorInfoAction", "/updateVendorInfoAction", function(self)
	local user = accounts.isLoggedIn(self);
	if user then
		user.CompanyName = self.POST.FirstName == "" and user.FirstName or self.POST.FirstName;
		user.LastName = self.POST.LastName == "" and user.LastName or self.POST.LastName;
		user.PhoneNumber = self.POST.PhoneNumber == "" and user.PhoneNumber or self.POST.PhoneNumber;
		user.AnnualIncome = self.POST.AnnualIncome == "" and user.AnnualIncome or self.POST.AnnualIncome;
		user:update("FirstName", "LastName", "PhoneNumber", "AnnualIncome");
		return {redirect_to = "/dashboard"};
	else
		self:write("Something went wrong, sorry! (updateVendorInfoAction)");
	end
end)

--All to do with creating and editing homes

--Accepts POST data in the form
--self.POST.Address = "123 Fake Street";
--self.POST.NewHome = true; --IF you want to make a new home
app:post("homes", "homes/", function(self)
	--TODO (finish)
	local data = self.POST;

	--Does this home exist?

	--Bad update request
	if (not data.HomeID or data.HomeID < 0) and not data.NewHome then
		return {status = 400};
	end

	--Only users get to add homes
	if not (accounts.getAccountType(self) == "User") then
		return {status = 401};
	end

	local home = Homes:find(data.HomeID);
	--Editing home but couldn't find the given id
	if not home and not data.NewHome then
		return {status = 404};
	end

	--Get the data from post into something concrete that we know is good
	local updateTable = {};
	for q = 1, #homesHelper.fieldsWithoutIDs do
		local name, type = homesHelper.fieldsWithoutIDs[q][1], homesHelper.fieldsWithoutIDs[q][2];
		local newFieldValue;
		if type == "int" then
			newFieldValue = tonumber(data[name]);
		elseif type == "string" then
			--It probably already is a string but whatever
			newFieldValue = tostring(data[name]);
		else
			error("Can't handle a type from homesHelper.fieldsWithoutIDs");
		end
		updateTable[name] = newFieldValue;
	end
	--If just updating
	if not data.NewHome then
		home:update(updateTable);
	else --Making new home
		updateTable["HomeOwner"] = self.account.UserID; --We make sure we are logged in as user beforehand
		Homes:create(updateTable);
	end
end)

app:delete("homes", "homes/", function(self)
	--TODO

end)

return app;