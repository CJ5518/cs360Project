local Model = require("lapis.db.model").Model;
local db = require("lapis.db");

local Homes = require("models.Homes");
local Services = require("models.Services");
local Users = require("models.Users");
local Vendors = require("models.Vendors");

local Orders, Orders_mt = Model:extend("Orders", {
	primary_key = "OrderID"
});

function Orders_mt:getHome()
	return Homes:find(self.HomeID)
end
function Orders_mt:getUser()
	return Users:find(self.UserID)
end
function Orders_mt:getVendor()
	return Vendors:find(self.VendorID)
end
function Orders_mt:getService()
	return Services:find(self.ServiceID)
end
function Orders_mt:getState()
	return self.OrderStateEnum;
end
function Orders:getStateEnumName(id)
	local tab = {
		"Requested",
		"Accepted"
	}
	return tab[id];
end

return Orders;