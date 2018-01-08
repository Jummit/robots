local engine = require "Documents/Programming/Lua/Love/Robots/engine"
local utils = require "Documents/Programming/Lua/Love/Robots/utils"

--clear screen
os.execute("clear")

--edit script for robot
local script = engine.editScript()

--make new world and draw it
local world = engine.newWorld(80, 20, 2040192)
for _ = 1, 10 do
  utils.sleep(1)
  os.execute("clear")
  world:draw()

  --run script in world
  world:runScript(script)
end

--[[ script for filling the screen
for x = 1, world.w do
  for y = 1, world.h do
    set(x, y)
  end
end
]]

--[[ script for walking and placing
for _ = 1, 10 do
  move(math.random(-1, 1), math.random(-1, 1))
  set(math.random(-1, 1), math.random(-1, 1), "stone")
end
]]
