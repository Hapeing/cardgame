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

    -- o.frame = 0

    --o.mySquare = lg.newImage("square.png")

    return o
end

function Game:update(dt)

    --self.MenuHandler:update(self, dt)
    self.ZoneHandler:update(self, dt)
    -- self.frame = self.frame + 1
    
end

function Game:draw()

    self.ZoneHandler:draw()
    -- lg.setColor(1,1,1,255)
    -- lg.draw(self.mySquare, 50, 50)
    --self.MenuHandler:draw()

end