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
end

function state:leave ()
end

function state:draw ()
    Entities.draw()
end

function state:update (dt)
end

function state:keypressed (key)
end

return state
