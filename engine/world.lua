local utils = require "Documents/Programming/Lua/Love/Robots/engine/utils"
return {
  new = function(w, h, key, tiles)
    math.randomseed(key)
    return {
      key = key,
      w = w,
      h = h,
      tiles = tiles,
      robot = {
        x = 2,
        y = 2
      },
      draw = function(self)
        math.randomseed(key)
        os.execute("clear")

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
      init = function(self)
        for x = 1, self.w do
          self[x] = {}
          for y = 1, self.h do
            local tile
            if math.random(1, 10) == 1 then
              tile = self.tiles.stone
            else
              tile = self.tiles.ground
            end
            self[x][y] = tile
          end
        end
      end
    }
  end
}
