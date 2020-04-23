require "zone"

Hand = Zone:new()

function Hand:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    o.cardW = 100
    o.cardH = 150

    o.cardSelectFrame = 5

    o.nrOfCards = 0
    o.firstCardX = 100
    o.cardsY = 800

    o.cardSpace = 50

    --o.target = {x=nil, y=nil}
    o.selectedCard = 0

    --reserved buttons goes after all the others or thay have special tags as "summon" or "discard"
    --o.nrOfReservedButtons = o.nrOfReservedButtons or 5+2 --nrOfChannels +2

    --test code
    o.selectedChannel = 1
    --o:addButton({x=0, y=0, hight=64, width=64})
    --o:addButton({x=64, y=64, hight=64, width=64})

    return o
end

function Hand:addCard(card, i)--should return true/false

    table.insert(self.Cards, card)

    self.nrOfCards = self.nrOfCards + 1

    self:addButton({
        x = self.firstCardX + (self.cardSpace + self.cardW) * self.nrOfCards - self.cardSelectFrame, 
        y = self.cardsY - self.cardSelectFrame,
        width = self.cardW + self.cardSelectFrame * 2, 
        hight = self.cardH + self.cardSelectFrame * 2,
        r = 0, g = 0.5, b = 0,
        I = self.nrOfCards,
        pressed = function(self) self.g = 1 end,
        released = function(self, zHandler) 
            --is self selected?
            --yes -> deselect self
            --no:
            --is anything selected?
            --yes -> do nothing
            --no:
            --select self
            hand = zHandler.Zone_Hands[1]
            if (hand.selectedCard == self.I) then
                hand.selectedCard = 0
                --zHandler.Zone_Fields[1]:disableButtons(self.choises)
            elseif (hand.selectedCard ~= 0) then
                print("Ability " .. hand.selectedCard .. " is active")
            else
                hand.selectedCard = self.I
                zHandler.Zone_Hands[1].Cards[self.I]:activate()
            end


            
            --zHandler:changeZone(zHandler.Zone_Hands[1], zHandler.Zone_Fields[1], self.I, zHandler.Zone_Hands[1].selectedChannel)
            --print("Button index: " .. self.I)
            self.g = 0.5 
            
        end
    })


    return true
end

function Hand:removeCard(i)--returns card

    local i = i or 1

    self.nrOfCards = self.nrOfCards - 1

    table.remove(self.Buttons, i)

    for i, btn in ipairs(self.Buttons) do --correcting the index (I) and pos of the buttons
        btn.I = i
        btn.x = self.firstCardX + (self.cardSpace + self.cardW) * i - self.cardSelectFrame
    end

    return table.remove(self.Cards, i)

end

function Hand:draw()

    self:drawButtons()

    for i, card in ipairs(self.Cards) do 
        
        card:draw(self.firstCardX + (self.cardSpace + self.cardW) * i, self.cardsY, self.cardW/2.5, self.cardH)

    end
    
    lg.setColor(1, 1, 1)
    lg.print("Select channel before clicking the card.\nCurrent selection: Channel " .. self.selectedChannel, W_WIDTH/2, W_HEIGHT-(W_HEIGHT*0.1), 0, 3)


end