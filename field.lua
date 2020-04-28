require "zone"

Field = Zone:new()

function Field:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    o.nrOfRows = o.nrOfRows or 9
    o.nrOfChannels = o.nrOfChannels or  8
    o.nrOfCards = {}--nr or cards per channel
    o.selectedSquare = {x=nil, y=nil}
    o.player = {x=3, y=1}

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
                    
                    --print("__start button:move()")
                    -- print("self.channel: ")
                    -- print(self.fieldChannel)
                    --print("selectedSqare x & y:")
                    --print(field.selectedSquare.x)
                    --print(field.selectedSquare.y)
                    

                    field:addCard(field:removeCard(field.player.x, field.player.y),self.fieldChannel, self.fieldRow)
                    
                    
                    local toDeactivate = {
                        field:getButtonIndex(field.player.x,   field.player.y),
                        field:getButtonIndex(field.player.x+1, field.player.y),
                        field:getButtonIndex(field.player.x-1, field.player.y),
                        field:getButtonIndex(field.player.x,   field.player.y+1),
                        field:getButtonIndex(field.player.x,   field.player.y-1)}
                        
                        --field.Buttons[field:getButtonIndex(field.selectedSquare.x, field.selectedSquare.y)].active = false
                        --field.Buttons[field:getButtonIndex(field.selectedSquare.x, field.selectedSquare.y)].visable = false
                        for i=1, 5 do
                            if (toDeactivate[i] and toDeactivate[i] ~= field:getButtonIndex(self.fieldChannel, self.fieldRow)) then
                                field.Buttons[toDeactivate[i]]:setUse("select", false, false, 
                                {r=1,g=1,b=1}, {r=1,g=1,b=1})
                            end
                        end
                        
                        field.player.x = self.fieldChannel
                        field.player.y = self.fieldRow
                    
                    field.selectedSquare.x = nil
                    field.selectedSquare.y = nil
                    
                    --print("__end button:move()")
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

                    self:use(zHandler, I)
                    
                    self.r = self.r_org
                    self.g = self.g_org
                    self.b = self.b_org
                end,
                select = function(self, zHandler, I)
                    


                    --zHandler.Zone_Hands[1].target.x = self.fieldChannel
                    --zHandler.Zone_Hands[1].target.y = self.fieldRow

                    --is self selected?
                    --yes -> deselect self
                    --no:
                    --is anything selected?
                    --yes -> do nothing
                    --no:
                    --select self
                    --[[

                    local validMoves = {
                        field:getButtonIndex(self.fieldChannel+1, self.fieldRow),
                        field:getButtonIndex(self.fieldChannel-1, self.fieldRow),
                        field:getButtonIndex(self.fieldChannel, self.fieldRow+1),
                        field:getButtonIndex(self.fieldChannel, self.fieldRow-1)}

                    if(field.selectedSquare.x == self.fieldChannel and 
                    field.selectedSquare.y == self.fieldRow) then
                        

                        for i=1, 4 do
                            if (validMoves[i]) then
                                field.Buttons[validMoves[i] ]:setUse("select", false, false, 
                                {r=1,g=1,b=1}, {r=1,g=1,b=1})
                            end
                        end


                        field.selectedSquare.x = nil
                        field.selectedSquare.y = nil


                    elseif(field.selectedSquare.x ~= nil and 
                    field.selectedSquare.y ~= nil) then
                        print("invalid button action")
                    else
                        
                        field.selectedSquare.x = self.fieldChannel
                        field.selectedSquare.y = self.fieldRow

                        for i=1, 4 do
                            if (validMoves[i]) then
                                field.Buttons[validMoves[i] ]:setUse("move", true, true, 
                                {r=0.5,g=0,b=0}, {r=0.5,g=0,b=0})
                            end
                        end



                    
                    end--]]
                
                    
                end,
                deselect = function(self)

                end,
                setUse = function(self, F_use, active, visable, rgb, rgb_org)
                   

                    if (F_use == "deselect")then
                        self.use = self.deselect
                    elseif (F_use == "select") then
                        self.use = self.select
                    else
                        print("+ERROR: Trying to set a button in field to an invalid action")
                        return false
                    end
                    self.active = active
                    self.visable = visable

                    self.r = rgb.r or self.r
                    self.g = rgb.g or self.g
                    self.b = rgb.b or self.b

                    self.r_org = rgb_org.r_org or self.r_org
                    self.g_org = rgb_org.g_org or self.g_org
                    self.b_org = rgb_org.b_org or self.b_org


                    --print("__end button:setUse()")
                end
            })
        end
    end

    o:addCard(Creature:new({switchTurn = function(self) end, health = 10}),o.player.x, o.player.y)


    return o
