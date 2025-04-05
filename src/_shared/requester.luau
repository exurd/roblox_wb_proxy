-- shared/requester --
local HttpService = game:GetService("HttpService")


local FastFlags = {
	SAVE_FIRST = false :: boolean,					-- save urls first instead of finding cached version on wbm
	USE_TIMESTAMP = "nil" :: string,				-- use this timestamp instead of using now as timestamp
	INCLUDE_HOUR_IN_TIMESTAMP = true :: boolean		-- put the current hour in now timestamp
}


local dateTime_Now
local function _GetNowAsTimestamp()
	dateTime_Now = DateTime.now()
	local localTime = dateTime_Now:ToLocalTime()

	local year = localTime.Year
	local month = string.format("%02d", localTime.Month)
	local day = string.format("%02d", localTime.Day)
	local hour = ""
	if FastFlags.INCLUDE_HOUR_IN_TIMESTAMP then
		hour = string.format("%02d", localTime.Hour)
	end

	return tostring(year .. month .. day .. hour)
end


local timestamp_check = 1 * 60 * 60  -- 3600 (1 hour)
local function _IsArchiveRecent(dateTime_ToCheck: DateTime)
	local diffInSeconds = math.abs(dateTime_Now.UnixTimestamp - dateTime_ToCheck.UnixTimestamp)
	if diffInSeconds <= timestamp_check then
		return true
	end
	return false
end


local function _ConvertToDateTime(timestamp:string)
	local year = tonumber(timestamp:sub(1, 4))
	local month = tonumber(timestamp:sub(5, 6))
	local day = tonumber(timestamp:sub(7, 8))
	local hour = tonumber(timestamp:sub(9, 10))
	local minute = 0
	local second = 0

	if #timestamp > 10 then
		minute = tonumber(timestamp:sub(11, 12))
		second = tonumber(timestamp:sub(13, 14))
	end

	local isoString = string.format("%04d-%02d-%02dT%02d:%02d:%02dZ", year, month, day, hour, minute, second)
	return DateTime.fromIsoDate(isoString)
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


local m = {}


function m:SetFastFlag(FastFlag: string, value: any)
	if FastFlags[FastFlag] ~= nil then
		FastFlags[FastFlag] = value
	else
		warn("Invalid FastFlag: " .. tostring(FastFlag))
	end
end


function m:GetRequest(url: string, headers: table)
	print("Requesting", url .. "...")
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


function m:CheckUrlInWB(url: string)
	local timestamp
	if FastFlags.USE_TIMESTAMP ~= "nil" then
		timestamp = tostring(FastFlags.USE_TIMESTAMP)
	else
		timestamp = _GetNowAsTimestamp()
	end

	local url_encoded = HttpService:UrlEncode(tostring(url))
	url = string.format("https://archive.org/wayback/available?url=%s&timestamp=%s", tostring(url_encoded), tostring(timestamp))

	local res = self:GetRequest(url)
	if res ~= nil then
		if res.StatusCode == 200 then
			local info = HttpService:JSONDecode(res["Body"])
			return info
		end
	end
	warn("Failed to get info for " .. tostring(url))
	return nil
end


function m:GetRequestWB(url: string)
	print("Requesting", url, "in WBM...")
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

	-- check zero
	local wb_availability_info = self:CheckUrlInWB(url)
	if wb_availability_info ~= nil then
		local archived_snapshots = wb_availability_info["archived_snapshots"]
		if archived_snapshots and archived_snapshots["closest"] then
			local timestamp = archived_snapshots["closest"]["timestamp"]
			if timestamp then
				local dateTime_Archived = _ConvertToDateTime(timestamp)
				if _IsArchiveRecent(dateTime_Archived) then
					wb_url = "https://web.archive.org/web/" .. tostring(timestamp) .. "id_/" .. url
					success, res = _request_wb(wb_url)
					if success and res then
						if res.StatusCode == 200 then
							return res
						end
					end
				end
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
