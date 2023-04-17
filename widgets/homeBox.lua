local Widget = require("lapis.html").Widget
local Homes = require("models.Homes");


local homeBox, homeBox_mt = Widget:extend("homeBox")

function homeBox_mt:content()
	div({class = "home-box"}, function()
		if not self.HomeID then
			text("homeBox.lua: no HomeID passed to homeBox");
		else
			local home = Homes:find(self.HomeID);
			text(home.Address);
			button({class = "home-box-button", onclick="homeBoxDeleteButtonFunc(" .. tostring(self.HomeID) .. ")"}, "Delete home");
			button({class = "home-box-button", onclick="homeBoxEditButtonFunc(" .. tostring(self.HomeID) .. ")"}, "Edit home");
		end
	end)
end

return homeBox