Player = GameObject:extend()

function Player:new(area, position, opts)
    Player.super.new(self, area, position, opts)
    self.size =  Vector(32, 32)
    self.speed = 200
    self.spinSpeed = 400
    self.direction = Vector(0, 0)
    self.acceleration = 5
    self.minFiringCooldown = 0.075
    self.startFiringCooldown = 0.5
    self.firingCooldown = self.startFiringCooldown
    self.cooldownTimer = 0.5
    self.spinning = false
    self.spinTime = 0

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
  
end

function Player:draw()
    if not self.spinning then
        if self.direction.x < 0 then 
            love.graphics.draw(self.sprites.left, self.position.x, self.position.y)
        elseif 
            self.direction.x > 0 then love.graphics.draw(self.sprites.right, self.position.x, self.position.y)
        else 
            love.graphics.draw(self.sprites.normal, self.position.x, self.position.y) 
        end
    else
        love.graphics.rectangle('fill', self.position.x, self.position.y, self.size.x, self.size.y)
    end
end

function Player:update(dt)
    if(input:down('right')) then 
        self.direction.x = 1
    elseif (input:down('left')) then
        self.direction.x = -1
    else
        self.direction.x = 0
    end

    if(input:down('down')) then 
        self.direction.y = 1
    elseif (input:down('up')) then
        self.direction.y = -1
    else
        self.direction.y = 0
    end

    self.direction = self.direction:normalized()

    if(input:pressed('fire') and not self.spinning) then
        self:fire()
    end

    if(input:pressed('spin') and not self.spinning) then
        self:spin()
    end
    local moveSpeed = self.speed

    if self.spinning then
        self.spinTime = self.spinTime - dt

        if self.spinTime > 0 then moveSpeed = self.spinSpeed else self.spinning = false end
    end

    local newPosition = self.position + (moveSpeed * self.direction * dt)
    self:move(newPosition)
end

function Player:move(newPosition, dt)
    self.position = newPosition
end

function Player:fire()
    love.audio.play(self.audio.fire())
    self.area:addGameObject('Bullet', Vector(self.position.x + (self.size.x * 0.5), self.position.y))
end

function Player:spin()
    self.spinning = true
    self.spinTime = 0.3
end
