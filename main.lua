require "game"

function love.load()

    screen = {}
    screen.x = 1600
    screen.y = 1000

    love.window.setMode(screen.x, screen.y)

    lg = love.graphics
    lm = love.mouse

    Game = Game:new()


end

function love.update(dt)

    Game:update(dt)

end

function love.draw()

    Game:draw()

end