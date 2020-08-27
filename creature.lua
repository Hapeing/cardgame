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

    o.img_img = o.img_img or lg.newImage("full_04.png")
    o.img_img:setFilter("nearest","nearest")
    o.img_first = lg.newQuad(0,0,16,16, o.img_img:getDimensions())
    o.img_heart = o.img_heart or lg.newImage("GameToken_16_2.png")

    o.num_scale = 5

    return o
end


function Creature:switchTurn(field)
    if (self.health <= 0) then
        field:removeCard(self.arr_grid.x, self.arr_grid.y)
    elseif (self.arr_grid.y > 7) then
        field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x, self.arr_grid.y - 1)
    elseif (self.specialSwitch()) then
        self:ai(field)
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
    if (self.health < 1) then
        self.img_img = lg.newImage("GameToken_12_2.png")

        self.img_first = lg.newQuad(0,0,1024,1024, self.img_img:getDimensions())
        self.num_scale = 0.1
    end
    return self.health
end

function Creature:draw(x, y, w, h)

    --h = h or w * 3.5
    --h = w * 3.5

    --lg.setColor(1, 0, 0)
    --lg.rectangle("fill", x, y, w * 2.5, h)
    
    
    lg.setColor(1, 1 ,1)
    if (self.num_scale < 1) then
        lg.setColor(0, 0 ,0)
    end
    lg.draw(self.img_img, self.img_first, x, y, 0, self.num_scale)
    
    lg.setColor(1, 0 ,0)
    for i = 1, self.health do
        lg.draw(self.img_heart, x + i*30, y + 45, 0, 0.05)
    end

    --lg.setColor(0, 0, 0)
    --lg.print("C:" .. self.cost .. "\nHP:" .. self.health .. "\nP:" .. self.power, x +10, y + 10, 0, 1)


end