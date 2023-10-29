local World = require('objects/world')

function love.load()

  --song = love.audio.newSource("source/song.ogg", "stream")

  --song:play()


  world = World:new()


  actor = world:getMainActor()


end

function love.update(dt)
  world:update(dt)
end


function love.draw()

  love.graphics.setColor(255, 255, 255)

  world:draw()

end



function love.mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
end

function love.keypressed(key)
  if key == "space" then 
    world:createObject()
  end

  if key == "e" then
    
  end

  if key == 'up' then
    actor:shootTop(world)
  end
  if key == 'down' then
    actor:shootBottom(world)
  end
  if key == 'left' then
    actor:shootLeft(world)
  end
  if key == 'right' then
    actor:shootRight(world)
  end

  if key == 'w' then
    actor:moveTop()
  end
  if key == 's' then
    actor:moveDown()
  end
  if key == 'a' then
    actor:moveLeft()
  end
  if key == 'd' then
    actor:moveRight()
  end
end

function love.keyreleased(key)

  if (key == 'w' or key == 's') and not (love.keyboard.isDown('w') or love.keyboard.isDown('s')) then
    actor:stopMoveY()
  end
  if (key == 'a' or key == 'd') and not (love.keyboard.isDown('a') or love.keyboard.isDown('d')) then
    actor:stopMoveX()
  end

end

function love.focus(f)
  if not f then 
    print("LOST FOCUS")
  else 
    print("GAINED FOCUS")
  end
end

function love.quit()
  print("game quit")
end