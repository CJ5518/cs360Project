local Model = require("lapis.db.model").Model;
local db = require("lapis.db");
local Users, Users_mt = Model:extend("Users", {
	primary_key = "UserID"
});

--- Check if a user already exists
--@tparam string email - the email you want to check
--@treturn User user - the user with the email, or nil
function Users:exists_email(email)
	return Users:find({[db.raw("lower(Email)")] = email:lower()});
end

function Users:new(email, pass)
	return Users:create({
		Email = email,
		Password = pass
	})
end


return Users;