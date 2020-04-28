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

function Boost:activate(zHandler, int_index)
    --print("activate card: " .. self.power)
    --print(zHandler)
    --print(int_index)
    self:preExecute(zHandler)
    if (self:checkExecute(zHandler, int_index)) then
        --self:execute()
        self:postExecute(zHandler)
    end
end

function Boost:checkExecute(zHandler, int_index)
    --is self selected?
    --yes -> deselect self
    --no:
    --is anything selected?
    --yes -> do nothing
    --no:
    --select self
    if (zHandler.Zone_Hands[1].selectedCard == int_index) then
        print("Deactivate " .. int_index)
        zHandler.Zone_Hands[1].selectedCard = 0
        zHandler.Zone_Fields[1]:disableButtons(self.choises)
        return false
    elseif (zHandler.Zone_Hands[1].selectedCard ~= 0) then
        print("Cant activate " .. int_index .. ". Because " .. zHandler.Zone_Hands[1].selectedCard .. " is active")
        return false
    else
        print("Activate " .. int_index)
        zHandler.Zone_Hands[1].selectedCard = int_index
        zHandler.Zone_Fields[1]:enableButtons(self.choises, self.fieldUse)
        return false
        --zHandler.Zone_Hands[1].Cards[int_index]:activate()
    end
    return true
end

function Boost:preExecute(zHandler)
    -- if (self.choises ~= nil) then
    --     zHandler.Zone_Fields[1]:visableButtons(self.choises)
    -- end
end

function Boost:postExecute(zHandler)
    self.cooling = self.cooldown
    zHandler.Zone_Fields[1]:visableButtons(self.choises, false)
end

function Boost:draw(x, y, w, h)

    h = h or w * 3.5

    lg.setColor(1, 1, 0)
    lg.rectangle("fill", x, y, w * 2.5, h)

    lg.setColor(0, 0, 0)
    lg.print(self.name .. "\nC:" .. self.cooldown .. "\n\n\nID:" .. self.power, x +10, y + 10, 0, 2)

end