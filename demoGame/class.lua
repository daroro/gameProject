local Class = {}
Class.__index = Class 

--default implementation
function Class:new() end

--create new Class type from base class
function Class:derive(type)
    local cls = {}
    cls["__call"] = Class.__call
    cls.type = type
    cls.__index = cls
    cls.super = self

    --enables inheritance of methods
    setmetatable(cls, self) 
    return cls
end

--function to create instance of class
function Class:__call(...)
    local inst = setmetatable({}, self)
    inst:new(...)
    return inst
end

--obtain the current instance of class
function Class:get_type()
    return self.type
end

--Creating a class "Player"
local Player = Class:derive("Player")

return Class