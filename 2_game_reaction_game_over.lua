
-----------------------------------------------------------------------------------------
--
-- 
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )

local scene = composer.newScene()
-- Require the widget library
local widget = require( "widget" )


display.setStatusBar( display.HiddenStatusBar ) 


local isAndroid = "Android" == system.getInfo("platformName")
--local debug
-- CREATE OBJECTS
function scene:create( event )
    local sceneGroup = self.view
  -- get passed parameters from last scene
   local params = event.params
  ---------------------------------------------------------------------------------------------------------------
local turnmusicOnOrOff = params[table.maxn(params)]

table.remove(params,table.maxn(params))


local lastGameScore = params[table.maxn(params)]
local highScore


  -- get highscore from database
  local dbPath = system.pathForFile("gamescores.db", system.DocumentsDirectory)
  local db = sqlite3.open( dbPath ) 
  for row in db:nrows("SELECT * FROM gamescores WHERE id=1") do
  print("printing")
  --  local text = row.score.." "..row.highscore
   highScore =  tonumber(row.highscorereaction)
  
  print (highScore)
  print("HIGHSCROE!!")
  end


-- update highscore 
  if lastGameScore > highScore then
          -- siia panna image " new high score "
          highScore = lastGameScore
        local update = "UPDATE gamescores SET highscorereaction ='"..lastGameScore.."',lastscorereaction ='"..lastGameScore.."'  WHERE id = 1"
      db:exec(update)

    else
print("no new highscore set")
 local update = "UPDATE gamescores SET lastscorereaction ='".. lastGameScore .."' WHERE id = 1"
 db:exec(update)


  end








-------------------------------------------------------------------------------------------------------------------



display.setDefault( "background", 1, 1, 1 )


-- gradient for top box
local gradient = {
  type = 'gradient',
  --color1 = { 1, 1, 1 }, 
  color1 = {255/255,230/255,70/255},
  color2 = { 235/255, 205/255, 25/255 }, --green color taken from a background pci
  direction = "down"
}





 


local statusBoxHeight = 100
local statusBox = display.newRect( display.contentCenterX, display.screenOriginY, display.actualContentWidth, statusBoxHeight )
statusBox:setFillColor( gradient ) 
-- statusBox.fill = gradient
statusBox.alpha = 0.9
--]]

--Create a text object to show the current status
local statusText = display.newText( "", statusBox.x, statusBox.y+25, native.systemFontBold, 18 )


local BestScoreText = display.newText( "Skoor: ".. lastGameScore, display.contentCenterX, display.actualContentWidth*0.20, native.systemFontBold, 20 )
local lastGameScoreText = display.newText( "Parim skoor: " .. highScore , display.contentCenterX, BestScoreText.y+30, native.systemFontBold, 20 )
BestScoreText:setFillColor( 0, 0, 0 )
lastGameScoreText:setFillColor( 0, 0, 0 )

--DEBUG messages in commandline
print("Game over vaade 2_game_reaction_game_over")




---------------------------------------------------------------------------------------------
local restartGameRelease = function( event )

 -- scrollView:removeSelf()     -- Hide keyboard when the user clicks restartGameButton
 
  composer.gotoScene( "2_game_reaction", "fade", 100 )
  composer.removeScene( "2_game_reaction_game_over" )      
          
  return true -- indicates successful touch
end

function backButtonRelease()


 -- scrollView:removeSelf()     -- Hide keyboard when the user clicks restartGameButton
 
  composer.gotoScene( "gamelist", "fade", 100 )
  composer.removeScene( "2_game_reaction_game_over" )      
          
  return true -- indicates successful touch
end

--[[

local restartGameButton = widget.newButton
{
  defaultFile = "images/buttonGreen.png",
  overFile = "images/buttonGreenOver.png",
  label = "Mängi uuesti",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onPress = nextGamePress,
  onRelease = restartGameRelease,
}
restartGameButton.x = display.contentCenterX; restartGameButton.y = 230+60

   
sceneGroup:insert(restartGameButton)
--]]
---------------------------------------------------------------------------------------------




local restartGameButtonOnStatusBoxOnPress = function( event )



    local options =
    {
    effect = "fade",
    time = 100,
    params = { turnMusic = turnmusicOnOrOff }
    }

  composer.gotoScene( "2_game_reaction", options )
  composer.removeScene( "2_game_reaction_game_over" )      
  
  return true -- indicates successful touch
end





---------------------------------------------------------------------------------------------
local restartGameButton = widget.newButton
{
  defaultFile = "images/button/blue.png",
  overFile = "images/button/blueover.png",
  label = "Restart",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onPress = restartGameButtonOnStatusBoxOnPress,
}
-- below  
--restartGameButton.x = display.contentCenterX; restartGameButton.y = display.actualContentHeight-100
restartGameButton.x = display.contentCenterX; restartGameButton.y = display.contentCenterY+100
sceneGroup:insert(restartGameButton)

-----------------------------------------------------------------------------------------------------------------------------------------------------------
 
local nextGameButton = widget.newButton
{
  defaultFile = "images/button/green.png",
  overFile = "images/button/greenover.png",
  label = "Menüü",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onPress = nextGamePress,
  onRelease = backButtonRelease,
}
nextGameButton.x = display.contentCenterX; nextGameButton.y =  restartGameButton.y - 60
sceneGroup:insert(nextGameButton)
 

 restartGameButtonOnStatusBox = widget.newButton
{
  defaultFile = "images/arrowcircle.png",
  overFile = "images/arrowcircle.png",
  label = "",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },  
  onPress = restartGameButtonOnStatusBoxOnPress,

}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
restartGameButtonOnStatusBox.x = display.actualContentWidth-30; restartGameButtonOnStatusBox.y = statusBox.y+25
sceneGroup:insert( restartGameButtonOnStatusBox)

backButton = widget.newButton
{
  defaultFile = "images/back_button.png",
  overFile = "images/back_buttonOver.png",
  label = "",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
   onPress = nextGamePress,
  onRelease = backButtonRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
backButton.x = 30; backButton.y = statusBox.y+25
sceneGroup:insert(backButton)





--  sceneGroup:insert()
sceneGroup:insert(statusBox)
sceneGroup:insert(statusText)
sceneGroup:insert(lastGameScoreText)
sceneGroup:insert(BestScoreText)



end



---------------------------------------------------------------------------------------------
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
  
  -- Called prior to the removal of scene's "view" (sceneGroup)
  -- 
  -- INSERT code here to cleanup the scene
  -- e.g. remove display objects, remove touch listeners, save state, etc.
end
--[[
function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   print( event.phase, event.keyName )

   if ( "back" == keyName and phase == "up" ) then

    composer.gotoScene( "gamelist", "fade", 100 )
    composer.removeScene( "2_game_reaction_game_over" )        
   end
  return true -- to Override physical back button
end
Runtime:addEventListener( "key", onKeyEvent )
--]]
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
