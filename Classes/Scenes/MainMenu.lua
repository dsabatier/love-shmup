MainMenu = Object:extend()

function MainMenu:new()
    print("entered main menu")
end

function MainMenu:update(dt)
    if input:pressed('return') then goToScene('Game') end 
end

function MainMenu:draw()
    love.graphics.print("Main Menu", 10, 10)
    love.graphics.print("Press Enter To Continue", 10, 50)
end