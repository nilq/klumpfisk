require "lib"

State = "game"

local Foo = Class(nil)

Foo:newValue("Table1", {})
Foo:newValue("Number1", 2.0)

local barTable = Foo:copyTable1()

Foo:incrementNumber1(5)

local barNumber = Foo:getNumber1()

print(barTable, barNumber)

Foo:scaleNumber1(3)

barNumber = Foo:getNumber1()

print(barNumber)

Foo:divideNumber1(6)

barNumber = Foo:getNumber1()

print(barNumber)
