Class = setmetatable({}, {
  __call = function(self, parent, listed, named)
    local class = Object()
    class:newValue("Class", class)
         :newValue("Parent", parent)
    setmetatable(class, {
      __index = parent,
      __call = function(self, ...)
        local obj = setmetatable(obj(), {
          __index = class,
        })
        class:emitEvent("init", obj, ...)
             :emitEvent("postInit", obj, ...)
        return obj
      end,
    })

    if parent then
      class:newEvent("init", function(...)
        parent:emitEvent("init", ...)
      end)
      class:newEvent("postInit", function(...)
        parent:emitEvent("postInit", ...)
      end)
    end

    if listed then
      class:newValue("List", {})

      class:newEvent("init", function(obj)
        table.insert(class:getList(), obj)
        obj:newEvent("remove", function()
          table.remove(class:getList(), Utility.indexElement(obj, class:getList()))
        end)
      end)
    end

    return class
  end
})
