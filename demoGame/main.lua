local Anim = require("Animation")

local hero_atlas
local hero_sprite 


--animation parameters
local fps = 10
local anim_timer = 1 / fps
local frame = 1
local num_frames = 4
local xoffset 
----------------------

local a = Anim(6, 64, 32, 32, 6, 6, 12)

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    hero_atlas = love.graphics.newImage("Assets/Sprites/characters.png")
    hero_sprite = love.graphics.newQuad(6,64,32,32,hero_atlas:getDimensions())

    local an = Anim(xoffset, yoffset, w, h, column_size, num_frames, fps)
end

function love.update(dt)
    if dt >0.035 then return end
    
    a:update(dt, hero_sprite)
end 

function love.draw()
    love.graphics.clear(0, 2, 10)
    love.graphics.draw(hero_atlas, hero_sprite, 320, 180, 0, 4, 4, 16, 16)
end