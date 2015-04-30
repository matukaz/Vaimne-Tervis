-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here




local ui = require("togglebutton")
local testButton

local widget = require( "widget" )
local composer = require( "composer" )


local scene = composer.newScene()

local menuGameButton,restartGameButton

local hasRestartGameBeenPressed = false

local hasAnswerButtonBeenPressed = false

local backButton

local turnmusicOnOrOff = 0

---------------------------------------------------------------------------------------------


function scene:create( event )

  local sceneGroup = self.view

answer = event.params

turnmusicOnOrOff = answer[table.maxn(answer)]
--remove last paramter
table.remove(answer,table.maxn(answer))


parameeter = {}

-- esimesed 6 sõna on õiged, paneme need eraldi listi, hiljem paneme need random järjekorda.
for i=1,6,1 do
table.insert(parameeter,answer[i])
end


--DEBUG messages in commandline
print("Vastuste/Answer vaade 3_game_memory_word")
print ( table.concat(answer, ", ") )

--Box to underlay our audio status text
-- gradient same as buttons 

-- gradient for top box
local gradient = {
  type = 'gradient',
  --color1 = { 1, 1, 1 }, 
  color1 = {76/255,143/255,199/255},
  color2 = { 57/255, 107/255, 149/255 }, --blue color
  direction = "down"
}

  
local statusBoxHeight = 100
local statusBox = display.newRect( display.contentCenterX, display.screenOriginY, display.actualContentWidth, statusBoxHeight )
statusBox:setFillColor( gradient ) 
-- statusBox.fill = gradient
statusBox.alpha = 0.9

--Create a text object to show the current status
local statusText = display.newText( "", statusBox.x, statusBox.y+25, native.systemFontBold, 18 )






local itemsSelected = 0
local itemSelectedText = display.newText( "0/6 Sõna valitud", display.contentCenterX, statusBox.y+65, native.systemFontBold, 18)
itemSelectedText:setFillColor( 0, 0, 0 )

sceneGroup:insert(itemSelectedText)




display.setDefault( "background", 1, 1, 1 )

function btnOnPressHandler( event )

      --  
if(hasAnswerButtonBeenPressed == false) then
	print(event.target:isChecked()) --this should return the button status
  print("button pressed")
  if event.target:isChecked() == true then


   -- itemsSelected = itemsSelected + 1
 --   itemSelectedText.text = itemsSelected.."/6 items selected" 
itemSelectedText.text = event.target:itemsSelectedNumber().."/6 Sõna valitud"
 --   event.target:itemsSelected(itemsSelected)

    print("event.target == true")

  elseif event.target:isChecked() == false then
 --      if(itemsSelected < 6) then
 --   itemsSelected = itemsSelected - 1
 -- end


   -- itemSelectedText.text = itemsSelected.."/6 items selected"

itemSelectedText.text = event.target:itemsSelectedNumber().."/6 Sõna valitud"
  --    event.target:itemsSelected(itemsSelected)
--  end
end
end -- hasAnswerButtonBeenPressed = false

end



-- over icon has to be same as checked for toggled.
--testButton = ui.newButton{text =23,default = "icon.png",	over = "Icon-hdpi.png",	checked = "Icon-hdpi.png",onRelease = btnOnPressHandler,}



--testButton.x = display.contentWidth*0.5
--testButton.y = display.contentHeight*0.5


-------------------------------------------------------------------------------------------------------
local function shuffleTable( t )
    local rand = math.random 
    assert( t, "shuffleTable() expected a table, got nil" )
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end
--shuffleTable( wordslist )
--print ( table.concat(wordslist, ", ") )
-------------------------------------------------------------------------------------------------------


-- make second list to shuffle words in answer 
local shuffledWordList = {}
shuffledWordList = answer
shuffleTable(  shuffledWordList )
print ("\n\n".. table.concat( shuffledWordList, ", ") .. " = shuffledWordsList in 3_game_word_answer" )

------------------------------------ GREEN BOXES ---------------------------------------------------------
  local tHeight = 52
  local tWidth = 148
  local borders = 3

  ------------------


  local startX = 80
local startY = 30
local padding =55
--+(padding*_)







