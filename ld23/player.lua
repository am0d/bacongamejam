MAX_VEL = 50

Player = Class{function(self, pos)
    self.shape = Collider:addRectangle(0, 0, 20, 50)
    self.shape.object = self
    self.group = "Player"

    self.dy = 10
    self.ay = 0
    self.shape:moveTo(pos.x, pos.y)

    Entities.add(self, Entities.MID)
end}
make_collidable(Player)

function Player:remove()
    Entities.remove(self, Entities.MID)
end

function Player:update(dt)
    local dx = 0
    local dy = 0
    if love.keyboard.isDown('right') then
        dx = dx + 1
    end
    if love.keyboard.isDown('left') then
        dx = dx - 1
    end
    dx = dx * dt * MAX_VEL
    dy = self.dy * dt

    self.shape:move(dx, dy)
end

function Player:draw()
    love.graphics.setColor(255, 0, 255)
    self.shape:draw('fill')
end

Player:onCollide("ground", function (self, other, dx, dy)
    self.shape:move(dx, dy)
    self.dy = 0
end)
