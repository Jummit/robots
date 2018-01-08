local base = {
  {true, false, true, false, true},
  {false, true, false, true, false},
  {true, false, true, false, true},
  {false, true, false, true, false},
  {true, false, true, false, true},
  {false, true, false, true, false},
}

direc = 1
for y = 1, 10 do
  for x = 1, 19 do
    place(0, 0, "stone")
    move(direc, 0)
  end
  move(0, 1)
  move(-direc, 0)
  if direc == 1 then
    direc = -1
  else
    direc = 1
  end
end

move(1, 0)
place(0, 1, "machine")
