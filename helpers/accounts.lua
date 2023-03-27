--FOR ALL FUNCTIONS: Takes the self param of the thing calling, do NOT call account:isLoggedIn

--Includes
local db = require("lapis.db");
local email = require("helpers.email");
local Users = require("models.Users");

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
					if self.session.current_user.Type == "User" then
						return User:find(tonumber(self.session.current_user.UserID));
					elseif self.session.current_user.Type == "Vendor" then
						--TODO
						error("Come back later for Vendor support!");
					else
						error("Bad user type in self.session.current_user.Type somehow");
					end
				else
					error("accounts.isLoggedIn: self.session.current_user exists, but not one of the UserID or Type?");
				end
			else
				return nil;
			end
		else
			error("Bad argument to account.isLoggedIn #1: Excepted object with session, got object without session")
		end
	else
		error("Bad argument to account.isLoggedIn #1: Excepted object, got nothing")
	end
end

function accounts.tryNewUser(self, email, pass, type)

end

--@tparam self - self object containing self.session
--@treturn bool isLoggedIn - returns true if the user is logged in
function accounts.tryLogIn(self, email, pass, type)
	if type == "User" then
		local user = Users:check_credentials(email, pass);
		self.session.current_user = {};
		self.session.current_user.UserID = user.UserID;
		self.session.current_user.Type = "User";
	elseif type == "Vendor" then
		--TODO
		error("Vendor not ready yet come back later");
	else
		error("Bad type pass to account.tryLogIn: " .. tostring(type));
	end
end

--Logs the user out
--@tparam self - self object containing self.session
function accounts.logOut(self)
	self.session.current_user = nil;
end

return accounts;
