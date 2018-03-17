require("Class/Enemy")

EnemyManager = Class {}

function EnemyManager:init()
    self.enemies = {}
end

function EnemyManager:update(dt)
    for _,v in pairs(self.enemies) do
        v:update(dt)
    end

    self:checkCollisions()
end

function EnemyManager:draw()
    for _,v in pairs(self.enemies) do
        v:draw()
    end
end

function EnemyManager:spawnEnemy(position, size, color)
    local enemy = Enemy(position, size, color)
    table.insert(self.enemies, enemy)
end

function EnemyManager:checkCollisions()
    for bulletIndex,bullet in ipairs(playerBulletManager.bullets) do
        for enemyIndex,enemy in ipairs(self.enemies) do
            if(checkCollision(bullet.position.x, bullet.position.y, bullet.size.x, bullet.size.y, enemy.position.x, enemy.position.y, enemy.size.x, enemy.size.y)) then
                table.remove(playerBulletManager.bullets, bulletIndex)
                enemy:takeDamage()
                --table.remove(self.enemies, enemyIndex)
            end
        end
      end
end

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end