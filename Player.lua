player = {}
player.width = 30
player.height = 20
player.x = gameController.width / 2
player.y = gameController.height - player.height - 10
player.speed = 0
player.acceleration = 5
player.maxSpeed = 5
player.drag = 5
player.bullets = {}
player.cooldown = 0
player.score = 0
player.velocity = {}
player.velocity.x = 0
player.velocity.y = 0

function player:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

player.fire = function()
  if player.cooldown <= 0 then
    player.cooldown = 20
    bullet = {}
    bullet.x = player.x + player.width * 0.5
    bullet.y = player.y
    bullet.speed = 300
    bullet.radius = 7
    table.insert(player.bullets, bullet)
  end
end

function player:move()
  self.x = self.x + self.speed
end
