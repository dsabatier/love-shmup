Class = require("lib/hump.class")
Vector = require("lib/hump.vector")
Math = require("Class/Math")
Gamestate = require("lib/hump.gamestate")


require("Class/Settings")

function love.load()
    --love.graphics.setDefaultFilter('nearest', 'nearest')
    --love.graphics.setFont(love.graphics.newFont('fonts/font.ttf', 8))

    States = {}
    States.Game = require("GameStates/Game")
    States.MainMenu = require("GameStates/MainMenu")

    Gamestate.registerEvents()
    Gamestate.switch(States.MainMenu)
end