MainMenu = {} -- previously: Gamestate.new()

function MainMenu:draw()
    love.graphics.print("Press Enter to continue", 10, 10)
end

function MainMenu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(Game)
    end
end
