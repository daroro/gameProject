local Anim = require("Animation")
local Sprite = require("Sprite")
local Key = require("Keyboard")
local Evt = require("Events")

local hero_atlas
local angle = 0

--animation parameters-
local fps = 12
local anim_timer = 1 / fps
local frame = 1
local num_frames = 6
local xoffset
-----------------------

local spr 
local idle = Anim(16, 16, 16, 16, 4, 4, 6 )
local walk = Anim(16, 32, 16, 16, 6, 6, 12)
local swim = Anim(16, 64, 16, 16, 6, 6, 12)
local hit = Anim(16, 80, 16, 16, 3, 3, 10, false)
local sound = love.audio.newSource("Assets/Music/punch.mp3", "static")
local e

--function the gets carried out when love.exe is loaded
function love.load()
    Key:hook_love_events()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    hero_atlas = love.graphics.newImage("Assets/Sprites/hero.png")
    spr = Sprite(hero_atlas, 16, 16, 100, 100, 5, 5, 0)
    spr:add_animation("walk", walk)
    spr:add_animation("idle", idle)
    spr:add_animation("hit", hit)
    spr:add_animation("swim", swim)
    spr:animate("walk")
    e = Evt()
    e:add('on_space')
    e:hook('on_space', on_space)

end

function on_space()
    print("Spaced!")
end

--function that gets carried out every x milliseconds.
function love.update(dt)
    if dt >0.035 then return end
    
    if Key:key_down("space") and spr.current_anim ~= "hit" then
        spr:animate("hit")
        love.audio.stop(sound)
        love.audio.play(sound)
        e:invoke('on_space')
    elseif Key:key_down("u") then
        e:unhook("on_space", on_space)
    elseif Key:key_down("a") then
        spr:flip_h(true)
    elseif Key:key_down("d") then
        spr:flip_h(false)
    elseif Key:key_down("escape") then
        love.event.quit()
    end
    if spr.current_anim == "hit" and spr:animation_finished() then
        spr:animate("walk")
    end
    
    Key:update(dt)
    spr:update(dt)
end 

--drawing function
function love.draw()
    love.graphics.clear(64, 64, 255)
    spr:draw()
end




 