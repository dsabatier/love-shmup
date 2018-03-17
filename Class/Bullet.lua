Bullet = Class{}

function Bullet:init(position, direction, speed, size, color)
  self.position = position
  self.direction = direction
  self.speed = speed
  self.size = size
  self.color = color
end

function Bullet:draw()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
end

function Bullet:update(bulletManager, index, dt)
  self:move(dt)

  if self.position.y < 0 or self.position.x < 0 or self.position.x > Settings.window.width then
    table.remove(bulletManager.bullets, index)
  end

end

function Bullet:move(dt)
  self.position = self.position + self.direction * self.speed * dt
end