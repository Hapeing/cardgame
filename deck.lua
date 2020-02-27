require "zone"

Deck = Zone:new()

function Deck:new()

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    return o
end

function Deck:draw()


    if (table.getn(self.Cards) > 0) then

        lg.setColor(0.54, 0.27, 0.07)--brown
        lg.rectangle("fill", 1400, 600, 100, 150)
    end

end