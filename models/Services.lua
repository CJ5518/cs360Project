local Model = require("lapis.db.model").Model;
local db = require("lapis.db");
local Services, Services_mt = Model:extend("Services", {
	primary_key = "ServiceID"
});

--The main type table
function Services:getTypeTable()
	return {
		"internet", -- tab[1] == "internet";
		"cellphoneService", --wncare, mortgage, homeowners’insurance and auto insurance
		"lawnCare",
		"mortgage",
		"homeownersInsurance",
		"autoInsurance",
		"television",
		"electricity"
	}
end



return Services;