local ltn12 = require("ltn12")
local http = require("lapis.nginx.http")
local encode_query_string
encode_query_string = require("lapis.util").encode_query_string
local encode_base64
encode_base64 = require("lapis.util.encoding").encode_base64
local concat
concat = table.concat
local key, domain, sender
pcall(function()
  do
    local _obj_0 = require("secret.email")
    key, domain, sender = _obj_0.key, _obj_0.domain, _obj_0.sender
  end
end)
local send_email
if key then
  send_email = function(to, subject, body, opts)
    if opts == nil then
      opts = { }
    end
    local out = { }
    local res = http.request({
      url = "https://api.mailgun.net/v3/" .. tostring(domain) .. "/messages",
      source = ltn12.source.string(encode_query_string({
        to = to,
        from = sender,
        subject = subject,
        [opts.html and "html" or "text"] = body
      })),
      headers = {
        ["Content-type"] = "application/x-www-form-urlencoded",
        ["Authorization"] = "Basic " .. encode_base64(key)
      },
      sink = ltn12.sink.table(out)
    })
    return concat(out), res
  end
else
  send_email = function() end
end
return {
  send_email = send_email
}