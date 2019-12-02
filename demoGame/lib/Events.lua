-- module to invoke an event and have multiple response
-- key = event type, value = functions 

local class = require("lib.Class")
local Events = class:derive("lib.Events")

-- constructor
function Events:new(event_must_exist)
    self.handlers = {}
    self.event_must_exist = (event_must_exist == nil) or event_must_exist
end

-- checks if callback exists in event table already
local function index_of(evt_tbl, callback)
    if evt_tbl == nil or callback == nil then return -1 end
    
    for i = 1, #evt_tbl do
        if evt_tbl[i] == callback then return i end
    end
    return -1
end

-- add new event type
function Events:add(evt_type)
    assert(self.handlers[evt_type] == nil, "Event " .. evt_type .. "already exist!")
    self.handlers[evt_type] = {}
end

-- remove event type 
function Events:remove(evt_type)
    self.handlers[evt_type] = nil
end

-- subscribe to an event
function Events:hook(evt_type, callback)
    assert(type(callback) == "function", "Callback parameter must be a function")
    
    if self.event_must_exist then
        assert(self.handlers[evt_type] ~= nil, "Event of type " .. evt_type .. " does not exist!")
    elseif self.handlers[evt_type] == nil then
        self:add(evt_type)
    end

    -- if index_of(self.handlers[type], callback) > -1 then return end
    assert(index_of(self.handlers[evt_type], callback) == -1, "callback has already been registered")


    local tbl = self.handlers[evt_type]
    tbl[#tbl + 1] = callback
end

-- unsubscribe an event
function Events:unhook(evt_type, callback)
    assert(type(callback) == "function", "Callback parameter must be a function")
    if self.handlers[evt_type] == nil then return end
    local index = index_of(self.handlers[evt_type], callback)
    if index > -1 then
        table.remove(self.handlers[evt_type], index)
    end
end

-- Clear out event handlers for given event type
function Events:clear(evt_type)
    if evt_type == nil then
        for k,v in pairs(self.handlers) do
            self.handlers[k] = {}
        end
    elseif self.handlers[evt_type] ~= nil then 
        self.handlers[evt_type] = {}
    end
end

-- invoke an event
function Events:invoke(evt_type, ...)
    if self.handlers[evt_type] == nil then return end
    -- assert(self.handlers[evt_type] ~= nil, "Event of type " .. evt_type .. " does not exist!")
    local tbl = self.handlers[evt_type]
    for i = 1, #tbl do
        tbl[i](...)
    end
end

return Events