require "zoneHandler"
--require "Menu/MenuHandler"

Game = {}

function Game:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    
    --o.MenuHandler = MenuHandler:new()
    --o.MenuHandler:addMenu()
    --o.MenuHandler:addMenu()

    --o.MenuHandler.Menus[1]:addButton(500, 500, 100, 100)
    --o.MenuHandler.Menus[2]:addButton(600, 600, 100, 100)

    


    o.ZoneHandler = ZoneHandler:new()

    o.mousePressed = false

    o.playerID = 1

    o.int_maxHealth = 10

    o.int_health = o.int_maxHealth

    o.mySquare = lg.newImage("GameToken_16_2.png")

    return o
end

function Game:update(dt)

    self.ZoneHandler:update(self, dt)
    
end

function Game:draw()

    self.ZoneHandler:draw()
    lg.setColor(1,0,0,255)
    for i = 1, self.int_maxHealth do

        if (i > self.int_health) then
            lg.setColor(0.5,0.5,0.5,255)
        end
        lg.draw(self.mySquare, 100, 700 - 50 * i, 0, 0.1)
    end
    --self.MenuHandler:draw()

end