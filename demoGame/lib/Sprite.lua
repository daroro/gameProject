--creating a class Sprite and importing other classes
local class = require("lib.Class")
local Sprite = class:derive("lib.Sprite")
local Anim = require("lib.Animation")
local Vector2 = require("lib.Vector2")


--constructor for sprite class
function Sprite:new(atlas, w, h, x, y, sx, sy, angle)
    self.w = w
    self.h = h
    self.flip = Vector2(1,1)
    self.pos = Vector2(x or 0, y or 0)
    self.scale = Vector2(sx or 1, sy or 1)
    self.atlas = atlas
    self.angle = angle or 0
    self.animations = {}
    self.current_anim = ""
    self.quad = love.graphics.newQuad(0, 0, w, h, atlas:getDimensions())
end

--function to change animation of sprite
function Sprite:animate(anim_name)
    if self.current_anim ~= anim_name and self.animations[anim_name] ~= nil then
        self.current_anim = anim_name
        self.animations[anim_name]:reset()
        self.animations[anim_name]:set(self.quad)
    end
end

--function to flip the animation horizontally
function Sprite:flip_h(flip)
   if flip then
        self.flip.x = -1
   else
        self.flip.x = 1
   end 
end

--function to flip the animation vertically
function Sprite:flip_v(flip)
    if flip then
         self.flip.y = -1
    else
         self.flip.y = 1
    end 
 end
--checks if animation is finished
function Sprite:animation_finished()
    if self.animations[self.current_anim] ~= nil then
        return self.animations[self.current_anim].done
    end
    return true
end

--function to add a new animation to sprite
function Sprite:add_animation(name, anim)
    self.animations[name] = anim
end

--function to update the animation frames
function Sprite:update(dt)
    if self.animations[self.current_anim] ~= nil then
        self.animations[self.current_anim]:update(dt, self.quad)
    end
end

--function to draw the sprite
function Sprite:draw()
    love.graphics.draw(self.atlas, self.quad, self.pos.x, self.pos.y, self.angle, self.scale.x * self.flip.x , self.scale.y * self.flip.y, self.w / 2, self.h / 2)
end


return Sprite
