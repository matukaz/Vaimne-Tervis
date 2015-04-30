-----------------------------------------------------------------------------------------
--
-- main.lua
-- This is main screen of 
-----------------------------------------------------------------------------------------

-- TODO LIST

--[[

* DO I REALLY NEED STOP MUSIC BUTTON?

 


--]]


-- Display background as white(1,1,1), (r,g,b).
--display.setDefault( "background", 1, 1, 1 )
local composer = require( "composer" )
local scene = composer.newScene()

-- Require the widget library
local widget = require( "widget" )




local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

--Hide the status bar
display.setStatusBar( display.HiddenStatusBar )

--Require the widget library ( we will use this to create buttons and other gui elements )
local widget = require( "widget" )
-- The device will auto-select the theme or you can set it here
 widget.setTheme( "widget_theme_ios" )	-- iOS5/6 theme
 --widget.setTheme( "widget_theme_ios7" )	-- iOS7 theme
-- widget.setTheme( "widget_theme_android" )	  -- android theme



--Box to underlay our audio status text
local gradient = {
	type = 'gradient',
	color1 = {94/255,181/255,100/255},
	color2 = { 20/255, 143/255, 17/255 },
	direction = "down"
}

function backButtonRelease()

	print("backButtonRelease function")
	print("back to menu")
	composer.gotoScene( "mainmenu", "fade", 200 )
					
	
	return true	-- indicates successful touch
end



-- create all objects
function scene:create( event )

	local sceneGroup = self.view
	-- Display background image.
display.setDefault( "background", 198/255, 198/255, 198/255 ) -- silver
	-- sellinne, et supportida ka nt S3 ja iphone 5 oskab scaleda paremini http://forums.coronalabs.com/topic/39290-modernizing-the-configlua-rob-miracle-article/
	--local background = display.newImage("images/green_background.png",true)
--	background.x = display.contentWidth / 2 -- center the image
--	background.y = display.contentHeight / 2




local statusBoxHeight = 100
local statusBox = display.newRect( display.contentCenterX, display.screenOriginY, display.actualContentWidth, statusBoxHeight )
statusBox:setFillColor( gradient ) 
-- statusBox.fill = gradient
statusBox.alpha = 0.9










local backButton = widget.newButton
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







--Create a text object to show the current status
local statusText = display.newText( "Audio Test",  statusBox.x, statusBox.y+25, native.systemFontBold, 18 )

--Variable to store what platform we are on.
local platform

--Check what platform we are running this sample on
if system.getInfo( "platformName" ) == "Android" then
	platform = "Android"
elseif system.getInfo( "platformName" ) == "Mac OS X" then
	platform = "Mac"
elseif system.getInfo( "platformName" ) == "Win" then
	platform = "Win"
else
	platform = "IOS"
end


--[[]

juhuks kui vaja kunagi muid faile panna 
	["Mac"] = { extensions = { ".aac", ".aif", ".caf", ".wav", ".mp3", ".ogg" } },
	["IOS"] = { extensions = { ".aac", ".aif", ".caf", ".wav", ".mp3" } },
	["Win"] = { extensions = { ".wav", ".mp3", ".ogg" } },
	["Android"] = { extensions = { ".wav", ".mp3", ".ogg" } },
}
--]]


--Create a table to store what types of audio are supported per platform
local supportedAudio = {
	["Mac"] = { extensions = {".mp3" } },
	["IOS"] = { extensions = {  ".mp3" } },
	["Win"] = { extensions = { ".mp3"} },
	["Android"] = { extensions = {".mp3" } },
}

--Create a table to store what types of audio files should be streamed or loaded fully into memory.
local loadTypes = {
	["sound"] = { extensions = {  } },
	["stream"] = { extensions = { ".mp3"} }
}

--Forward references for our buttons/labels
local volumeLabel
local playButton, stopButton

--Variables
local audioFiles = { "Skisofreenia","Rõõmus" } --Table to store what audio files are available for playback. (ie included in the app).
local audioLoaded, audioHandle = nil, nil --Variables to hold audio states.
local audioLoops = 0	--Variables to hold audio states.
local audioVolume = 0.5 --Variables to hold audio states.
local audioWasStopped = false -- Variable to hold whether or not we have manually stopped the currently playing audio.

--Set the initial volume to match our initial audio volume variable
audio.setVolume( audioVolume, { channel = 1 } )




--Handle slider events
local function sliderListener( event )
	local value = event.value
		    		    
	--Convert the value to a floating point number we can use it to set the audio volume	
	audioVolume = value / 100
	audioVolume = string.format('%.02f', audioVolume )

	
	--Update the volume text to reflect the new value
	volumeLabel.text = "Volume: " ..  string.format('%i', audioVolume*100 )

				
	--Set the audio volume at the current level
   	audio.setVolume( audioVolume, { channel = 1 } )
end



--Create a slider to control the volume level
local volumeSlider = widget.newSlider
{

--loopButton.x, loopButton.y = display.contentCenterX, stopButton.y + stopButton.contentHeight + loopButton.contentHeight * 0.5 - 10

	left = 50,
	top = 160, -- X cordinate

	-- top = 210
	width = _W - 80,
	orientation = "horizontal",
	listener = sliderListener
}


--Create our volume label to display the current volume on screen
volumeLabel = display.newText( "Volume: " .. string.format('%i', audioVolume*10 ) .. "0", centerX, volumeSlider.y -40, native.systemFontBold, 18 )
volumeLabel:setFillColor( 0, 0, 0)
-- Set up the Picker Wheel's columns
local columnData = 
{ 
	{ 
		align = "center",
		width = 280,
		startIndex = 1,
		labels = audioFiles,
	}
}



