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


--to-do: wenn nicht exalted, getfactionparagoninfo gibt nil, muss also in getfactiondatabyid oder so checken 
--außerdem stimmt glaub mit dem timing was nicht wenn das abgerufen wird

for i,factionID in ipairs(factionIDs) do
    local currentValue, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon       = C_Reputation.GetFactionParagonInfo(factionID)
    factionData = C_Reputation.GetFactionDataByID(factionID)
    if factionData ~= nil then 
        print(factionData.name,": ",currentValue, threshold, hasRewardPending)
    end
    
end

--if horde ...

--if not exalted
-- continue
--if <8000 paragon reputation and not hasRewardPending
--  continue

--if <8000 paragon reputation and hasRewardPending
--  print factionname: paragon ready

--if >8000 paragon reputation and not hasRewardPending
--  print factionname: >8000/10000 rep warning

--if >8000 paragon reputation and hasRewardPending
--  print factionname: paragon ready and >8000/10000

-- https://warcraft.wiki.gg/wiki/World_of_Warcraft_API#ReputationInfo
-- https://warcraft.wiki.gg/wiki/API_C_Reputation.GetFactionDataByID

