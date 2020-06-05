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

    o.squ_selectedCard = {pos_pixel= {x=-100, y=-100}, size_pixel = {hight = 10, width = 40}}

    --o.int_selectedCard = 0

    --reserved buttons goes after all the others or thay have special tags as "summon" or "discard"
    --o.nrOfReservedButtons = o.nrOfReservedButtons or 5+2 --nrOfChannels +2

    --test code
    -- o.selectedChannel = 1
    -- o:addButton({x=0, y=0, hight=64, width=64})
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
        r_org = 0, g_org = 0.5, b_org = 0,
        I = self.nrOfCards,
        pressed = function(self) self.g = 1 end,
        foo_move = function(self, zHandler)
            zHandler:changeZone(zHandler.Zone_Hands[1], zHandler.Zone_Fields[1], self.I, zHandler.Zone_Hands[1].selectedChannel)
        end,
        foo_use = function(self, zHandler)
            self:foo_default(zHandler)
        end,
        foo_inactive = function(self, zHandler)
            print("foo_inactive() I:" .. self.I)
        end,
        foo_active = function(self, zHandler)
            --turns buttons in hand to foo_default

            -- print("Active button I:" .. self.I)
            zHandler.Zone_Hands[1]:setButtons_foo(self.foo_default)

            zHandler.Zone_Cycles[1]:setButtons(false)

            zHandler.Zone_Hands[1].squ_selectedCard.pos_pixel.x = - 100
            zHandler.Zone_Hands[1].squ_selectedCard.pos_pixel.y = - 100

            -- print("foo_active() I:" .. self.I)
            -- print("setButtons(foo_default)")
        end,
        foo_default = function (self, zHandler)
            --set self to foo_active - OK
            --set others to foo_inactive - OK
            --set cycle buttons - OK

            zHandler.Zone_Hands[1]:setButtons_foo(self.foo_inactive)
            self.foo_use = self.foo_active

            local int_hand_index = self.I
            local temp_foo_default = self.foo_default

            local foo_summon = function(self)--will be called from The cycle buttons

                zHandler:changeZone(zHandler.Zone_Hands[1], zHandler.Zone_Fields[1], int_hand_index, self.int_channel)
                zHandler.Zone_Cycles[1]:setButtons(false)
                zHandler.Zone_Hands[1]:setButtons_foo(temp_foo_default)

                zHandler.Zone_Hands[1].squ_selectedCard.pos_pixel.x = - 100
                zHandler.Zone_Hands[1].squ_selectedCard.pos_pixel.y = - 100
                
            end
            
            --[BUG] When a card is selected and you draw a card, the new card can be selected instead
            
            zHandler.Zone_Cycles[1]:setButtons_foo(foo_summon)

            zHandler.Zone_Cycles[1]:setButtons(zHandler.Zone_Cycles[1]:checkButtons({1,2,3,4,5,6,7,8}, zHandler.Zone_Fields[1]), true)
            
            -- zHandler.Zone_Hands[1].squ_selectedCard = {pos_pixel= {x=-100, y=-100}}
            zHandler.Zone_Hands[1].squ_selectedCard.pos_pixel.x = self.x + 35
            zHandler.Zone_Hands[1].squ_selectedCard.pos_pixel.y = self.y - 12
            
            -- zHandler.Zone_Cycles[1]:setButtons({1,2,3,4,5,6,7,8}, false)
            -- print("foo_default() I:" .. self.I)
            -- print("setOtherButtons(foo_inactive)")
        end,
        released = function(self, zHandler)

            self:foo_use(zHandler)
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
    lg.rectangle("fill", self.squ_selectedCard.pos_pixel.x, self.squ_selectedCard.pos_pixel.y, self.squ_selectedCard.size_pixel.width, self.squ_selectedCard.size_pixel.hight)

    -- self.squ_selectedCard.pos_pixel.y

    -- lg.setColor(1, 1, 1)
    -- lg.print("Select channel before clicking the card.\nCurrent selection: Channel " .. self.selectedChannel, W_WIDTH/2, W_HEIGHT-(W_HEIGHT*0.1), 0, 3)


end