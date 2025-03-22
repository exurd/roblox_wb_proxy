# roblox_wb_proxy
A ModuleScript that uses the Internet Archive's [Wayback Machine](https://web.archive.org/) as a Roblox API proxy. No servers are needed to host the proxy and it's easy to add into a Roblox game.

## How it works
The Wayback Machine's "[Save Page Now](https://blog.archive.org/2019/10/23/the-wayback-machines-save-page-now-is-new-and-improved/)" feature allows anyone to anonymously add a URL into their database. This allows others to archive content that can disappear in the future.

Due to how SPN works, cookie / .ROBLOSECURITY support cannot be added to this proxy. Their saving functionality does not accept cookies (this is to keep saved pages as neutral as possible). This means roblox_wb_proxy can only get API responses that do not need authentication.

### Saving rate limit
The rate limit for saving a new snapshot of a URL is around 1 hour (which can vary). I recommend using the default settings, with "SAVE_FIRST" disabled (see below example code for more details).


## Usage
Build the model (.rbxm) with [Argon](https://argon.wiki/), open Roblox Studio and drag and drop the file into a game. Move the imported instance to your game's ModuleScripts location.

You will need to enable "Allow HTTP Requests" in your game settings for it to work correctly.

Once added, you can require the module and use it as such:
```lua
local roblox_wb_proxy = require(game.ServerScriptService.modules.roblox_wb_proxy)


roblox_wb_proxy.RobloxApi:GetUniverseId(1818)
--{ 
--	["universeId"] = 13058
--}


-- Optional, but if you need the most recent response,
-- this FF tells the requester to save into WBM first,
-- and returns the response that was given from saving
roblox_wb_proxy.Requester:SetFastFlag("SAVE_FIRST", true)


roblox_wb_proxy.RobloxApi:SearchUserProfiles("Roblox")
--{
--	["data"] =  {
--		[1] =  {
--			["displayName"] = "Roblox",
--			["hasVerifiedBadge"] = true,
--			["id"] = 1,
--			["name"] = "Roblox",
--			["previousUsernames"] = {}
--		},
--		[2] = {...},
--		[3] = {...},
--		[4] = {...},
--		[5] = {...},
--		[6] = {...},
--		[7] = {...},
--		[8] = {...},
--		[9] = {...},
--		[10] = {...}
--	},
--	["nextPageCursor"] = "eyJzdGFydE...QwMmVkODRhMQ=="
--}
```

# License
roblox_wb_proxy is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
