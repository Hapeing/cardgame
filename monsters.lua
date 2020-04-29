Monsters = {}

function Monsters:getPawn(field)
    local pawn = {
        cost = 1, 
        ai = function(self)
            if (self.arr_grid.x-1 == field.player.x and self.arr_grid.y-1 == field.player.y or
            self.arr_grid.x+1 == field.player.x and self.arr_grid.y-1 == field.player.y) then
                field.Cards[field.player.x][field.player.y]:takeDamage(1)
            else
                field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x, self.arr_grid.y-1)
            end
        end}

    return pawn
end

function Monsters:getBishop(field)

    local bishop = {cost = 2, --bishop
    ai = function(self)
        if (self.arr_grid.x-1 == field.player.x and self.arr_grid.y-1 == field.player.y or
        self.arr_grid.x+1 == field.player.x and self.arr_grid.y-1 == field.player.y or
        self.arr_grid.x-1 == field.player.x and self.arr_grid.y+1 == field.player.y or
        self.arr_grid.x+1 == field.player.x and self.arr_grid.y+1 == field.player.y) then
            field.Cards[field.player.x][field.player.y]:takeDamage(1)
        elseif (self.arr_grid.x <= field.player.x and self.arr_grid.y <= field.player.y) then
            field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x +1, self.arr_grid.y+1)
        
        elseif (self.arr_grid.x >= field.player.x and self.arr_grid.y >= field.player.y) then
            field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x -1, self.arr_grid.y-1)
        
        elseif (self.arr_grid.x >= field.player.x and self.arr_grid.y <= field.player.y) then
            field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x -1, self.arr_grid.y+1)

        elseif (self.arr_grid.x <= field.player.x and self.arr_grid.y >= field.player.y) then
            field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x +1, self.arr_grid.y-1)
        end
    end}

end