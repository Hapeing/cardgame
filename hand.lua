require "zone"

Hand = Zone:new()

function Hand:new()

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    return o
end

function Hand:draw()


    for i, card in ipairs(self.Cards) do 
        
        card:draw(150 * i, 800, 100, 150)

    end

end