local Widget = require("lapis.html").Widget

local Dashboard, Dashboard_mt = Widget:extend("Index")
local Users = require("models.Users");

--<button>Edit Profile Information</button>
--<button onclick="location.href='/logout'">logout</button>

function Dashboard_mt:content()
	local user = Users:find(self.session.userID)
	--TODO, this is just used as the way to check if the user has set up their profile
	if not user.FirstName then
		local function rowAndCol(func)
			div({class = "row"}, function()
				div({class = "col"}, function()
					func();
				end)
			end)
		end
		div({class = "container"}, function()
			form({action = "/updateUserInfo", method = "post"}, function() 
				local function inputTextEasy(id, lab, required, placeholder, type)
					type = type or "text"
					div({class = "mb-3"}, function()
						label({["for"] = id, class=""}, lab);
						input(
							{["type"] = type, id = id, name=id, ["required"]=required, class = "form-control", ["placeholder"]=placeholder}
						);
					end)
				end
				rowAndCol(function() h3({class = "mb-3"},"Hello new user, let's get you set up"); end)
				inputTextEasy("FirstName", "First Name", true, "John");
				inputTextEasy("LastName", "Last Name", true, "Smith");
				inputTextEasy("PhoneNumber", "Phone Number", false, "555-3226");
				inputTextEasy("AnnualIncome", "Annual Income", true, "32000", "number");

				button({type="submit", class="btn btn-primary"}, "Submit");
			end)
		end)
		

	else --This is NOT the user's first time here
		h1("Hello " .. user.FirstName);
		div({class = "body"}, function()
			text "Welcome to my site!"
		end)
	end
end

return Dashboard