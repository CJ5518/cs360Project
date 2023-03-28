local Model = require("lapis.db.model").Model;
local db = require("lapis.db");
local Vendors, Vendors_mt = Model:extend("Vendors", {
	primary_key = "VendorID"
});

--- Check if a vendor already exists
--@tparam string email - the email you want to check
--@treturn Vendors vendor - the vendor with the email, or nil
function Vendors:exists_email(email)
	return Vendors:find({[db.raw("lower(Email)")] = email:lower()});
end

--- Check if a vendor credentials are correct
--@tparam string email - the email
--@tparam string pass - the password
--@treturn Vendor vendor - the vendor with the credentials, or nil
function Vendors:with_credentials(email, pass)
	return Vendors:find({[db.raw("lower(Email)")] = email:lower(), Password = pass});
end


--- Create a new vendor
--@tparam string email - the email of the new vendor
--@tparam string pass - the password of the new vendor
--@treturn Vendors vendor - the vendor with the email, or nil
function Vendors:new(email, pass)
	return Vendors:create({
		Email = email,
		Password = pass
	})
end


return Vendors;