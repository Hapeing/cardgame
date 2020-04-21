require "card"

Boost = Card:new()

function Boost:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.power = o.power or -1
    o.cooldown = o.cooldown or 1
    o.cooling = o.cooling or 0
    o.name = "._."

    return o
end

function Boost:activate()
    print("activate card: " .. self.power)
end

function Boost:draw(x, y, w, h)

    h = h or w * 3.5

    lg.setColor(1, 1, 0)
    lg.rectangle("fill", x, y, w * 2.5, h)

    lg.setColor(0, 0, 0)
    lg.print(self.name .. "\nC:" .. self.cooldown .. "\n\n\nID:" .. self.power, x +10, y + 10, 0, 2)

end