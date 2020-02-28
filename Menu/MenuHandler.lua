require "Menu/menu"

MenuHandler = {}

function MenuHandler:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.Menus = {}

    return o
end

function MenuHandler:addMenu(o)

    local o = Menu:new(o)
    table.insert(self.Menus, o)

end

function MenuHandler:update(Game, dt)

    self.Menus[1]:update(Game, dt)
    self.Menus[2]:update(Game, dt)

end

function MenuHandler:draw()

    self.Menus[1]:draw()
    self.Menus[2]:draw()

end