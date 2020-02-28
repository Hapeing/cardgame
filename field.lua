require "zone"

Field = Zone:new()

function Field:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    --temp code
    

    o:addButton({x=0, y=64*2, hight=64, width=64})
    o:addButton({x=64, y=64*3, hight=64, width=64})

    return o
end

function Field:draw()


    for i, card in ipairs(self.Cards) do 
        
        card:draw(300 * i, 100, 100, 150)

    end

    self:drawButtons()

end