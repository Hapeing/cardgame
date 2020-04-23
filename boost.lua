require "card"

Boost = Card:new()

function Boost:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.power = o.power or -1
    o.cooldown = o.cooldown or 2
    o.cooling = o.cooling or 0
    o.name = "._."

    return o
end

function Boost:activate()
    --print("__start activate() " .. self.cooling)
    if (self.cooling == 0) then
        print("Activate card: " .. self.power)
        self:startCooldown()
        self:execute()
    else
        print("Card " .. self.power .. " is on cooldown")
    end
    --print("__end activate() " .. self.cooling)
end

function Boost:tickCooldown()
    if (self.cooling - 1 < 0) then
        self.cooling = 0
    else
        self.cooling = self.cooling - 1
    end
end

function Boost:startCooldown()
    self.cooling = self.cooldown

end

function Boost:draw(x, y, w, h)

    h = h or w * 3.5

    lg.setColor(1, 1, 0)
    lg.rectangle("fill", x, y + 10*self.cooling, w * 2.5, h)

    lg.setColor(0, 0, 0)
    lg.print(self.name .. "\nC:" .. self.cooldown.. "\n\n\nID:" .. self.power, x +10, y + 10 + 10*self.cooling, 0, 2)

end

function Boost:turnSwitch()
    --print("__start turnSwitch() " .. self.cooling .. self.power)
    Game.ZoneHandler.Zone_Hands[1].selectedCard = 0
    self:tickCooldown()
    --print("__end turnSwitch() " .. self.cooling)
end