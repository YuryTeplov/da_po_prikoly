local Base = {}

function Base:new(body, width, height, texture)

  local private = {}

  private.texture = texture or love.graphics.newImage("source/actor.jpg")
  private.body = body
  private.width = width or 100
  private.height = height or 100
  private.shape = love.physics.newRectangleShape(private.width, private.height)
  private.fixture = love.physics.newFixture(private.body, private.shape)

  private.fixture:setUserData(self)


  local public = {}

  function public:disableRotation()
    private.body:setFixedRotation(true)
  end

  function public:draw()

    love.graphics.push()


    love.graphics.setColor(100, 0, 100)
    --love.graphics.draw(
    --  private.texture, 
    --  - private.width/2, 
    --  - private.height/2, 
    --  private.body:getAngle(), 
    --  private.width/private.texture:getWidth(), 
    --  private.height/private.texture:getHeight(),
    --  private.width/2,
    --  private.height/2
    --)
    local points = {private.shape:getPoints()}
    local angle = private.body:getAngle()
    local x, y = private.body:getPosition()

    love.graphics.translate(x, y)
    love.graphics.rotate(angle)
    love.graphics.polygon("line", points)
    love.graphics.setColor(255, 255, 255)
    love.graphics.pop()
  end

  function public:move(x, y)
    private.body:setLinearVelocity(x, y)
  end

  function public:getX() 
    return private.body:getX()
  end

  function public:getY() 
    return private.body:getY()
  end

  function public:getWidth()
    return private.width
  end

  function public:getHeight()
    return private.height
  end

  function public:applyForce(fx, fy)
    private.body:applyForce(fx, fy)
  end


  public:disableRotation()



  setmetatable(public,self)
  self.__index = self 
  return public
end

function Base:touch(object_name) 
  print(object_name)

end

return Base