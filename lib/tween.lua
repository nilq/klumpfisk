Tween = Class(nil, true)
  :newValue("Thing", Thing())
  :newValue("CurrentTime", 0)
  :newValue("Duration", 0)
  :newValue("BeginVars", {})
  :newValue("TargetVars", {})
  :newValue("Ease", "quadinout")
  :newValue("Bounce", 1.70158)

Tween:newValue("Tweens", {
  linear = function(t, b, c, d)
    return c * t / d + b
  end,

  quadin = function(t, b, c, d)
    return c * (t / d)^2 + b
  end,

  quadout = function(t, b, c, d)
    return -c * (t / d) * (t / d - 2) + b
  end,

  quadinout = function(t, b, c, d)
    local t = t / d * 2
    if t < 1 then
      return c / 2 * t^2 + b
    end
    return -c / 2 * ((t - 1) * (t - 3) - 1) + b
  end,

  backin = function(t, b, c, d, s)
    local s = s or 1.70158
    local t = t / d
    return c * (t^2 * ((s + 1) * t + s) + 1) + b
  end,

  backinout = function(t, b, c, d, s)
    local s = (s or 1.70158) * 1.525
    local t = t / d * 2
    if t < 1 then
      return c / 2 * (t^2 * ((s + 1) * t - s)) + b
    end
    t = t - 2
    return c / 2 * (t^2 * ((s - 1) * t + s) + 2) + b
  end,

  bouncein = function(t, b, c, d)
    return c - Tween:getTweens()["bounceout"](d - t, 0, c, d) + b
  end,

  bounceout = function(t, b, c, d)
    local t = t / d
    if t < 1 / 2.75 then
      return c * (7.5625 * t^2) + b
    elseif t < 2 / 2.75 then
      t = t - (1.5 / 2.75)
      return c * (7.5625 * t^2 + 0.75) + b
    elseif t < 2.5 / 2.75 then
      t = t - (2.25 / 2.75)
      return c * (7.5625 * t^2 + 0.9375)
    end
    t = t - (2.625 / 2.75)
    return c * (7.5625 * t^2 + 0.984375) + b
  end,

  bounceinout = function(t, b, c, d)
    if t < d / 2 then
      return Tween:getTweens()["bouncein"](t * 2, 0, c, d) / 2 + b
    end
    return Tween:getTweens()["bounceout"](t * 2 - d, 0, c, d) / 2 + c / 2 + b
  end,
})

Tween:newEvent("init", function(tween, thing, duration, vars, info)
  local info = info or {}

  tween:setThing(thing)
       :setDuration(duration)
       :setBeginVars({})
       :setTargetVars({})
       :setEase(info.ease)
       :setBounce(info.bounce)

  for var, target in pairs(vars) do
    local sv = nil
    if thing["get" .. var] then
      sv = thing["get" .. var](thing)
    end
    tween:setSubBeginVars(var, sv)
         :setSubTargetVars(var, target)
  end

  if info.complete then
    tween:newEvent("complete", info.complete)
  end

  if info.update then
    tween:newEvent("update", info.update)
  end
end)

Event:new("update", function(dt)
  for _, tween in ipairs(Tween:getList()) do
    tween:setCurrentTime(math.min(tween:getCurrentTime() + dt, tween:getDuration()))

    for var, value in ipairs(tween:getBeginVars()) do
      local target_v = tween:getSubTargetVars(var)
      if type(target_v) == "function" then
        target_v = target_v()
      end

      newVal = Tween:getTweens()[tween:getEase()](tween:getCurrentTime(),
          value, target_v - value, tween:getDuration(), tween:getBounce())
    end

    tween:emitEvent("update", tween, dt)

    if tween:getCurrentTime() == tween:getDuration() then
      tween:emitEvent("complete", thing)
      tween:emitEvent("remove")
    end
  end
end, {name = "_TWEEN"})
