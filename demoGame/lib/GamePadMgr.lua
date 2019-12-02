local Class = require("lib.Class")
local GPM = Class:derive("GamePadMgr")

local function hook_love_events(self)

    function love.joystickadded(joystick)
        local id = joystick:getID()
        assert(self.connected_sticks[id] == nil, "Joystick " .. id .. " already exists!")
        self.connected_sticks[id] = joystick
        self.is_connected[id] = true
        self.button_map[id] = {}
    end

    function love.joystickremoved(joystick)
        local id = joystick:getID()
        self.is_connected[id] = false
        self.connected_sticks[id] = nil
        self.button_map[id] = {}
    end

    function love.gamepadpressed(joystick, button)
        local id = joystick:getID()
        self.buttonmap[id][button] = true
    end

    function love.gamepadreleased(joystick, button)
        local id = joystick:getID()
        self.buttonmap[id][button] = false
    end

end

function GPM:new(db_files)
    if db_files ~= nil then
        for i = 1, #db_files do
            love.joystick.loadGamepadMappings(db_files[i])
        end
    end

    -- currently conencted joysticks
    self.connected_sticks = {}
    self.is_connected = {}

    -- maps joystick id to a table of key values, key = button and value is either true = just pressed , false = just released
    self.button_map = {}
    hook_love_events(self)
end

-- return the instantaneous state of button of joystick
function GPM:button(joyId, button)
    local stick = self.connected_sticks[joyId]
    if self.is_connected[id] == nil or self.is_connected[id] == false then return false
    
    local is_down = stick:isGamepadDown(button)

    return is_down
end

-- return true if given button was pressed for joystick
function GPM:button_down(joyId, button)
    if self.is_connected[id] == nil or self.is_connected[id] == false then return false
    else return self.button_map[joyId][button] == true
    end
end

-- return true if given button was released for joystick
function GPM:button_up(joyId, button)
    if self.is_connected[id] == nil or self.is_connected[id] == false then return false
    else return self.button_map[joyId][button] == false
    end
end

-- update the button states for all connected joysticks
function GPM:update(dt)

end
return GPM