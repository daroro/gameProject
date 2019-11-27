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
local walk = Anim(6, 64, 32, 32, 4, 4, 12)

--function the gets carried out when love.exe is loaded
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    hero_atlas = love.graphics.newImage("Assets/Sprites/characters.png")
    spr = Sprite(hero_atlas, 32, 32, 100, 100, 1, 1, 0)
    spr:add_animation("walk", walk)
    spr:animate("walk")
end

--function that gets carried out every x milliseconds.
function love.update(dt)
    if dt >0.035 then return end
    
    spr:update(dt)
end 

--drawing function
function love.draw()
    love.graphics.clear(64, 64, 255)
    spr:draw()
end




