Input = Thing():newTable("Down", {})

Event:new("keychanged", function(key, state)
  Input:setSubDown(key, state)
end)

function Input.isDown(key)
  return Input:getSubDown(key) or false
end

function Input.isDownAny(keys)
  for _, key in ipairs(keys) do
    if Input.isDown(key) then
      return true
    end
  end
  return false
end

function Input.isDownAll(keys)
  for _, key in ipairs(keys) do
    if not Input.isDown(key) then
      return false
    end
  end
  return true
end
