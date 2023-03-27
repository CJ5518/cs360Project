local randomString = {};

math.randomseed(os.time())
math.random(); --old wives tale

function randomString.getRandomString(length)
	if length <= 1 then
		error("Bad arg #1 to randomString.getRandomString: " .. tostring(length));
	end
	local str = "";
	for q = 1, length do
		str = str .. string.char(math.random(65, 65+25) + (32 * math.random(0,1)));
	end
	return str;
end



return randomString;