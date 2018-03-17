require("Class/Bullet")

BulletManager = Class{}

function BulletManager:init()
  self.bullets = {}
end

function BulletManager:spawnBullet(position, direction, speed, size, color)
  local bullet = Bullet(position, direction:normalized(), speed, size, color)
  table.insert(self.bullets, bullet)
end

function BulletManager:update(dt)
  for index,v in ipairs(self.bullets) do
    v:update(self, index, dt)
  end
end

function BulletManager:draw(dt)
  for _,v in pairs(self.bullets) do
    v:draw(dt)
  end
end