--FOR ALL FUNCTIONS: Takes the self param of the thing calling, do NOT call account:isLoggedIn

--Includes
local db = require("lapis.db");
local email = require("helpers.email");
local Users = require("models.Users");
local Vendors = require("models.Vendors");

local accounts = {};

--Do we smack the database every time we check if the user is logged in?
local confirmUserHard = true;

--@tparam self - self object containing self.session
--@treturn User/Vendor user - returns the current user or nil
function accounts.isLoggedIn(self)
	if self then
		if self.session then
			if self.session.current_user then
				if self.session.current_user.Type and self.session.current_user.UserID then
					print(self.session.current_user.Type);
					if self.session.current_user.Type == "User" then
						return Users:find(tonumber(self.session.current_user.UserID));
					elseif self.session.current_user.Type == "Vendor" then
						return Vendors:find(tonumber(self.session.current_user.UserID));
					else
						error("Bad user type in self.session.current_user.Type somehow");
					end
				else
					error("accounts.isLoggedIn: self.session.current_user exists, but not one of the ID or Type");
				end
			else -- not self.session.current_user
				return nil;
			end
		else -- not self.session
			error("Bad argument to account.isLoggedIn #1: Excepted object with session, got object without session")
		end
	else -- not self
		error("Bad argument to account.isLoggedIn #1: Excepted object, got nothing")
	end
end

--- Check if an email is taken
--@tparam self - self object containing self.session
--@tparam self - self object containing self.session
--@treturn User/Vendor account - returns the found account type object
function accounts.checkIfEmailIsTaken(self, email, type)
	if type == "User" then
		return Users:exists_email(email);
	elseif type == "Vendor" then
		return Vendors:exists_email(email);
	else
		error("Bad arg to accounts.checkIfEmailIsTaken");
	end
end

--- Make a new account. DOESN'T check if the account already exists
--@tparam self - self object containing self.session
--@treturn User/Vendor account - returns the newly logged in user/vendor object, or nil
function accounts.makeNewAccount(self, email, pass, type)
	if type == "User" then
		Users:new(email, pass);
		return accounts.tryLogIn(self, email, pass, type);
	elseif type == "Vendor" then
		Vendors:new(email, pass);
		return accounts.tryLogIn(self, email, pass, type);
	else
		error("Bad argument #4 to accounts.makeNewAccount: Type expected, got: " .. tostring(type));
	end
end

--- Try to log in
--@tparam self - self object containing self.session
--@treturn User/Vendor user - returns the newly logged in user object, or nil
function accounts.tryLogIn(self, email, pass, type)
	if type == "User" then
		local user = Users:with_credentials(email, pass);
		if not user then return nil; end
		self.session.current_user = {};
		self.session.current_user.UserID = user.UserID;
		self.session.current_user.Type = "User";
		return user;
	elseif type == "Vendor" then
		local user = Vendors:with_credentials(email, pass);
		if not user then return nil; end
		self.session.current_user = {};
		self.session.current_user.UserID = user.VendorID;
		self.session.current_user.Type = "Vendor";
	else
		error("Bad type pass to account.tryLogIn: " .. tostring(type));
	end
end

--@tparam self - self object containing self.session
--@treturn string type - the account type, either "User" or "Vendor";
function accounts.getAccountType(self)
	if self and
	self.session and
	self.session.current_user and
	self.session.current_user.Type then
		return self.session.current_user.Type;
	end
end


--- Logs the user out
--@tparam self - self object containing self.session
function accounts.logOut(self)
	self.session.current_user = nil;
end

return accounts;
