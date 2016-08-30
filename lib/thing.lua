Thing = setmetatable({}, {
  __call = function(parent)
    local thing = setmetatable({
      newValue   = Property.newValue,
      newBoolean = Property.newBoolean,
      newTable   = Property.newTable,
    }, {
      __index = parent,
    })
    return thing
  end
})
