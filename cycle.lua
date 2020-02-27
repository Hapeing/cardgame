require "zone"

Cycle = Zone:new()

function Cycle:new()

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    return o
end