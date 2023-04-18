local Widget = require("lapis.html").Widget

local logoutButton, logoutButton_mt = Widget:extend("logoutButton")


function logoutButton_mt:content()
	button({id = "logoutButton"}, "Log out");
	raw('<script src="/static/js/logoutButtonScript.js"></script>');
end

return logoutButton