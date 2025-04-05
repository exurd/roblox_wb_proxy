-- BoR_Valuable_Badge_Database/init --

local bases = require("./_shared/bases")


local m = {}


function m:BoR_MultiQueryBadges(badge_ids: {string|number})
	table.sort(badge_ids)
	return bases:_GetInfoBase(
		string.format("https://bor-valuable-badge-database-production.up.railway.app/api/v3/query/bybadgeids?badgeIds=%s", tostring(table.concat(badge_ids, ",")))
	)
end
function m:BoR_QueryBadge(badge_id: string|number)  -- alias of BoR_MultiQueryBadges
	return self:BoR_MultiQueryBadges({badge_id})
end

function m:BoR_MultiQueryUniverses(universe_ids: {string|number})
	table.sort(universe_ids)
	return bases:_GetInfoBase(
		string.format("https://bor-valuable-badge-database-production.up.railway.app/api/v3/query/byuniverseids?universeIds=%s", tostring(table.concat(universe_ids, ",")))
	)
end
function m:BoR_QueryUniverse(universe_id: string|number)  -- alias of BoR_MultiQueryUniverses
	return self:BoR_MultiQueryUniverses({universe_id})
end

function m:BoR_MultiReportMissingBadgesInDatabase(badge_ids: {string|number})
	table.sort(badge_ids)
	return bases:_GetInfoBase(
		string.format("https://bor-valuable-badge-database-production.up.railway.app/api/v3/user/reportmissing?badgeIds=%s", tostring(table.concat(badge_ids, ",")))
	)
end
function m:BoR_ReportMissingBadgeInDatabase(badge_id: string|number)  -- alias of BoR_MultiReportMissingBadgesInDatabase
	return self:BoR_MultiReportMissingBadgesInDatabase({badge_id})
end

function m:BoR_RequestUniverseCheck(universe_id: string|number)
	return bases:_GetInfoBase(
		string.format("https://bor-valuable-badge-database-production.up.railway.app/api/v3/user/requestcheck?universeId=%s", tostring(universe_id))
	)
end


return m

-- (c) 2025 exurd
-- This code is licensed under the MIT License.
