-- Apis/Advanced --
-- for apis that have a very niche usage

local bases = require("../_shared/bases")

local m = {}


-- assetdelivery.roblox.com
function m:GetAsset(user_id: string|number, version: string|number, which_api_version: number)
	version = version or 0  -- latest
	which_api_version = which_api_version or 2
	return bases:_GetInfoBase(
		string.format("https://assetdelivery.roblox.com/v%s/assetId/%s/version/%s", tostring(which_api_version), tostring(user_id), tostring(version))
	)
end

function m:DeliverAsset(user_id) -- alias of GetAsset
	return self:GetAsset(user_id)
end


-- clientsettings.roblox.com
function m:GetClientVersionInfo(binaryType: string, channelName: string)  -- binaryType: WindowsPlayer, WindowsStudio, MacPlayer or MacStudio
    channelName = channelName or ""
    if channelName ~= "" then
        channelName = "/" .. channelName
    end
	return bases:_GetInfoBase(
		string.format("https://clientsettings.roblox.com/v2/client-version/%s%s", tostring(binaryType), tostring(channelName))
	)
end

function m:GetCompressionDictionaries()
	return bases:_GetInfoBase("https://clientsettings.roblox.com/v2/compression-dictionaries")
end

function m:GetChannelName(binaryType: string)  -- binaryType: WindowsPlayer, WindowsStudio, MacPlayer or MacStudio
	return bases:_GetInfoBase(
		string.format("https://clientsettings.roblox.com/v2/user-channel?binaryType=%s", tostring(binaryType))
	)
end

function m:DownloadCompressionDictionaries(dictionarySha256: string)
	return bases:_DownloadBase(
		string.format("https://clientsettings.roblox.com/v2/compression-dictionaries/%s", tostring(dictionarySha256))
	)
end

function m:GetMobileClientVersionInfo(appVersion: string)  -- appVersion: AppiOSV2.13, AppVersioniOS2.0.1, etc
	return bases:_GetInfoBase(
		string.format("https://clientsettings.roblox.com/v1/mobile-client-version?appVersion=%s", tostring(appVersion))
	)
end

function m:GetInstallerCDNs()
	return bases:_GetInfoBase("https://clientsettings.roblox.com/v1/installer-cdns")
end


-- gameinternationalization.roblox.com
-- TODO:
-- https://gameinternationalization.roblox.com/v1/automatic-translation/languages/en/target-languages?targetLanguages=string&targetLanguages=ar&targetLanguages=de&gameId=1818
-- https://gameinternationalization.roblox.com/v1/player-policies/all-values

function m:GetGameSupportedLanguages(gameId: string|number)
	return bases:_GetInfoBase(
		string.format("https://gameinternationalization.roblox.com/v2/supported-languages/games/%s", tostring(gameId))
	)
end


-- inventory.roblox.com
-- TODO:
-- https://inventory.roblox.com/v1/users/*/categories
-- https://inventory.roblox.com/v1/users/*/categories/favorites


-- misc
function m:_GetJSONInfo(url: string)
	return bases:_GetInfoBase(url)
end

return m

-- (c) 2025 exurd
-- This code is licensed under the MIT License.
