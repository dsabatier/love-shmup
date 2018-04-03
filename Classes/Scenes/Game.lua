Game = Object:extend()

function Game:new()
    print("Entered game scene")
    self.area = Area(self)
    self.area:addGameObject('Player', Vector(Settings.window.width / 2, Settings.window.height-70))
end

function Game:update(dt)
    self.area:update(dt)
end

function Game:draw()
  self.area:draw()  
end