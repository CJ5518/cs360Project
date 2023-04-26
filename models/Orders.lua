local Model = require("lapis.db.model").Model;
local db = require("lapis.db");

local Homes = require("models.Homes");
local Services = require("models.Services");
local Users = require("models.Users");
local Vendors = require("models.Vendors");

local Orders, Orders_mt = Model:extend("Services", {
	primary_key = "ServiceID"
});

function Orders_mt:getHome()
	return Homes:find(self.HomeID)
end
function Orders_mt:getUser()
	return Homes:find(self.UserID)
end
function Orders_mt:getVendor()
	return Homes:find(self.VendorID)
end
function Orders_mt:getService()
	return Homes:find(self.ServiceID)
end

return Orders;