

-----------------------------------------------------------------------------------------
--
-- 
--
-----------------------------------------------------------------------------------------
  local isGameOver = false

local composer = require( "composer" )

local scene = composer.newScene()
-- Require the widget library
local widget = require( "widget" )

local isTimerSet = false

local backgroundMusicChannel

local turnSoundOnOff = 0

local passingParameter

local countdownTimer

  local livesLeft = 3
 
-- CREATE OBJECTS
function scene:create( event )
  local sceneGroup = self.view


print(livesLeft)

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


if passingParameter.turnMusic == 1 then 

 local randomSound = randomMusic[math.random( 1, #randomMusic )]
 print(randomSound)
local backgroundMusic = audio.loadStream( randomSound )

-- Play the background music on channel 1, loop infinitely, and fade in over 0.1 seconds 
backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=100 } )
end



  local score = 0


  local spawnTime = 1000
  local fastestSpawnTime = 300
  
  

  local collision

---------------------------------------------------------------------------------------


local physics = require( "physics" )
physics.start()
physics.setGravity(0,9.8)

local rainBackground = display.newImage( "images/raincloud_2.png", display.contentCenterX, 15 )


local sky = display.newImage( "images/bkg_clouds.png", 160, 240 )
display.setDefault( "background", 1, 1, 1 )


local ground = display.newImage("images/ground.png",display.contentCenterX,460)

local spikes = display.newImage("images/spikes.png",display.contentCenterX,390)
spikes.type = "ground"
physics.addBody( spikes, "static" )
-- This makes object to be sensor - as known as it can detect collision but it will not collide with body itself - it will not effect body somehow. You can pass throught sensor = true body with another physicsbody!
spikes.isSensor = true



-- invisible top bar so that healthbar and scoretext will be in same X cordinate
local statusBoxHeight = 100
local statusBox = display.newRect( display.contentCenterX, display.screenOriginY, display.actualContentWidth, statusBoxHeight )
-- statusBox.fill = gradient
statusBox.alpha = 0

local healthbar =  display.newImageRect("images/heart_3.png",54,17)


--healthbar.anchorX = 0
--healthbar.anchorY = 0

healthbar.x = 40
healthbar.y = statusBox.y+25
-- 3-5 digits max long
local scoreText = display.newText("skoor: 0", 270,statusBox.y+25, native.systemFontBold, 20)
scoreText:setFillColor( 0, 0, 0 )




-- raindrop is 16 pixels wide (16,344)
--local raindrop =  display.newImage( "images/raindrop.png", math.random(16,300), -100 )
--physics.addBody( raindrop, "kinematic", { density=10.0, friction=0.5, bounce=0.2 } )
--raindrop:setLinearVelocity( 0, 40 )

----------------------------------------------------------------------------------------------


function takehealthoff()
if (isGameOver == false) then

  livesLeft = livesLeft - 1
  print("ouch you touched Spike, I have so many life left: " .. livesLeft )

  if (livesLeft == 2 ) then
    healthbar =  display.newImage("images/heart_2.png")
    healthbar.x = 40
    healthbar.y = statusBox.y+25

    sceneGroup:insert(healthbar)
    print("Health should have 2 bars left now")
  elseif(livesLeft == 1) then

    healthbar =  display.newImage("images/heart_1.png")
    healthbar.x = 40
    healthbar.y = statusBox.y+25
    sceneGroup:insert(healthbar)
    print("Health should have 1 bars left now")
  elseif(livesLeft == 0) then
    healthbar =  display.newImage("images/heart_0.png")
    healthbar.x = 40
    healthbar.y = statusBox.y+25
    sceneGroup:insert(healthbar)
    print("GameOver")
    --gameover
    -- garbage collector
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )

    timer.cancel( countdownTimer )

    showGameOverScreen()
 end-- if isGameOver
  end
end

----------------------------------------------------------------------------------------------

function onTouch( self, event )
  print (self.type)
  display.remove(self)

  -- update scoreText
  if(self.type=="crate") then
      score = score + 1
      scoreText.text = "skoor: " ..score
      --score must be over 100 to reach max speed
        if(spawnTime > fastestSpawnTime) then
          spawnTime= spawnTime -40
          print(spawnTime)
        end
      elseif(self.type=="spike") then

          print("ouch Spikes " .. livesLeft )
      takehealthoff()
  end

  return true
end
--------------------------------------------------------------------------------------------------------------------------------
 function onCollision( event )

    if ( event.phase == "began" ) then

      if(event.object1.type == "ground" and event.object2.type == "crate" and isGameOver == false) then
      display.remove(event.object2)
        print("CRATE AND spikes COLLISON")

        takehealthoff()
      end
    elseif ( event.phase == "ended" ) then
  

       -- print( "ended: " .. event.object1.type .. " and " .. event.object2.type )

    end
end


ArrayOfSpawnItems = {}

--Function to spawn an object
local function spawn(params)

if (isGameOver == false) then
local object = display.newImage(params.image,params.x,params.y)


--Set the objects table to a table passed in by parameters
object.objTable = params.objTable
--Automatically set the table index to be inserted into the next available table index
object.index = #object.objTable + 1

--Give the object a custom name
object.myName = "Object : " .. object.index
object.type=params.type

