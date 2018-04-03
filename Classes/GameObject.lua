GameObject = Object:extend()

function GameObject:new(area, position, opts)
    local opts = opts or {}
    if opts then for k,v in pairs(opts) do self[k] = v end end
    self.area = area
    self.position = position
    self.id = 0
    self.alive = true
    self.timer = Timer()
end

function GameObject:update(dt)
    if self.timer then self.timer:update(dt) end
end

function GameObject:draw()

end