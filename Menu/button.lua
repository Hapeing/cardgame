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

    --hovered colors
    o.r_hov = o.r_hov or 0.5
    o.g_hov = o.g_hov or 0.5
    o.b_hov = o.b_hov or 0.5

    if (o.visable == nil) then
        o.visable = true
    end
    if (o.active == nil) then
        o.active = true
    end

    o.arr_imgScale = {}
    o.arr_imgScale.x = o.arr_imgScale.x or 0.1
    o.arr_imgScale.y = o.arr_imgScale.y or 0.1

    o.num_rotation = o.num_rotation or 0

    if (type(o.img_current) == "string")then
        o.img_current = lg.newImage(o.img_current)
    elseif (o.img_current == nil) then
        o.img_current = lg.newImage("s1.png")
    else
        o.img_current = o.img_current
    end
    o.img_default = o.img_default or o.img_current

    if (type(o.img_atk) == "string")then
        o.img_atk = lg.newImage(o.img_atk)
    elseif (o.img_atk == nil) then
        o.img_atk = lg.newImage("GameToken_8_1.png")
    else
        o.img_atk = o.img_atk
    end

    if (type(o.img_mov) == "string")then
        o.img_mov = lg.newImage(o.img_mov)
    elseif (o.img_mov == nil) then
        o.img_mov = lg.newImage("GameToken_2_1.png")
    else
        o.img_mov = o.img_mov
    end
    
    
    return o
end

function Button:changeImgFromFile(str_fimeName)
    
    self.img_img = lg.newImage(str_fimeName)

end

function Button:changeImgString(str_btnType)

    if (str_btnType == "atk") then
        
        self.img_current = self.img_atk

        return true
    elseif (str_btnType == "mov") then
        self.img_current = self.img_mov

        return true
    end
    
    return false
end

function Button:pressed()
    self.r = self.r_prs
    self.g = self.g_prs
    self.b = self.b_prs
end

function Button:released()
    self.r = self.r_org
    self.g = self.g_org
    self.b = self.b_org
end

function Button:hover()
    self.r = self.r_hov
    self.g = self.g_hov
    self.b = self.b_hov
end

function Button:noHover()
    self.r = self.r_org
    self.g = self.g_org
    self.b = self.b_org
end

function Button:draw(scale)

    if (self.visable) then
        local scale = scale or 1
        --one color when inactive
        --one color when hover
        --one color when hover and mouse pressed
        --inactive when not hover and mouse pressed

        lg.setColor(self.r, self.g, self.b)

        lg.rectangle("fill", self.x, self.y, self.width * scale, self.hight * scale)
        lg.draw(self.img_current, self.x, self.y, self.num_rotation, self.arr_imgScale.x, self.arr_imgScale.y)
    end
end