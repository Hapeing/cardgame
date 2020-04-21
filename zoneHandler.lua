require "field"
require "hand"
require "cycle"
require "deck"
require "grave"

ZoneHandler = {}

function ZoneHandler:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    o.Zone_Cycles = Cycle:new()
    o.Zone_Graves = Grave:new()
    o.Zone_Decks = {}
    o.Zone_Decks[1] = Deck:new()
    o.Zone_Fields = {}
    o.Zone_Fields[1] = Field:new()
    o.Zone_Hands = {}    
    o.Zone_Hands[1] = Hand:new()


    --test code

    --fill the deck with temp creatures
    for i = 1, 30 do
        o.Zone_Decks[1]:addCard(Boost:new({power = i, cost = i}))
    end

    o.Zone_Decks[1].Cards[1].name = "move"
    o.Zone_Decks[1].Cards[1].activate = function(self)
        local validMoves = {
            o.Zone_Fields[1]:getButtonIndex(o.Zone_Fields[1].player.x+1, o.Zone_Fields[1].player.y),
            o.Zone_Fields[1]:getButtonIndex(o.Zone_Fields[1].player.x-1, o.Zone_Fields[1].player.y),
            o.Zone_Fields[1]:getButtonIndex(o.Zone_Fields[1].player.x,   o.Zone_Fields[1].player.y+1),
            o.Zone_Fields[1]:getButtonIndex(o.Zone_Fields[1].player.x,   o.Zone_Fields[1].player.y-1)}

            for i=1, 4 do
                if (validMoves[i]) then
                    o.Zone_Fields[1].Buttons[validMoves[i]]:setUse("move", true, true, 
                    {r=0.5,g=0,b=0}, {r=0.5,g=0,b=0})
                end
            end

    end
    
    --draw 5 cards to hand
    for i=1, 5 do
        o.Zone_Decks[1].Buttons[1]:released(o)
    end

    return o
end

function ZoneHandler:changeZone(zoneFrom, zoneTo, removeIndex, addIndex)
    
    zoneTo:addCard(zoneFrom:removeCard(removeIndex), addIndex)

end

function ZoneHandler:shuffle()

end

function ZoneHandler:update(game, dt)

    self.Zone_Fields[1]:update(game, dt)
    self.Zone_Graves:update(game, dt)
    self.Zone_Hands[1]:update(game, dt)
    self.Zone_Decks[1]:update(game, dt)
    self.Zone_Cycles:update(game, dt)

end

function ZoneHandler:draw()

    self.Zone_Fields[1]:draw()
    self.Zone_Decks[1]:draw()
    self.Zone_Hands[1]:draw()
    self.Zone_Cycles:draw()
    self.Zone_Graves:draw()

end

