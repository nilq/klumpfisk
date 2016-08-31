klumpfisk
===

A fancy framework for game development to be used a long with LÖVE. Implementing nice event systems, comfortable input handling and giving Lua the *thing oriented* structure you've always wanted.

---
*based on things and stuff from Luvnit by Justin van der Leij*

---
###Examples
Very basic classes

```lua
local Animal = Class(nil) -- inherits nothing
Animal:newValue("LegAmount", 0)
	  :newBoolean("Head", true)
local Human = Class(Animal) -- inherits from Animal
	  :setLegAmount(2)
	  :disableHead()
```
