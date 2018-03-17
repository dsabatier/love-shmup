Player = Class {}

function Player:init()
  self.size =  Vector(32, 32)
  self.color = Colors.white
  self.position = Vector(Settings.window.width / 2, Settings.window.height-30)
  self.speed = 0
  self.maxSpeed = 250
  self.direction = Vector(0, 0)
  self.acceleration = 5
  self.drag = 10
  self.minFiringCooldown = 0.075
  self.startFiringCooldown = 0.5
  self.firingCooldown = self.startFiringCooldown
  self.cooldownTimer = 0.5
  self.spinupCount = 0
  self.lastFireDirection = 0
  self.spinningUp = true
  self.audio = {}
  self.audio.fire = function()
    local rnd = math.random(1, 3)
    if(rnd == 1) then return love.audio.newSource('Assets/Audio/Shoot1.wav') end
    if(rnd == 2) then return love.audio.newSource('Assets/Audio/Shoot2.wav') end
    return love.audio.newSource('Assets/Audio/Shoot3.wav')
  end
  self.sprites = {}
  self.sprites.normal = love.graphics.newImage("Assets/Art/player.png")
  self.sprites.left = love.graphics.newImage("Assets/Art/playerLeft.png")
  self.sprites.right = love.graphics.newImage("Assets/Art/playerRight.png")
  self.inputDirection = {}
  
end

function Player:draw()
  --love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  --love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
  love.graphics.setColor(255, 255, 255, 255)

  if self.inputDirection.x < 0 then 
    love.graphics.draw(self.sprites.left, self.position.x, self.position.y)
  elseif 
    self.inputDirection.x > 0 then love.graphics.draw(self.sprites.right, self.position.x, self.position.y)
  else 
    love.graphics.draw(self.sprites.normal, self.position.x, self.position.y) 
  end
  
end

function Player:update(input, dt)
  self.cooldownTimer = self.cooldownTimer + dt
  self.inputDirection = input.direction
  self:move(input.direction, dt)

  if input.firing then
    if(self.cooldownTimer > self.firingCooldown) then
      self:fire()

      if player.spinningUp then
        self.firingCooldown = self.firingCooldown - 0.1
        if self.firingCooldown < self.minFiringCooldown then self.firingCooldown = self.minFiringCooldown end
      end

    end
  else
    self.firingCooldown = player.startFiringCooldown
    self.spinupCount = 0
    self.cooldownTimer = 1
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
  self.position.x = math.clamp(0, self.position.x, Settings.window.width - self.size.x)
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

  local randomFactor = 0
  if self.spinningUp then
    self.spinupCount = self.spinupCount + 1 
    if self.spinupCount > 3 then 
      randomFactor = math.random(0, 2) * (self.spinupCount * 0.01) * fireDirection
    end
  end
  print(randomFactor)
  playerBulletManager:spawnBullet(bulletPosition, Vector(randomFactor, 1):normalized(), -250, Vector(5, 5), Color(255, 255, 255))
  love.audio.play(self.audio.fire())
  self.lastFireDirection = fireDirection

end
