local Widget = require("lapis.html").Widget

local servBox, servBox_mt = Widget:extend("servBox")

--In the future, we'd want this to only take in the service Id and then do some sort of database query

local items = {
	{"Type: ", "serviceType"},
	{"Price: ", "servicePrice"},
	{"Description: ", "serviceDescription"}
}

function servBox_mt:content()
	div({class = "service-box", onclick="location.href='service/" .. (math.floor(math.random() * 1000) .. "'")}, function()
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