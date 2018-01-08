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
          --[[{
            math = math,
            table = table,
            error = error,
            place = function(x, y, tile)
              if tiles[tile] then
                world[robot.x][robot.y] = tiles[tile]
              else
                error("place: tile "..tile.." does not exist!")
              end
            end,
            world = {
              w = world.w,
              h = world.h
            },
            move = function(x, y)
              if math.abs(x)+math.abs(y) > 1 then
                x = 0
              end
              robot.x = robot.x + x
              robot.y = robot.y + y
            end,
            build = function(x, y, building)
              if math.abs(x)+math.abs(y) == 1 then
                world[robot.x+x][robot.y+y] = tiles[building]
              else
                error("build: you can't reach this position!")
              end
            end
          }]]
          {
            math = math,
            table = table,
            error = error,
            world = {
              w = world.w,
              h = world.h
            },
            place = function(x, y, tile)
              table.insert(robot.events, {action="place", x=x, y=y, tile=tile})
            end,
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
  end
}
