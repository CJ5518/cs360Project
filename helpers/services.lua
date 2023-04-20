--Services helper

local module = {};
--Model:columns() exists but I didn't use it
module.fields = {
    {"ServiceID", "int"},
    {"ServiceOwner", "int"}, 
    {"Name", "string"},
    {"Description", "string"},
    {"PricePerUnit", "int"}, 
    {"PriceUnitID", "int"},
	{"ServiceTypeID", "int"},
    {"Field1", "string"},
    {"Field2", "string"},
    {"Field3", "string"},
    {"Field4", "string"},
    {"Field5", "string"},
    {"Field6", "string"},
    {"Field7", "string"},
    {"Field8", "string"},
    {"Field9", "string"}
}

module.types = {
	"internet", -- tab[1] == "internet";
	"cellphoneService",
	"lawnCare",
	"mortgage",
	"homeownersInsurance",
	"autoInsurance",
	"television",
	"electricity"
}

--Get the ID of a string type
function module.getIDFromType(str)
	for i, v in pairs(module.types) do
		if v == str then return i end
	end
end

function module.getTypeFromID(id)
	if type(id) ~= "number" then
		error("Something other than number passed as id (getTypeFromID)");
	else
		return module.types[id];
	end
end

--The special fields for all the types
module.typeFields = {
	["internet"] = { --Internet
		{"speed", "int"}, --Name, type (although everything is stored as a string)
		{"data", "mixed", "unlimited"}
	},
	["cellphoneService"] = { --cellphoneService
		{"data", "mixed", "unlimited"}, --Mixed means both int and string, typically the string will be special and one-of-a-kind
		{"minutes", "mixed", "unlimited"}, --You can check this third property for the special string(s)
		{"messages", "mixed", "unlimited"},
		{"devices", "mixed", "unlimited"}
	},
	["lawnCare"] = { --Lawn care

	},
	["mortgage"] = { --mortgage
		{"interest", "int"} --Called int by convention, this one should actually be a float or as lua calls it a number
	},
	["homeownersInsurance"] = { --homeownersInsurance
		--I have never dealt with homeownersInsurance in my life
	},
	["autoInsurance"] = { --autoInsurance

	},
	["television"] = { --television
		{"type", "string", "streaming", "live"} -- note that this string field includes options
	},
	["electricity"] = { --electricity

	}
}

--Version of the above without q=1 or q=2, which are the two ids
--Or any of the generic field items, or PriceUnitIDs or service type id
module.fieldsWithoutIDsOrGenerics = {};
for q = 3, #module.fields-11 do
	module.fieldsWithoutIDsOrGenerics[q-2] = module.fields[q];
end

return module;