--Create the picker which will display our audio files & extensions
local audioPicker = widget.newPickerWheel
{
	top = volumeSlider.y + 50, 	
	width = 360,
	font = native.systemFontBold,
	columns = columnData,
}


	--Set the audio to loop forever in test screen
audioLoops = -1

--Function to handle all button events
local function manageButtonEvents( event )
	local phase = event.phase
	local buttonPressed = event.target.id
	
	if phase == "began" then
		--Loop Button

	

		
		--Play button
		if buttonPressed == "PlayAudio" then

			--Toggle the buttons state ( 1 or 0 )
			playButton.toggle = 1 - playButton.toggle
			
			--Function to reset the play button state when audio completes playback
			local function resetButtonState()
				playButton:setLabel( "Play" ); 
				playButton.toggle = 0
				
				--Only update the status text to finished if we didn't stop the audio manually
				if audioWasStopped == false then
					--Update status text
				
				end
				
				--Set the audioWasStopped flag back to false
				audioWasStopped = false
			end
				
			--Audio playback is set to paused		
			if playButton.toggle == 0 then
				--Pause any currently playing audio
				if audio.isChannelPlaying( 1 ) then
					audio.pause( 1 )
				end
				
				--Set the buttons label to "Resume"
				playButton:setLabel( "Resume" )
				
				--Update status text
			
				
			--Audio playback is set to play	
			else
				--If the audio is paused resume it
				if audio.isChannelPaused( 1 ) then
					audio.resume( 1 )
					
					--Update status text
				
					
				--If not play it from scratch
				else
				 	local audioFileSelected = audioPicker:getValues()[1].index
				 	local audioExtensionSelected = ".mp3"
					
					--Print what sound we have loaded to the terminal
				--	print( "Loaded sound:", audioFiles[ audioFileSelected ] .. supportedAudio[ platform ].extensions[ audioExtensionSelected ] )
					
					--If we are trying to load a sound, then use loadSound
					if supportedAudio[ platform ].extensions[ audioFileSelected ] == loadTypes[ "sound" ].extensions[ audioExtensionSelected ] then
						--Load the audio file fully into memory
						audioLoaded = audio.loadStream( audioFiles[ audioFileSelected ] .. ".mp3" )
					-- loadsound too laggy
					--	audioLoaded = audio.loadSound( audioFiles[ audioFileSelected ] .. ".mp3"   )
						--Play audio file
						audioHandle = audio.play( audioLoaded, { channel = 1, loops = audioLoops, onComplete = resetButtonState } )
					else
						--Load the audio file in chunks
						audioLoaded = audio.loadStream( audioFiles[ audioFileSelected ] .. ".mp3" )
						--Play the audio file
						audioHandle = audio.play( audioLoaded, { channel = 1, loops = audioLoops, onComplete = resetButtonState } )
					end
					
				
					
				end
				
				--Set the buttons label to "Pause"
				playButton:setLabel( "Pause" )
			end

			--Stop button
			elseif buttonPressed == "StopAudio" then
				--If there is audio playing on channel 1
				if audio.isChannelPlaying( 1 ) then
					--Stop the audio
					audio.stop( 1 )
					
					--Let the system know we stopped the audio manually
					audioWasStopped = true
					
				
					
					
				--No audio currently playing
				else
				
					
				end
			end
		end
	
	return true
end



--Play/pause/resume Button
playButton = widget.newButton{
	id = "PlayAudio",
	style = "sheetBlack",
	label = "Play",
	yOffset = - 3,
	fontSize = 24,
	emboss = true,
	width = 140,
	onEvent = manageButtonEvents,
}
playButton.toggle = 0
playButton.x, playButton.y = playButton.contentWidth * 0.5 + 10, 80


--Stop button
local stopButton
stopButton = widget.newButton{
	id = "StopAudio",
	style = "sheetBlack",
	label = "Stop",
	yOffset = - 3,
	fontSize = 24,
	emboss = true,
	width = 140,
	onEvent = manageButtonEvents,
}
stopButton.x, stopButton.y = display.contentWidth - stopButton.contentWidth * 0.5 - 10, 80






--	sceneGroup:insert(background)
	sceneGroup:insert(backButton) -- siin järjekorras, et tekiks teistsugune buttoni effekt. Saab mängida nii.
	

	sceneGroup:insert(statusBox)
	sceneGroup:insert(volumeSlider)
	sceneGroup:insert(volumeLabel)
	sceneGroup:insert(audioPicker) -- maybe disable this one
	sceneGroup:insert(playButton)
	sceneGroup:insert(stopButton)
	sceneGroup:insert(statusText)
	



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
		audio.stop( 1 )
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	audio.stop(backgroundSound)
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	-- -- Dispose the handles from memory and 'nil' out each reference
	--[[
audio.dispose( laserSound )
audio.dispose( backgroundMusic )
laserSound = nil  --prevents the handle from being used again
backgroundMusic = nil  --prevents the handle from being used again
--]]

end



--- MUSIC PART ---------------------------------------------------------------------------------




-- Comments: 
--		Supports: .aac, .aif, .caf, .wav, .mp3 and .ogg audio formats
--		Notes: 
--			iOS ( iPhone/iPad/iPod Touch ) doesn't support .ogg format audio.
--			Android only supports .wav, .mp3 and .ogg format audio.			
--
--
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2012 Corona Labs Inc. All Rights Reserved.
--
-- Supports Graphics 2.0
---------------------------------------------------------------------------------------
--[[
function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   print( event.phase, event.keyName )

   if ( "back" == keyName and phase == "up" ) then

   	print("backButtonRelease function")
	print("back to menu")
	composer.gotoScene( "mainmenu", "fade", 200 )
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