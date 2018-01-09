local worldEngine = require "Documents/Programming/Lua/Love/Robots/engine/world"
local utils = require "Documents/Programming/Lua/Love/Robots/engine/utils"
local scriptEngine = require "Documents/Programming/Lua/Love/Robots/engine/script"
local tiles = require "Documents/Programming/Lua/Love/Robots/engine/tiles"

--make new world and draw it
local world = worldEngine.new(80, 20, 2040192, tiles)

world:init(10, 10)
while true do
  world:draw()
  utils.sleep(0.5)

  scriptEngine.fillEventQueues(newWorld)
  scriptEngine.runEventQuenues(newWorld)
end
