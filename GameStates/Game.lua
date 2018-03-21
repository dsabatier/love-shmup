require("Class/BulletManager")
require("Class/EnemyManager")
require("Class/Player")


local Game = {}

function Game:enter()
  player = Player()
  playerBulletManager = BulletManager()
  enemyBulletManager = BulletManager()
  enemyManager = EnemyManager()
  enemyManager:spawnEnemy(Vector(Settings.window.width * 0.5 - 25, 100), Vector(30, 30), Colors.green)
end

function Game:update(dt)
  -- these should probably all go into an Entities class? idk what I'm doing send help
  playerBulletManager:update(dt)
  enemyManager:update(dt)
  player:update(playerInput(), dt) --TODO: create static input class, dont pass this in.
end

function Game:draw()
  love.graphics.setColor(0, 0, 0, 0)
  love.graphics.rectangle("fill", 0, 0, Settings.window.width, Settings.window.height)

  if Settings.debug == true then
    love.graphics.setColor(255, 255, 255, 125)
    love.graphics.rectangle("line", 0, Settings.window.height-200, Settings.window.width, 200)
  end

  playerBulletManager:draw()
  enemyManager:draw()
  player:draw()
end

function love.keypressed(key, scancode, isrepeat)
  -- watch for pause
end

function playerInput()
  local input = {}
  input.direction = Vector(0, 0)
  input.firing = love.keyboard.isDown('space')

  if love.keyboard.isDown('left') or love.keyboard.isDown("a") then
    input.direction.x = -1
  elseif love.keyboard.isDown('right') or love.keyboard.isDown("d") then
    input.direction.x =  1
  end

  if love.keyboard.isDown('up') or love.keyboard.isDown("w") then
    input.direction.y = -1
  elseif love.keyboard.isDown('down') or love.keyboard.isDown("s") then
    input.direction.y =  1
  end

  return input
end

return Game