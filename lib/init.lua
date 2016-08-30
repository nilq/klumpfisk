local modules = {
  "property",
  "event",
  "thing",
  "class",
  "util/utility",
  "util/math",
  "timer",
  "input",
}

love.graphics.setDefaultFilter("nearest", "nearest")

for _, mod in ipairs(modules) do
  require(... .. "." .. mod)
end

function love.run()
  local dt = 0

  local update_timer = 0
  local target_delta = 1 / 60

  if love.math then
    love.math.setRandomSeed(os.time())
  end

  if love.load() then
    Event:emit("load", arg)
  end

  if love.timer then
    love.timer.step()
  end

  while true do
    update_timer = update_timer + dt

    if love.event then
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        Event:emit(name, a, b, c, d, e, f)

        if name == "quit" then
          if not love.quit or not love.quit() then
            return a
          end
        end
      end
    end

    if love.timer then
      love.timer.step()
      dt = love.timer.getDelta()
    end

    if update_timer > target_delta then
      Event:emit("update", target_delta)
    end

    update_timer = math.fmod(update_timer, target_delta)

    if love.graphics and love.graphics.isActive() then
      love.graphics.clear(love.graphics.getBackgroundColor())
      love.graphics.setColor(255, 255, 255)

      love.graphics.origin()

      Camera:set()
      Event:emit("draw"):emit("postDraw")
      Camera:unset()

      love.graphics.present()
    end

    if love.timer then
      love.timer.sleep(0.001)
    end
  end
end

Event:new("keypressed", function(...)
  Event:emit("keychanged", ..., true)
end)

Event:new("keyreleased", function(...)
  Event:emit("keychanged", ..., false)
end)

Event:new("threaderror", function(thread, errorstr)
  print("This is interesting..? - thread error!\n" .. errorstr)
end)
