GS = require "hump.gamestate"

--[[ RESOURCE MANAGEMENT ]]--
local function Proxy(f)
    return setmetatable({}, {__index = function(self, k)
        local v = f(k)
        rawset(self, k, v)
        return v
    end})
end

State = Proxy(function(k) return assert(love.filesystem.load('states/'..k..'.lua'))() end)


function love.load ()
    GS.registerEvents ()
    GS.switch(State.title)
end
