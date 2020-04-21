require "zone"

Field = Zone:new()

function Field:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self



    o.nrOfRows = o.nrOfRows or 5
    o.nrOfChannels = o.nrOfChannels or  5
    o.nrOfCards = {}--nr or cards per channel
    o.selectedSquare = {x=nil, y=nil}

    for i = 1, o.nrOfChannels do
        o.nrOfCards[i] = 0
        o.Cards[i] = {}--each array is its own channel from left to right
        for j = 1, o.nrOfRows do
            o:addButton({
                x = 150 * i,
                y = 700 - 100 * j,
                fieldChannel = i,
                fieldRow = j,
                active = false,
                visable = false,
                use = nil,
                move = function(self, field, I)
                    --print("button x y: " .. self.fieldChannel .. " " .. self.fieldRow)
                    --print("selected x y: " .. field.selectedSquare.x .. " " .. field.selectedSquare.y)
                    
                    print("__start button:move()")
                    -- print("self.channel: ")
                    -- print(self.fieldChannel)
                    print("selectedSqare x & y:")
                    print(field.selectedSquare.x)
                    print(field.selectedSquare.y)
                    
                    --bug:cannot move a card beyond 3 unless swapped
                    --bug:cards swap places if one card is moved into another

                    field:addCard(field:removeCard(field.selectedSquare.x, field.selectedSquare.y),self.fieldChannel, self.fieldRow)
                    
                    field.Buttons[field:getButtonIndex(field.selectedSquare.x, field.selectedSquare.y)].active = false
                    field.Buttons[field:getButtonIndex(field.selectedSquare.x, field.selectedSquare.y)].visable = false
                    field.selectedSquare.x = nil
                    field.selectedSquare.y = nil
                    
                    print("__end button:move()")
                end,
                released = function(self, zHandler)
                    local field = zHandler.Zone_Fields[1]

                    -- if(field.selectedSquare.x ~= self.fieldChannel and 
                    -- field.selectedSquare.y ~= self.fieldRow and
                    -- field.selectedSquare.x ~= nil and 
                    -- field.selectedSquare.y ~= nil) then
                        
                    --     self:move()
                    -- else
                    --     self:select(field)
                    -- end

                    local I = self.fieldChannel*field.nrOfRows-(field.nrOfRows-self.fieldRow)

                    self:use(field, I)
                    
                    self.r = self.r_org
                    self.g = self.g_org
                    self.b = self.b_org
                end,
                select = function(self, field, I)
                    --bug:a button can stuck in use=move if the button a row below called select
                    
                    --is this selected?
                    --yes -> deselect
                    --no:
                    --is anything selected?
                    --yes -> do nothing
                    --no:
                    --select this
                    local steps = 1

                    if(field.selectedSquare.x == self.fieldChannel and 
                    field.selectedSquare.y == self.fieldRow) then
                        
                        field.Buttons[I+steps].active = false
                        field.Buttons[I+steps].visable = false
                        field.Buttons[I+steps].use = field.Buttons[I+1].select
                        field.selectedSquare.x = nil
                        field.selectedSquare.y = nil

                        field.Buttons[I+steps].r_org = 1
                        field.Buttons[I+steps].g_org = 1
                        field.Buttons[I+steps].b_org = 1

                        field.Buttons[I+steps].r = 1
                        field.Buttons[I+steps].g = 1
                        field.Buttons[I+steps].b = 1


                    elseif(field.selectedSquare.x ~= nil and 
                    field.selectedSquare.y ~= nil) then
                        --invalid button action
                    
                    else
                        
                        field.Buttons[I+steps].active = true
                        field.Buttons[I+steps].visable = true
                        field.Buttons[I+steps].use = field.Buttons[I+1].move
                        
                        field.selectedSquare.x = self.fieldChannel
                        field.selectedSquare.y = self.fieldRow

                        field.Buttons[I+steps].r_org = 0.5
                        field.Buttons[I+steps].g_org = 0
                        field.Buttons[I+steps].b_org = 0

                        field.Buttons[I+steps].r = 0.5
                        field.Buttons[I+steps].g = 0
                        field.Buttons[I+steps].b = 0

                        

                    
                    end
                    
                end
            })
        end
    end

    o:addCard(Creature:new(),4, 5)


    return o
end

function Field:addCard(card, channel, row)

    print("__start Field:addCard()")

    if (card == nil) then
        print("-ERROR: Cannot add card to field: card = nil")
        print("-channel: " .. channel .. "\n-row: " .. row)
        print("__end Field:addCard()")
        return false
    end
    
    self.nrOfCards[channel] = self.nrOfCards[channel] + 1
    local row = row or self.nrOfCards[channel]
    --local row = row or 5
    
    print("|Card added\n|cost: " .. card.cost)
    print("|channel: " .. channel .. "\n|row: " .. row)


    self.Cards[channel][row] = card

    local I = self:getButtonIndex(channel, row)

    self.Buttons[I].active = true
    self.Buttons[I].visable = true
    self.Buttons[I].use = self.Buttons[I].select



    self.Buttons[I].r_org = 1
    self.Buttons[I].g_org = 1
    self.Buttons[I].b_org = 1
    self.Buttons[I].r = 1
    self.Buttons[I].g = 1
    self.Buttons[I].b = 1
    
    print("__end of addCard")

    return true

end

function Field:getButtonIndex(channel, row)
    return channel * self.nrOfRows - (self.nrOfRows - row)
end

function Field:removeCard(channel, row)--returns card



    -- print("Field:removeCard()")
    -- print("local channel: ")
    -- print(channel)
    -- print("__end Field:removeCard()")

    self.nrOfCards[channel] = self.nrOfCards[channel] - 1
    
    local card = self.Cards[channel][row]

    self.Cards[channel][row] = nil

    return card

end

function Field:draw()

    self:drawButtons()

    for i, row in pairs(self.Cards) do 
        for j, card in pairs(row) do 
            
            card:draw(150 * i, 700 - 100 * j, 20)
            
            

        end
    end

    for i=1, 30 do
        for j=1, 30 do
            if (self.Cards[i]) then
                if (self.Cards[i][j]) then
                    lg.setColor(1, 1, 1)
                    lg.print(self.Cards[i][j].cost, W_WIDTH*0.9 + i*25, W_HEIGHT*0.2 - j*25, 0, 1)
                end
            end
        end
    end

            

end