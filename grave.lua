require "zone"

Grave = Zone:new()

function Grave:new(o)

    local o = o or {}
    setmetatable(o, self)
    self.__index = self


    return o
end