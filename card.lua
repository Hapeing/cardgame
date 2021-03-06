
Card = {}

function Card:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.cost = -1
    o.boo_hasSwitched = false
    o.int_owner = o.int_owner or 0

    --o.special = nil --a function that will be called when the card is used
    --o.owner = -1 --playerID
    --o.visable = {} --table with playerIDs that should see the card

    return o
end

function Card:switchTurn()
    self.boo_hasSwitched = true

end

function Card:draw(x, y, w, h)

    h = h or w * 3.5

    lg.setColor(0, 0, 1)
    lg.rectangle("fill", x, y, w * 2,5, h)
    lg.setColor(1, 1, 1)
end

