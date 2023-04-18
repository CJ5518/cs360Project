--Homes helper

local module = {};
--Model:columns() exists but I didn't use it
module.fields = {
	{"HomeID", "int"}, -- INTEGER PRIMARY KEY,
    {"HomeOwner", "int"}, -- INTEGER,
    {"Address", "string"}, -- varchar(255),
    {"City", "string"}, -- varchar(255),
    {"State", "string"}, -- varchar(255),
    {"ZipCode", "int"}, -- int,
    {"Bedrooms", "int"}, -- int,
    {"Bathrooms", "int"}, -- int,
    {"HalfBaths", "int"}, -- int,
    {"SquareFootage", "int"}, -- int,
    {"CarpetSquareFootage", "int"}, -- int,
    {"ConstructionYear", "int"} -- int,
}

--Version of the above without q=1 or q=2, which are the two ids
module.fieldsWithoutIDs = {};
for q = 3, #module.fields do
	module.fieldsWithoutIDs[q-2] = module.fields[q];
end

return module;