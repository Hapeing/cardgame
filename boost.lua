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
    o.str_type = "default"

    return o
end


function Boost:activate(zHandler, int_index)
    --print("activate card: " .. self.power)
    --print(zHandler)
    --print(int_index)
    self:preExecute(zHandler)
    if (self:checkExecute(zHandler, int_index)) then
        --self:execute()
        --self:postExecute(zHandler)
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
    elseif (self.cooling > 0) then
        print("Ability " .. int_index .. " on cooldown")
    else
        print("Activate " .. int_index)
        zHandler.Zone_Hands[1].selectedCard = int_index
        for i, btn in pairs(zHandler.Zone_Fields[1]:enableButtons(self.choises, self.fieldUse, self.str_type)) do
            btn.int_callback = self.power
        end


        return false
        --zHandler.Zone_Hands[1].Cards[int_index]:activate()
    end
    return true
end

function Boost:switchTurn(zHandler)--bug:buttons are not disabled when switching turns
    if (self.cooling > 0) then
        self.cooling = self.cooling - 1
    end
    self.boo_hasSwitched = true
    -- if (zHandler.Zone_Hands[1].selectedCard ~= 0) then
    --     zHandler.Zone_Fields[1]:disableButtons(zHandler.Zone_Hands[1].Cards[zHandler.Zone_Hands[1].selectedCard].choises, false)
    -- end
    --zHandler.Zone_Hands[1].selectedCard = 0
end

function Boost:preExecute(zHandler)
    -- if (self.choises ~= nil) then
    --     zHandler.Zone_Fields[1]:visableButtons(self.choises)
    -- end
end

function Boost:postExecute(zHandler)
    self.cooling = self.cooldown
    zHandler.Zone_Fields[1]:disableButtons(self.choises, false)
    zHandler.Zone_Hands[1].selectedCard = 0

end

function Boost:draw(x, y, w, h)

    h = h or w * 3.5

    lg.setColor(1, 1, 0)

    lg.rectangle("fill", x, y + 30*self.cooling, w * 2.5, h)

    lg.setColor(0, 0, 0)
    lg.print(self.name .. "\nC:" .. self.cooldown .. "\n\n\nID:" .. self.power, x +10, y + 10  + 30*self.cooling , 0, 2)
end

-- function Boost:turnSwitch()
--     --print("__start turnSwitch() " .. self.cooling .. self.power)
--     Game.ZoneHandler.Zone_Hands[1].selectedCard = 0
--     self:tickCooldown()
--     --print("__end turnSwitch() " .. self.cooling)
-- end