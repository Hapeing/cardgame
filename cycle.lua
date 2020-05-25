require "zone"

Cycle = Zone:new()

function Cycle:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.int_nrOfChannels = o.int_nrOfChannels or 8

    for i = 1, o.int_nrOfChannels do
        o:addButton({x=100 * i, y=700})
    end
        


    return o
end