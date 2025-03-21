-- Apis/init --
local HttpService = game:GetService("HttpService")

local bases = require("./_shared/bases")


local m = {}


-- apis.roblox.com
function m:GetGamepassInfo(gamepass_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://apis.roblox.com/game-passes/v1/game-passes/%s/product-info", tostring(gamepass_id))
	)
end

function m:MultiGetToolboxDetails(asset_ids: {string|number})
	return bases:_GetInfoBase(
		string.format("https://apis.roblox.com/toolbox-service/v1/items/details?assetIds=%s", tostring(table.concat(asset_ids, ",")))
	)
end
function m:GetToolboxDetails(asset_id: string|number)  -- alias of MultiGetToolboxDetails
	return self:MultiGetToolboxDetails({asset_id})
end


-- avatar.roblox.com
function m:GetAvatarRules()
	return bases:_GetInfoBase("https://avatar.roblox.com/v1/avatar-rules")
end

function m:GetAvatarMetadata()
	return bases:_GetInfoBase("https://avatar.roblox.com/v1/avatar/metadata")
end

function m:GetGameStartInfo(universe_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://avatar.roblox.com/v1/game-start-info?universeId=%s", tostring(universe_id))
	)
end

function m:GetUserCurrentlyWearing(user_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://avatar.roblox.com/v1/users/%s/currently-wearing", tostring(user_id))
	)
end

function m:GetUserAvatar(user_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://avatar.roblox.com/v1/users/%s/avatar", tostring(user_id))
	)
end


-- badges.roblox.com
function m:GetBadgeInfo(badge_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://badges.roblox.com/v1/badges/%s", tostring(badge_id))
	)
end

