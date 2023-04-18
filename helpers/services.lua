--Services helper

local module = {};
--Model:columns() exists but I didn't use it
module.fields = {
    {"ServiceID", "int"}
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

--Version of the above without q=1 or q=2, which are the two ids
module.fieldsWithoutIDs = {};
for q = 3, #module.fields do
	module.fieldsWithoutIDs[q-2] = module.fields[q];
end

return module;