Color = Class{}

function Color:init(r, g, b, a)
  self.r = r
  self.g = g
  self.b = b
  if a ~= nil then self.a = a else a = 255 end
end