function m:GetUniverseBadges(universe_id: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	return bases:_GetPaginatedBase(
		string.format("https://badges.roblox.com/v1/universes/%s/badges", tostring(universe_id)),
		limit,
		pageCursor,
		sortOrder
	)
end

function m:GetUserOwnedBadges(user_id: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	return bases:_GetPaginatedBase(
		string.format("https://badges.roblox.com/v1/users/%s/badges", tostring(user_id)),
		limit,
		pageCursor,
		sortOrder
	)
end

function m:MultiGetBadgeAwardedDates(user_id: string|number, badge_ids: {string|number})
	return bases:_GetInfoBase(
		string.format("https://badges.roblox.com/v1/users/%s/badges/awarded-dates?badgeIds=%s", tostring(user_id), tostring(table.concat(badge_ids, ",")))
	)
end
function m:GetBadgeAwardedDate(user_id: string|number, badge_id: string|number)  -- alias of MultiGetBadgeAwardedDates
	local req = self:MultiGetBadgeAwardedDates(user_id, {badge_id})
	if req then
		return req
	end
	-- else
	return bases:_GetInfoBase(
		string.format("https://badges.roblox.com/v1/users/%s/badges/%s/awarded-date", tostring(user_id), tostring(badge_id))
	)
end


-- catalog.roblox.com
function m:GetAssetToCategoryList()
	return bases:_GetInfoBase("https://catalog.roblox.com/v1/asset-to-category")
end

function m:GetAssetToSubcategoryList()
	return bases:_GetInfoBase("https://catalog.roblox.com/v1/asset-to-subcategory")
end

function m:GetCatalogCategories()
	return bases:_GetInfoBase("https://catalog.roblox.com/v1/categories")
end

function m:GetCatalogSubcategories()
	return bases:_GetInfoBase("https://catalog.roblox.com/v1/subcategories")
end

function m:GetBundleRecommendations(bundle_id: string|number, num_items: string|number)
	num_items = num_items or 20
	return bases:_GetInfoBase(
		string.format("https://catalog.roblox.com/v1/bundles/%s/recommendations?numItems=%s", tostring(bundle_id), tostring(num_items))
	)
end

function m:GetAssetFavoritesCount(asset_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://catalog.roblox.com/v1/favorites/assets/%s/count", tostring(asset_id))
	)
end

function m:GetBundlesWithAsset(asset_id: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	return bases:_GetPaginatedBase(
		string.format("https://catalog.roblox.com/v1/assets/%s/bundles", tostring(asset_id)),
		limit,
		pageCursor,
		sortOrder
	)
end

function m:GetUserOwnedBundles(user_id: string|number, bundle_type: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or 2
	bundle_type = bundle_type or ""
	if bundle_type ~= "" then
		bundle_type = "/"..tostring(bundle_type)  -- janky but works
	end
	return bases:_GetPaginatedBase(
		string.format("https://catalog.roblox.com/v1/users/%s/bundles%s", tostring(user_id), tostring(bundle_type)),
		limit,
		pageCursor,
		sortOrder
	)
end


function m:MultiGetBundleInfo(bundle_ids: {string|number})
	return bases:_GetInfoBase(
		string.format("https://catalog.roblox.com/v1/bundles/details?bundleIds=%s", tostring(table.concat(bundle_ids, ",")))
	)
end
function m:GetBundleInfo(bundle_id: string|number, badge_id: string|number)  -- alias of MultiGetBadgeAwardedDates
	local req = self:MultiGetBundleInfo({bundle_id})
	if req then
		return req
	end
	-- else
	return bases:_GetInfoBase(
		string.format("https://catalog.roblox.com/v1/bundles/%s/details", tostring(bundle_id))
	)
end


-- develop.roblox.com
function m:GetGameTemplates()
	return bases:_GetInfoBase("https://develop.roblox.com/v1/gametemplates")
end

function m:GetUniverseInfo(universe_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://develop.roblox.com/v1/universes/%s", tostring(universe_id))
	)
end

function m:GetUniversePlaces(universe_id: string|number, isUniverseCreation: boolean, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	isUniverseCreation = isUniverseCreation or false
	return bases:_GetPaginatedBase(
		string.format("https://develop.roblox.com/v1/universes/%s/places", tostring(universe_id)),
		limit,
		pageCursor,
		sortOrder,
		string.format("?isUniverseCreation=%s", tostring(isUniverseCreation))
	)
end

function m:MultiGetUniverseInfo(universe_ids: {string|number})
	return bases:_GetInfoBase(
		string.format("https://develop.roblox.com/v1/universes/multiget?ids=%s", tostring(table.concat(universe_ids, ",")))
	)
end

function m:MultiGetPluginInfo(plugin_ids: {string|number})
	return bases:_GetInfoBase(
		string.format("https://develop.roblox.com/v1/plugins?pluginIds=%s", tostring(table.concat(plugin_ids, ",")))
	)
end
function m:GetPluginInfo(plugin_id: string|number)  -- alias of MultiGetPluginInfo
	return self:MultiGetPluginInfo({plugin_id})
end


-- economy.roblox.com
function m:GetEconomyAssetDetails(asset_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://economy.roblox.com/v2/assets/%s/details", tostring(asset_id))
	)
end


-- friends.roblox.com
function m:GetFriendsMetadata(target_user_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://friends.roblox.com/v1/metadata?targetUserId=%s", tostring(target_user_id))
	)
end

function  m:GetUserFriends(user_id: string|number, userSort: string|number)
	return bases:_GetInfoBase(
		string.format("https://friends.roblox.com/v1/users/%s/friends?userSort=%s", tostring(user_id), tostring(userSort))
	)
end

function  m:GetUserFriendsCount(user_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://friends.roblox.com/v1/users/%s/friends/count", tostring(user_id))
	)
end

function m:GetUserFollowersCount(user_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://friends.roblox.com/v1/users/%s/followers/count", tostring(user_id))
	)
end

function m:GetUserFollowingCount(user_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://friends.roblox.com/v1/users/%s/followings/count", tostring(user_id))
	)
end

function m:GetUserFriends_Paginated(user_id: string|number, isUniverseCreation: boolean, limit: string|number, pageCursor: string, userSort: string)
	limit = limit or 50
	pageCursor = pageCursor or ""
	userSort = userSort or "2"
	isUniverseCreation = isUniverseCreation or false
	return bases:_GetPaginatedBase(
		string.format("https://friends.roblox.com/v1/users/%s/friends/find", tostring(user_id)),
		limit,
		pageCursor,
		"",
		string.format("?userSort=2", tostring(userSort))
	)
end

function m:GetUserFollowers(user_id: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	return bases:_GetPaginatedBase(
		string.format("https://friends.roblox.com/v1/users/%s/followers", tostring(user_id)),
		limit,
		pageCursor,
		sortOrder
	)
end

function m:GetUserFollowing(user_id: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	return bases:_GetPaginatedBase(
		string.format("https://friends.roblox.com/v1/users/%s/followings", tostring(user_id)),
		limit,
		pageCursor,
		sortOrder
	)
end


-- games.roblox.com
-- TODO:
-- very complicated:
-- /v1/games/recommendations/game/{universeId}  Get games recommendations based on a given universe
	-- https://games.roblox.com/v1/games/recommendations/game/13058?PaginationKey=%20&MaxRows=6&IsTruncatedResultsEnabled=false
	--
	-- Name	Description
	-- universeId * -- integer($int64) -- (path)
	-- The universe to base recommendations on
	-- 13058
	--
	-- PaginationKey * -- string -- (query)
	-- The key of a page, which includes the start row index and all other necessary information to query the data.
	-- This parameter is usually not needed for the first page.
	--
	--
	-- MaxRows * -- integer($int32)
	-- (query) -- The requested number of rows.
	-- 6
	--
	-- IsTruncatedResultsEnabled * -- boolean -- (query)
	-- Truncated Results -- false

function m:GetUniverseMediaData(universe_id: string|number, fetchAllExperienceRelatedMedia: boolean)
	fetchAllExperienceRelatedMedia = fetchAllExperienceRelatedMedia or false
	return bases:_GetInfoBase(
		string.format("https://games.roblox.com/v2/games/%s/media?fetchAllExperienceRelatedMedia=%s", tostring(universe_id), tostring(fetchAllExperienceRelatedMedia))
	)
end

function m:GetUniverseFavoritesCount(universe_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://games.roblox.com/v1/games/%s/favorites/count", tostring(universe_id))
	)
end

function m:GetGroupGames(group_id: string|number, accessFilter: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	accessFilter = accessFilter or 2
	return bases:_GetPaginatedBase(
		string.format("https://games.roblox.com/v2/groups/%s/games", tostring(group_id)),
		limit,
		pageCursor,
		sortOrder,
		string.format("?accessFilter=%s", tostring(accessFilter))
	)
end

function m:GetGroupGames_V2(group_id: string|number, accessFilter: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	accessFilter = accessFilter or 1
	return bases:_GetPaginatedBase(
		string.format("https://games.roblox.com/v2/groups/%s/gamesV2", tostring(group_id)),
		limit,
		pageCursor,
		sortOrder,
		string.format("?accessFilter=%s", tostring(accessFilter))
	)
end

function m:GetUserFavoriteGames(user_id: string|number, accessFilter: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	accessFilter = accessFilter or 2
	return bases:_GetPaginatedBase(
		string.format("https://games.roblox.com/v2/users/%s/favorite/games", tostring(user_id)),
		limit,
		pageCursor,
		sortOrder,
		string.format("?accessFilter=%s", tostring(accessFilter))
	)
end

function m:GetUserGames(user_id: string|number, accessFilter: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	accessFilter = accessFilter or 2
	return bases:_GetPaginatedBase(
		string.format("https://games.roblox.com/v2/users/%s/games", tostring(user_id)),
		limit,
		pageCursor,
		sortOrder,
		string.format("?accessFilter=%s", tostring(accessFilter))
	)
end

function m:GetUniverseGamepasses(universe_id: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or 1
	return bases:_GetPaginatedBase(
		string.format("https://games.roblox.com/v1/games/%s/game-passes", tostring(universe_id)),
		limit,
		pageCursor,
		sortOrder
	)
end

function m:MultiGetGameDetails(universe_ids: {string|number})
	return bases:_GetInfoBase(
		string.format("https://games.roblox.com/v1/games?universeIds=%s", tostring(table.concat(universe_ids, ",")))
	)
end
function m:GetGameDetails(universe_id: string|number)  -- alias of MultiGetGameDetails
	return self:MultiGetGameDetails({universe_id})
end

function m:MultiGetGameProductInfo(universe_ids: {string|number})
	return bases:_GetInfoBase(
		string.format("https://games.roblox.com/v1/games/games-product-info?universeIds=%s", tostring(table.concat(universe_ids, ",")))
	)
end
function m:GetGameProductInfo(universe_id: string|number)  -- alias of MultiGetGameProductInfo
	return self:MultiGetGameProductInfo({universe_id})
end

function m:MultiGetUniverseVotes(universe_ids: {string|number})
	return bases:_GetInfoBase(
		string.format("https://games.roblox.com/v1/games/votes?universeIds=%s", tostring(table.concat(universe_ids, ",")))
	)
end
function m:GetUniverseVotes(universe_id: string|number)  -- alias of MultiGetUniverseVotes
	return self:MultiGetUniverseVotes({universe_id})
end

function m:GetGameServers(place_id: string|number, serverType: string|number, excludeFullGames: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	serverType = serverType or 0
	excludeFullGames = excludeFullGames or false
	return bases:_GetPaginatedBase(
		string.format("https://games.roblox.com/v1/games/%s/servers/%s", tostring(place_id), tostring(serverType)),
		limit,
		pageCursor,
		sortOrder,
		string.format("?excludeFullGames=%s", tostring(excludeFullGames))
	)
end


-- groups.roblox.com
function m:GetGroupInfo(group_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://groups.roblox.com/v1/groups/%s", tostring(group_id))
	)
end

function m:GetGroupRoles(group_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://groups.roblox.com/v1/groups/%s/roles", tostring(group_id))
	)
end

function m:GetGroupNames(group_id: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	return bases:_GetPaginatedBase(
		string.format("https://groups.roblox.com/v1/groups/%s/name-history", tostring(group_id)),
		limit,
		pageCursor,
		sortOrder
	)
end

function m:GetUsersInGroup(group_id: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	return bases:_GetPaginatedBase(
		string.format("https://groups.roblox.com/v1/groups/%s/users", tostring(group_id)),
		limit,
		pageCursor,
		sortOrder
	)
end


-- inventory.roblox.com
-- TODO:
-- https://inventory.roblox.com/v1/users/1/items/1/741995504
-- https://inventory.roblox.com/v2/users/1/inventory/24?limit=10&sortOrder=Asc

function m:GetUserCollectableItems(user_id: string|number, assetType: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	assetType = assetType or ""
	local prefix = ""
	if assetType ~= "" then
		prefix = "?assetType=" .. tostring(assetType)
	end
	return bases:_GetPaginatedBase(
		string.format("https://inventory.roblox.com/v1/users/%s/assets/collectibles", tostring(user_id)),
		limit,
		pageCursor,
		sortOrder,
		prefix
	)
end

function m:CanViewUserInventory(user_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://inventory.roblox.com/v1/users/%s/can-view-inventory", tostring(user_id))
	)
end


-- thumbnails.roblox.com
-- TODO: request assets from thumbnails
-- TODO (all very similar):
-- https://thumbnails.roblox.com/v1/assets?assetIds=1818&returnPolicy=PlaceHolder&size=30x30&format=Png&isCircular=false
	-- returnPolicy  Optional policy to use in selecting thumbnail to return (default = PlaceHolder).
	-- PlaceHolder, ForcePlaceHolder, AutoGenerated, ForceAutoGenerated
	-- might need to force saving to avoid using expired 30DAY/180DAY images
		-- unless we save the images for later, but... why?
-- https://thumbnails.roblox.com/v1/badges/icons?badgeIds=2200659640643962,123456&size=150x150&format=Png&isCircular=false
-- https://thumbnails.roblox.com/v1/bundles/thumbnails?bundleIds=320,12345&size=150x150&format=Png&isCircular=false
-- https://thumbnails.roblox.com/v1/developer-products/icons?developerProductIds=1587943486,123456&size=150x150&format=Png&isCircular=false
-- https://thumbnails.roblox.com/v1/game-passes?gamePassIds=1,12345678&size=150x150&format=Png&isCircular=false
-- https://thumbnails.roblox.com/v1/groups/icons?groupIds=1&size=150x150&format=Png&isCircular=false
	-- GetGroupEmblem and GetGroupIcon alias
-- https://thumbnails.roblox.com/v1/games/multiget/thumbnails?universeIds=13058,12345678&countPerUniverse=1&defaults=true&size=768x432&format=Png&isCircular=false
-- https://thumbnails.roblox.com/v1/places/gameicons?placeIds=1818,1919&returnPolicy=PlaceHolder&size=50x50&format=Png&isCircular=false
-- https://thumbnails.roblox.com/v1/games/icons?universeIds=4545315306,123456&returnPolicy=PlaceHolder&size=50x50&format=Png&isCircular=false
	-- what? why are there two game universe thumbnail apis?? (^ is icons, not thumbnail)
-- https://thumbnails.roblox.com/v1/users/avatar?userIds=1,123456&size=30x30&format=Png&isCircular=false
-- https://thumbnails.roblox.com/v1/users/avatar-bust?userIds=1,123456&size=48x48&format=Png&isCircular=false
-- https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=1,123456&size=48x48&format=Png&isCircular=false
-- https://thumbnails.roblox.com/v1/users/outfits?userOutfitIds=123456,1234&size=150x150&format=Png&isCircular=false
--
-- Enum.ThumbnailSize.Size48x48 should i use enums? maybe

function m:GetAnimatedThumbnail(asset_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://thumbnails.roblox.com/v1/asset-thumbnail-animated?assetId=%s", tostring(asset_id))
	)
end

function m:Get3DThumbnail(asset_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://thumbnails.roblox.com/v1/assets-thumbnail-3d?assetId=%s", tostring(asset_id))
	)
end

function m:Get3DAvatar(user_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://thumbnails.roblox.com/v1/users/avatar-3d?userId=%s", tostring(user_id))
	)
end

function m:Get3DOutfit(outfit_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://thumbnails.roblox.com/v1/users/outfit-3d?outfitId=%s", tostring(outfit_id))
	)
end


-- universes
function m:GetUniverseId(place_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://apis.roblox.com/universes/v1/places/%s/universe", tostring(place_id))
	)
end


-- users.roblox.com
function m:GetUserInfo(user_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://users.roblox.com/v1/users/%s", tostring(user_id))
	)
end

function m:GetUsernameHistory(user_id: string|number, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	return bases:_GetPaginatedBase(
		string.format("https://users.roblox.com/v1/users/%s/username-history", tostring(user_id)),
		limit,
		pageCursor,
		sortOrder
	)
end

function m:SearchUserProfiles(query: string, limit: string|number, pageCursor: string, sortOrder: string)
	limit = limit or 10
	pageCursor = pageCursor or ""
	sortOrder = sortOrder or "Asc"
	return bases:_GetPaginatedBase(
		string.format("https://users.roblox.com/v1/users/search", tostring(query)),
		limit,
		pageCursor,
		sortOrder,
		string.format("?keyword=%s", tostring(query))
	)
end


return m

-- (c) 2025 exurd
-- This code is licensed under the MIT License.
