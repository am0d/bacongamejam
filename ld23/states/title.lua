local state = GS.new()

function state:init ()
end

function state:enter ()
end

function state:leave ()
end

function state:draw ()
    love.graphics.print("Hello, world!", 50, 50)
end

function state:update (dt)
end

function state:keypressed (key)
end

return state
