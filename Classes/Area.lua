Area = Object:extend()

function Area:new(scene)
    self.scene = scene
    self.gameObjects = {}
end

function Area:update(dt)
    for i, go in ipairs(self.gameObjects) do 
        go:update(dt)
        if not go.alive then
           table.remove(self.gameObjects, i) 
        end
    end
end

function Area:draw()
    for _, go in ipairs(self.gameObjects) do go:draw() end
end

function Area:addGameObject(goType, position, opts)
    local opts = opts or {}
    local gameObject = _G[goType](self, position or Vector(0, 0), opts)
    table.insert(self.gameObjects, gameObject)
    return gameObject
end