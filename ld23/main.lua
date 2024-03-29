HC = require "HardonCollider"
Class = require "hump.class"
GS = require "hump.gamestate"
vector = require "hump.vector"

_NULL_ = function () end

--[[ RESOURCE MANAGEMENT ]]--
local function Proxy(f)
    return setmetatable({}, {__index = function(self, k)
        local v = f(k)
        rawset(self, k, v)
        return v
    end})
end

State = Proxy(function(k) return assert(love.filesystem.load('states/'..k..'.lua'))() end)

require 'collidable'
require 'entities'

require 'player'
require 'ground'

function love.load ()
    GS.registerEvents ()
    GS.switch(State.game)
end
