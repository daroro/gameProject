local hero_atlas
local hero_sprite 

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    hero_atlas = love.graphics.newImage("Assets/Sprites/characters.png")
    hero_sprite = love.graphics.newQuad(6,73,18,23,hero_atlas:getDimensions())
end

function love.update(dt)
    
end 

function love.draw()
    love.graphics.draw(hero_atlas, 25, 25, 0, 1, 1)
    love.graphics.draw(hero_atlas, hero_sprite, 25, 200, 0, 4, 4)
end