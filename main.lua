require "lib"

local Emile = Class()
    :setValue("NumberThingFoo", 1337)
    :setValue("IamBool", false)
    :setValue("Tablebebel", {hej = "hej", [2] = 420})
    :setValue("Bar", function(name)
      print(name)
    end)

print(Emile:getNumberThingFoo())

Emile:invokeBar("Hej")
Emile:getBar()("Emile")
