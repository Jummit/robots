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
  run = function(world, robot)
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
}
