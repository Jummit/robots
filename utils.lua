local utils = {}
utils.sleep = function(time)
  local endTime = os.clock() + time
  repeat until os.clock() > endTime
end

return utils
