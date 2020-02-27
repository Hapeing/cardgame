require "zone"

Field = Zone:new()

function Field:new()

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    return o
end

function Field:draw()


    for i, card in ipairs(self.Cards) do 
        
        card:draw(300 * i, 100, 100, 150)

    end

end