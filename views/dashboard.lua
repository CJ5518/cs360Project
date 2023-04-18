local Widget = require("lapis.html").Widget

local Dashboard, Dashboard_mt = Widget:extend("Dashboard")
local Homes = require("models.Homes");
local accounts = require("helpers.accounts");
local util = require("lapis.util")

--<button>Edit Profile Information</button>
--<button onclick="location.href='/logout'">logout</button>

--This one is called for both vendors and users so needs to swap between the two
function Dashboard_mt:content()
	render("widgets.nav");
	local user = accounts.isLoggedIn(self);
	local userType = accounts.getAccountType(self);
	--TODO, this is just used as the way to check if the user has set up their profile
	--Fair enough if you ask me, lowest of priorities
	if (userType == "User" and not user.FirstName) or (userType == "Vendor" and not user.CompanyName) then
		local function rowAndCol(func)
			div({class = "row"}, function()
				div({class = "col"}, function()
					func();
				end)
			end)
		end
		local function formatAccount(str)
			return str:format(accounts.getAccountType(self));
		end
		div({class = "container"}, function()
			rowAndCol(function() h3({class = "mb-3"},formatAccount("Hello new %s, let's get you set up")); end)
			form({action = formatAccount("/update%sInfoAction"), method = "post"}, function() 
				--Very dumb, but it switches between user and vendor setup forms
				local editAccountInfoFormWidget = require(formatAccount("widgets.edit%sInfoForm"));
				widget(editAccountInfoFormWidget({
					onlyForm = true,
					editPassword = false
				}));
			end)
		end)
		

	else --This is NOT the account's first time here
		--i.e the normal dasboard

		local name = userType == "User" and user.FirstName or user.CompanyName;

		h1("Hello " .. name);
		div({class = "body"}, function()
			text "Welcome to my site!"
		end)
		raw('<script src="/static/js/homeBoxScript.js"></script>');
		widget(require("widgets.logoutButton"));

		--How many comparisons have we already done on this variable?
		--No matter, different dashboards for each
		if userType == "User" then --USER
			--Add the create new home button
			raw([[<br><button onclick="window.location.href = '/editHomeInfo';">Create New Home</button><br>]]);
			local homes = Homes:select("WHERE HomeOwner = ?", user.UserID, {fields = "HomeID"});
			h3("My homes");
			div({class = "homes-display horizontal-list"}, function()
				for i, v in pairs(homes) do
					li(function() widget(require("widgets.homeBox")({HomeID = v.HomeID})) end)
				end
			end)
		else
			--VENDOR dashboard
			--TODO
			raw([[<br><button onclick="window.location.href = '/editServiceInfo';">Create New Service</button><br>]]);
		end
	end
end

return Dashboard