Color = Object:extend()

function Color:new(r, g, b, a)
  self.r = r
  self.g = g
  self.b = b
  if a ~= nil then self.a = a else a = 1 end
end

