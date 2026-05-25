OTAPBaseGameCharacterDetails = {}

-- require "Items/SpawnItems";

OTAPBaseGameCharacterDetails.NewCharacterInit = function(playerNum, character)
    local player = getSpecificPlayer(playerNum); -- playerNum is like a player ID?

    if player:hasTrait(OTAP.CharacterTrait.God) then
        player:getInventory():AddItem("Base.Pistol")
    end

end

Events.OnCreatePlayer.Add(OTAPBaseGameCharacterDetails.NewCharacterInit);

------------ Nyctophobia ------------
OTAPBaseGameCharacterDetails.MaxPanic = function()

    local player = getPlayer();
    local square = player:getSquare();
    local lightLevel = forageSystem.getLightLevelPenalty(player, square, true);

    if not player then return; end;
    -- print("Light Level: " .. tostring(lightLevel));

    if player:hasTrait(OTAP.CharacterTrait.Nyctophobia) then
        -- Lookup tables for the different panic levels
        local panicLevels = {
            [1] = function (x) 
                player:getStats():add(CharacterStat.PANIC, 8)
                syncPlayerStats(player, 0x00000100)
            end,
            [2] = function (x) 
                player:getStats():add(CharacterStat.PANIC, 12)
                syncPlayerStats(player, 0x00000100)
            end,
            [3] = function (x) 
                player:getStats():add(CharacterStat.PANIC, 18)
                syncPlayerStats(player, 0x00000100)
            end,
        }
        -- Acting on lookup table
        if (lightLevel < 0.5 and lightLevel >= 0.3) 
            then panicLevels[1]();
        elseif (lightLevel < 0.3 and lightLevel >= 0.2) 
            then panicLevels[2]();
        elseif (lightLevel < 0.2 and lightLevel >= 0) 
            then panicLevels[3](); 
        end
    end
    
end
Events.EveryOneMinute.Add(OTAPBaseGameCharacterDetails.MaxPanic);