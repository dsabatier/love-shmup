require("Class/Bullet")
require("Class/BulletManager")
require("Class/Enemy")
require("Class/Player")
Color = require("Class/Color")

local Game = {}

function Game:enter()
  Settings = Settings()
  player = Player(Vector(25, 15), Color(255, 0, 0), Vector(Settings.window.width / 2, Settings.window.height-30))
  playerBulletManager = BulletManager()
end

function Game:update(dt)
  playerBulletManager:update(dt)
  player:update(playerInput(), dt)

end

function Game:draw()
  if Settings.debug == true then
    love.graphics.setColor(255, 255, 255, 125)
    love.graphics.rectangle("line", 0, Settings.window.height-200, Settings.window.width, 200)
  end

  playerBulletManager:draw()
  player:draw()
end

function love.keypressed(key, scancode, isrepeat)

end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function playerInput()
  local input = {}
  input.direction = Vector(0, 0)
  input.firing = love.keyboard.isDown('space')

  if love.keyboard.isDown('left') then
    input.direction.x = -1
  elseif love.keyboard.isDown('right') then
    input.direction.x =  1
  end

  if love.keyboard.isDown('up') then
    input.direction.y = -1
  elseif love.keyboard.isDown('down') then
    input.direction.y =  1
  end

  return input
end

return Game