local Model = require("lapis.db.model").Model;
local db = require("lapis.db");
local Homes, Homes_mt = Model:extend("Homes", {
	primary_key = "HomeID"
});


return Homes;