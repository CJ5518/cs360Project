local Widget = require("lapis.html").Widget
local Users = require("models.Users");
local accounts = require("helpers.accounts");

local editUserInfoForm, editUserInfoForm_mt = Widget:extend("editUserInfoForm")

function editUserInfoForm_mt:content()
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
		form({action = "/updateUserInfoAction", method = "post"}, function()
			--TODO
			inputTextEasy("Password", "Password (Not implemented yet sorry)", false, "", "password", self.editPassword);
			inputTextEasy("FirstName", "First Name", true, user.FirstName);
			inputTextEasy("LastName", "Last Name", true, user.LastName);
			inputTextEasy("PhoneNumber", "Phone Number", false, user.PhoneNumber);
			inputTextEasy("AnnualIncome", "Annual Income", true, user.AnnualIncome, "number");
		
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



return editUserInfoForm;

