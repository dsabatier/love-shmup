Player = Class {}

function Player:init(width, height, color, position)
  self.height = height
  self.width = width
  self.color = color
  self.position = position
  self.speed = 0
  self.maxSpeed = 250
  self.direction = Vector(0, 0)
  self.acceleration = 5
  self.drag = 10
end

function Player:draw()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.width, self.height)
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
  self.position.x = math.clamp(0, self.position.x, Settings.window.width - player.width)
  self.position.y = math.clamp(Settings.window.height - 200, self.position.y, Settings.window.height-self.height)
end
