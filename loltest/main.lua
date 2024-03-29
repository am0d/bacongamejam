-- Most of this code is (currently) copied straight from the Love2D
-- site as I am just beginning to learn Lua and Love2D
-- Also from http://www.headchant.com/

-- Shoot another bullet from the hero's gun
function shoot()
    local shot = {}
    shot.x = hero.x + hero.width / 2
    shot.y = hero.y
    table.insert(hero.shots, shot)
end

function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    if x1 > x2 + w2 or -- Box 1 is right of Box 2
        y1 > y2 + h2 or -- Box 1 is below Box 2
        x2 > x1 + w1 or -- Box 2 is right of Box 1
        y2 > y1 + h1    -- Box 2 is below Box 1
    then
        return false
    else
        return true
    end
end

function love.load()
    -- the hero
    hero = {}
    hero.x = 300
    hero.y = 450
    hero.width = 30
    hero.speed = 100
    hero.shots = {}

    -- the enemies
    enemies = {}
    for i=0,6 do
        enemy = {}
        enemy.width = 40
        enemy.height = 20
        enemy.x = i * (enemy.width + 60) + 100
        enemy.y = enemy.height + 100
        table.insert(enemies, enemy)
    end

    -- images
    bg = love.graphics.newImage("resources/stormclouds.bmp")

    -- the game itself
    game = {}
    game.state = "start"
    game.level = 1
end

function love.update(dt)
    if game.state == "play" then
        if love.keyboard.isDown("left") then
            hero.x = hero.x - hero.speed*dt
        elseif love.keyboard.isDown("right") then
            hero.x = hero.x + hero.speed*dt
        end

        for i,v in ipairs(enemies) do
            -- enemies slowly drift down
            v.y = v.y + dt * game.level * game.level * 2

            -- check for collision with ground
            if v.y > 465 then
                -- DIE!!!
                game.state = "dead"
            end
        end

        -- update bullets and remove any dead enemies
        local remShots = {}
        local remEnemies = {}
        for i,v in ipairs(hero.shots) do
            v.y = v.y - dt * 100

            if (v.y < 0) then
                table.insert(remShots, i)
            end

            -- check for hits
            for ii,vv in ipairs(enemies) do
                if CheckCollision(v.x, v.y, 2, 5, vv.x, vv.y, vv.width, vv.height) then
                    table.insert(remEnemies, ii)
                    table.insert(remShots, i)
                end
            end
        end

        for i,v in ipairs(remEnemies) do
            table.remove(enemies, v)
        end
        for i,v in ipairs(remShots) do
            table.remove(hero.shots, v)
        end

        -- count how many enemies are left
        local numEnemies = 0
        for i,v in ipairs(enemies) do
            numEnemies = numEnemies + 1
        end
        if numEnemies == 0 then
            game.level = game.level + 1
            if game.level > 3 then
                game.state = "win"
            else
                -- reset enemies
                enemies = {}
                for i=0,6 do
                    enemy = {}
                    enemy.width = 40
                    enemy.height = 20
                    enemy.x = i * (enemy.width + 60) + 100
                    enemy.y = enemy.height + 100
                    table.insert(enemies, enemy)
                end

                -- remove all the bullets from the screen
                for i,v in ipairs(hero.shots) do
                    hero.shots[i] = nil
                end
            end
        end
    end
end

function love.draw()
    if game.state == "start" then
        -- start screen
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.print("Press any key to start ...", 350, 400)
    elseif game.state == "play" then
        -- draw the background
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(bg)

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

        -- draw the hero's bullets
        love.graphics.setColor(255, 255, 255, 255)
        for i,v in ipairs(hero.shots) do
            love.graphics.rectangle("fill", v.x, v.y, 2, 5)
        end

        -- draw the level on the screen
        love.graphics.setColor(0, 255, 255, 255)
        love.graphics.print("Level: ", 20, 20)
        love.graphics.print(game.level, 60, 20)
    elseif game.state == "dead" then
        -- lost the game
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.print("Game Over :(", 300, 300)
    elseif game.state == "win" then
        -- won the game
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.print("You Win! :)", 300, 300)
    end
end

function love.keypressed(key)
    if game.state == "start" then
        game.state = "play"
    end
end

function love.keyreleased(key)
    if game.state == "play" then
        if (key == " ") then
            shoot()
        end
    end
end
