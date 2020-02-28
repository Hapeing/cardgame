require "Menu/button"

Menu = {}

function Menu:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    o.Buttons = {}

    o.mousePressed = false

    I_btnPressed = 0 --index of the pressed button

    --o:addButton(0, 0, 64, 64)
    --o:addButton(64, 64, 64, 64)

    return o
end

function Menu:update(Game, dt)

    if (love.mouse.isDown(1) and not (self.mousePressed)) then
        
        

        for i, btn in ipairs(self.Buttons) do 
            print(self.Buttons[1].x)
            if (btn.x < love.mouse.getX() and
                btn.y < love.mouse.getY() and
                btn.x + btn.width > love.mouse.getX() and
                btn.y + btn.hight > love.mouse.getY()) then  --if mouse is pressed on a button then

                    
                I_btnPressed = i
                print("Pressed: " .. I_btnPressed)
                btn:pressed(dt)
                
                
            end
        end

        self.mousePressed = true

    elseif ((self.mousePressed) and not love.mouse.isDown(1) ) then

        if (I_btnPressed ~= 0) then --if mouse is released and earlier pressed a button then
            if (self.Buttons[I_btnPressed].x < love.mouse.getX() and
            self.Buttons[I_btnPressed].y < love.mouse.getY() and
            self.Buttons[I_btnPressed].x + self.Buttons[I_btnPressed].width > love.mouse.getX() and
            self.Buttons[I_btnPressed].y + self.Buttons[I_btnPressed].hight > love.mouse.getY()) then --if the mouse is still on the pressed button then
                
                
                print("Release: " .. I_btnPressed)
                self.Buttons[I_btnPressed]:released()
            end
            I_btnPressed = 0
        end
        self.mousePressed = false
    end

end

function Menu:addButton(x, y, width, hight)-- cannot add more than one

    local o = Button:new(o)

    o.x = x
    o.y = y
    o.width = width
    o.hight = hight

    table.insert(self.Buttons, o)

end


function Menu:draw()

    for i, btn in ipairs(self.Buttons) do 
        btn:draw()
    end


end