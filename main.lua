require "lib"

Event:new("foo", function(bar)
  print("Foo event printing: " .. bar)
end)

Event:new("foo", function(bar)
  print("Also foo printing: " .. bar)
end)

Event:emit("foo", "yeah boi")

local Foo = Object()
