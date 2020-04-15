require "zone"

Field = Zone:new()

function Field:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    --nr or cards per channel
    o.nrOfCards = {0,0,0,0,0,0,0}

    --each array is its own channel from left to right
    o.Cards[1] = {}
    o.Cards[2] = {}
    o.Cards[3] = {}
    o.Cards[4] = {}
    o.Cards[5] = {}
    o.Cards[6] = {}
    o.Cards[7] = {}


    --test code
    o:addButton({x=0, y=64*2, hight=64, width=64})
    o:addButton({x=64, y=64*3, hight=64, width=64})

    return o
end

function Field:addCard(card, channel, row)

    if (card == nil) then
        print("ERROR: Cannot add card to field")
        return false
    end

    local row = row or 1

    self.nrOfCards[channel] = self.nrOfCards[channel] + 1


    self.Cards[channel][row] = card

    return true

end

function Field:draw()


    for i, channel in ipairs(self.Cards) do 
        for i, card in ipairs(channel) do 
            
            card:draw(150 * i, 100, 100, 150)
            
        end
    end

    self:drawButtons()

end