------------------------------------------------------------------------------------------------------------------------------


-- this is background for answer once answers are submitted alpha = 1 that means they will show if answer is right(green) or wrong(red)
local rightAnswerBoxes = {}
--]]
  local tHeight = 40
  local tWidth = 80
  local borders = 2

rightAnswerBoxes[1] = ui.newButton{text =shuffledWordList[1],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler,  textColor={ 0, 0, 0, 255 }}





rightAnswerBoxes[2] = ui.newButton{text =shuffledWordList[2],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}

rightAnswerBoxes[3] = ui.newButton{text =shuffledWordList[3],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}


rightAnswerBoxes[4] = ui.newButton{text =shuffledWordList[4],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}


rightAnswerBoxes[5] = ui.newButton{text =shuffledWordList[5],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}


rightAnswerBoxes[6] = ui.newButton{text =shuffledWordList[6],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}


rightAnswerBoxes[7] = ui.newButton{text =shuffledWordList[7],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}


rightAnswerBoxes[8] = ui.newButton{text =shuffledWordList[8],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}


rightAnswerBoxes[9] = ui.newButton{text =shuffledWordList[9],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}


rightAnswerBoxes[10] = ui.newButton{text =shuffledWordList[10],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}


rightAnswerBoxes[11] = ui.newButton{text =shuffledWordList[11],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}


rightAnswerBoxes[12] = ui.newButton{text =shuffledWordList[12],default = "blank.png",  over = "blankover.png", checked = "blankover.png",onRelease = btnOnPressHandler, textColor={ 0, 0, 0, 255 }}







for _, rightAnswerBox in ipairs(rightAnswerBoxes) do

--  rightAnswerBox:setFillColor(127/255,255/255,0) -- kõigile green background.
--  rightAnswerBox.strokeWidth = 0
 -- rightAnswerBox.x=.alpha = 0
  rightAnswerBox.x = startX
  rightAnswerBox.y = startY
print("")


rightAnswerBox.y= startY+(padding*_)

