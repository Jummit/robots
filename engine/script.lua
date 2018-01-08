return {
  loadScript = function(path)
    local script = ""
    local file = io.open(path, "r")

    for line in file:lines(6) do
      script = script..line
    end
    return {
      name = string.match(path, "[^/]+$"),
      script = script
    }
  end
}
