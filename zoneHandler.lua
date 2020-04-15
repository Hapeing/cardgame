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


    --temp code
    crep1 = Creature:new({power = 1, cost = 1})
    crep2 = Creature:new({power = 2, cost = 2})
    crep3 = Boost:new({power = 3, cost = 3})
    crep4 = Boost:new({power = 4, cost = 4})
    crep5 = Boost:new({power = 5, cost = 5})

    o.Zone_Decks[1]:addCard(crep1)
    o.Zone_Decks[1]:addCard(crep2)
    o.Zone_Decks[1]:addCard(crep3)
    o.Zone_Decks[1]:addCard(crep4)
    o.Zone_Decks[1]:addCard(crep5)

    --o.Zone_Decks[1]:addCard(Boost:new({power = 6, cost = 6}))


    

    -- o.Zone_Hands[1]:addButton({x=175, y=750, hight=50, width=50, released = function(self, game)
    --         game.ZoneHandler:changeZone(o.Zone_Hands[1], o.Zone_Field)
    --         -- o:changeZone(o.Zone_Hands[1], o.Zone_Field)
    --         self.r = 1
    --         self.g = 1
    --         self.b = 1
    --     end})

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

