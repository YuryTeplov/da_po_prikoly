local Base = require("objects/base")

local Actor = {}

setmetatable(Actor,{__index = Base}) 


function Actor:new(body, width, height, speed)

  self = Base.new(self, body, width, height)

  self:setUserData('actor')


  local private = {}


  private.speed = speed

  private.countBullets = 10

  private.vx = 0
  private.vy = 0

  local public = self

  function private:registerShoot()
    if private.countBullets > 0 then
      private.countBullets = private.countBullets - 1
      return true
    else 
      return false
    end

  end



  function public:shootTop(world)
    if private:registerShoot() then
      world:createBullet(public:getX(), public:getY() - public:getHeight()/2, 0, -1000)
    end
  end

  function public:shootBottom(world)
    if private:registerShoot() then
      world:createBullet(public:getX(), public:getY() + public:getHeight()/2, 0, 1000)
    end
  end

  function public:shootLeft(world)
    if private:registerShoot() then
      world:createBullet(public:getX() - public:getWidth()/2, public:getY(), -1000, 0)
    end
  end

  function public:shootRight(world)
    if private:registerShoot() then
      world:createBullet(public:getX() + public:getWidth()/2, public:getY(), 1000, 0)
    end
  end

  function public:stopMoveX()
    private.vx = 0 
    self:move(private.vx, private.vy)
  end

  function public:stopMoveY()
    private.vy = 0
    self:move(private.vx, private.vy)
  end

  function public:moveTop()
    private.vy = -private.speed
    self:move(private.vx, private.vy)
  end
   
  function public:moveDown()
    private.vy = private.speed
    self:move(private.vx, private.vy)
  end

  function public:moveLeft()
    private.vx = -private.speed
    self:move(private.vx, private.vy)
  end

  function public:moveRight()
    private.vx = private.speed
    self:move(private.vx, private.vy)
  end

  setmetatable(public,self)
  self.__index = self 
  return public
end

return Actor