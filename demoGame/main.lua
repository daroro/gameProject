local hero_atlas
local hero_sprite 

--animation parameters
local fps = 10
local anim_timer = 1 / fps
local frame = 1
local num_frames = 4
local xoffset 


function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    hero_atlas = love.graphics.newImage("Assets/Sprites/characters.png")
    hero_sprite = love.graphics.newQuad(6,64,32,32,hero_atlas:getDimensions())
end

function love.update(dt)
    if dt >0.035 then return end

    anim_timer = anim_timer - dt
    if anim_timer <= 0 then
        anim_timer = 1 / fps
        frame = frame + 1

        if frame > num_frames then
            frame = 1
        end

        xoffset = 32 * frame 
        hero_sprite:setViewport(xoffset, 64, 32, 32)
    end
end 

function love.draw()
    love.graphics.draw(hero_atlas, hero_sprite, 320, 180, 0, 4, 4, 16, 16)
end