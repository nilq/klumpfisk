Property = {}

function Property:newValue(name, initial, functions)
  functions = functions or {}

  self[name] = initial
  -- always
  self["get" .. name] = functions.get or function(self)
    return self[name]
  end
  self["set" .. name] = functions.set or function(self, v)
    self[name] = v
    return self
  end
  -- type dependent
  local x_type = type(initial)
  if x_type == "boolean" then
    self["is" .. name] = functions.get or function(self)
      return self[name]
    end

    self["enable" .. name] = functions.enable or function(self)
      self["set" .. name](self, true)
    end

    self["disable" .. name] = functions.disable or function(self)
      self["set" .. name](self, false)
    end

    self["toggle" .. name] = functions.toggle or function(self)
      self["set" .. name](self, not self[name])
    end
  elseif x_type == "table" then
    self["copy" .. name] = functions.getCopy or function(self)
      return Utility.copy(self[name])
    end

    self["getSub" .. name] = functions.getSub or function(self, a)
      return self[name][a]
    end

    self["setSub" .. name] = functions.setSub or function(self, a, v)
      self[name][a] = v
      return self[name][a]
    end
  elseif x_type == "number" then
    self["increment" .. name] = functions.increment or function(self, v)
      self["set" .. name](self, self[name] + (v or 1))
    end

    self["decrement" .. name] = functions.decrement or function(self, v)
      self["set" .. name](self, self[name] - (v or 1))
    end

    self["scale" .. name] = functions.scale or function(self, v)
      self["set" .. name](self, self[name] * v)
    end

    self["divide" .. name] = functions.divide or function(self, v)
      self["set" .. name](self, self[name] / v)
    end
  end
  return self
end
