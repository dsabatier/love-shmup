Enemy = Class {}

function Enemy:init(size, color, position)
  self.size = size
  self.color = color
  self.position = position
end

function Enemy:move()

end

function Enemy:update(dt)

end

function Enemy:draw()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size, self.size)
end