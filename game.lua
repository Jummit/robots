local world = require "Documents/Programming/Lua/Love/Robots/engine/world"
local utils = require "Documents/Programming/Lua/Love/Robots/engine/utils"
local script = require "Documents/Programming/Lua/Love/Robots/engine/script"
local tiles = require "Documents/Programming/Lua/Love/Robots/engine/tiles"

--make new world and draw it
local newWorld = world.new(80, 20, 2040192, tiles)

newWorld:init(10, 10)
while true do
  newWorld:draw()
  utils.sleep(0.5)

  script.fillEventQueues(newWorld)
  script.runEventQuenues(newWorld)
end
