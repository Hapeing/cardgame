require "zone"

Cycle = Zone:new()

function Cycle:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.int_nrOfChannels = o.int_nrOfChannels or 8

    local arr_int_btn_I = {}

    for i = 1, o.int_nrOfChannels do
        o:addButton({x=100 * i, y=700, int_channel = i})
        -- print(o.Buttons[i].int_channel)
        table.insert(arr_int_btn_I, i, i)
    end
        

    o:setButtons(arr_int_btn_I, false) --set all buttons off

    return o
end

function Cycle:checkButtons(arr_buttons, field)
    local arr_buttons = arr_buttons

    local int_size = 0

    for key, value in pairs(arr_buttons) do
        int_size = int_size + 1
    end

    for i = int_size, 1, -1 do
    


        if (field.Cards[i][1]) then

            table.remove(arr_buttons, i)

        end

    end

    return arr_buttons
end