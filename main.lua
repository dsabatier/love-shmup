Object = require 'lib/classic/classic'
Input = require 'lib/input/Input'
Timer = require 'lib/hump/timer'
Math = require 'lib/math/math'
Vector = require("lib/hump.vector")

require("Classes/Color")
require("globals")
require('Classes/GameObject')
require('Classes/Player')

function love.load()
    -- require all in ./Classes
    local classes_files = {}
    recursiveEnumerate('Classes', classes_files)
    requireFiles(classes_files)

    -- init input
    input = Input()

    --keyboard
    input:bind('space', 'fire')
    input:bind('lshift', 'spin')
    input:bind('w', 'up')
    input:bind('s', 'down')
    input:bind('d', 'right')
    input:bind('a', 'left')
    input:bind('return', 'return')

    --gamepad
    --[[ input:bind('fup', 'fire')
    input:bind('fleft', 'fire')
    input:bind('fdown', 'fire')
    input:bind('fright', 'fire')
    input:bind('f1', 'f1')
    input:bind('f2', 'f2') ]]

    Settings = Settings()

    goToScene('MainMenu')
end

function love.update(dt)
    if current_scene then current_scene:update(dt) end
end

function love.draw()
    if current_scene then current_scene:draw() end
end

function goToScene(scene_type, ...)
    current_scene = _G[scene_type](...)
end

function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.isFile(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        print("Loaded: ", tostring(file))
        require(file)
    end
end