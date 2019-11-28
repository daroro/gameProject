local Anim = require("Animation")
local Sprite = require("Sprite")

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
local walk = Anim(6, 32, 32, 32, 4, 4, 12)
local jump = Anim(134, 32, 32, 32, 4, 4, 12)
local hit = Anim(262, 32, 32, 32, 4, 4, 12, false)
local climb = Anim(582, 32, 32, 32, 3, 3, 12)
local sound = love.audio.newSource("Assets/Music/punch.mp3", "static")

--function the gets carried out when love.exe is loaded
function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    hero_atlas = love.graphics.newImage("Assets/Sprites/characters.png")
    spr = Sprite(hero_atlas, 32, 32, 100, 100, 5, 5, 0)
    spr:add_animation("walk", walk)
    spr:add_animation("jump", jump)
    spr:add_animation("hit", hit)
    spr:add_animation("climb", climb)
    spr:animate("walk")
    -- spr:animate("punch")
    -- spr:animate("jump")
    -- spr:animate("hit")
    -- spr:animate("climb")


end

--function that gets carried out every x milliseconds.
function love.update(dt)
    if dt >0.035 then return end
    
    if spr.current_anim == "hit" and spr:animation_finished() then
        spr:animate("walk")
    end
    
    spr:update(dt)
end 

--drawing function
function love.draw()
    love.graphics.clear(64, 64, 255)
    spr:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" and spr.current_anim ~= "punch" then 
        spr:animate("hit")
        love.audio.stop(sound)
        love.audio.play(sound)
    end
end


