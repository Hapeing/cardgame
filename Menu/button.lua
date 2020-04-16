Button = {}

function Button:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.x = o.x or 0
    o.y = o.y or 0
    o.hight = o.hight or 64
    o.width = o.width or 64

    --original colors
    o.r_org = o.r_org or 1
    o.g_org = o.g_org or 1
    o.b_org = o.b_org or 1

    --current colors
    o.r = o.r or o.r_org
    o.g = o.g or o.g_org
    o.b = o.b or o.b_org

    --pressed colors
    o.r_prs = o.r_prs or 0
    o.g_prs = o.g_prs or 1
    o.b_prs = o.b_prs or 0

    if (o.visable == nil) then
        o.visable = true
    end
    if (o.active == nil) then
        o.active = true
    end
    
    
    return o
end

function Button:pressed(dt)
    self.r = self.r_prs
    self.g = self.g_prs
    self.b = self.b_prs
end

function Button:released()
    self.r = self.r_org
    self.g = self.g_org
    self.b = self.b_org
end

function Button:draw(scale)

    if (self.visable) then
        scale = scale or 1
        --one color when inactive
        --one color when hover
        --one color when hover and mouse pressed
        --inactive when not hover and mouse pressed

        lg.setColor(self.r, self.g, self.b)
        lg.rectangle("fill", self.x, self.y, self.width * scale, self.hight * scale)
    end
end