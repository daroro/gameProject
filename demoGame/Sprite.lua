local class = require("class")
local Anim = require("Animation")
local Sprite = class:derive("Sprite")


--constructor for sprite class
function Sprite:new(atlas, w, h)
    self.w = w
    self.h = h
    self.atlas = atlas
    self.animations = {}
    self.current_anim = ""
    quad = hero_sprite = love.graphics.newQuad(0, 0, w, h, atlas:getDimensions())
end

function Sprite:animate(anim_name)
    if self.current_anim ~= anim_name and self.animations[anim_name] ~= nil then
        self.animations[anim_name]:set(self.quad)
        self.current_anim = anim_name
    end
end

function Sprite:update(dt)
    if self.animations[anim_name] ~= nil then
        self.animations[anim_name]:update(dt, self.quad)
    end
end

function Sprite:draw()
    love.graphics.draw(hero_atlas, hero_sprite, self.x, self.y, 0, 1, 1  , self.w / 2, self.h / 2)
end


return Sprite