local world = require "Documents/Programming/Lua/Love/Robots/engine/world"
local utils = require "Documents/Programming/Lua/Love/Robots/engine/utils"
local script = require "Documents/Programming/Lua/Love/Robots/engine/script"

local sc = script.load("Documents/Programming/Lua/Love/Robots/scripts/test.rsc")
os.execute("clear")
print(sc.script)

--make new world and draw it
local newWorld = world.new(
  80, 20, 2040192,
  {
    ground = {
      name = "ground",
      char = {".", ",", "¸"}
    },
    stone = {
      name = "stone",
      char = {"o", "O", "0", "Q"}
    },
    machine = {
      name = "machine",
      char = {"H"}
    }
  }
)
newWorld:init(10, 10)
for _ = 1, 10 do
  utils.sleep(1)
  newWorld:draw()

  --run script in world
  script.run(newWorld, sc)
end
