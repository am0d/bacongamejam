Player = Class{function(self, pos)
    self.shape = Collider:addRectangle(0, 0, 20, 50)
    self.shape.object = self
    self.group = "Player"

    self.shape:moveTo(pos.x, pos.y)

    Entities.add(self, Entities.MID)
end}
make_collidable(Player)

function Player:remove()
    Entities.remove(self, Entities.MID)
end

function Player:draw()
    self.shape:draw('fill')
end
