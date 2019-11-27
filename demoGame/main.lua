local Anim = require("Animation")
local Sprite = require("Sprite")

local hero_atlas
local hero_sprite 

--animation parameters
local fps = 10
local anim_timer = 1 / fps
local frame = 1
local num_frames = 4
local xoffset 
----------------------
local spr 
local a = Anim(6, 64, 32, 32, 6, 6, 12)

--functiobn the gets carried out when love.exe is loaded
function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    hero_atlas = love.graphics.newImage("Assets/Sprites/characters.png")
    hero_sprite = love.graphics.newQuad(6,64,32,32,hero_atlas:getDimensions())
    spr = Sprite(hero_atlas, 16, 16, 100, 100, 10, 10)
    spr:add_animation("walk", a)
    spr:animate("walk")
end

--function that gets carried out every x milliseconds.
function love.update(dt)
    if dt >0.035 then return end
    
    a:update(dt, hero_sprite)
end 

--drawing function
function love.draw()
    love.graphics.clear(0, 2, 10)
    spr.draw()
end