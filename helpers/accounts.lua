--FOR ALL FUNCTIONS: Takes the self param of the thing calling, do NOT call account:isLoggedIn

--Includes
local db = require("lapis.db");
local email = require("helpers.email");
local Users = require("models.Users");

local accounts = {};

--Do we smack the database every time we check if the user is logged in?
local confirmUserHard = true;

--@tparam self - self object containing self.session
--@treturn bool isLoggedIn - returns true if the user is logged in
function accounts.isLoggedIn(self)

end

function accounts.tryNewUser(self, email, pass)

end

function accounts.tryLogIn(self, email, pass, type)
	local user = Users:exists_email(email);
end

function account.logOut(self)

end

return accounts;
