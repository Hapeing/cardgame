require "zone"

Field = Zone:new()

function Field:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    --temp code
    o:addButton(0, 64*2, 64, 64)
    o:addButton(64, 64*3, 64, 64)

    return o
end

function Field:draw()


    for i, card in ipairs(self.Cards) do 
        
        card:draw(300 * i, 100, 100, 150)

    end

    self:drawButtons()

end