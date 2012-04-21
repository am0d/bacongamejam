MAX_VEL = 10
GRAVITY = 10

Player = Class{function(self, pos)
    self.shape = Collider:addRectangle(0, 0, 20, 50)
    self.shape.object = self
    self.group = "Player"

    self.velocity = vector(0, 0)
    self.shape:moveTo(pos.x, pos.y)

    Entities.add(self, Entities.MID)
end}
make_collidable(Player)

function Player:remove()
    Entities.remove(self, Entities.MID)
end

function Player:update(dt)
    local dv = vector(0, GRAVITY)

    if love.keyboard.isDown('right') then
        dv.x = dv.x + MAX_VEL
    end
    if love.keyboard.isDown('left') then
        dv.x = dv.x - MAX_VEL
    end
    if math.abs(self.velocity.x) < MAX_VEL / 4 and dv.x == 0 then
        self.velocity.x = 0
    elseif dv.x == 0 then
        dv.x = -MAX_VEL
    end
    self.velocity = self.velocity + dv * dt
    if math.abs(self.velocity.x) > MAX_VEL then
        self.velocity.x = self.velocity.x / math.abs(self.velocity.x) * MAX_VEL
    end

    self.shape:move(self.velocity)
end

function Player:keyPressed(key)
    if key == 'up' then
        self.velocity.y = -GRAVITY
    end
end

function Player:draw()
    love.graphics.setColor(255, 0, 255)
    self.shape:draw('fill')
end

Player:onCollide("ground", function (self, other, dx, dy)
    self.shape:move(dx, dy)
    self.velocity.y = 0
end)
