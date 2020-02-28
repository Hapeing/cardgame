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
    o.Zone_Decks = Deck:new()
    o.Zone_Field = Field:new()
    o.Zone_Hands = {}    
    o.Zone_Hands[1] = Hand:new()


    --temp code
    crep1 = Creature:new({power = 1, cost = 1})
    crep2 = Creature:new({power = 2, cost = 2})
    crep3 = Boost:new({power = 3, cost = 3})

    o.Zone_Hands[1]:addCard(crep1)
    o.Zone_Hands[1]:addCard(crep2)
    o.Zone_Hands[1]:addCard(crep3)

    o:changeZone(o.Zone_Hands[1], o.Zone_Field)

    return o
end

function ZoneHandler:changeZone(zoneFrom, zoneTo)
    
    zoneTo:addCard(zoneFrom:removeCard())

end

function ZoneHandler:shuffle()

end

function ZoneHandler:update(game, dt)

    self.Zone_Field:update(game, dt)
    self.Zone_Graves:update(game, dt)
    self.Zone_Hands[1]:update(game, dt)
    self.Zone_Decks:update(game, dt)
    self.Zone_Cycles:update(game, dt)

end

function ZoneHandler:draw()

    self.Zone_Field:draw()
    self.Zone_Decks:draw()
    self.Zone_Hands[1]:draw()
    self.Zone_Cycles:draw()
    self.Zone_Graves:draw()

end

