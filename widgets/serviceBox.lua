local Widget = require("lapis.html").Widget

local servBox, servBox_mt = Widget:extend("servBox")

local items = {
	{"Type: ", "serviceType"},
	{"Price: ", "servicePrice"},
	{"Description: ", "serviceDescription"}
}

function servBox_mt:content()
	div({class = "service-box"}, function()
		ul({class = "service-box-list"}, function ()
			li(function() 
				span({class = "service-box-title"}, self.title)
			end)
			for q = 1, #items do
				li(function ()
					span({class = "service-box-item"}, self[items[q][2]]);
				end)
			end
		end)
	end)
end

return servBox