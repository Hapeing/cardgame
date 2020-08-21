require "field"
require "hand"
require "cycle"
require "deck"
require "grave"

ZoneHandler = {}

function ZoneHandler:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    o.Zone_Cycles = Cycle:new()
    o.Zone_Graves = Grave:new()
    o.Zone_Decks = {}
    o.Zone_Decks[1] = Deck:new()
    o.Zone_Fields = {}
    o.Zone_Fields[1] = Field:new()
    o.Zone_Hands = {}    
    o.Zone_Hands[1] = Hand:new()



    --fill the deck with boosts aka abilities
    for i = 1, 30 do
        o.Zone_Decks[1]:addCard(Boost:new({power = i, cost = i}))
    end


    --1st ability ############################################################################################################################################################
    o.Zone_Decks[1].Cards[1].name = "Move"
    o.Zone_Decks[1].Cards[1].choises = {{x=-1, y=0},{x=1, y=0},{x=0, y=-1},{x=0, y=1}}
    o.Zone_Decks[1].Cards[1].preExecute = function(self)
        self.str_type = "mov"
    end
    o.Zone_Decks[1].Cards[1].execute = function(self)-- not used???
        o.Zone_Fields[1]:enableButtons(self.choises, self.fieldUse)
    end
    o.Zone_Decks[1].Cards[1].fieldUse = function(self)--this function is to be set in a fieldButton
        local field = o.Zone_Fields[1]

        if (field.Cards[self.fieldChannel][self.fieldRow] == nil) then

            field:addCard(field:removeCard(field.player.x, field.player.y),self.fieldChannel, self.fieldRow)
            
            --o.Zone_Fields[1]:disableButtons(self.choises)
            o.Zone_Hands[1].Cards[self.int_callback]:postExecute(o)
            field.player.x = self.fieldChannel
            field.player.y = self.fieldRow
        else
            print("invalid target")
            --o.Zone_Hands[1].selectedCard = 0
        end
        --o.Zone_Hands[1].selectedCard = 0
    end

    --2nd ability ############################################################################################################################################################
    o.Zone_Decks[1].Cards[2].name = "Stab"
    o.Zone_Decks[1].Cards[2].preExecute = function(self)
        self.str_type = "atk"
    end
    o.Zone_Decks[1].Cards[2].choises = {{x=-1, y=1 }, {x=0, y=1 },{x=1, y=1 },
                                        {x=-1, y=0 },--[[player]] {x=1, y=0 },
                                        {x=-1, y=-1}, {x=0, y=-1},{x=1, y=-1}}
    o.Zone_Decks[1].Cards[2].execute = function(self)
        o.Zone_Fields[1]:enableButtons(self.choises, self.fieldUse)

    end
    o.Zone_Decks[1].Cards[2].fieldUse = function(self)--this function is to be set in a fieldButton
        local field = o.Zone_Fields[1]
        --field:addCard(field:removeCard(field.player.x, field.player.y),self.fieldChannel, self.fieldRow)
        
        --o.Zone_Fields[1]:disableButtons(self.choises)
        --o.Zone_Hands[1].selectedCard = 0
        if (field.Cards[self.fieldChannel][self.fieldRow]) then
            field.Cards[self.fieldChannel][self.fieldRow].health = field.Cards[self.fieldChannel][self.fieldRow].health -1

            o.Zone_Hands[1].Cards[self.int_callback]:postExecute(o)
        else
            print("invalid target")
            --o.Zone_Hands[1].selectedCard = 0
        end
        -- self.callback:postExecute(o)
    end


    --3rd ability ############################################################################################################################################################
    o.Zone_Decks[1].Cards[3].name = "Throw"
    o.Zone_Decks[1].Cards[3].preExecute = function(self)
        self.str_type = "atk"
    end
    o.Zone_Decks[1].Cards[3].choises = {{x=-2, y=2 }, {x=-1, y=2 }, {x=0, y=2 }, {x=1, y=2 }, {x=2, y=2 },
                                        {x=-2, y=1 }, --[[__]]      --[[__]]     --[[__]]     {x=2, y=1 },
                                        {x=-2, y=0 }, --[[__]]      --[[player]] --[[__]]     {x=2, y=0 },
                                        {x=-2, y=-1}, --[[__]]      --[[__]]     --[[__]]     {x=2, y=-1},
                                        {x=-2, y=-2}, {x=-1, y=-2}, {x=0, y=-2}, {x=1, y=-2}, {x=2, y=-2}}
    o.Zone_Decks[1].Cards[3].execute = function(self)
        o.Zone_Fields[1]:enableButtons(self.choises, self.fieldUse)

    end
    o.Zone_Decks[1].Cards[3].fieldUse = function(self)--this function is to be set in a fieldButton
        local field = o.Zone_Fields[1]

        
        --o.Zone_Fields[1]:disableButtons(self.choises)
       -- o.Zone_Hands[1].selectedCard = 0
        if (field.Cards[self.fieldChannel][self.fieldRow]) then
            field.Cards[self.fieldChannel][self.fieldRow].health = field.Cards[self.fieldChannel][self.fieldRow].health -1
            o.Zone_Hands[1].Cards[self.int_callback]:postExecute(o)
        else
            print("invalid target")
            --o.Zone_Hands[1].selectedCard = 0
        end
        --    self.callback:postExecute(o)
    end


    --4th ability ############################################################################################################################################################
    o.Zone_Decks[1].Cards[4].name = "Dash"
    o.Zone_Decks[1].Cards[4].preExecute = function(self)
        self.str_type = "mov"
    end
    o.Zone_Decks[1].Cards[4].choises = {{x=0, y=-2},{x=0, y=2}, {x=-2, y=0},{x=2, y=0}}
    o.Zone_Decks[1].Cards[4].execute = function(self)
        o.Zone_Fields[1]:enableButtons(self.choises, self.fieldUse, "Tex_badge_33.png")
        print("here")
    end
    o.Zone_Decks[1].Cards[4].fieldUse = function(self)--this function is to be set in a fieldButton
        local field = o.Zone_Fields[1]
        


        --o.Zone_Fields[1]:disableButtons(self.choises)
        if (field.Cards[self.fieldChannel][self.fieldRow] == nil) then
            field:addCard(field:removeCard(field.player.x, field.player.y),self.fieldChannel, self.fieldRow)

            o.Zone_Hands[1].Cards[self.int_callback]:postExecute(o)
            field.player.x = self.fieldChannel
            field.player.y = self.fieldRow
        else
            print("invalid target")
            --o.Zone_Hands[1].selectedCard = 0
        end
        --o.Zone_Hands[1].selectedCard = 0
        -- self.callback:postExecute(o)
    end


    


    --draw cards to hand
    for i=1, 4 do
        o.Zone_Decks[1].Buttons[1]:released(o)
    end

    return o
end

function ZoneHandler:changeZone(zoneFrom, zoneTo, removeIndex, addIndex)
    
    zoneTo:addCard(zoneFrom:removeCard(removeIndex), addIndex)

end

function ZoneHandler:shuffle()

end

function ZoneHandler:update(game, dt)

    self.Zone_Fields[1]:update(game, dt)
    self.Zone_Graves:update(game, dt)
    self.Zone_Hands[1]:update(game, dt)
    self.Zone_Decks[1]:update(game, dt)
    self.Zone_Cycles:update(game, dt)

end

function ZoneHandler:draw()

    self.Zone_Fields[1]:draw()
    self.Zone_Decks[1]:draw()
    self.Zone_Hands[1]:draw()
    self.Zone_Cycles:draw()
    self.Zone_Graves:draw()

end