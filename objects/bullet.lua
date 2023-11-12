local Base = require("objects/base")

local Bullet = {}

setmetatable(Bullet,{__index = Base}) 

function Bullet:new(body, width, height, fx, fy)
  self = Base.new(self, body, width, height)

  local private = {}
  private.fx = fx 
  private.fy = fy
  local public = self

  public:applyForce(private.fx, private.fy)

  setmetatable(public,self)
  self.__index = self 
  return public

end

return Bullet