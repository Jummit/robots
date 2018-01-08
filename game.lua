local engine = require "Documents/Programming/Lua/Love/Robots/engine"
local utils = require "Documents/Programming/Lua/Love/Robots/utils"

--clear screen
os.execute("clear")

--edit script for robot
local script = engine.editScript()

--make new world and draw it
local world = engine.newWorld(
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
world:init(10, 10)
for _ = 1, 10 do
  utils.sleep(1)
  os.execute("clear")
  world:draw()

  --run script in world
  world:runScript(script)
end
