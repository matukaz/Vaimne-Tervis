
-----------------------------------------------------------------------------------------
-- 
-- http://code.tutsplus.com/tutorials/corona-sdk-create-an-alphabet-soup-game-interaction--mobile-10441
--
-- väga abiks
-- http://code.tutsplus.com/tutorials/corona-sdk-make-a-word-drop-game--mobile-20446 
-----------------------------------------------------------------------------------------


local composer = require( "composer" )

local scene = composer.newScene()
-- Require the widget library
local widget = require( "widget" )

local startButton,timeLeft,randomLetter,currentWords,countDownTimer

local numberOfWordsMaxiumum = 6

local answers = {}



-------------------------------------------------------------------------------------------------------

-- system.DocumentsDirectory, ei sobi, sest documents kui apk installeeritakse on tühi.
local path = system.pathForFile( "Sonad/omadussonad.txt", system.ResourceDirectory )

local randomWordList = {}
local max_Lines = 15 -- should be soon deleted
local i = 0
local a = 1
local numberofWordsMax  = 12
local randomNumbersList = {}

------------------------------------------------------------------------------------------------------



-- CREATE OBJECTS
function scene:create( event )


passingParameter = event.params



local randomMusic = {}

local function add(soundstring)

table.insert(randomMusic,soundstring)


end




add( "Sounds/Skisofreenia_1.mp3" ) -- An unnamed track.
add( "Sounds/Skisofreenia_2.mp3" ) -- An unnamed track.
add( "Sounds/Skisofreenia_3.mp3" ) -- An unnamed track.
add( "Sounds/Skisofreenia_4.mp3" ) -- An unnamed track.
add( "Sounds/Skisofreenia_5.mp3" ) -- An unnamed track.


function turnOffSound()
  if(backgroundMusicChannel ~= nil) then
         audio.stop( backgroundMusicChannel )
          backgroundMusicChannel = nil  
          audio.dispose(backgroundMusicChannel)
        end
end






  local sceneGroup = self.view
  
local numberOfWordsSoFar = 1
  -- show how many words have been shown for a person so far.

--Box to underlay our audio status text
-- gradient for top box
local gradient = {
  type = 'gradient',
  color1 = {76/255,143/255,199/255},
  color2 = { 57/255, 107/255, 149/255 }, --green color taken from a background pci
  direction = "down"
}

  
local statusBoxHeight = 100
local statusBox = display.newRect( display.contentCenterX, display.screenOriginY, display.actualContentWidth, statusBoxHeight )
statusBox:setFillColor( gradient ) 
-- statusBox.fill = gradient
statusBox.alpha = 0.9

--Create a text object to show the current status
local statusText = display.newText( "Mälumäng - sõnad", statusBox.x, statusBox.y+25, native.systemFontBold, 18 )


-- backbutton to menu
function backButtonRelease()
  
  print("back to menu")
  if(countdownTimer~=nil) then
    timer.cancel(countdownTimer)
    countdownTimer=nil
  end
    turnOffSound()
  composer.gotoScene( "3_game_instructions", "fade", 0 )
  composer.removeScene( "3_game_memory_word" )      
          
end


