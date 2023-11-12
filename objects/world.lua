local Base = require("objects/base")
local Actor = require("objects/actor")
local Bullet = require("objects/bullet")

local World = {}

function World:new()

  local private = {}


  love.physics.setMeter(32)
  private.world = love.physics.newWorld(0, 0, true)

  private.background_image = love.graphics.newImage('source/background.jpg')

  private.objectList = {}

  private.actor = Actor:new(love.physics.newBody(private.world, 400, 200, "dynamic"), 50, 100, 300)

  table.insert(private.objectList, private.actor)

  local public = {}

  function public:draw()

    love.graphics.translate(-private.actor:getX() + 400, -private.actor:getY() + 300)

    love.graphics.draw(private.background_image, 0, 0)

    for i,v in ipairs(private.objectList) do 
      v:draw()
    end

    love.graphics.origin()
  end

  function public:update(dt)
    private.world:update(dt)
  end

  function public:getMainActor()
    return private.actor
  end

  function public:createBullet(px, py, fx, fy) 
    local b = Bullet:new(love.physics.newBody(private.world, px, py, "dynamic"), 10, 10, fx, fy)

    table.insert(private.objectList, b)
  end

  function public:createObject()

    local b = Base:new(love.physics.newBody(private.world, math.random(100, 500), math.random(100, 500), "dynamic"), 100, 50)

    table.insert(private.objectList, b)

  end

  function contactHandler(a, b, coll)
    local entityA = a:getUserData()
    local entityB = b:getUserData()

    entityA:touch('1')
    entityB:touch('2')

  end

  private.world:setCallbacks(contactHandler, nil, nil, nil)


  setmetatable(public,self)
  self.__index = self 
  return public

end

return World