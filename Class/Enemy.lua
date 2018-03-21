Enemy = Class {}

function Enemy:init(position, size, color)
  self.size = size
  self.color = color
  self.position = position
  self.direction = Vector(0, 0)
  self.speed = 100
  self.hp = 0
  self.lifetime = 0
  self.audio = {}
  self.audio.hit = function()
    return love.audio.newSource('Assets/Audio/Hit1.wav')
  end
end

function Enemy:move(dt)
  local velocity = Vector(0, 0)

  self.direction.x = math.sin(self.lifetime * 2)

  velocity = self.direction:normalized() * self.speed
  self.position = self.position + velocity * dt
end

function Enemy:update(dt)
  self.lifetime = self.lifetime + dt
  self:move(dt)
end

function Enemy:draw()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
end

function Enemy:takeDamage()
  love.audio.play(self.audio.hit())
  --camera:shake(4, 0.5, 120)
end