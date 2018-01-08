local utils = require "Documents/Programming/Lua/Love/Robots/engine/utils"
local script = require "Documents/Programming/Lua/Love/Robots/engine/script"

return {
  new = function(w, h, key, tiles)
    math.randomseed(key)
    return {
      key = key,
      w = w,
      h = h,
      tiles = tiles,
      robots = {
        {
          name = "paul"
        },
        {
          name = "jummit"
        }
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
            local robotDrawn = false
            for robotNum = 1, #self.robots do
              if self.robots[robotNum].x == x and self.robots[robotNum].y == y then
                io.write("#")
                robotDrawn = true
                break
              end
            end
            if not robotDrawn then
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
        for robotNum = 1, #self.robots do
          local robot = self.robots[robotNum]
          print("Documents/Programming/Lua/Love/Robots/scripts/"..robot.name..".rsc")
          robot.script = script.load("Documents/Programming/Lua/Love/Robots/scripts/"..robot.name..".rsc")
          robot.x = 10
          robot.y = 10
          robot.events = {}
        end
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
