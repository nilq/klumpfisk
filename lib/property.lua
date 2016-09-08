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
      self[name] = true
      return self
    end

    self["disable" .. name] = functions.disable or function(self)
      self[name] = false
      return self
    end

    self["toggle" .. name] = functions.toggle or function(self)
      self[name] = not self[name]
      return self
    end
  elseif x_type == "table" then
    self["shallowCopy" .. name] = functions.getCopy or function(self)
      return Utility.shallowCopy(self[name])
    end

    self["deepCopy" .. name] = functions.getCopy or function(self)
      return Utility.shallowCopy(self[name])
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
      self[name] = self[name] + (v or 1)
      return self
    end

    self["decrement" .. name] = functions.decrement or function(self, v)
      self[name] = self[name] - (v or 1)
      return self
    end

    self["scale" .. name] = functions.scale or function(self, v)
      self[name] = self[name] * v
      return self
    end

    self["divide" .. name] = functions.divide or function(self, v)
      self[name] = self[name] / v
      return self
    end
  elseif x_type == "function" then
    self["call"] = functions.invoke or function(self, ...)
      return self[name](...)
    end
  elseif x_type == "string" then
    self["concat"] = functions.invoke or function(self, v)
      self[name] = self[name] .. v
    end
  end
  return self
end
