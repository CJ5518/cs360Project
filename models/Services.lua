local Model = require("lapis.db.model").Model;
local db = require("lapis.db");
local servicesHelper = require("helpers.services");

local Services, Services_mt = Model:extend("Services", {
	primary_key = "ServiceID"
});

function Services_mt:getTypeFields()
	return servicesHelper.typeFields[servicesHelper.types[self.ServiceTypeID]];
end

function Services_mt:getField(q)
	return self["Field" .. tostring(q)]
end

return Services;