require "zone"

Field = Zone:new()

function Field:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    o.nrOfChannels = o.nrOfChannels or 5
    o.nrOfCards = {}--nr or cards per channel



    for i = 1, o.nrOfChannels do
        o.nrOfCards[i] = 0
        o.Cards[i] = {}--each array is its own channel from left to right
    end


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

    self.nrOfCards[channel] = self.nrOfCards[channel] + 1
    local row = row or self.nrOfCards[channel]

    self.Cards[channel][row] = card

    return true

end

function Field:draw()


    for i, row in ipairs(self.Cards) do 
        for j, card in ipairs(row) do 
            
            card:draw(150 * i, 700 - 100 * j, 20)
            
        end
    end

    self:drawButtons()

end