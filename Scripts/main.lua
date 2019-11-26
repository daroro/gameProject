local x = 120
local dir = 1

function love.load()
    print("console!")
end

function love.update(dt)
    if x >= 500 or x < 100 then
        dir = dir * -1
    end

    x = x + dir * 100 * dt
    
end 

function love.draw()
    love.graphics.setColor(133,123,30)
    love.graphics.print("bye", 10, 100)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill",x,100,100,100)
end