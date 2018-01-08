return {
  load = function(path)
    local script = ""
    local file = io.open(path, "r")

    for line in file:lines(6) do
      script = script..line
    end
    return {
      name = string.match(path, "[^/]+$"),
      script = script
    }
  end,
  fillEventQueues = function(world)
    for robotNum = 1, #world.robots do
      local robot = world.robots[robotNum]
      if #robot.events == 0 then
        scriptFunc, message = load(
          robot.script.script,
          robot.name..".rbs",
          "t",
          {
            math = math,
            table = table,
            error = error,
            world = {
              w = world.w,
              h = world.h
            },
            move = function(x, y)
              table.insert(robot.events, {action="move",x=x, y=y})
            end,
            build = function(x, y, building)
              table.insert(robot.events, {action="build", x=x, y=y, building=building})
            end
          }
        )
        if not scriptFunc then
          print(message)
        else
          succ, message = pcall(scriptFunc)
          if not succ then
            print(message)
          end
        end
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
