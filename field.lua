require "zone"
require "monsters"

Field = Zone:new()

function Field:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    o.nrOfRows = o.nrOfRows or 30

    o.nrOfChannels = o.nrOfChannels or  8

    o.nrOfCards = {}--nr or cards per channel
    o.selectedSquare = {x=nil, y=nil}
    o.player = {x=3, y=1}

    --for drawing
    o.pos_firstSquare = {}
    o.pos_firstSquare.x = W_WIDTH*0.2
    o.pos_firstSquare.y = W_HEIGHT*0.74
    o.num_distanceSquare = 10
    o.num_widthSquare = 100

    local img_default = lg.newImage("s1.png")
    local img_attack = lg.newImage("GameToken_8_1.png")
    local img_move = lg.newImage("GameToken_2_1.png")

    for i = 1, o.nrOfChannels do
        o.nrOfCards[i] = 0
        o.Cards[i] = {}--each array is its own channel from left to right
        for j = 1, o.nrOfRows do
            o:addButton({
                img_current = img_default,
                img_atk = img_attack,
                img_mov = img_move,
                x = o.pos_firstSquare.x + (o.num_widthSquare + o.num_distanceSquare) * i,
                y = o.pos_firstSquare.y - (o.num_widthSquare + o.num_distanceSquare) * j,
                fieldChannel = i,
                fieldRow = j,
                active = false,
                visable = false,
                use = nil,
                move = function(self, field, I)

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
                    --local field = zHandler.Zone_Fields[1]

                    --local I = self.fieldChannel*field.nrOfRows-(field.nrOfRows-self.fieldRow)

                    self:use(zHandler)--, I)

                    self.r = self.r_org
                    self.g = self.g_org
                    self.b = self.b_org
                end,
                select = function(self, zHandler, I)
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

    o.img_square = lg.newImage("square.png")



    o:addButton({x= W_WIDTH * 0.2, y=W_HEIGHT * 0.75,
        hight=128, width=128,
        released = function(self)
            for i = 1, o.nrOfChannels do
                for j = 1, o.nrOfRows do
                    if (o.Cards[i][j]) then
                        if (o.Cards[i][j].boo_hasSwitched == false) then
                            o.Cards[i][j]:switchTurn(o)
                            
                        end
                    end
                end
            end

            for i = 1, o.nrOfChannels do
                for j = 1, o.nrOfRows do
                    if (o.Cards[i][j]) then
                        o.Cards[i][j].boo_hasSwitched = false
                    end
                end
            end

            for i = 1, Game.ZoneHandler.Zone_Hands[1].nrOfCards do
                Game.ZoneHandler.Zone_Hands[1].Cards[i]:switchTurn(Game.ZoneHandler)
                --print(boost.cooling)

            end
            self.r = self.r_org
            self.g = self.g_org
            self.b = self.b_org
            
            local boo_winCheck = true
            for i, nr in pairs(o.nrOfCards) do
                if (nr > 1) then
                    boo_winCheck = false
                end
            end

            if (boo_winCheck == true) then
                Game.win = true
                o:disableButtons("all")
            elseif (Game.int_health < 1) then
                o:disableButtons("all")
            end

        end
    })


    -- adding the player
    o:addCard(Creature:new({switchTurn = function(self) end,
        takeDamage = function(self, int_damage) 
            Game.int_health = Game.int_health - int_damage
            return Game.int_health 
        end,
        health = 0
    }),
        o.player)


    


    o:addCard(Creature:new(Monsters:getBishop(o)), 6, 23)


    o:addCard(Creature:new(Monsters:getPawn(o)), 1, 8)
    o:addCard(Creature:new(Monsters:getPawn(o)), 2, 9)
    o:addCard(Creature:new(Monsters:getPawn(o)), 4, 10)
    o:addCard(Creature:new(Monsters:getPawn(o)), 3, 11)
    o:addCard(Creature:new(Monsters:getPawn(o)), 5, 12)
    o:addCard(Creature:new(Monsters:getPawn(o)), 6, 15)
    o:addCard(Creature:new(Monsters:getPawn(o)), 7, 15)
    o:addCard(Creature:new(Monsters:getPawn(o)), 8, 15)
    o:addCard(Creature:new(Monsters:getPawn(o)), 1, 18)
    o:addCard(Creature:new(Monsters:getPawn(o)), 2, 20)
    o:addCard(Creature:new(Monsters:getPawn(o)), 3, 23)
    o:addCard(Creature:new(Monsters:getPawn(o)), 4, 24)
    o:addCard(Creature:new(Monsters:getPawn(o)), 6, 24)
    o:addCard(Creature:new(Monsters:getPawn(o)), 7, 25)




    o:addCard(Creature:new(Monsters:getBishop(o)), 1, 13)
    o:addCard(Creature:new(Monsters:getBishop(o)), 3, 14)
    o:addCard(Creature:new(Monsters:getBishop(o)), 2, 14)
    o:addCard(Creature:new(Monsters:getBishop(o)), 4, 17)
    o:addCard(Creature:new(Monsters:getBishop(o)), 6, 17)
    o:addCard(Creature:new(Monsters:getBishop(o)), 5, 21)
    o:addCard(Creature:new(Monsters:getBishop(o)), 7, 21)
    o:addCard(Creature:new(Monsters:getBishop(o)), 8, 26)



    -- o:addCard(Creature:new(bishop), 6, 8)



    return o
end

function Field:move(pos_from, pos_to)

    if (pos_from.x == nil) then
        pos_from.x = pos_from[1]
    end
    if (pos_from.y == nil) then
        pos_from.y = pos_from[2]
    end
    if (pos_to.x == nil) then
        pos_to.x = pos_to[1]
    end
    if (pos_to.y == nil) then
        pos_to.y = pos_to[2]
    end

    --might be a bug here
    --check if target square is valid
    if (pos_to.x < 1 or pos_to.y > self.nrOfChannels or self.Cards[pos_to.x][pos_to.y] ~= nil) then
        return false
    end

    local crd = self:removeCard(pos_from)

    self:addCard(crd, pos_to)

    return true
end

function Field:enableButtons(button_arr, fieldUse, img_new)--img_new is optional
    local arr_result = {}
    if (button_arr == "all")then
        for i, btn in pairs(self.Buttons) do
                btn.use = fieldUse
                btn.active = true
                btn.visable = true
                btn.choises = self.Buttons
        end
    else
        for i, btn in pairs(button_arr) do
            local int_btnIndex = self:getButtonIndex(self.player.x + btn.x, self.player.y + btn.y)
            if (int_btnIndex) then

                if(img_new ~= nil) then
                    self.Buttons[int_btnIndex]:changeImgString(img_new)

                    -- if (self.Cards[self.player.x + btn.x][self.player.y + btn.y] ~= nil) then

                    --     if (img_new == "atk") then
                    --         self.Buttons[int_btnIndex].r_org = self.Buttons[int_btnIndex].r_hov
                    --         self.Buttons[int_btnIndex].g_org = self.Buttons[int_btnIndex].g_hov
                    --         self.Buttons[int_btnIndex].b_org = self.Buttons[int_btnIndex].b_hov
                    --     end
                    -- else
                    --     if (img_new == "mov") then
                    --         self.Buttons[int_btnIndex].r_org = self.Buttons[int_btnIndex].r_hov
                    --         self.Buttons[int_btnIndex].g_org = self.Buttons[int_btnIndex].g_hov
                    --         self.Buttons[int_btnIndex].b_org = self.Buttons[int_btnIndex].b_hov
                    --     end
                    -- end

                end
                self.Buttons[int_btnIndex].use = fieldUse

                self.Buttons[int_btnIndex].active = true
                self.Buttons[int_btnIndex].visable = true
                self.Buttons[int_btnIndex].choises = button_arr

                arr_result[int_btnIndex] = self.Buttons[int_btnIndex]
            end
        end
    end
    return arr_result
end

function Field:disableButtons(button_arr)
    if (button_arr == "all") then
        for i, btn in pairs(self.Buttons) do
            btn.use = nil

            btn.active = false
            btn.visable = false
        end
    else
        for i, btn in pairs(button_arr) do
            local int_btnIndex = self:getButtonIndex(self.player.x + btn.x, self.player.y + btn.y)
            if (int_btnIndex) then
                self.Buttons[int_btnIndex].use = nil

                self.Buttons[int_btnIndex].active = false
                self.Buttons[int_btnIndex].visable = false
            end
        end
    end
end

function Field:visableButtons(button_arr, visable)
    if (visable == nil) then visable = true end
    if (button_arr == nil) then print("+ERROR: button_arr = nil") end

    for i, btn in pairs(button_arr) do
        self.Buttons[self:getButtonIndex(btn.x + self.player.x, btn.y + self.player.y)].visable = visable
    end
end

function Field:addCard(card, channel, row) --channel can be pos_

    --print("__start Field:addCard()")



    if (type(channel) == "table") then
        row = channel.y
        channel = channel.x
    end

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

    -- card.arr_grid = {x=channel, y=row}

    self.Cards[channel][row] = card
    self.Cards[channel][row].arr_grid = {x=channel, y=row}

    local I = self:getButtonIndex(channel, row)
    
    if (I ~= false) then

        self.Buttons[I].active = false
        self.Buttons[I].visable = false
        self.Buttons[I].use = self.Buttons[I].select



        self.Buttons[I].r_org = 1
        self.Buttons[I].g_org = 1
        self.Buttons[I].b_org = 1
        self.Buttons[I].r = 1
        self.Buttons[I].g = 1
        self.Buttons[I].b = 1
    
    end
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

    if (type(channel) == "table") then
        row = channel.y
        channel = channel.x
    end

    self.nrOfCards[channel] = self.nrOfCards[channel] - 1

    local card = self.Cards[channel][row]

    self.Cards[channel][row] = nil

    return card

end

function Field:draw()
    -- print("#####")


    for i=1, self.nrOfChannels do
        for j=1, self.nrOfRows do
            if (self.Cards[i]) then

                lg.setColor(0.2, 0.2, 1)
                lg.rectangle("fill", W_WIDTH*0.8 + i*25 -3, W_HEIGHT*0.9 - j*25 -3, 20, 20) --debug field
                --lg.rectangle("fill", 100 * i, 700 - 100 * j, 80, 80)
                lg.setColor(1,1,1,255)
                if (j <= 7) then
                    lg.draw(self.img_square, self.pos_firstSquare.x + (self.num_widthSquare + self.num_distanceSquare) * i, self.pos_firstSquare.y - (self.num_widthSquare + self.num_distanceSquare) * j)
                end

                if (j == 7) then --debug line
                    lg.setColor(1, 1, 1)
                    lg.rectangle("fill", W_WIDTH*0.8 -6, W_HEIGHT*0.9 - j*25 -6, 250, 5)
                end

                if (self.Cards[i][j]) then --debug cards

                    -- print(i)
                    -- print(j)
                    -- print("-----")
                    self.Cards[i][j]:draw(self.pos_firstSquare.x + (self.num_widthSquare + self.num_distanceSquare) * i, self.pos_firstSquare.y - (self.num_widthSquare + self.num_distanceSquare) * j, 20)

                    lg.setColor(1, 1, 1)
                    lg.print(self.Cards[i][j].cost, W_WIDTH*0.8 + i*25, W_HEIGHT*0.9 - j*25, 0, 1)


                end
            end
        end
    end

    self:drawButtons(0.05)

    for i, row in pairs(self.Cards) do
        for j, card in pairs(row) do

            --card:draw(self.pos_firstSquare.x + 100 * i, self.pos_firstSquare.y - 100 * j, 20)
            -- lg.print(self.Cards[i][j].arr_grid.x .. " " .. self.Cards[i][j].arr_grid.y, 100 * i, 700 - 100 * j, 0, 1)

        end
    end

    lg.setColor(1, 1, 1)
    if (Game.win == true) then
        lg.print("you win", W_WIDTH*0.4, W_HEIGHT*0.4, 0, 10)
    elseif (Game.int_health < 1) then
        lg.print("you lose", W_WIDTH*0.4, W_HEIGHT*0.4, 0, 10)
    end

end