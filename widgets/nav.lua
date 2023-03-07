local Widget = require("lapis.html").Widget

local nav, nav_mt = Widget:extend("nav")

local links = {
	{"Dashboard", "dashboard"},
	{"Service Calculator", "serviceCalc"}
}

function nav_mt:content()
	div({class = "navigation"}, function() 
		div({class = "nav-inner"}, function() 
			ul({class = "nav-list"}, function()
				for q = 1, #links do
					li(function() 
						a({href=self:url_for(links[q][2])}, links[q][1]);
					end)
				end
			end)
		end)
	end)
end

return nav