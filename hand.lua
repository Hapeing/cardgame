require "zone"

Hand = Zone:new()

function Hand:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    --test code
    o:addButton(0, 0, 64, 64)
    o:addButton(64, 64, 64, 64)
    --print(table.getn(self.Buttons))

    return o
end

function Hand:draw()

    

    for i, card in ipairs(self.Cards) do 
        
        card:draw(150 * i, 800, 100, 150)

    end

    self:drawButtons()

end