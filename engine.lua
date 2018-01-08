local engine = {}
engine.editScript = function()
  local input = ""
  while true do
    local newInput = io.read()
    if newInput == "q" then
      return {
        name = io.read(),
        script = input
      }
    else
      input = input.." "..newInput
    end
  end
end
engine.newWorld = function(w, h, key, tiles)
  math.randomseed(key)
  local world = {
    w = w,
    h = h,
    robot = {
      x = 2,
      y = 2
    }
  }

  for x = 1, w do
    world[x] = {}
    for y = 1, h do
      local tile
      if math.random(1, 10) == 1 then
        tile = tiles.stone
      else
        tile = tiles.ground
      end
      world[x][y] = tile
    end
  end
  return setmetatable(
    world,
    {
      __index = {
        draw = function(self)
          math.randomseed(key)

          io.write(" /--")
          for _ = 1, self.w do io.write("-") end
          io.write("-\\\n")
          io.write("/ /")
          for _ = 1, self.w do io.write("-") end
          io.write("\\ \\\n")

          for y = 1, self.h do
            io.write("| |")
            for x = 1, self.w do
              if self.robot.x == x and self.robot.y == y then
                io.write("#")
              else
                io.write(self[x][y].char[math.random(1, #self[x][y].char)])
              end
            end
            io.write("| |\n")
          end

          io.write("\\ \\")
          for _ = 1, self.w do io.write("-") end
          io.write("/ /\n")
          io.write(" \\-")
          for _ = 1, self.w-1 do io.write("-") end
          io.write("--/\n")
        end,
        runScript = function(self, script)
          scriptFunc, message = load(
            script.script,
            script.name..".rbs",
            "t",
            {
              math = math,
              table = table,
              set = function(x, y)
                self[x][y] = tiles.stone
              end,
              world = {
                w = self.w,
                h = self.h
              },
              move = function(x, y)
                if math.abs(x)+math.abs(y) > 1 then
                  x = 0
                end
                self.robot.x = self.robot.x + x
                self.robot.y = self.robot.y + y
              end,
              build = function(x, y, building)
                if math.abs(x)+math.abs(y) == 1 then
                  self[self.robot.x+x][self.robot.y+y] = tiles[building]
                else
                  error("build: you can't reach this position!")
                end
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
    }
  )
end

return engine
