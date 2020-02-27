require "zoneHandler"
require "Menu/MenuHandler"

Game = {}

function Game:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    
    o.MenuHandler = MenuHandler:new()
    o.MenuHandler:addMenu()

    o.ZoneHandler = ZoneHandler:new()

    o.mousePressed = false

    o.playerID = 1

    return o
end

function Game:update(dt)

    self.ZoneHandler:update(self, dt)
    self.MenuHandler:update(self, dt)
    
end

function Game:draw()

    self.ZoneHandler:draw()
    self.MenuHandler:draw()

end