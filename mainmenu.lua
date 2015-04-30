-----------------------------------------------------------------------------------------
--
-- main.lua
-- This is main screen of app
-----------------------------------------------------------------------------------------

-- 1. tähtis asi, button1press funktsioon peab olema varasemas järjekorras kui button. EHK BUTTONPRESS siis BUTTONi loomine muidu ei tööta.


-- Display background as white(1,1,1), (r,g,b).
--display.setDefault( "background", 1, 1, 1 )


--- MULTIPLE LANGUAGES http://prairiewest.net/blog/2013/09/multi-language-apps-with-corona-sdk/
-- slideview https://github.com/vadiminc/CoronaLabs/tree/master/SlideView




local composer = require( "composer" )

local scene = composer.newScene()


--[[
			for i = 1, 8 do
            icons = display.newCircle( i * 20, display.contentCenterY, 3 ) -- last is circle, how big
            icons:setFillColor( 1, 1, 1 )
            icons.strokeWidth = 5

end
--]]

-- Require the widget library
local widget = require( "widget" )

-- CREATE ALL FUNCTIONS

local button1Release = function( event )
	
	composer.gotoScene( "gamelist", "crossFade", 100 )
	
	return true	-- indicates successful touch
end



local button2Release = function( event )
	
	composer.gotoScene( "list_menu", "crossFade", 100 )
	
	return true	-- indicates successful touch
end


local button3Release = function( event )


	composer.gotoScene( "sound", "crossFade", 100 )
	
	return true	-- indicates successful touch
end


local button4Release = function( event )


	composer.gotoScene( "lingid", "crossFade", 100	 )
	
	return true	-- indicates successful touch
end



----------------------------------------------------------------------------------------	
----------------------- Create objects seen on screen ----------------------------------
----------------------------------------------------------------------------------------	

-- Making buttons and texts to display.


function scene:create( event )
	local sceneGroup = self.view
	



	background = display.newImage("images/green_background.png",true)
	background.x = display.contentWidth / 2 -- center the image
	background.y = display.contentHeight / 2

local padding = 5

local button1 = widget.newButton
{
	defaultFile = "images/button/blue.png",
	overFile = "images/button/blueover.png",
	label = "Mängud",
	--emboss = true,
	-- white and grey, default= normal. over= pressed
	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
	onPress = button1Press,
	onRelease = button1Release,
}
button1.x = display.contentCenterX; button1.y = display.contentCenterY

print(display.actualContentHeight-button1.y)
	logo = display.newImage("images/brainlogo.png",true)
	logo.x = display.contentWidth / 2 -- center the image
	logo.anchorX = 0.5
	logo.anchorY = 0
	logo.width = 256
	logo.height =button1.y*0.80
	logo.y = 0





local button2 = widget.newButton
{
	defaultFile = "images/button/oranz.png",
	overFile = "images/button/oranzover.png",
	label = "Psühhoosi info",
	--emboss = true,
	-- white and grey, default= normal. over= pressed
	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
	onPress = button2Press,
	onRelease = button2Release,
}
button2.x = display.contentCenterX; button2.y = button1.y+button1.contentHeight + padding



-- THESE STILL DO NOTHING
local button3 = widget.newButton
{
	defaultFile = "images/button/green.png",
	overFile = "images/button/greenover.png",
	label = "Helid",
	--emboss = true,
	-- white and grey, default= normal. over= pressed
	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
	onPress = button3Press,
	onRelease = button3Release,
}
button3.x = display.contentCenterX; button3.y = button2.y+button2.contentHeight + padding



local button4 = widget.newButton
{
	defaultFile = "images/button/grey.png",
	overFile = "images/button/greyover.png",
	label = "Lingid ja Partnerid",
	--emboss = true,
	-- white and grey, default= normal. over= pressed
	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
	onPress = button4Press,
	onRelease = button4Release,
}
button4.x = display.contentCenterX; button4.y = button3.y+button3.contentHeight + padding



--TO DELETE when done testing-->
--[[
local button5Release = function( event )


	composer.gotoScene( "tests", "fade", 100 )
	
	return true	-- indicates successful touch
end

local button5 = widget.newButton
{
	defaultFile = "images/buttonGreen.png",
	overFile = "images/buttonGreenOver.png",
	label = "TESTS",
	--emboss = true,
	-- white and grey, default= normal. over= pressed
	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
	onPress = button5Press,
	onRelease = button5Release,
}
button5.x = display.contentCenterX; button5.y = button4.y+button4.contentHeight
	

--TO DELETE when done testing--<

--]]

-- text
local options = 
{
    --parent = textGroup,
    text = " vaimne\ntervis",     
    x = display.contentCenterX,
    y = 90,  -- 480 on display suurus
    width = 360,     --required for multi-line and alignment
    font = native.systemFont,   
    fontSize = 40,
    align = "center"  --new alignment parameter
}

local myText = display.newText( options )
myText:setFillColor( 1, 1, 1 )





	sceneGroup:insert(background)
	sceneGroup:insert(button1)
	sceneGroup:insert(button2)
	sceneGroup:insert(button3)
	sceneGroup:insert(button4)

	sceneGroup:insert(logo)
	sceneGroup:insert(myText)
----------------------------------------------------------------------------------------	
----------------------- SQL database for local scores ----------------------------------
----------------------------------------------------------------------------------------	

--Include sqlite
local sqlite3 = require "sqlite3"

--Open data.db.  If the file doesn't exist it will be created
local path = system.pathForFile("gamescores.db", system.DocumentsDirectory)
db = sqlite3.open( path )  

--Setup the table if it doesn't exist, for 
--local tablesetup = [[CREATE TABLE IF NOT EXISTS score (id INTEGER PRIMARY KEY, currentscore, highscore);]]
-- highscorereaction, lastscorereaction = 2_game_reaction_game database

local tablesetup = [[CREATE TABLE IF NOT EXISTS gamescores (id INTEGER PRIMARY KEY autoincrement,highscorewordmemory,lastscorewordmemory,highscorereaction,lastscorereaction,highscorenumber,highscoreword,lastscoreword);]]
print(tablesetup)
db:exec( tablesetup )

local doesTableExists = false
  for row in db:nrows("SELECT * FROM gamescores WHERE id=1") do
  doesTableExists = true 
end

print(doesTableExists)

--Add rows with a auto index in 'id'. You don't need to specify a set of values because we're populating all of them

if doesTableExists == false then
print("Inserted zero data to database")
local insertQuery = [[INSERT INTO gamescores VALUES ('1','0','0','0','0','0','0','0' );]]
db:exec( insertQuery )
print(db:exec( insertQuery ))
end



--Handle the applicationExit event to close the db
local function onSystemEvent( event )
    if( event.type == "applicationExit" ) then              
        db:close()
    end
end
-------- test----------------------------------
--print the sqlite version to the terminal
print( "version " .. sqlite3.version() )







---------------------------------------------------------------------------------------------
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



function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   print( event.phase, event.keyName )

   if ( "back" == keyName and phase == "up" ) then
	native.requestExit()
    return true
   end

return false
end
Runtime:addEventListener( "key", onKeyEvent )


---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene