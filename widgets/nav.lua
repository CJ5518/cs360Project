local Widget = require("lapis.html").Widget

local nav, nav_mt = Widget:extend("nav")

local links = {
	{"Home", "index"},
	{"Service Calculator", "serviceCalc"},
	{"Affordability Calculator", "affordCalc"},
	{"Service Search", "serviceSearch"},
	{"Edit Home Info", "editHomeInfo"}
}
function nav_mt:content()
	if self.account then
		table.insert(links, 2, {"Dashboard", "dashboard"});
	end
	
	div({class = "navigation"}, function() 
		div({class = "nav-inner"}, function() 
			ul({class = "nav-list"}, function()
				for q = 1, #links do
					li(function()
						--Unreadable hunk of junk don't worry about it
						--Sets class to active if this 
						local classMaybe = self.route_name and (self.route_name:find(links[q][2]) and 'active' or '') or '';
						a({href="/" .. (links[q][2]), class = classMaybe}, links[q][1]);
					end)
				end
			end)
		end)
	end)
end

return nav