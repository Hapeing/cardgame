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

    if (card == nil) then
        print("-ERROR: Cannot add card to field: card = nil")
        return false

    end

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

    if (L.mouse.isDown(1) and self.I_btnPressed == 0) then

        for i, btn in ipairs(self.Buttons) do
            if (btn.x < L.mouse.getX() and
                btn.y < L.mouse.getY() and
                btn.x + btn.width > L.mouse.getX() and
                btn.y + btn.hight > L.mouse.getY() and
                btn.active) then --if mouse is pressed on a button then


                self.I_btnPressed = i
                --print("Pressed: " .. self.I_btnPressed)
                btn:pressed(dt)


            end
        end

        --Game.mousePressed = true

    elseif (not L.mouse.isDown(1) and self.I_btnPressed ~= 0) then --if mouse is released and earlier pressed a button then

        if (self.Buttons[self.I_btnPressed].x < L.mouse.getX() and
        self.Buttons[self.I_btnPressed].y < L.mouse.getY() and
        self.Buttons[self.I_btnPressed].x + self.Buttons[self.I_btnPressed].width > L.mouse.getX() and
        self.Buttons[self.I_btnPressed].y + self.Buttons[self.I_btnPressed].hight > L.mouse.getY()) then --if the mouse is still on the pressed button then


            --print("Release: " .. self.I_btnPressed)
            self.Buttons[self.I_btnPressed]:released(game.ZoneHandler)
        end
        self.I_btnPressed = 0

    else
        for i, btn in pairs(self.Buttons) do
            if (btn.x < L.mouse.getX() and
                btn.y < L.mouse.getY() and
                btn.x + btn.width > L.mouse.getX() and
                btn.y + btn.hight > L.mouse.getY() and
                btn.active) then
                    btn:hover()
                else
                    btn:noHover()
            end
        end

    end

end

function Zone:setButtons_foo(foo)
    for i, btn in pairs(self.Buttons) do
        btn.foo_use = foo
    end
end


function Zone:setButtons(arr_button, boo_on)
     
    
       boo_on = boo_on or false
       if (arr_button == true or arr_button == false) then
            for i, btn in pairs(self.Buttons) do
               --print("here")
               btn.active = arr_button
               btn.visable = arr_button
            end
       else
           for i, int_btn_I in ipairs(arr_button) do
               if (int_btn_I) then
                -- print(int_btn_I)
                self.Buttons[int_btn_I].active = boo_on
                self.Buttons[int_btn_I].visable = boo_on
               end
           end
       end
    end

function Zone:visableButtons(arr_button, visable)
    if (visable == nil) then visable = true end
    if (arr_button == nil) then print("-ERROR: button_arr = nil") end

    for i, int_btn_I in pairs(arr_button) do
        self.Buttons[int_btn_I].visable = visable
    end
end

function Zone:addButton(o)

    local o = Button:new(o) or o

    table.insert(self.Buttons, o)

end

function Zone:drawButtons(scale)

    for i, btn in ipairs(self.Buttons) do
        btn:draw(scale)
    end

end

function Zone:draw()

    self:drawButtons()

end