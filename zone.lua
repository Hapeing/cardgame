require "creature"
require "boost"
require "Menu/button"

Zone = {}

function Zone:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.Cards = {}

    o.Buttons = {}
    o.nrOfCards = 0
    o.I_btnPressed = 0 --index of the pressed button
    

    return o
end

function Zone:addCard(card, i)--return true/false
    
    local i = i or 1--will be able to choose position in array

    self.nrOfCards = self.nrOfCards + 1

    table.insert(self.Cards, card)

    return true
end

function Zone:removeCard(i)--returns card

    local i = i or 1

    self.nrOfCards = self.nrOfCards - 1


    return table.remove(self.Cards, i)

end

function Zone:update(game, dt)--bug: press and hold one button, move to another button on another zone, and release. it triggers the second button

    if (love.mouse.isDown(1) and self.I_btnPressed == 0) then
        
        for i, btn in ipairs(self.Buttons) do 
            if (btn.x < love.mouse.getX() and
                btn.y < love.mouse.getY() and
                btn.x + btn.width > love.mouse.getX() and
                btn.y + btn.hight > love.mouse.getY()) then --if mouse is pressed on a button then

                    
                self.I_btnPressed = i
                print("Pressed: " .. self.I_btnPressed)
                btn:pressed(dt)
                
                
            end
        end

        --Game.mousePressed = true

    elseif (not love.mouse.isDown(1) and self.I_btnPressed ~= 0) then --if mouse is released and earlier pressed a button then
        
        if (self.Buttons[self.I_btnPressed].x < love.mouse.getX() and
        self.Buttons[self.I_btnPressed].y < love.mouse.getY() and
        self.Buttons[self.I_btnPressed].x + self.Buttons[self.I_btnPressed].width > love.mouse.getX() and
        self.Buttons[self.I_btnPressed].y + self.Buttons[self.I_btnPressed].hight > love.mouse.getY()) then --if the mouse is still on the pressed button then
                
                
            --print("Release: " .. self.I_btnPressed)
            self.Buttons[self.I_btnPressed]:released(game.ZoneHandler)
        end
        self.I_btnPressed = 0

    --elseif (self.I_btnPressed == 0) then

        --Game.mousePressed = false
    end

end

function Zone:addButton(o)

    local o = Button:new(o)

    table.insert(self.Buttons, o)

end

function Zone:drawButtons()
    
    for i, btn in ipairs(self.Buttons) do 
        btn:draw()
    end

end

function Zone:draw()

    self:drawButtons()

end