local backButton = widget.newButton
{
  defaultFile = "images/back_button.png",
  overFile = "images/back_buttonOver.png",
  label = "",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onRelease = backButtonRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
backButton.x = 30; backButton.y = statusBox.y+25


-- GAME start button, has to fade out.
----------------------------------------------------

local startButtonRelease = function( event )
-- Start the memory game after start button has pressed then hide button to transition to game.
  print("startbuttonrelease")

--start sound if button is pressed ON:
  if passingParameter.turnMusic == 1 then 

 local randomSound = randomMusic[math.random( 1, #randomMusic )]
 print(randomSound)
local backgroundMusic = audio.loadStream( randomSound )

-- Play the background music on channel 1, loop infinitely, and fade in over 0.1 seconds 
backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=100 } )

end

  transition.to( startButton, { time=200,  x=startButton.x-100,alpha=0, onComplete = startButtonDestroy} )
  
  return true -- indicates successful touch
end

  startButton = widget.newButton
{
  defaultFile = "images/bluebuttonround.png",
  overFile = "images/bluebuttonround.png",
  label = "Start",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  onRelease = startButtonRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
startButton.x = display.contentCenterX; startButton.y = display.contentCenterY
------------------------------------------------------
-- | Functions that get random words from file | --
-------------------------------------------------------------------------------------------------------


function randomNumbers()

  for i = 1, numberofWordsMax, 1 do
  randomNumber= math.random(max_Lines) --an integer between 1 and 10 (inclusive)
-------------------
  table.insert(randomNumbersList,randomNumber)
  end
  table.sort( randomNumbersList )
  print( table.concat( randomNumbersList, ", " ) )  -- 1, 2, 3, 4, 5 

end

randomNumbers()

-------------------------------------------------------------------------------------------------------

--[[
-- io.open opens a file at path. returns nil if no file found
local fh, reason = io.open( path, "r" )

if fh then
   -- read all contents of file into a string
 --  local contents = fh:read( "*a" )

    local file = io.open(path, "r")

    for lines in file:lines() do
  i = i +1

  if i == randomNumbersList[a] then
    a = a + 1
    table.insert(randomWordList,lines)

        print (lines)
        print(i)
    end
end



--   print( "Contents of " .. path .. "\n" .. contents )
else
   print( "Reason open failed: " .. reason )  -- display failure message in terminal
end

fh:close()
print( table.concat( randomWordList, ", " ) )  -- 1, 2, 3, 4, 5 
--io.close( fh )

--]]

--------------------------------------------------------------------------------------------------------------------------------------------
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


local randomWordList = {}
local lopptabel = {} -- see antakse edasi siis 3_game_memory_word_answerile

function readRandomLettersFromFile()
-- io.open opens a file at path. returns nil if no file found
local fh, reason = io.open( path, "r" )

if fh then
   -- read all contents of file into a string
 --  local contents = fh:read( "*a" )

    local file = io.open(path, "r")

    for lines in file:lines() do
  table.insert(randomWordList,lines)


end



--   print( "Contents of " .. path .. "\n" .. contents )
else
   print( "Reason open failed: " .. reason )  -- display failure message in terminal
end

fh:close()
print( table.concat( randomWordList, ", " ) )  -- 1, 2, 3, 4, 5 
--io.close( fh )


 -- return randomWordsList
 shuffleTable(randomWordList)
 print( table.concat( randomWordList, ", " ) )  -- 1, 2, 3, 4, 5 

--paneb lopptabelisse
 for i=1,numberofWordsMax do table.insert(lopptabel,table.remove(randomWordList)) end



end


-------------------------------------------------------


function pickRandomWordFromList(number)


  --local var wordslist = {'ANDROID', 'IPHONE', 'GAME', 'LOVE', 'NEW', "CLOCK", "DOOR", "ROCKING", "FILM", "MOVIE", "STOPPING", "HOME"}
  if(number == 1)then
readRandomLettersFromFile()
end
 -- letter =   wordslist[number]

letter = lopptabel[number]

  return letter
end


function clearscreenfornewletter()
  
  if(timeLeft~=nil) then
     timeLeft:removeSelf()
    timeLeft=nil
  end
  if(currentWords~=nil)then

    currentWords:removeSelf() -- seda vb ei ole vaja, võib pärast refaktoreerida koodi.
    currentWords=nil

  end

    randomLetter=nil
   -- currentWords:removeSelf() -- seda vb ei ole vaja, võib pärast refaktoreerida koodi.
   -- currentWords=nil

    numberOfWordsSoFarAsText:removeSelf()
    numberOfWordsSoFarAsText=nil
end







function startGame()

  print ('startGame')

if(  backButton ~= nil ) then
-- backButton:removeSelf()
 -- backButton=nil

end



  numberOfWordsSoFarAsText = display.newText(numberOfWordsSoFar .. ". Sõna", display.contentCenterX, 140, native.systemFontBold, 14)
  numberOfWordsSoFarAsText:setFillColor( 0 )
  sceneGroup:insert(numberOfWordsSoFarAsText)



  -- Show randomLetter
  --randomLetter = function pickRandomWordFromList()
  randomLetter = pickRandomWordFromList(numberOfWordsSoFar)
  numberOfWordsSoFar = numberOfWordsSoFar + 1



  currentWords = display.newText(randomLetter, display.contentCenterX, display.contentCenterY, 'Arial', 35)
  --currentWord.alpha = 0 -- make it invisbile first
  currentWords:setFillColor( 0 )
  sceneGroup:insert(currentWords)


--table.insert(answers,randomLetter)


--transition.to(numberOfWordsSoFarAsText { time=500, alpha = 1 })

--TIMER 6 SEC
--Show timer
  local timeLimit = 3
  timeLeft = display.newText(timeLimit, 160, 160, native.systemFontBold, 14)
  sceneGroup:insert(timeLeft)
  timeLeft:setTextColor(255,0,0)





  local function timerDown()
     timeLimit = timeLimit-1
     timeLeft.text = timeLimit
       if(timeLimit==0)then


         print(randomLetter)


          -- clear screen, after that show new word
          clearscreenfornewletter()
          if(numberOfWordsSoFar <= numberOfWordsMaxiumum) then
          timer.performWithDelay(300,startGame) -- inimese reaktsiooni aeg, näitab uuesti sõna 250ms pärast
          elseif numberOfWordsSoFar > numberOfWordsMaxiumum then
          print("numberOfWordsSoFar has reached the maxiumum value" )
          print ( table.concat(answers, ", ") .. " 3_game_memory_show \n\n")
         
        -- answers = wordslist

         -- need to pass turnmusiconoff

         table.insert(lopptabel,passingParameter.turnMusic)
          local options = { effect = "fade", time = 500, params = lopptabel,  }


             if(passingParameter.turnMusic == 1) then
              turnOffSound()
            end 


          composer.gotoScene( "3_game_memory_word_answer", options )
          composer.removeScene( "3_game_memory_word" )        -- so i can debug the answers.


          end
       end
    end
 countdownTimer = timer.performWithDelay(1000,timerDown,timeLimit)

end


function startButtonDestroy()
  print("startbuttondestroy")

  startButton:removeSelf()
  startButton=nil

  startGame()

end

------------------------------------------------------ sceneGroup:insert()-----------------------------------------------------------




sceneGroup:insert(backButton)
sceneGroup:insert(statusBox)
sceneGroup:insert(statusText)
sceneGroup:insert(startButton)

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

    if(passingParameter.turnMusic == 1) then
    turnOffSound()
  end
  
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

    if(passingParameter.turnMusic == 1) then
    turnOffSound()
  end
  
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

      print("back to menu")
  if(countdownTimer~=nil) then
    timer.cancel(countdownTimer)
    countdownTimer=nil
  end
    turnOffSound()
  composer.gotoScene( "3_game_instructions", "fade", 0 )
  composer.removeScene( "3_game_memory_word" )       
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

