require "lib"

State = "game"

Event:new("update", function(...)
  Event:emit("update_" .. State, ...)
end)

Event:new("draw", function(...)
  Event:emit("draw_" .. State, ...)
end)
