-- shared/requester --
local HttpService = game:GetService("HttpService")


local FastFlags = {
	SAVE_FIRST = true :: boolean,  -- save urls first instead of finding cached version on wbm
}

local m = {}


function m:SetFastFlag(FastFlag: string, value: any)
	if FastFlags[FastFlag] ~= nil then
		FastFlags[FastFlag] = value
	else
		warn("Invalid FastFlag: " .. tostring(FastFlag))
	end
end


function m:GetRequest(url: string, headers: table)
	local success, res = pcall(HttpService.RequestAsync, HttpService, {
		Url = url,
		Method = "GET",
		headers = headers
	})

	if (success and res) then
		return res
	end
	return nil
end


local function _request_wb(a: string)
	return pcall(HttpService.RequestAsync, HttpService, {
		Url = a,
		Method = "GET",
		Headers = {
			["x-pywb-requested-with"] = "XMLHttpRequest"
		}
	})
end


function m:GetRequestWB(url: string)
	local wb_url
	local success, res
	if FastFlags.SAVE_FIRST then
		wb_url = "https://web.archive.org/save/_embed/" .. url
		success, res = _request_wb(wb_url)
		if (success and res) then
			if res.StatusCode == 200 then
				return res
			end
		end
	end

	-- check one
	wb_url = "https://web.archive.org/web/2id_/" .. url
	success, res = _request_wb(wb_url)
	if (success and res) then
		if res.StatusCode == 200 then
			return res
		end
	end

	-- check two
	if not FastFlags.SAVE_FIRST then
		wb_url = "https://web.archive.org/save/_embed/" .. url
		success, res = _request_wb(wb_url)
		if (success and res) then
			if res.StatusCode == 200 then
				return res
			end
		end
	end

	-- check three
	wb_url = "https://web.archive.org/web/1id_/" .. url
	success, res = _request_wb(wb_url)
	if (success and res) then
		if res.StatusCode == 200 then
			return res
		end
	end

	-- check four
	wb_url = "https://web.archive.org/web/0id_/" .. url
	success, res = _request_wb(wb_url)
	if (success and res) then
		if res.StatusCode == 200 then
			return res
		end
	end

	return nil
end


return m

-- (c) 2025 exurd
-- This code is licensed under the MIT License.
