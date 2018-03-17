BulletManager = Class{}

function BulletManager:init()
  self.bullets = {}
end

function BulletManager:spawnBullet()
  local bullet = new Bullet()
  table.insert(self.bullets, bullet)
end

function BulletManager:update(dt)

end
