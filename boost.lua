require "card"

Boost = Card:new()

function Boost:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.power = o.power or -1

    return o
end

function Boost:draw(x, y, w, h)

    h = h or w * 3.5

    lg.setColor(255, 255, 0)
    lg.rectangle("fill", x, y, w * 2.5, h)

    lg.setColor(0, 0, 0)
    --lg.setColor(255, 255, 255)
    lg.print("C:" .. self.cost .. "\n\nP:" .. self.power, x +10, y + 10, 0, 3)

end