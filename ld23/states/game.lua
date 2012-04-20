local state = GS.new()

function state:init()
    Collider = HC(250, function(_,a,b,dx,dy)
        a.object:collideWith(b.object, dx,dy)
        b.object:collideWith(a.object, -dx,-dy)
    end, function(_,a,b,dx,dy)
        a.object:stopCollideWith(b.object, dx,dy)
        b.object:stopCollideWith(a.object, -dx,-dy)
    end)
end

function state:enter ()
    p = Player({x = 100, y = 200})

    for i = 0,10 do
        Ground({x = i * 100, y = 500})
    end
end

function state:leave ()
end

function state:draw ()
    Entities.draw()
end

function state:update (dt)
    Entities.update(dt)
    Collider:update(dt)
end

function state:keypressed (key)
    Entities.keyPressed(key)
end

return state
