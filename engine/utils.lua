return {
  sleep = function(time)
    local endTime = os.clock() + time
    repeat until os.clock() > endTime
  end,
  drawUpperBorder = function(w)
    io.write(" /--")
    for _ = 1, w do io.write("-") end
    io.write("-\\\n")
    io.write("/ /")
    for _ = 1, w do io.write("-") end
    io.write("\\ \\\n")
  end,
  drawLowerBorder = function(w)
    io.write("\\ \\")
    for _ = 1, w do io.write("-") end
    io.write("/ /\n")
    io.write(" \\-")
    for _ = 1, w-1 do io.write("-") end
    io.write("--/\n")
  end
}
