require "game"

L = love


function L.load()

    --screen = {}
    --screen.x = 1600
    --screen.y = 1000

    --L.window.setMode(screen.x, screen.y)

    lg = L.graphics
    lm = L.mouse

    L.window.setFullscreen(true, "desktop")

    W_WIDTH, W_HEIGHT, FLAGS = L.window.getMode()

    
    print(W_WIDTH .." ".. W_HEIGHT)

    Game = Game:new()


end

function L.update(dt)

    -- if L.keyboard.isDown("escape") then
    --     L.window.close()
    --     L.event.quit(0)
    -- end

    Game:update(dt)

end

function L.keypressed(key, scancode, isrepeat)
    if (key == "escape") then
        L.window.close()
        L.event.quit(0)
    end


    --temp code
    -- if (key == '1' or key == '2' or key == '3' or key == '4' or key == '5') then
    --     Game.ZoneHandler.Zone_Hands[1].selectedChannel = tonumber(key)
    -- end

end

function L.quit()
    print("Bye!")
end

function L.draw()

    Game:draw()

end