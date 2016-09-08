Object = setmetatable({}, {
  __call = function(parent)
    local obj = setmetatable({
      events          = {},
      newValue        = Property.newValue,
      newEvent        = Event.new,
      emitEvent       = Event.emit,
      removeEvent     = Event.remove,
      removeSubEvent  = Event.removeSub,
      setSubEvent     = Event.setSub,
      enableSubEvent  = Event.enableSub,
      disableSubEvent = Event.disableSub,
      toggleSubEvent  = Event.toggleSub,
    }, {
      __index = parent,
    })
    return obj
  end
})
