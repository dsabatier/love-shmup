Bullet = Class{}

function Bullet:init(position, direction, speed, size, color)
  self.direction = direction
  self.speed = speed
  self.size = size
  self.color = color
  self.position = position
end

function Bullet:draw()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
end

function Bullet:update(dt)
  self:move(dt)
end

function Bullet:move(dt)
  self.position = self.position + self.direction * self.speed * dt
end
