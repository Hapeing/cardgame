require "card"

Creature = Card:new()

function Creature:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    o.power = o.power or -1
    o.health = o.health or 10
    --collection of positions related to this creature (1-9)
    --this creature is nr 5
    --o.support = o.support or {}

    return o
end

function Creature:turnSwitch(field)
    
    --print("Try to move " .. self.power)
    field:addCard(field:removeCard(self.gridPos.x, self.gridPos.y),self.gridPos.x, self.gridPos.y - 1)
    
        
    --field.player.x = self.gridPos.x
    --field.player.y = self.gridPos.y
end

function Creature:draw(x, y, w, h)

    --h = h or w * 3.5
    h = w * 3.5

    lg.setColor(1, 0, 0)
    lg.rectangle("fill", x, y, w * 2.5, h)
    lg.setColor(0, 0, 0)
    --lg.setColor(255, 255, 255)
    lg.print("C:" .. self.cost .. "\nH: ".. self.health .."\nP:" .. self.power, x +10, y + 10, 0, 1)

end