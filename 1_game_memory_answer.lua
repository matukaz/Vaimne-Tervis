---------------------------------------------------------------------------------------------
--
-- 
--
---------------------------------------------------------------------------------------------


local composer = require( "composer" )

local scene = composer.newScene()
-- Require the widget library
local widget = require( "widget" )


display.setStatusBar( display.HiddenStatusBar ) 

-- CREATE OBJECTS
function scene:create( event )
  local sceneGroup = self.view
display.setDefault( "background", 1, 1, 1 )

local backButton

local areAnswersVisible = false

local maxAnswers = 8
local answer = {}
-- false answer -1
local person_answers ={-1,-1,-1,-1,-1,-1,-1,-1}
-- get numbers from the last scene (1_game_memory)
answer = event.params

local turnmusicOnOrOff = answer[table.maxn(answer)]

print(turnmusicOnOrOff.. " Turnmusic")


-- gradient for top box
local gradient = {
  type = 'gradient',
  --color1 = { 1, 1, 1 }, 
  color1 = {76/255,143/255,199/255},
  color2 = { 57/255, 107/255, 149/255 }, --green color
  direction = "down"
}

-- This is the top box
local statusBoxHeight = 100
local statusBox = display.newRect( display.contentCenterX, display.screenOriginY, display.actualContentWidth, statusBoxHeight )
statusBox:setFillColor( gradient ) 
-- statusBox.fill = gradient
statusBox.alpha = 0.9
--Create a text object to show the current status
local statusText = display.newText( "", statusBox.x, statusBox.y, native.systemFontBold, 18 )

--DEBUG messages in commandline
print("Vastuste/Answer vaade 1_game_memory")
print ( table.concat(answer, ", ") )

local answerLabels = display.newText("Sisesta numbrid õiges järjekorras!", display.contentCenterX, 38, native.systemFontBold, 18)
answerLabels:setFillColor( 0, 0, 0 )



local function textListener( event )
    if event.phase == "began" then
      event.target.text=''
      event.text=''


--statusText = display.newText( event.target.name, statusBox.x, statusBox.y, native.systemFontBold, 18 )

    elseif event.phase == "ended" then

        -- textField/Box loses focus
    elseif event.phase == "ended" or event.phase == "submitted" then


    elseif event.phase == "editing" then
    local txt = event.text            
            if(string.len(txt)>2)then
                txt=string.sub(txt, 1, 2)
                event.target.text=txt
            end

    table.remove(person_answers,event.target.id)
    table.insert(person_answers,event.target.id,event.target.text )
    
    end
end




---------------------------------------------------------------------------------------------

-- this is background for answer once answers are submitted alpha = 1 that means they will show if answer is right(green) or wrong(red)
local rightAnswerBoxes = {}

  local tHeight = 40
  local tWidth = 110
  local borders = 2

rightAnswerBoxes[1] = display.newRoundedRect( 80, 78, tWidth+borders, tHeight+borders, 3)

rightAnswerBoxes[2] = display.newRoundedRect( 240, 78, tWidth+borders, tHeight+borders, 3)

rightAnswerBoxes[3] = display.newRoundedRect( 80, 128, tWidth+borders, tHeight+borders, 3)

rightAnswerBoxes[4] = display.newRoundedRect( 240, 128,tWidth+borders, tHeight+borders, 3)

rightAnswerBoxes[5] = display.newRoundedRect( 80, 178, tWidth+borders, tHeight+borders, 3)

rightAnswerBoxes[6] = display.newRoundedRect( 240, 178, tWidth+borders, tHeight+borders, 3)

rightAnswerBoxes[7] = display.newRoundedRect( 80, 228,tWidth+borders, tHeight+borders, 3)

rightAnswerBoxes[8] = display.newRoundedRect( 240, 228, tWidth+borders, tHeight+borders, 3)