--If the object should have a body create it, else dont.
if params.hasBody then
--Allow physics parameters to be passed by parameters:
object.density = params.density or 0
object.friction = params.friction or 0
object.bounce = params.bounce or 0
object.isSensor = params.isSensor or false
object.bodyType = params.bodyType or "dynamic"

physics.addBody(object, object.bodyType, {density = object.density, friction = object.friction, bounce = object.bounce, isSensor = object.isSensor})
--object:addEventListener("touch",removecrate)
  object.touch = onTouch
  object:addEventListener( "touch" )

end

--The objects group
object.group = params.group or nil

--If the function call has a parameter named group then insert it into the specified group

object.group:insert(object)


table.insert(ArrayOfSpawnItems,object)


sceneGroup:insert(rainBackground)

sceneGroup:insert(ground)
sceneGroup:insert(spikes)
sceneGroup:insert(scoreText)
sceneGroup:insert(healthbar)
--sceneGroup:insert(object)

--Insert the object into the table at the specified index
object.objTable[object.index] = object


--

return object
  end -- if
end


--Create a table to hold our spawns
local spawnTable = {}




timeLimit = 1 -- forever loop

function spawnObjects()


local randomNumber = math.random(1,3)
print("Spawning object")
if(randomNumber < 3) then
 spawn(
{


image = "images/crate.png",
--35 
x= math.random(35,280),
y= -100,
objTable = spawnTable,
hasBody = true,
density = 10,
friction = 0.4,
bounce = 0.4,
--bodyType = "kinematic",
group = sceneGroup,
type = "crate"
})

else
 spawn(
{


image = "images/spike.png",
--35 
x= math.random(35,280),
y= -100,
objTable = spawnTable,
hasBody = true,
density = 10,
friction = 0.4,
bounce = 0.4,
--bodyType = "kinematic",
group = sceneGroup,
type = "spike"
})
end


--[[
  if isTimerSet == false  then
    isTimerSet = true

countdownTimer = timer.performWithDelay(spawnTime,spawnObjects,timeLimit)
end

--]]

countdownTimer = timer.performWithDelay(spawnTime,spawnObjects,timeLimit)
--[[local function spawnRain()

 spawn({


image = "images/raindrop.png",
--35 
x= math.random(16,300),
y= -200,
objTable = spawnTable,
hasBody = true,
density = 100,
friction = 0.4,
bounce = 0.4,
bodyType = "kinematic",
group = sceneGroup,
}

)
--]]
end


sceneGroup:insert(sky)
--sceneGroup:insert(raindrop)
 --countdownTimer = timer.performWithDelay(spawnTime,spawnObjects,timeLimit)

count = timer.performWithDelay(2000,spawnObjects)

 --if isTimerSet == false  then
--spawnObjects()

--end


--[[
 function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   print( event.phase, event.keyName )

   if ( "back" == keyName and phase == "up" ) then

        collectgarbage( "collect" )
  
    timer.cancel(count)
    timer.cancel(countdownTimer)

    if(backgroundMusicChannel ~= nil) then
         audio.stop( backgroundMusicChannel )
          backgroundMusicChannel = nil  
          audio.dispose(backgroundMusicChannel)
        end
     composer.removeScene( "2_game_reaction" )   
    composer.gotoScene( "2_game_instructions", "fade", 0 )
      end
    return true
end
--]]


function clearObjects()
for index,ref in pairs(ArrayOfSpawnItems) do display.remove(ref) end ArrayOfSpawnItems = {}

 ArrayOfSpawnItems = nil
ArrayOfSpawnItems = {}
 collectgarbage()
 
end

----------------------------------------------------------------------------------------------
 function showGameOverScreen()
isGameOver = true

    turnOffSound()

lastGameScore = {}

table.insert(lastGameScore,score)
table.insert(lastGameScore, passingParameter.turnMusic )


clearObjects()

  local GameOverScreenOptions =
{
effect = "fade",
time = 100,
params = lastGameScore
}

timer.cancel( countdownTimer )
--countdownTimer:removeSelf() 

--countdownTimer  = nil
  composer.removeScene( "2_game_reaction" )   
  composer.gotoScene( "2_game_reaction_game_over", GameOverScreenOptions )
 

end
----------------------------------------------------------------------------------------------
--spawnRain()

-- When detected as a Runtime event, each collision event includes event.object1 and event.object2, which contain the table IDs of the two Corona display objects involved.
Runtime:addEventListener( "collision", onCollision )

end
 


function turnOffSound()
  if(backgroundMusicChannel ~= nil) then
         audio.stop( backgroundMusicChannel )
          backgroundMusicChannel = nil  
          audio.dispose(backgroundMusicChannel)
        end
end



--Runtime:addEventListener( "key", onKeyEvent )




--  sceneGroup:insert()


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
  if(turnSoundOnOff == 1) then
    turnOffSound()
  end

    -- INSERT code here to pause the scene
    -- e.g. stop timers, stop animation, unload sounds, etc.)
  elseif phase == "did" then
    -- Called when the scene is now off screen
    
  end 
end

function scene:destroy( event )
  local sceneGroup = self.view

  if(turnSoundOnOff == 1) then
    turnOffSound()
  end
  
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

-----------------------------------------------------------------------------------------

return scene
