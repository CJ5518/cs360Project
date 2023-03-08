local Widget = require("lapis.html").Widget

local servBox, servBox_mt = Widget:extend("servBox")

local items = {
	{"", "serviceTitle"},
	{"Type: ", "serviceType"},
	{"Price: ", "servicePrice"},
	{"Description: ", "serviceDescription"}
}

function servBox_mt:content()
	div({class = "service-box"}, function()
		ul({class = "service-box-list"}, function ()
			li()
			span({class = "service-box-title"}, self.title)
			for q = 1, #items do
				
			end
		end)
	end)
end

return servBox