-- Add options to all of the rightAnswerBoxes
for _, rightAnswerBox in ipairs(rightAnswerBoxes) do
  rightAnswerBox:setFillColor(127/255,255/255,0) -- kõigile green background.
  rightAnswerBox.strokeWidth = 0
  rightAnswerBox.alpha = 0
  sceneGroup:insert(rightAnswerBox)
end



---------------------------------------------------------------------------------------------

      local textFieldArrays = {}

    	textFieldArrays[1] = native.newTextField( 80, 80,  tWidth, tHeight )
		textFieldArrays[1].text = "esimene"


    	textFieldArrays[2] = native.newTextField( 240, 80, tWidth, tHeight )
    	textFieldArrays[2].text = "teine"

    	textFieldArrays[3] = native.newTextField( 80, 130, tWidth, tHeight )
    	textFieldArrays[3].text = "kolmas"

    	textFieldArrays[4] = native.newTextField( 240, 130, tWidth, tHeight )
    	textFieldArrays[4].text = "neljas"

    	textFieldArrays[5] = native.newTextField( 80, 180, tWidth, tHeight ) 
    	textFieldArrays[5].text = "viies"   

    	textFieldArrays[6] = native.newTextField( 240, 180, tWidth, tHeight )
    	textFieldArrays[6].text = "kuues"

    	textFieldArrays[7] = native.newTextField( 80, 230, tWidth, tHeight )  
    	textFieldArrays[7].text = "seitsmes"

    	textFieldArrays[8] = native.newTextField( 240, 230, tWidth, tHeight )   
    	textFieldArrays[8].text = "kaheksas"
 

  for _, textFieldArray in ipairs(textFieldArrays) do
     
	    textFieldArray:addEventListener( "userInput", textListener )
	    textFieldArray.inputType = "number"
	    textFieldArray.font = native.newFont( "Helvetica-Bold", 16 )
	    textFieldArray:setTextColor( 0.5, 0.5, 0.5 )
		textFieldArray.id = _
	    sceneGroup:insert(textFieldArray)
	end


---------------------------------------------------------------------------------------------
local nextGameRelease = function( event )

 -- scrollView:removeSelf()     -- Hide keyboard when the user clicks nextGameButton
  native.setKeyboardFocus( nil )
  composer.gotoScene( "gamelist", "fade", 100 )
  composer.removeScene( "1_game_memory_answer" )      
          
  return true -- indicates successful touch
end




local restartGameButtonOnStatusBoxOnPress = function( event )

  print("backButtonRelease function")

  local options =
  {
  effect = "fade",
  time = 100,
  params = { turnMusic = turnmusicOnOrOff }
  }

  composer.gotoScene( "1_game_memory", options )
  composer.removeScene( "1_game_memory_answer" )      

  
  return true -- indicates successful touch
end



---------------------------------------------------------------------------------------------
local submitRelease = function( event )
if areAnswersVisible == true then
nextGameRelease()

end

areAnswersVisible = true
backButton.alpha = 1
submitCheckMarkButton.isVisible = false

 restartGameButtonOnStatusBox.isVisible = true





	native.setKeyboardFocus( nil )
	local rightAnswers = 0
	for i=1,#answer-1 do
		
        if  answer[i] ==  tonumber(person_answers[i]) then
        rightAnswers = rightAnswers + 1
	rightAnswerBoxes[i].alpha = 1
	else 
		rightAnswerBoxes[i]:setFillColor(1,0,0)
		rightAnswerBoxes[i].alpha = 1 -- kõigile red background valedele vastustele.
	    end
    end
---------------------------------------------------------------------------------------------

-- TODO _ näidata ka millised vastused olig õiged ja millised valed.
--[[
elseif string.len(renameBox.text) == 0 then
            local alert = native.showAlert( "Warning", "You have not entered anything.", { "OK" }, onComplete )
            
        end 
        --]]
--  local alert = native.showAlert( "Warning", "You have not entered anything.", { "OK" }, onComplete )

