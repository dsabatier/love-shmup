Settings = Class{}

function Settings:init()
  self.debug = true
  self.window = {}
  self.window.width, self.window.height = love.window.getMode()
end
