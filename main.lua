require("GameController")
require("EnemyController")
require("Player")
require("Gui")
require("MathExt")

function love.load(arg)
  --love.window.setMode(gameController.width, gameController.height, {})
  enemyController:init(50, 16)
  enemyController:spawnEnemies()
end

function love.update(dt)
  if gameController.paused then
    -- do nothing probably, maybe some gui
  elseif gameController.gameOver then
    gui.gameOver.enabled = true
  else
    if player.cooldown > 0 then
      player.cooldown = player.cooldown-1
    end

    handlePlayerInput(dt)
    clampPlayerPosition()
    updateBulletPositions(dt)
    enemyController:moveEnemies(dt)
    enemyController:checkCollisions()
  end
end

function love.draw()

  drawBullets()
  player.draw()
  enemyController:drawEnemies()
  gui:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "x" or key == "escape" then
      gameController.paused = not gameController.paused
    end

    if key == "return" and gameController.gameOver then
      gameController.reset(false)
      gameController:newGame()
    end
end

function drawBullets()
  love.graphics.setColor(255, 255, 0)
  for _,bullet in pairs(player.bullets) do
    love.graphics.circle("fill", bullet.x, bullet.y, bullet.radius)
  end
end

function clampPlayerPosition()
  player.x = math.Clamp(player.x, 0, gameController.width - player.width)
end

function handlePlayerInput(dt)
  if love.keyboard.isDown("right", "d") and player.x ~= (gameController.width - player.width) then
    player.speed = 150 * dt
  elseif love.keyboard.isDown("left", "a") and player.x ~= 0 then
    player.speed = -150 * dt
  else
    player.speed = math.Lerp(player.speed, 0, player.drag * dt)
  end

  --player.speed = math.Clamp(player.speed, -player.maxSpeed, player.maxSpeed)

  player:move()

  if love.keyboard.isDown("space", "up") and #player.bullets < 3 then
    player.fire()
  end
end

function updateBulletPositions(dt)
  for i, v in ipairs(player.bullets) do
    v.y = v.y - (v.speed * dt)
    if v.y < 10 then
      table.remove(player.bullets, i)
    end
  end
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