if(answerLabels ~=nil) then
answerLabels:removeSelf()
answerLabels=nil
end

local answerLabels = display.newText(rightAnswers .. "/8 õiget vastust", display.contentCenterX, 38, native.systemFontBold, 18)
answerLabels:setFillColor( 0, 0, 0 )

sceneGroup:insert(answerLabels)

---------------------------------------------------------------------------------------------
  -- get highscore from database
  local dbPath = system.pathForFile("gamescores.db", system.DocumentsDirectory)
  local db = sqlite3.open( dbPath ) 
  for row in db:nrows("SELECT * FROM gamescores WHERE id=1") do
  print("printing")
  --  local text = row.score.." "..row.highscore
   highScore =  tonumber(row.highscorewordmemory)
 
  end


-- update highscore 
  if rightAnswers > highScore then
          -- siia panna image " new high score "
        
        local update = "UPDATE gamescores SET highscorewordmemory ='"..rightAnswers.."',lastscorewordmemory ='"..rightAnswers.."'  WHERE id = 1"
      db:exec(update)

    else
print("no new highscore set")
 local update = "UPDATE gamescores SET lastscorewordmemory ='".. rightAnswers .."' WHERE id = 1"
 db:exec(update)


  end






--submitButton:removeSelf()
submitButton=nil
---------------------------------------------------------------------------------------------
local nextGameButton = widget.newButton
{
  defaultFile = "images/button/green.png",
  overFile = "images/button/greenover.png",
  label = "Menüü",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onPress = nextGamePress,
  onRelease = nextGameRelease,
}
nextGameButton.x = display.contentCenterX; nextGameButton.y = 230+60

   
sceneGroup:insert(nextGameButton)


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
  
restartGameButton.x = display.contentCenterX; restartGameButton.y = 230+65+56

   
sceneGroup:insert(restartGameButton)



    
  return true -- indicates successful touch
end
---------------------------------------------------------------------------------------------

local submitButton = widget.newButton
{
  defaultFile = "images/button/green.png",
  overFile = "images/button/greenover.png",
  label = "Esita",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onPress = submitPress,
  onRelease = submitRelease,
}
submitButton.x = display.contentCenterX; submitButton.y = 230+60
---------------------------------------------------------------------------------------------
function backButtonRelease()

  print("backButtonRelease function")
  composer.gotoScene( "1_game_instructions", "fade", 100 )
  composer.removeScene( "1_game_memory_answer" )      
 
  return true -- indicates successful touch
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

backButton.alpha = 0

sceneGroup:insert(backButton)


 submitCheckMarkButton = widget.newButton
{
  defaultFile = "images/arrow.png",
  overFile = "images/arrowOver.png",
  label = "",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  
 onPress = submitPress,
  onRelease = submitRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
submitCheckMarkButton.x = display.actualContentWidth-30; submitCheckMarkButton.y = statusBox.y+25



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
restartGameButtonOnStatusBox .x = display.actualContentWidth-30; restartGameButtonOnStatusBox.y = statusBox.y+25
 restartGameButtonOnStatusBox.isVisible = false
sceneGroup:insert(  restartGameButtonOnStatusBox ) 




--submitCheckMarkButton.onPress = nextGamePress


sceneGroup:insert( submitCheckMarkButton)






sceneGroup:insert(answerLabels)
sceneGroup:insert(submitButton)
sceneGroup:insert(statusBox)
sceneGroup:insert(statusText)
--  sceneGroup:insert()


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


---------------------------------------------------------------------------------------------
--[[
function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   print( event.phase, event.keyName )

   if ( "back" == keyName and phase == "up" ) then

     print("backButtonRelease function")
       composer.removeScene( "1_game_memory_answer" )     
  composer.gotoScene( "1_game_instructions", "fade", 100 )
     
   end
  return true -- to Override physical back button
end
Runtime:addEventListener( "key", onKeyEvent )
--]]
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------------------

return scene
