require "game"


function love.load()

    --screen = {}
    --screen.x = 1600
    --screen.y = 1000

    --love.window.setMode(screen.x, screen.y)

    lg = love.graphics
    lm = love.mouse

    love.window.setFullscreen(true, "desktop")

    W_WIDTH, W_HEIGHT, FLAGS = love.window.getMode()

    
    print(W_WIDTH .." ".. W_HEIGHT)

    Game = Game:new()


end

function love.update(dt)

    -- if love.keyboard.isDown("escape") then
    --     love.window.close()
    --     love.event.quit(0)
    -- end

    Game:update(dt)

end

function love.keypressed(key, scancode, isrepeat)
    if (key == "escape") then
        love.window.close()
        love.event.quit(0)
    end


    --temp code
    if (key == '1' or key == '2' or key == '3' or key == '4' or key == '5') then
        Game.ZoneHandler.Zone_Hands[1].selectedChannel = tonumber(key)
    end

end

function love.quit()
    print("Bye!")
end

function love.draw()

    Game:draw()

end