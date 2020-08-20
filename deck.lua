require "zone"

Deck = Zone:new()

function Deck:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.x = 1400
    o.y = 600
    o.width = 50 * 2.5
    o.hight = 50 * 3.5
    o.color = {r = 0.54, g = 0.27, b = 0.07}--brown


    o:addButton({
        x = o.x,
        y = o.y,
        width = o.width, 
        hight = o.hight,
        r_org = o.color.r, g_org = o.color.g, b_org = o.color.b,
        pressed = function(self) self.g = 1 end,
        released = function(self, zHandler) 
            if (zHandler.Zone_Decks[1].nrOfCards > 0)then
                zHandler:changeZone(zHandler.Zone_Decks[1], zHandler.Zone_Hands[1])
                --print("Draw to hand")
            else
                print("No cards in deck")
            end
            
            self.g = o.color.g
            
        end
    })

    return o
end

function Deck:draw()


    if (table.getn(self.Cards) > 0) then

        --lg.setColor(self.color.r, self.color.g, self.color.b)
        --lg.rectangle("fill", self.x, self.y, self.width, self.hight)
        self:drawButtons()
    end

end