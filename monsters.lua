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

    local bishop = {
        cost = 2,
        ai = function(self, field)
            local pos_closestEnemy = Monsters:findClosestEnemy(field)
            

            if (self.arr_grid.x-1 == pos_closestEnemy.x and self.arr_grid.y-1 == pos_closestEnemy.y or
            self.arr_grid.x+1 == pos_closestEnemy.x and self.arr_grid.y-1 == pos_closestEnemy.y or
            self.arr_grid.x-1 == pos_closestEnemy.x and self.arr_grid.y+1 == pos_closestEnemy.y or
            self.arr_grid.x+1 == pos_closestEnemy.x and self.arr_grid.y+1 == pos_closestEnemy.y) then
                field.Cards[pos_closestEnemy.x][pos_closestEnemy.y]:takeDamage(1)
            elseif (self.arr_grid.x <= pos_closestEnemy.x and self.arr_grid.y <= pos_closestEnemy.y) then
                --field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x +1, self.arr_grid.y+1)
                self.pos_moveTo.x = self.arr_grid.x +1
                self.pos_moveTo.y = self.arr_grid.y +1
            
            elseif (self.arr_grid.x >= pos_closestEnemy.x and self.arr_grid.y >= pos_closestEnemy.y) then
                --field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x -1, self.arr_grid.y-1)
                self.pos_moveTo.x = self.arr_grid.x -1
                self.pos_moveTo.y = self.arr_grid.y -1
            
            elseif (self.arr_grid.x >= pos_closestEnemy.x and self.arr_grid.y <= pos_closestEnemy.y) then
                --field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x -1, self.arr_grid.y+1)
                self.pos_moveTo.x = self.arr_grid.x -1
                self.pos_moveTo.y = self.arr_grid.y +1
            
            elseif (self.arr_grid.x <= pos_closestEnemy.x and self.arr_grid.y >= pos_closestEnemy.y) then
                --field:addCard(field:removeCard(self.arr_grid.x, self.arr_grid.y), self.arr_grid.x +1, self.arr_grid.y-1)
                self.pos_moveTo.x = self.arr_grid.x +1
                self.pos_moveTo.y = self.arr_grid.y -1
            end
        end
        }
    return bishop
end

function Monsters:getWall()

    local wall = {cost = 0}
    return wall

end

function Monsters:getRook(field)

    local rook = {
        cost = 3,
        int_charge = {max = 2, current = 0},
        ai = function(self)

            if(self.arr_grid.x == field.player.x or self.arr_grid.y == field.player.y)then 


            else
                self.int_charge.current = 0

            end

            
        end
        }
    return rook
end

function Monsters:findClosestEnemy(field)

    local pos_closestEnemy = {x=0, y=0}

    for i, channel in pairs(field.Cards) do
        for j, creature in pairs(field.Cards[i]) do

            if (creature.int_owner ~= 0) then
                if(pos_closestEnemy.x == 0) then--the first enemy to find id the closest
                    pos_closestEnemy = creature.arr_grid
                elseif ((pos_closestEnemy.x^2 + pos_closestEnemy.y^2)^0.5 > (creature.arr_grid.x^2 + creature.arr_grid.y^2)^0.5) then
                    pos_closestEnemy = creature.arr_grid
                end
            end

        end
    end

    return pos_closestEnemy

end