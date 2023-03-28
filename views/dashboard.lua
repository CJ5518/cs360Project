local Widget = require("lapis.html").Widget

local Dashboard, Dashboard_mt = Widget:extend("Dashboard")
local Users = require("models.Users");
local accounts = require("helpers.accounts");

--<button>Edit Profile Information</button>
--<button onclick="location.href='/logout'">logout</button>

function Dashboard_mt:content()
	local user = accounts.isLoggedIn(self);
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
			rowAndCol(function() h3({class = "mb-3"},"Hello new user, let's get you set up"); end)
			form({action = "/updateUserInfoAction", method = "post"}, function() 
				local editUserInfoFormWidget = require("widgets.editUserInfoForm");
				widget(editUserInfoFormWidget({
					onlyForm = true,
					editPassword = false
				}));
			end)
		end)
		

	else --This is NOT the user's first time here
		
		h1("Hello " .. user.FirstName);
		div({class = "body"}, function()
			text "Welcome to my site!"
		end)
		button({id = "logoutButton"}, "Log out");
		raw('<script src="/static/js/dashboardLoggedIn.js"></script>');
	end
end

return Dashboard