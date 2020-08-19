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

    o.Zone_Cycles = {}
    o.Zone_Cycles[1] = Cycle:new()
    o.Zone_Graves = Grave:new()
    o.Zone_Decks = {}
    o.Zone_Decks[1] = Deck:new()
    o.Zone_Fields = {}
    o.Zone_Fields[1] = Field:new()
    o.Zone_Hands = {}    
    o.Zone_Hands[1] = Hand:new()

    o.arr_cards = {}
    o.arr_cards = o.createCards()


    for i, crd in pairs(o.arr_cards) do
        o.Zone_Decks[1]:addCard(crd)
    end

    --fill the deck with creatures
    -- for i = 1, 30 do
    --     o.Zone_Decks[1]:addCard(Creature:new({power = i, cost = i, 
    --         ai = function(self, field)
    --             self.pos_moveTo = {x=self.arr_grid.x, y = self.arr_grid.y+1}
    --             field:getButton(self.pos_moveTo.x, self.pos_moveTo.y).visable = true
    --         end, 
    --         int_owner = 1}))
    -- end


    --draw cards to hand
    for i=1, 4 do
        o.Zone_Decks[1].Buttons[1]:released(o)
    end

    return o
end

function ZoneHandler:changeZone(zoneFrom, zoneTo, removeIndex, addIndex)
    
    zoneTo:addCard(zoneFrom:removeCard(removeIndex), addIndex)

end


function ZoneHandler:update(game, dt)

    self.Zone_Fields[1]:update(game, dt)
    self.Zone_Graves:update(game, dt)
    self.Zone_Hands[1]:update(game, dt)
    self.Zone_Decks[1]:update(game, dt)
    self.Zone_Cycles[1]:update(game, dt)

end

function ZoneHandler:draw()

    self.Zone_Fields[1]:draw()
    self.Zone_Graves:draw()
    self.Zone_Hands[1]:draw()
    self.Zone_Decks[1]:draw()
    self.Zone_Cycles[1]:draw()

end