if(_ >= #shuffledWordList/2 + 1) then

rightAnswerBox.x = 240
-- if 12 answers then #shuffledWorldList is 12
rightAnswerBox.y= startY+(padding*(_-#shuffledWordList/2))
-- sceneGroup:insert(rightAnswerBox)


end


  --sceneGroup:insert(rightAnswerBox)
end








--[[

  print(rightAnswers) 
rightAnswerBoxesGreen = {}
-- -2 because blue box is slightly bigger then black box
local border = 2
rightAnswerBoxesGreen[1] = display.newRoundedRect( startX, 85, rightAnswerBoxes[1].width-border, rightAnswerBoxes[1].height-border, 3)

rightAnswerBoxesGreen[2] = display.newRoundedRect( 240, 85, tWidth+borders, tHeight+borders, 3)

--rightAnswerBoxesGreen[3] = display.newRoundedRect( 80, 128, tWidth+borders, tHeight+borders, border)

--rightAnswerBoxesGreen[4] = display.newRoundedRect( 240, 128,tWidth+borders, tHeight+borders, border)

--rightAnswerBoxesGreen[5] = display.newRoundedRect( 80, 178, tWidth+borders, tHeight+borders, border)

--rightAnswerBoxesGreen[6] = display.newRoundedRect( 240, 178, tWidth+borders, tHeight+borders, border)

--rightAnswerBoxesGreen[7] = display.newRoundedRect( 80, 228,tWidth+borders, tHeight+borders, border)

--rightAnswerBoxesGreen[8] = display.newRoundedRect( 240, 228, tWidth+borders, tHeight+borders, border)

-- Add options to all of the rightAnswerBoxes
for _, rightAnswerBoxgreen in ipairs(rightAnswerBoxesGreen) do
 -- rightAnswerBox:setFillColor(127/255,255/255,0) -- kõigile green background.
rightAnswerBoxgreen:setFillColor(0,0,0,0)-- to make center TRANSPARENT 
  rightAnswerBoxgreen:setStrokeColor(127/255,255/255,0 ) --kõigile green background.
  rightAnswerBoxgreen.strokeWidth = 5
  rightAnswerBoxgreen.alpha = 1
  --sceneGroup:insert(rightAnswerBox)
end
--]]


	local toggleBoxesArray = {}



function showRightAnswers(oigevastustabel)

  hasAnswerButtonBeenPressed = true
local rightAnswerBoxesGreen = {}
local rightAnswerBoxesBlack = {}
local m = 1
local BlackBox = 1
for a=1, 12,1 do

   rightAnswerBoxes[a].alpha = 0
  for i=1,6,1 do


    if rightAnswerBoxes[a].text == parameeter[i]  then


     rightAnswerBoxesBlack[BlackBox] = display.newRoundedRect( rightAnswerBoxes[a].x, rightAnswerBoxes[a].y, rightAnswerBoxes[1].width-2, rightAnswerBoxes[1].height-2, 3)
   
BlackBox = BlackBox +1
      rightAnswerBoxes[a].alpha = 1

-- õiged vastused mida kasutaja clickis




  end
if(oigevastustabel[i] == rightAnswerBoxes[a].text  ) then

     rightAnswerBoxesGreen[m] = display.newRoundedRect( rightAnswerBoxes[a].x, rightAnswerBoxes[a].y, rightAnswerBoxes[1].width-2, rightAnswerBoxes[1].height-2, 3)
      m = m +1


end






end
sceneGroup:insert(rightAnswerBoxes[a])

end

for _, rightAnswerBoxBlack in ipairs(rightAnswerBoxesBlack) do
 -- rightAnswerBox:setFillColor(127/255,255/255,0) -- kõigile green background.
rightAnswerBoxBlack:setFillColor(0,0,0,0)-- to make center TRANSPARENT 
  rightAnswerBoxBlack:setStrokeColor(0,0,0 ) --kõigile black background.
  rightAnswerBoxBlack.strokeWidth = 4
  rightAnswerBoxBlack.alpha = 1
  sceneGroup:insert(rightAnswerBoxBlack)
end


-------------------------------


for _, rightAnswerBoxgreen in ipairs(rightAnswerBoxesGreen) do
 -- rightAnswerBox:setFillColor(127/255,255/255,0) -- kõigile green background.
rightAnswerBoxgreen:setFillColor(0,0,0,0)-- to make center TRANSPARENT 
  rightAnswerBoxgreen:setStrokeColor(127/255,255/255,0 ) --kõigile green background.
  rightAnswerBoxgreen.strokeWidth = 5
  rightAnswerBoxgreen.alpha = 1
  sceneGroup:insert(rightAnswerBoxgreen)
end




end -- end of local function









---------------------------------------------------------------------------------------------
local restartGameRelease = function( event )

 -- scrollView:removeSelf()     -- Hide keyboard when the user clicks menuGameButton

if hasRestartGameBeenPressed == true then

   -- update score in SQL 

  composer.removeScene( "3_game_memory_word_answer" )   
  composer.gotoScene( "gamelist", "fade", 200 )
  
else

hasRestartGameBeenPressed = true


vahetabel = {}

vahetabelGreenBoxes = {}

rightAnswers = 0

 local oigevastustabel = {}

  for a=1, 12,1 do

   -- rightAnswerBoxes[a]:setEnabled( false )

    if  rightAnswerBoxes[a]:isChecked() == true then

      table.insert(vahetabel,rightAnswerBoxes[a].text)





    end
  end
---------------------------------------------------------------------------------------------

  for i=1,6,1 do
    for a=1,6,1 do
      -- kui valitud vastus on sama mis õige vastus siis..
      if tostring(parameeter[a]) == tostring(vahetabel[i]) then
        print("ÕIGE VASTUS ")
        rightAnswers = rightAnswers + 1

        print("vahetabel " ..i)

        table.insert(oigevastustabel,vahetabel[i])
        --Put right answers in green that user has gotten right

     

        --Show right answers on board 

        --Dissapear any other answers


      end
    end -- for loop
  end
  --debug
  --print ("\n\n".. table.concat( vahetabel, ", ") .. " = vahetabel in 3_game_word_answer" )
  --print ("\n\n".. table.concat( parameeter, ", ") .. " = vahetabel in 3_game_word_answer" )


  --  composer.gotoScene( "main_menu", "fade", 100 )
  --  composer.removeScene( "3_game_memory_word_answer" )      

  saveScoreToDb()
   showRightAnswers(oigevastustabel)            
itemSelectedText.text = rightAnswers .. "/6 õiget vastust"

if( rightAnswers == 6) then

  itemSelectedText.text = "Tubli! Kõik vastused on õiged"
end

backButton.alpha = 1
menuGameButton.alpha = 0
--menuGameButton:setLabel( "Menüü" )
submitCheckMarkButton:removeSelf()
submitCheckMarkButton = nil
restartGameButton.isVisible=true
 restartGameButtonOnStatusBox.isVisible = true











    return true -- indicates successful touch

end




end



function saveScoreToDb()


---------------------------------------------------------------------------------------------
  -- get highscore from database
  local dbPath = system.pathForFile("gamescores.db", system.DocumentsDirectory)
  local db = sqlite3.open( dbPath ) 
  for row in db:nrows("SELECT * FROM gamescores WHERE id=1") do
  print("printing")
  --  local text = row.score.." "..row.highscore
   highScore =  tonumber(row.highscoreword)
 
  end


-- update highscore 
  if rightAnswers > highScore then
          -- siia panna image " new high score "
        
        local update = "UPDATE gamescores SET highscoreword ='"..rightAnswers.."',lastscoreword ='"..rightAnswers.."'  WHERE id = 1"
      db:exec(update)

    else
print("no new highscore set")
 local update = "UPDATE gamescores SET lastscoreword ='".. rightAnswers .."' WHERE id = 1"
 db:exec(update)


  end


end


local restartGameButtonOnStatusBoxOnPress = function( event )

  print("backButtonRelease function")

  local options =
  {
  effect = "fade",
  time = 100,
  params = { turnMusic = turnmusicOnOrOff }
  }
  composer.removeScene( "3_game_memory_word_answer" ) 
  composer.gotoScene( "3_game_memory_word", options )
      

  
  return true -- indicates successful touch
end




 menuGameButton = widget.newButton
{
  defaultFile = "images/buttonGreen.png",
  overFile = "images/buttonGreenOver.png",
  label = "Vastus",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onPress = nextGamePress,
  onRelease = restartGameRelease,
}
menuGameButton.x = display.contentCenterX; menuGameButton.y = rightAnswerBoxes[12].y+58 -- + images width
 -- menuGameButton.y = display.actualContentHeight-80 -- images width+padding
--sceneGroup:insert(menuGameButton)



---------------------------------------------------------------------------------------------
restartGameButton = widget.newButton
{
  defaultFile = "images/button/blue.png",
  overFile = "images/button/blueover.png",
  label = "Restart",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onPress = restartGameButtonOnStatusBoxOnPress,
}
  
restartGameButton.x = display.contentCenterX; restartGameButton.y = rightAnswerBoxes[12].y+60
restartGameButton.isVisible=false
sceneGroup:insert(restartGameButton)
   


---------------------------------------------------------------------------------------------

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


function ButtonRelease()

  print("backButtonRelease function")
   composer.removeScene( "3_game_memory_word_answer" )      
  composer.gotoScene( "3_game_instructions", "fade", 100 )


  
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
  
  onRelease = restartGameRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
submitCheckMarkButton.x = display.actualContentWidth-30; submitCheckMarkButton.y = statusBox.y+25




--[[
 menuGameButtonkButton = widget.newButton
{
  defaultFile = "images/arrowcircle.png",
  overFile = "images/arrowcircle.png",
  label = "",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  
  onRelease = restartGameRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
 menuGameButtonkButton.x = display.actualContentWidth-30;  menuGameButtonkButton.y = statusBox.y+25

--]]






sceneGroup:insert( submitCheckMarkButton)







sceneGroup:insert(menuGameButton)
--sceneGroup:insert(backButton)
sceneGroup:insert(statusBox)
sceneGroup:insert(statusText)

---------------------------------------------------------------------------------
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

     print("backButtonRelease function")
   composer.removeScene( "3_game_memory_word_answer" )      
  composer.gotoScene( "3_game_instructions", "fade", 100 )
  
   end
    return true
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













