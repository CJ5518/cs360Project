local lapis = require("lapis");
local app = lapis.Application();

local db = require("lapis.db");
local email = require("helpers.email");
local Users = require("models.Users");
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


app:get("serviceCalc", "/serviceCalc", function(self)
	return {render = "serviceCalc"};
end)
app:get("affordCalc", "/affordCalc", function(self)
	return {render = "affordCalc"};
end)
app:get("serviceSearch", "/serviceSearch", function(self)
	return {render = "serviceSearch"};
end)
app:get("editHomeInfo", "/editHomeInfo", function(self)
	return {render = "editHomeInfo"};
end)

--A catch-all, probably not good for prod but easy for adding lots of new pages
app:match("/*", function(self)
	return {render = self.params.splat};
end)

return app;
