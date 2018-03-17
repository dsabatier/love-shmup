Player = Class {}

function Player:init(size, color, position)
  self.size = size
  self.color = color
  self.position = position
  self.speed = 0
  self.maxSpeed = 250
  self.direction = Vector(0, 0)
  self.acceleration = 5
  self.drag = 10
  self.minFiringCooldown = 0.5
  self.startFiringCooldown = 0.5
  self.firingCooldown = self.startFiringCooldown
  self.cooldownTimer = 0.5
  self.spinupCount = 0
  self.lastFireDirection = 0
  self.spinningUp = false
end

function Player:draw()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
end

function Player:update(input, dt)
  self.cooldownTimer = self.cooldownTimer + dt
  
  player:move(input.direction, dt)

  if input.firing then
    if(self.cooldownTimer > self.firingCooldown) then
      player:fire()

      if player.spinningUp then
        self.firingCooldown = self.firingCooldown - 0.1
        if self.firingCooldown < self.minFiringCooldown then self.firingCooldown = self.minFiringCooldown end
      end

    end
  else
    player.firingCooldown = player.startFiringCooldown
    player.spinupCount = 0
  end

end

function Player:calculateVelocity()
  if self.speed > self.maxSpeed then self.speed = self.maxSpeed end
  if self.speed < 0 then self.speed = 0 end
  self.direction = self.direction:normalized()
  self.velocity = self.direction * self.speed
end

function Player:move(input, dt)
  if input.x ~= 0 or input.y ~= 0 then
    self.speed = lerp(self.speed, self.maxSpeed, self.acceleration * dt)
    if input.x ~= 0 then
      self.direction.x = input.x
    else
      self.direction.x = lerp(self.direction.x, 0, self.drag * dt)
    end
    if input.y ~= 0 then
      self.direction.y = input.y
    else
      self.direction.y = lerp(self.direction.y, 0, self.drag * dt)
    end
  else
    self.speed = lerp(self.speed, 0, self.drag * dt)
  end

  self:calculateVelocity()
  self.position = self.position + self.velocity * dt
  self.position.x = math.clamp(0, self.position.x, Settings.window.width - player.size.x)
  self.position.y = math.clamp(Settings.window.height - 200, self.position.y, Settings.window.height-self.size.y)

end

function Player:fire()
  self.cooldownTimer = 0
  local bulletPosition = {}
  bulletPosition.x = self.position.x + (self.size.x * 0.5) - 2.5 -- minus half the bullet size
  bulletPosition.y = self.position.y

  if self.spinupCount > 10 then self.spinupCount = 10 end

  local fireDirection
  if self.lastFireDirection == -1 then fireDirection = 1 else fireDirection = -1 end

  if(self.spinningUp) then
    self.spinupCount = self.spinupCount + 1
    local randomFactor = math.random(0, 2) * (self.spinupCount * 0.01) * fireDirection
  end

 
  playerBulletManager:spawnBullet(bulletPosition, Vector(randomFactor, 1):normalized(), -250, Vector(5, 5), Color(255, 255, 255))
  self.lastFireDirection = fireDirection

end
