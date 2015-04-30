
-----------------------------------------------------------------------------------------
--
-- 
--
-----------------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar ) 

local composer = require( "composer" )

local scene = composer.newScene()
-- Require the widget library
local widget = require( "widget" )


local ui = require("togglebutton")
local turnMusicOnOffToggleButton
local webView 
local webViewHTML = "1_instructions_text.html" 



background = display.setDefault( "background", 1, 1, 1 )


-- Our ScrollView listener
local function scrollListener( event )
  local phase = event.phase
  local direction = event.direction
  
  if "began" == phase then
    --print( "Began" )
  elseif "moved" == phase then
    --print( "Moved" )
  elseif "ended" == phase then
    --print( "Ended" )
  end
  
  -- If the scrollView has reached it's scroll limit
  if event.limitReached then
    if "up" == direction then
      print( "Reached Top Limit" )
    elseif "down" == direction then
      print( "Reached Bottom Limit" )
    elseif "left" == direction then
      print( "Reached Left Limit" )
    elseif "right" == direction then
      print( "Reached Right Limit" )
    end
  end
      
  return true
end






function scene:create( event )

  local sceneGroup = self.view

--Box to underlay our audio status text
-- gradient same as buttons 
local gradient = {
  type = 'gradient',
  --color1 = { 1, 1, 1 }, 
  color1 = {94/255,181/255,100/255},
  color2 = { 5/255, 143/255, 17/255 }, --green color taken from a background pci
  direction = "down"
}


 
  
local statusBoxHeight = 100
local statusBox = display.newRect( display.contentCenterX, display.screenOriginY, display.actualContentWidth, statusBoxHeight )
statusBox:setFillColor( gradient ) 
-- statusBox.fill = gradient
statusBox.alpha = 0.9

--Create a text object to show the current status
local statusText = display.newText( "Juhised", statusBox.x, statusBox.y+25, native.systemFontBold, 20 )

statusText:setTextColor( 0, 0, 0 )
--------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------------------------
function removeWebView()
  if (webView ~= nil) then 

    webView:removeSelf()
    webView = nil
  end

end 

--removeWebView()

function backButtonRelease()
    removeWebView()
    composer.removeScene( "1_game_instructions" )   
    composer.gotoScene( "gamelist", "fade", 100 )

  --return true -- indicates successful touch
end



 backButton = widget.newButton
{
  defaultFile = "images/back_button.png",
  overFile = "images/back_buttonOver.png",
  label = "",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onPress = backButtonPress,
  onRelease = backButtonRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
backButton.x = 30; backButton.y = statusBox.y+25
------------------------------------------------------------------





-- Game button

local gameButtonRelease = function( event )

 local turnSoundOnOffparameter = 0



 if  turnMusicOnOffToggleButton:isChecked() == true then

print ("TURN MUSIC: ON")
turnSoundOnOffparameter = 1


 end
--print(turnSoundOnOffparameter)

local params = turnSoundOnOffparameter

--print("2_game_reaction " .. params)



local options =
{
effect = "fade",
time = 200,
params = { turnMusic = turnSoundOnOffparameter }
}

  removeWebView() 
  composer.removeScene( "1_game_instructions" )      
  composer.gotoScene( "1_game_memory", options )


  return true -- indicates successful touch
end


local gameButton = widget.newButton
{
  defaultFile = "images/start_2.png",
  overFile = "images/start.png",
  label = "",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onPress = gameButtonPress,
  onRelease = gameButtonRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.

--x tuleb sellest, et buttoni suuruse X suhtes jagame kaheks ja paneme paddingu + 5
--gameButton.x = 245; gameButton.y = 480
gameButton.x = 245; gameButton.y = display.contentHeight - 30 


-- turn sounds ON or OFF button
turnMusicOnOffToggleButton = ui.newButton{text="",default = "images/soundOFF.png",  over = "images/soundON.png", checked = "images/soundON.png",onRelease = f,  textColor={ 1, 1, 1, 255 }}
turnMusicOnOffToggleButton.x = 75
turnMusicOnOffToggleButton.y =  display.contentHeight - 30   -- + button half height and padding




webView = native.newWebView( display.contentCenterX, statusBox.y+65, display.actualContentWidth, (gameButton.y-gameButton.height)-(statusBox.y+55) ) -- statusBox.y real Y position + statusbox size+padding (55) - gameButton.y-backButtonHeight
webView.anchorX = 0.5 -- makes so that top left hits statusBox left corner
webView.anchorY = 0
webView:request( webViewHTML, system.ResourceDirectory  )


--------------------------------------------------------------------------------------------------

-- Create a ScrollView
local scrollView = widget.newScrollView
{
  left = 0,
--  top = statusBox.contentWidth,
  -- (20 on selle statusboxi width+padding 25)
  top = display.screenOriginY+statusBoxHeight/2+20,
  bottom = 100,
  width = display.actualContentWidth, -- what is visible on screen
  height = display.actualContentHeight-turnMusicOnOffToggleButton.y,

  id = "onBottom",

  listener = scrollListener,
}



--[[
local contents = "Tegemata.."
--Create a text object containing the large text string and insert it into the scrollView
local lotsOfTextObject = display.newText( contents, display.contentCenterX, 0, display.actualContentWidth-50, 0, native.systemFont, 20)
lotsOfTextObject:setFillColor( 0 ) 
lotsOfTextObject.anchorY = 0.0    -- Top
--------------------------------lotsOfTextObject:setReferencePoint( display.TopCenterReferencePoint )
--lotsOfTextObject.y = titleText.y + titleText.contentHeight + 10

lotsOfTextObject.y = 0

--]]


  --sceneGroup:insert(text)
  --scrollView:insert( lotsOfTextObject )
  sceneGroup:insert(scrollView)
  sceneGroup:insert(webView)
  sceneGroup:insert(backButton)
  sceneGroup:insert(statusBox)
  sceneGroup:insert(statusText)
  sceneGroup:insert(turnMusicOnOffToggleButton)
  sceneGroup:insert(gameButton)






end


function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   print( event.phase, event.keyName )

   if ( "back" == keyName and phase == "up" ) then

  removeWebView()
  composer.removeScene( "1_game_instructions" )   
  composer.gotoScene( "mainmenu", "fade", 0 )
     return true 
   end
  return false -- to Override physical back button
end


Runtime:addEventListener( "key", onKeyEvent )




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



---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--add the key callback


-----------------------------------------------------------------------------------------

return scene
