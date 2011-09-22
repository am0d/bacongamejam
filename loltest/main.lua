-- Most of this code is (currently) copied straight from the Love2D
-- site as I am just beginning to learn Lua and Love2D
-- Also from http://www.headchant.com/

function love.load()
    hero = {}
    hero.x = 300
    hero.y = 450
    hero.speed = 100
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        hero.x = hero.x - hero.speed*dt
    elseif love.keyboard.isDown("right") then
        hero.x = hero.x + hero.speed*dt
    end
end

function love.draw()
    -- draw some ground
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle("fill", 0, 465, 800, 150)

    -- draw a "hero"
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle("fill", hero.x, hero.y, 30, 15)
end
