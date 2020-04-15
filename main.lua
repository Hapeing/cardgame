require "game"

function love.load()

    screen = {}
    screen.x = 1600
    screen.y = 1000

    --love.window.setMode(screen.x, screen.y)

    lg = love.graphics
    lm = love.mouse

    love.window.setFullscreen(true, "desktop")

    Game = Game:new()


end

function love.update(dt)

    if love.keyboard.isDown("escape") then
        love.window.close()
        love.event.quit(0)
    end

    Game:update(dt)

end

function love.quit()
    print("Bye!")
end

function love.draw()

    Game:draw()

end