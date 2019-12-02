-- This module keeps track if keys are pressed / released

local Keyboard = {}
--table containing keys that have been pressed 

--for current frame
local key_states = {} 

function Keyboard:update(dt)
    for k,v in pairs(key_states) do
        key_states[k] = nil
    end
end

-- returns current state of the given key
function Keyboard:key(key)
    return love.keyboard.isDown(key)
end

-- returns if key has been pressed at THIS frame
function Keyboard:key_down(key)
    return key_states[key]
end

-- returns if key has been unpressed at THis frame
function Keyboard:key_up(key)
    return key_states[key] == false
end

function Keyboard:hook_love_events()
    function love.keypressed(key, scancode, isrepeat)
        key_states[key] = true
    end
    function love.keyreleased(key, scancode, isrepeat)
        key_states[key] = false
    end
end

return Keyboard