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
	if self.session.userInfo then
		table.insert(links, 2, {"Dashboard", "dashboard"});
	end
	div({class = "navigation"}, function() 
		div({class = "nav-inner"}, function() 
			ul({class = "nav-list"}, function()
				for q = 1, #links do
					li(function()
						if not modeIsDev then
							if q == 1 then
								a({class='active', href=self:url_for(links[q][2])}, links[q][1]);
							else
								a({href=self:url_for(links[q][2])}, links[q][1]);
							end

						else
							if q == 1 then
								a({class='active', href="/" .. (links[q][2])}, links[q][1]);
							else
								a({href="/" .. (links[q][2])}, links[q][1]);
							end
						end
					end)
				end
			end)
		end)
	end)
end

return nav