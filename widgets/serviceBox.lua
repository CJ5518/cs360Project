local Widget = require("lapis.html").Widget

local Services = require("models.Services");
local servicesHelper = require("helpers.services");
local servBox, servBox_mt = Widget:extend("servBox")


function servBox_mt:content()
	div({class = "service-box"}, function()
		ul({class = "service-box-list"}, function ()
			if not self.ServiceID then
				text("serviceBox.lua: no ServiceID passed to serviceBox");
			else
				local service = Services:find(self.ServiceID);
				text(service.Address);
				--button({class = "service-box-button", onclick="homeBoxDeleteButtonFunc(" .. tostring(self.HomeID) .. ")"}, "Delete home");
				--button({class = "service-box-button", onclick="homeBoxEditButtonFunc(" .. tostring(self.HomeID) .. ")"}, "Edit home");
				li(function() 
					span({class = "service-box-title service-box-item", onclick="location.href='service/" .. tostring(self.ServiceID) .. "'"}, service.Name)
				end)
				local function field(str)
					li(function ()
						span({class = "service-box-item", onclick="location.href='service/" .. tostring(self.ServiceID) .. "'"}, str);
					end)
				end
				for q = 1, #servicesHelper.typeFields[servicesHelper.types[service.ServiceTypeID]] do
					local elem = servicesHelper.typeFields[servicesHelper.types[service.ServiceTypeID]][q];
					field(elem[1] .. ": " .. service["Field" .. tostring(q)]);
				end
				if self.account.VendorID == service.ServiceOwner then
					field(function() 
						button({class = "service-box-button", onclick="serviceBoxDeleteButtonFunc(" .. tostring(self.ServiceID) .. ")"}, "Delete service");
						button({class = "service-box-button", onclick="serviceBoxEditButtonFunc(" .. tostring(self.ServiceID) .. ")"}, "Edit service");
					end)
				end
			end
		end)
	end)
end

return servBox