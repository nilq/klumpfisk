Property = {}

function Property:newProperty(name, initial, set, get)
  self[name] = initial

  self["get" .. name] = get or function(self)
    return self[name]
  end

  self["set" .. name] = set or function(self, v)
    self[name] = v
    return self
  end

  return self
end

function Property:newTableProperty(name, initial, get, set
    getCopy, getSub, setSub)
  Property.newProperty(self, name, default, set, get)

  self["copy" .. name] = getCopy or function(self)
    return Utility.copy(self[name])
  end

  self["getSub" .. name] = getSub or function(self, a)
    return self[name][a]
  end

  self["setSub" .. name] = setSub or function(self, a, v)
    self[name][a] = v
    return self[name][a]
  end
  return self
end

a:copyFoo()
