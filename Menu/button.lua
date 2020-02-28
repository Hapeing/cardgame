Button = {}

function Button:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.x = o.x or 0
    o.y = o.y or 0
    o.hight = o.hight or 64
    o.width = o.width or 64

    o.r = o.r or 1
    o.b = o.b or 1
    o.g = o.g or 1
    
    return o
end

function Button:pressed(dt)
    self.r = 0
    self.g = 1
    self.b = 0
end

function Button:released()
    self.r = 1
    self.g = 1
    self.b = 1
end

function Button:draw()

    --one color when inactive
    --one color when hover
    --one color when hover and mouse pressed
    --inactive when not hover and mouse pressed

    lg.setColor(self.r, self.g, self.b)
    lg.rectangle("fill", self.x, self.y, self.width, self.hight)

end