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

--- Check if a user credentials are correct
--@tparam string email - the email
--@tparam string pass - the password
--@treturn User user - the user with the credentials, or nil
function Users:exists_email(email)
	return Users:find({[db.raw("lower(Email)")] = email:lower()});
end


--- Create a new user
--@tparam string email - the email of the new user
--@tparam string pass - the password of the new user
--@treturn User user - the user with the email, or nil
function Users:new(email, pass)
	return Users:create({
		Email = email,
		Password = pass
	})
end


return Users;