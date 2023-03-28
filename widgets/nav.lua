local Widget = require("lapis.html").Widget

local nav, nav_mt = Widget:extend("nav")

local links = {
	{"Home", "index"},
	{"Service Calculator", "serviceCalc"},
	{"Affordability Calculator", "affordCalc"},
	{"Service Search", "serviceSearch"},
	{"Edit Home Info", "editHomeInfo"}
}

--Dunno man don't ask
local modeIsDev = true;



function nav_mt:content()
	if self.user then
		table.insert(links, 2, {"Dashboard", "dashboard"});
	end
	raw("<script>console.log(window.location.href);</script>")
	div({class = "navigation"}, function() 
		div({class = "nav-inner"}, function() 
			ul({class = "nav-list"}, function()
				for q = 1, #links do
					li(function()
						if modeIsDev then
							a({href="/" .. (links[q][2]), class = (self.route_name:find(links[q][2]) and 'active' or '')}, links[q][1]);
						else
							text("Hey what's up this shouldn't be nav.lua");
						end
					end)
				end
			end)
		end)
	end)
end

return nav