end

function Field:enableButtons(button_arr, fieldUse)
    for i, btn in pairs(button_arr) do
        local int_btnIndex = self:getButtonIndex(self.player.x + btn.x, self.player.y + btn.y)
        if (int_btnIndex) then
            self.Buttons[int_btnIndex].use = fieldUse
            
            self.Buttons[int_btnIndex].active = true
            self.Buttons[int_btnIndex].visable = true
            self.Buttons[int_btnIndex].choises = button_arr
        end
    end
end

function Field:disableButtons(button_arr)
    for i, btn in pairs(button_arr) do
        local int_btnIndex = self:getButtonIndex(self.player.x + btn.x, self.player.y + btn.y)
        if (int_btnIndex) then
            self.Buttons[int_btnIndex].use = nil
            
            self.Buttons[int_btnIndex].active = false
            self.Buttons[int_btnIndex].visable = false
        end
    end
end

function Field:visableButtons(button_arr, visable)
    if (visable == nil) then visable = true end --ska toggla visable
    if (button_arr == nil) then print("+ERROR: button_arr = nil") end 

    for i, btn in pairs(button_arr) do
        self.Buttons[self:getButtonIndex(btn.x + self.player.x, btn.y + self.player.y)].visable = visable
    end
end

function Field:addCard(card, channel, row)

    --print("__start Field:addCard()")

    if (card == nil) then
        print("-ERROR: Cannot add card to field: card = nil")
        print("-channel: " .. channel .. "\n-row: " .. row)
        --print("__end Field:addCard()")
        return false
    end
    
    self.nrOfCards[channel] = self.nrOfCards[channel] + 1
    local row = row or self.nrOfCards[channel]
    --local row = row or 5
    
    -- print("|Card added\n|cost: " .. card.cost)
    -- print("|channel: " .. channel .. "\n|row: " .. row)


    self.Cards[channel][row] = card

    local I = self:getButtonIndex(channel, row)

    self.Buttons[I].active = false
    self.Buttons[I].visable = false
    self.Buttons[I].use = self.Buttons[I].select



    self.Buttons[I].r_org = 1
    self.Buttons[I].g_org = 1
    self.Buttons[I].b_org = 1
    self.Buttons[I].r = 1
    self.Buttons[I].g = 1
    self.Buttons[I].b = 1
    
    --print("__end of addCard")

    return true

end

function Field:getButtonIndex(channel, row)

    local result = channel * self.nrOfRows - (self.nrOfRows - row)
    if (result < 1 or result > self.nrOfChannels*self.nrOfRows)then
        result = false
    end
    return result
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

    

    for i=1, self.nrOfChannels do
        for j=1, self.nrOfRows do
            if (self.Cards[i]) then
                lg.setColor(0.2, 0.2, 1)
                lg.rectangle("fill", W_WIDTH*0.8 + i*25 -3, W_HEIGHT*0.4 - j*25 -3, 20, 20)
                lg.rectangle("fill", 150 * i, 700 - 100 * j, 80, 80)
                if (self.Cards[i][j]) then
                    lg.setColor(1, 1, 1)
                    lg.print(self.Cards[i][j].cost, W_WIDTH*0.8 + i*25, W_HEIGHT*0.4 - j*25, 0, 1)
                    
                end
            end
        end
    end

    self:drawButtons()

    for i, row in pairs(self.Cards) do 
        for j, card in pairs(row) do 
            
            card:draw(150 * i, 700 - 100 * j, 20)

        end
    end

end