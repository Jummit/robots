local script = require "Documents/Programming/Lua/Love/Robots/engine/script"

return {
  fillEventQueues = function(world)
    for robotNum = 1, #world.robots do
      local robot = world.robots[robotNum]
      if #robot.events == 0 then
        script.run(world, robot)
      end
    end
  end,
  runEventQuenues = function(world)
    for robotNum = 1, #world.robots do
      local robot = world.robots[robotNum]
      for eventNum = 1, #robot.events do
        local event = robot.events[eventNum]
        if event.action == "move" then
          if math.abs(event.x)+math.abs(event.y) > 1 then
            event.x = 0
          end
          robot.x = robot.x + event.x
          robot.y = robot.y + event.y
        elseif event.action == "build" then
          if math.abs(event.x)+math.abs(event.y) == 1 then
            world[robot.x+event.x][robot.y+event.y] = world.tiles[event.building]
          else
            error("build: you can't reach this position!")
          end
        end
        table.remove(robot.events, eventNum)
        break
      end
    end
  end
}
