require "card"

Creature = Card:new()

function Creature:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.arr_grid = {x=1, y=1} or o.arr_grid
    o.damage = o.damage or 1
    o.health = o.health or 1
    o.power = o.power or -1
    o.health = o.health or 2
    --collection of positions related to this creature (1-9)
    --this creature is nr 5
    --o.support = o.support or {}

    return o
end


function Creature:switchTurn(field)
    if (self.health <= 0) then
        field:removeCard(self.arr_grid.x, self.arr_grid.y)
    end
    
    if (self.arr_grid.y > 7) then
        field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x, self.arr_grid.y - 1)
    else
        if (self.specialSwitch()) then
            self:ai(field)
        end
    end
    self.boo_hasSwitched = true
end

function Creature:specialSwitch()--return true if ai shuld run
    return true
end

function Creature:ai(field)
    field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x, self.arr_grid.y - 1)
end

function Creature:takeDamage(int_damage)
    self.health = self.health - int_damage
    return self.health
end

function Creature:draw(x, y, w, h)

    --h = h or w * 3.5
    h = w * 3.5

    lg.setColor(1, 0, 0)
    lg.rectangle("fill", x, y, w * 2.5, h)
    lg.setColor(0, 0, 0)
    --lg.setColor(255, 255, 255)

    lg.print("C:" .. self.cost .. "\nHP:" .. self.health .. "\nP:" .. self.power, x +10, y + 10, 0, 1)


end