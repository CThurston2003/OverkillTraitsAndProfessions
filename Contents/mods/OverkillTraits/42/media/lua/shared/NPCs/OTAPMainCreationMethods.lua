OTAPBaseGameCharacterDetails = {}

-- require "Items/SpawnItems";

OTAPBaseGameCharacterDetails.NewCharacterInit = function(playerNum, character)
    local player = getSpecificPlayer(playerNum); -- playerNum is like a player ID?

    if player:hasTrait(OTAP.CharacterTrait.God) then
        player:getInventory():AddItem("Base.Pistol")
    end

end

Events.OnCreatePlayer.Add(OTAPBaseGameCharacterDetails.NewCharacterInit);