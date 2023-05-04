local lapis = require("lapis");
local app = lapis.Application();

local db = require("lapis.db");
local email = require("helpers.email");
local Users = require("models.Users");
local Services = require("models.Services");
local accounts = require("helpers.accounts");

--------------------------------------------------
-- Routes that kind of go to pages but have some other stuff going on --
--------------------------------------------------

app:before_filter(function(self)
	self.account = accounts.isLoggedIn(self);
end)

app:get("editUserInfo", "/editUserInfo", function(self)
	return self:html(function()
		local editUserInfoFormWidget = require("widgets.editUserInfoForm");
		widget(editUserInfoFormWidget({
			onlyForm = false,
			editPassword = true,
			session = self.session
		}));
	end)
end)

app:get("editVendorInfo", "/editVendorInfo", function(self)
	return self:html(function()
		local editVendorInfoFormWidget = require("widgets.editVendorInfoForm");
		widget(editVendorInfoFormWidget({
			onlyForm = false,
			editPassword = true,
			session = self.session
		}));
	end)
end)

--------------------------------------------------
-- Routes that go to pages --
--------------------------------------------------

--Index page
app:get("index", "/", function(self)
	if accounts.isLoggedIn(self) then
		return {redirect_to = "dashboard"};
	end
	return {render = "index"};
end)

app:match("index2", "/index", function(self)
	return {redirect_to = "/"};
end)

--Dashboard
app:get("dashboard", "/dashboard", function(self)
	if not accounts.isLoggedIn(self) then
		return {redirect_to = "/"};
	end
	return {render = "dashboard"};
end)

--Service page
app:match("/service/:service_id", function(self)
	self.service_id = self.params.service_id;
	return {render = "servicePage"}
end)

--Request service page
app:match("/request/:service_id", function(self)
	self.service_id = self.params.service_id;
	return {render = "requestPage"}
end)

--Order page
app:match("/order/:order_id", function(self)
	self.order_id = self.params.order_id;
	return {render = "orderSingularPage"}
end)

--Vendor page
app:match("/vendor/:vendor_id", function(self)
	self.vendor_id = self.params.vendor_id;
	return {render = "vendorPage"}
end)


--Things on the navbar

app:get("serviceCalc", "/serviceCalc", function(self)
	if self.account then
		return {render = "serviceCalc"};
	else
		return self:html(function()
			widget(require("widgets.nav")({route_name = self.route_name}))
			h1(function()
				text("Please ")
				a({href = "/login"}, "log in")
				text(" or ")
				a({href = "/signup"}, "sign up")
				text(" to use the service calculator")
			end)
		end)
	end
end)
app:get("ordersPage", "/ordersPage", function(self)
	if self.account then
		return {render = "ordersPage"};
	else
		return self:html(function()
			widget(require("widgets.nav")({route_name = self.route_name}))
			h1(function()
				text("Please ")
				a({href = "/login"}, "log in")
				text(" or ")
				a({href = "/signup"}, "sign up")
				text(" to access orders")
			end)
		end)
	end
end)
app:get("affordCalc", "/affordCalc", function(self)
	if self.account then
		return {render = "affordCalc"};
	else
		return self:html(function()
			widget(require("widgets.nav")({route_name = self.route_name}))
			h1(function()
				text("Please ")
				a({href = "/login"}, "log in")
				text(" or ")
				a({href = "/signup"}, "sign up")
				text(" to use the affordability calculator")
			end)
		end)
	end
end)
app:get("serviceSearch", "/serviceSearch", function(self)
	if self.account then
		return {render = "serviceSearch"};
	else
		return self:html(function()
			widget(require("widgets.nav")({route_name = self.route_name}))
			h1(function()
				text("Please ")
				a({href = "/login"}, "log in")
				text(" or ")
				a({href = "/signup"}, "sign up")
				text(" to use the service search")
			end)
		end)
	end
end)

--Other
app:get("editHomeInfo", "/editHomeInfo", function(self)
	return {render = "editHomeInfo"};
end)


app:get("delet", "/delet", function(self)
	math.randomseed(os.time())
	for q = 1, 100 do
		local dataField = math.random(1,100) * 1000;
		if math.random() < 0.3 then
			dataField = "unlimited"
		end

		Services:create({
			ServiceOwner = 5,
			Name = "Robo internet 1_" .. tostring(q),
			Description = "This is a description for Robo internet 1_" .. tostring(q),
			PricePerUnit = math.random(20, 50),
			PriceUnitID = 1,
			ServiceTypeID = 1,
			Field1 = math.random(1,100) * 100,
			Field2 = dataField
		})
	end

	return {
		json = {
			"hello"
		}
	}
end)

--A catch-all, probably not good for prod but easy for adding lots of new pages
app:match("/*", function(self)
	return {render = self.params.splat};
end)

return app;
