Ground = Class{function(self, pos)
    self.shape = Collider:addRectangle(0, 0, 100, 20)
    self.shape.object = self
    self.group = "ground"

    self.shape:moveTo(pos.x, pos.y)

    Entities.add(self, Entities.BG)
end}
make_collidable(Ground)

function Ground:remove()
    Entities.remove(self, Entities.BG)
end

function Ground:draw()
    love.graphics.setColor(0, 255, 0)
    self.shape:draw('fill')
end

