local Class = {}
Class.__index = Class 

--default implementation
function Class:new() end

--create new Class type from base class
function Class:derive(class_type)
    assert(class_type ~= nil, "parameter must not be nil!")
    assert(type(class_type) == "string", "parameter must be a string!")
    local cls = {}
    cls["__call"] = Class.__call
    cls.type = class_type
    cls.__index = cls
    cls.super = self

    --enables inheritance of methods
    setmetatable(cls, self) 
    return cls
end

-- Check if the instance is a sub-class of the given type
function Class:is(class)
    assert(class ~= nil, "parameter must not be nil!")
    assert(type(class) == "table", "parameter class must be table!")
    local mt = getmetatable(self)
    while mt do
        if mt == class then return true end
        mt = getmetatable(mt)
    end
    return false
end

-- same thing but compares string
function Class:is_type(class_type)
    assert(class_type ~= nil, "parameter must not be nil!")
    assert(type(class_type) == "string", "parameter must be a string!")
    local base = self
    while base do
        if base.type == class_type then return true end
        base = base.super
    end
    return false
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