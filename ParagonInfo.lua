local factionData = nil
local factionIDs = {}
local factionGroupTag, localized = UnitFactionGroup("player")
local playerFaction = factionGroupTag

if playerFaction == "Horde" then
    factionIDs = {2170, 2045, 2165, 1900, 1883, 1828, 1859, 1894, 1948,                                                 --legion
                        2164, 2415, 2391, 2156, 2157, 2373, 2163, 2417, 2158, 2103,                                     --bfa
                        2413, 2470, 2472, 2407, 2478, 2410, 2465, 2432,                                                 --shadowlands
                        2507, 2574, 2511, 2564, 2503, 2510,                                                             --dragonflight
                        2673, 2675, 2590, 2669, 2688, 2685, 2570, 2677, 2594, 2653, 2605, 2658, 2600, 2607, 2601, 2671  --tww
                       }
elseif playerFaction == "Alliance" then
    factionIDs = {2170, 2045, 2165, 1900, 1883, 1828, 1859, 1894, 1948,                                                 --legion
                        2159, 2164, 2161, 2160, 2415, 2391, 2162, 2163, 2417, 2400,                                     --bfa
                        2413, 2470, 2472, 2407, 2478, 2410, 2465, 2432,                                                 --shadowlands
                        2507, 2574, 2511, 2564, 2503, 2510,                                                             --dragonflight
                        2673, 2675, 2590, 2669, 2688, 2685, 2570, 2677, 2594, 2653, 2605, 2658, 2600, 2607, 2601, 2671  --tww
                       }
else
    factionIDs = {2170, 2045, 2165, 1900, 1883, 1828, 1859, 1894, 1948,                                                 --legion
                        2159, 2164, 2161, 2160, 2415, 2391, 2156, 2157, 2373, 2162, 2163, 2417, 2400, 2158, 2103,       --bfa
                        2413, 2470, 2472, 2407, 2478, 2410, 2465, 2432,                                                 --shadowlands
                        2507, 2574, 2511, 2564, 2503, 2510,                                                             --dragonflight
                        2673, 2675, 2590, 2669, 2688, 2685, 2570, 2677, 2594, 2653, 2605, 2658, 2600, 2607, 2601, 2671  --tww
                       }
end

--dialoguebox

local function popupDialogue(message)

    StaticPopupDialogs["PARAGONBOX_INFO"] = {
        text = message,
        button1 = "OK",
        button2 = nil,
        OnAccept = nil,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show ("PARAGONBOX_INFO")

end



--todo: viele fraktionen brauchen nicht 10k für paragon und viele fraktionen brauchen nicht genau 42000 um exalted zu sein
--absicherungsblock fixen
--messages stattdessen in einem kleinen pop up erscheinen lassen


for i,factionID in ipairs(factionIDs) do
    repeat
	--Queries the server to pre-load Paragon reward data.
	C_Reputation.RequestFactionParagonPreloadRewardData(factionID)

    local currentValue, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon       = C_Reputation.GetFactionParagonInfo(factionID)
    factionData 																				= C_Reputation.GetFactionDataByID(factionID)

	--if failed, continue
	if factionID == "" or factionData == nil then
		print("faction: " .. factionID .. " ERROR: couldnt get rep info")
		break
	end

	--if not exalted, continue
--[[ 	if tooLowLevelForParagon or 
       (factionData.currentStanding == nil) or 
       not (factionData.currentStanding >= 42000) or 
       (C_Reputation.GetFactionParagonInfo(factionID) == nil) then
        print("debug:" .. factionData.currentStanding .." paragoninfo: " ..  C_Reputation.GetFactionParagonInfo(factionID))
		print("faction: " .. factionID .. " ERROR: not exalted/too low level/not met yet")
		break
	end ]]

	--find reputation paragon standing
	local currentParagonRep	= currentValue%10000

	--if paragon ready
	if hasRewardPending then
		popupDialogue("\124cffFF0000" .. factionData.name .. ": PARAGON READY (" .. currentParagonRep .. "/10000)\124r")
		break
	end

	--if paragon ready soon
	if currentParagonRep >= 9000 then
		popupDialogue("\124cffFFFF00" .. factionData.name .. ": PARAGON SOON READY (" .. currentParagonRep .. "/10000)\124r")
	end

    until true
end
