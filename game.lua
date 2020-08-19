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

    return o
end

function Game:unpackPos(pos_)
    return pos_.x, pos_.y
end

function Game:update(dt)

    --self.MenuHandler:update(self, dt)
    self.ZoneHandler:update(self, dt)
    
end

function Game:draw()

    self.ZoneHandler:draw()
    --self.MenuHandler:draw()

end