-- _shared/bases --
local HttpService = game:GetService("HttpService")

local requester = require("./requester")


local m = {}


function m:_GetInfoBase(url: string)
	local res = requester:GetRequestWB(url)
	if res ~= nil then
		if res.StatusCode == 200 then
			local info = HttpService:JSONDecode(res["Body"])
			return info
		end
	end
	warn("Failed to get info for " .. tostring(url))
	return nil
end


function m:_GetPaginatedBase(url: string, limit: string|number, pageCursor: string, sortOrder: string, prefix: string)
	prefix = prefix or "?"
	if prefix ~= "?" then
		prefix = prefix .. "&"
	end
	limit = limit or ""
	if limit ~= "" then
		limit = "limit=" .. tostring(limit)
	end
	sortOrder = sortOrder or ""
	if sortOrder ~= "" then
		sortOrder = "&sortOrder=" .. tostring(sortOrder)
	end

	local combined_url = url .. prefix .. limit .. sortOrder
	if pageCursor ~= "" then
		combined_url = string.format("%s&cursor=%s", combined_url, pageCursor)  -- &cursor=*
	end
	print(combined_url)
	return self:_GetInfoBase(combined_url)
end


function m:_DownloadBase(url: string)
    local res = requester:GetRequestWB(url)
	if res ~= nil then
		if res.StatusCode == 200 then
			return res
		end
	end
    warn("Failed to get info for " .. tostring(url))
	return nil
end


return m

-- (c) 2025 exurd
-- This code is licensed under the MIT License.
