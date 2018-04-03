Settings = Object:extend()

function Settings:new()
  self.debug = true
  self.window = {}
  self.window.width, self.window.height = love.window.getMode()
end