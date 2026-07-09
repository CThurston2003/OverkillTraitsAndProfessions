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
OTAPBaseGameCharacterDetails.Nyctophobia = function()

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
Events.EveryOneMinute.Add(OTAPBaseGameCharacterDetails.Nyctophobia);

------------ Astraphobia ------------
OTAPBaseGameCharacterDetails.Astraphobia = function(x,y,strike,lightning,rumble)
    local player = getPlayer();

    if not player then
        return;
    end

    if(player:hasTrait(OTAP.CharacterTrait.Astraphobia)) then
        local xProx = math.abs(x - player:getX());
        local yProx = math.abs(y - player:getY());

        local lightningLevels = {
        [1] = function (x)
            player:getStats():add(CharacterStat.PANIC, 50);
            syncPlayerStats(player, 0x00000100);
            print("Thunder Event 111111!");
        end,
        [2] = function (x)
            player:getStats():add(CharacterStat.PANIC, 33);
            syncPlayerStats(player, 0x00000100);
            print("Thunder Event 2222222!");
        end,
        [3] = function (x)
            player:getStats():add(CharacterStat.PANIC, 15);
            syncPlayerStats(player, 0x00000100);
            print("Thunder Event 33333333!");
        end
        }

        if((xProx <= 1000 and yProx <= 1000) and (lightning == true and rumble == true)) 
            then lightningLevels[1]();
        elseif((xProx <= 3000 and yProx <= 1500) and (lightning == true and rumble == true))
            then lightningLevels[2]();
        elseif((xProx <= 6000 and yProx <= 3000) and (lightning == true and rumble == true))
            then lightningLevels[3]();
        end
    end
end

Events.OnThunderEvent.Add(OTAPBaseGameCharacterDetails.Astraphobia);

------------ Nyctophilia ------------
OTAPBaseGameCharacterDetails.Nyctophilia = function()

    local player = getPlayer();
    local square = player:getSquare();
    local lightLevel = forageSystem.getLightLevelPenalty(player, square, true);

    if not player then return; end;
    -- print("Light Level: " .. tostring(lightLevel));

    if player:hasTrait(OTAP.CharacterTrait.Nyctophilia) then
        -- Lookup tables for the different happiness levels
        local happinessLevels = {
            [1] = function (x) 
                player:getStats():remove(CharacterStat.UNHAPPINESS, 8);
                player:getStats():remove(CharacterStat.PANIC, 4);
                syncPlayerStats(player, 0x00000100);
            end,
            [2] = function (x) 
                player:getStats():remove(CharacterStat.UNHAPPINESS, 12);
                player:getStats():remove(CharacterStat.PANIC, 6);
                syncPlayerStats(player, 0x00000100);
            end,
            [3] = function (x) 
                player:getStats():remove(CharacterStat.UNHAPPINESS, 18);
                player:getStats():remove(CharacterStat.PANIC, 9);
                syncPlayerStats(player, 0x00000100);
            end,
        }
        -- Acting on lookup table
        if (lightLevel < 0.5 and lightLevel >= 0.3) 
            then happinessLevels[1]();
        elseif (lightLevel < 0.3 and lightLevel >= 0.2) 
            then happinessLevels[2]();
        elseif (lightLevel < 0.2 and lightLevel >= 0) 
            then happinessLevels[3](); 
        end
    end
    
end
Events.EveryOneMinute.Add(OTAPBaseGameCharacterDetails.Nyctophilia);