local Widget = require("lapis.html").Widget

local Orders = require("models.Orders");
local orderBox, orderBox_mt = Widget:extend("orderBox")
local accounts = require("helpers.accounts");

--NEEDS OrderID

function orderBox_mt:content()
	div({class = "service-box"}, function()
		ul({class = "service-box-list"}, function ()
			if not self.OrderID then
				text("orderBox.lua: no OrderID passed");
			else
				local order = Orders:find(self.OrderID);
				
				li(function() 
					span({class = "service-box-title service-box-item", 
					onclick="location.href='order/" .. tostring(self.OrderID) .. "'"}, "Order for: " .. order:getService().Name)
				end)
				--noClick must be set on button fields
				local function field(str, noClick)
					li(function ()
						local onclick="location.href='order/" .. tostring(self.OrderID) .. "'";
						if noClick then
							onclick = false;
						end
						span({class = "service-box-item", ["onclick"] = onclick}, str);
					end)
				end
				field("ID: " .. tostring(self.OrderID))
				field("From: " .. order:getVendor().CompanyName);
				field("To: " .. order:getUser().Email);
				local canSee = false;
				if self.account then
					if accounts.getAccountType(self) == "User" then
						if order:getUser().UserID == accounts.isLoggedIn(self).UserID then
							canSee = true;
						end
					end
					if accounts.getAccountType(self) == "Vendor" then
						if order:getUser().VendorID == accounts.isLoggedIn(self).VendorID then
							canSee = true;
						end
					end
				end
				if self.account and canSee then
					field("Status: " .. Orders:getStateEnumName(order.OrderStateEnum));
				end
			end
		end)
	end)
end

return orderBox