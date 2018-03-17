Game = {}

function Game:enter()
  Settings = Settings()
  newEnemy = Enemy(10, {r = 255, g = 255, b = 255}, Vector(0, 0))
  player = Player(25, 15, Color(255, 0, 0), Vector(Settings.window.width / 2, Settings.window.height-30))
  bulletManager = BulletManager()
end

function Game:update(dt)
  local input = playerInput()
  player:move(input, dt)
  bulletManager:update(dt)
end

function Game:draw()
  if Settings.debug == true then
    love.graphics.setColor(255, 255, 255, 125)
    love.graphics.rectangle("line", 0, Settings.window.height-200, Settings.window.width, 200)
  end
  newEnemy:draw()
  player:draw()
  --bullet:draw()
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
  local input = Vector(0, 0)
  if love.keyboard.isDown('left') then
    input.x = -1
  elseif love.keyboard.isDown('right') then
    input.x =  1
  end

  if love.keyboard.isDown('up') then
    input.y = -1
  elseif love.keyboard.isDown('down') then
    input.y =  1
  end

  return input
end
