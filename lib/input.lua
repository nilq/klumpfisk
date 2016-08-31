Input = Thing():newTable("Key", {})
    :newTable("Button", {})
    :newTable("Touch", {})
    :newTable("Gamepad", {})
    :newTable("Joystick", {})

Event:new("keychanged", function(key, state)
  Input:setSubKey(key, state)
end)

function Input.isDown(key)
  return Input:getSubKey(key) or false
end

function Input.isClick(button)
  return Input:getSubButton(button) or false
end

function Input.isDownAny(keys)
  for _, key in ipairs(keys) do
    if Input.isDown(key) then
      return true
    end
  end
  return false
end

function Input.isClickAny(buttons)
  for _, b in ipairs(buttons) do
    if Input.isClick(b) then
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

function Input.isClickAny(buttons)
  for _, b in ipairs(buttons) do
    if not Input.isClick(b) then
      return false
    end
  end
  return true
end
