Button = {}

function Button:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.x = 0
    o.y = 0
    o.hight = 64
    o.width = 64

    o.r = 255
    o.b = 255
    o.g = 255
    
    return o
end

function Button:pressed(dt)
    self.r = 0
    self.g = 255
    self.b = 0
end

function Button:released()
    self.r = 255
    self.g = 255
    self.b = 255
end

function Button:draw()

    --one color when inactive
    --one color when hover
    --one color when hover and mouse pressed
    --inactive when hover and mouse pressed

    lg.setColor(self.r, self.g, self.b)
    lg.rectangle("fill", self.x, self.y, self.width, self.hight)

end