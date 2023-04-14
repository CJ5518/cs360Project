local Widget = require("lapis.html").Widget
local Vendors = require("models.Vendors");
local accounts = require("helpers.accounts");

local editVendorInfoForm, editVendorInfoForm_mt = Widget:extend("editVendorInfoForm")

function editVendorInfoForm_mt:content()
	local user = accounts.isLoggedIn(self);
	local function doForm()
		local function inputTextEasy(id, lab, required, placeholder, type, readonly)
			type = type or "text"
			div({class = "mb-3"}, function()
				label({["for"] = id, class=""}, lab);
				input(
					{["type"] = type, id = id, name=id, ["required"]=required,
					class = "form-control", ["value"]=placeholder, ["readonly"] = readonly}
				);
			end)
		end
		form({action = "/updateVendorInfoAction", method = "post"}, function()
			--TODO
			--inputTextEasy("Password", "Password (Not implemented yet sorry)", false, "", "password", self.editPassword);
			inputTextEasy("CompanyName", "Company Name", true, user.CompanyName);
			inputTextEasy("PhoneNumber", "Phone Number", false, user.PhoneNumber);
		
			button({type="submit", class="btn btn-primary"}, "Submit");
		end)
	end
	if self.onlyForm then
		doForm();
	else
		h2("Edit User Info For: " .. user.FirstName);
		doForm();
	end
end



return editVendorInfoForm;

