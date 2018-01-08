local world = require "Documents/Programming/Lua/Love/Robots/engine/world"
local utils = require "Documents/Programming/Lua/Love/Robots/engine/utils"
local script = require "Documents/Programming/Lua/Love/Robots/engine/script"

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
while true do
  newWorld:draw()
  utils.sleep(0.5)

  script.fillEventQueues(newWorld)
  for robotNum = 1, #newWorld.robots do
    local robot = newWorld.robots[robotNum]
    for eventNum = 1, #robot.events do
      local event = robot.events[eventNum]
      if event.action == "move" then
        if math.abs(event.x)+math.abs(event.y) > 1 then
          event.x = 0
        end
        robot.x = robot.x + event.x
        robot.y = robot.y + event.y
      end
      table.remove(robot.events, eventNum)
      break
    end
  end
end
