require "creature"
require "boost"

Zone = {}

function Zone:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.Cards = {}


    return o
end

function Zone:addCard(card, i)--return true/false
    
    local i = i or 1--will be able to choose position in array

    table.insert(self.Cards, card)

    return true
end

function Zone:removeCard(i)--returns card

    local i = i or 1

    return table.remove(self.Cards, i)

end

function Zone:update(game, dt)

end

function Zone:draw()

end