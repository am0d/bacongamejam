-- Most of this code is (currently) copied straight from the Love2D
-- site as I am just beginning to learn Lua and Love2D
-- Also from http://www.headchant.com/

function love.load()
    hero = {}
    hero.x = 300
    hero.y = 450
    hero.speed = 100
    enemies = {}
    for i=0,7 do
        enemy = {}
        enemy.width = 40
        enemy.height = 20
        enemy.x = i * (enemy.width + 60) + 100
        enemy.y = enemy.height + 100
        table.insert(enemies, enemy)
    end
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        hero.x = hero.x - hero.speed*dt
    elseif love.keyboard.isDown("right") then
        hero.x = hero.x + hero.speed*dt
    end

    for i,v in ipairs(enemies) do
        -- enemies slowly drift down
        v.y = v.y + dt

        -- check for collision with ground
        if v.y > 465 then
            -- DIE!!!
        end
    end
end

function love.draw()
    -- draw some ground
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle("fill", 0, 465, 800, 150)

    -- draw a "hero"
    love.graphics.setColor(0, 0, 255, 255)
    love.graphics.rectangle("fill", hero.x, hero.y, 30, 15)
    
    -- draw the "enemies"
    love.graphics.setColor(255, 0, 0, 255)
    for i,v in ipairs(enemies) do
        love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    end
end
