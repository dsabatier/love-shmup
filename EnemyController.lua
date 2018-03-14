enemyController = {}

function enemyController:init(startSpeed, numberToSpawn)
  self.enemies = {}
  self.step = 0
  self.direction = 1
  self.numberToSpawn = numberToSpawn
  self.enemySize = 20
  self.startSpeed = startSpeed
  enemyController.speed = startSpeed
  enemyController.enemiesPerRow = 8 --math.ceil((gameController.width - (enemyController.enemySize * 4)) / (enemyController.enemySize*2))
  print(enemyController.enemiesPerRow)
end

function enemyController:spawn(x, y)
  enemy = {}
  enemy.x = x
  enemy.y = y
  enemy.hp = 3
  enemy.size = self.enemySize
  table.insert(self.enemies, enemy)
end

function enemyController:spawnEnemies()
  verticalPadding = 50
  spacing = self.enemySize * 2 -- width + space between
  row = 0
  column = 0
  for i=0,self.numberToSpawn-1 do
    self:spawn((column*spacing), (row * spacing) + verticalPadding) -- left space + enemy + right space
    column = column + 1
    if column > self.enemiesPerRow-1 then
      row = row + 1
      column = 0
    end
  end
end

function enemyController:drawEnemies()
  for _,e in pairs(self.enemies) do
    love.graphics.setColor(0, 255, 120)
    love.graphics.rectangle("fill", e.x, e.y, e.size, e.size)
  end
end

function enemyController:moveEnemies(dt)
  self.step = self.step + (self.speed * dt)
  local moveDown = false
  if self.step > 165 then
    self.step = 0
    self.direction = self.direction * -1
    moveDown = true
  end
  for _,e in pairs(self.enemies) do
    e.x = e.x + self.speed * self.direction * dt
    if moveDown then e.y = e.y + 10 end
    if e.y > (gameController.height - (enemyController.enemySize * 2)) then
      gameController.gameOver = true
      gameController:reset(false)
    end
  end
end

function enemyController:checkCollisions()
  for bulletIndex,b in ipairs(player.bullets) do
    bulletSize = b.radius * 2
    for enemyIndex,e in ipairs(self.enemies) do
      if(CheckCollision(b.x, b.y, bulletSize, bulletSize, e.x, e.y, e.size, e.size)) then
        table.remove(player.bullets, bulletIndex)
        table.remove(enemyController.enemies, enemyIndex)
        player.score = player.score + self.speed
        self.speed = self.speed + 2.5
        if #self.enemies == 0 then
          newSpeed = self.startSpeed + 5
          newAmount = self.numberToSpawn + self.enemiesPerRow
          self:init(newSpeed, newAmount)
          gameController:reset(true)
          self:spawnEnemies()
        end
      end
    end
  end
end
