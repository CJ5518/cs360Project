local Model = require("lapis.db.model").Model;
local db = require("lapis.db");
local Services, Services_mt = Model:extend("Services", {
	primary_key = "ServiceID"
});




return Services;