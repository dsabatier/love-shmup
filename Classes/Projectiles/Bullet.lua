Bullet = GameObject:extend()

function Bullet:new(area, position, opts)
    Bullet.super.new(self, area, position, opts)
    self.speed = 200
end

function Bullet:update(dt)
    self.position.y = self.position.y - self.speed * dt
    if self.position.y < 0 then self.alive = false end
end

function Bullet:draw()
    love.graphics.circle('fill', self.position.x, self.position.y, 4)
end