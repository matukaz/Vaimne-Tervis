
-----------------------------------------------------------------------------------------
--
-- 
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )

local scene = composer.newScene()
-- Require the widget library
local widget = require( "widget" )


-- CREATE OBJECTS
function scene:create( event )
  local sceneGroup = self.view
  

--  sceneGroup:insert()
end




function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase




  
  if phase == "will" then


    -- Called when the scene is still off screen and is about to move on screen
  elseif phase == "did" then
    -- Called when the scene is now on screen
    -- 
    -- INSERT code here to make the scene come alive
    -- e.g. start timers, begin animation, play audio, etc.
  end 
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase
  
  if event.phase == "will" then
    -- Called when the scene is on screen and is about to move off screen
    --background:removeSelf()
    --background = nil


    -- INSERT code here to pause the scene
    -- e.g. stop timers, stop animation, unload sounds, etc.)
  elseif phase == "did" then
    -- Called when the scene is now off screen
    


  end 
end

function scene:destroy( event )
  local sceneGroup = self.view
  
--  audio.stop(backgroundSound)

--  background:removeSelf()
--  background = nil

  
  -- Called prior to the removal of scene's "view" (sceneGroup)
  -- 
  -- INSERT code here to cleanup the scene
  -- e.g. remove display objects, remove touch listeners, save state, etc.
  
--  if button1 then
--    button1:removeSelf()  -- widgets must be manually removed
--    button1 = nil
--  end
end





---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
