-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

--[[
local licensing = require( "licensing" )
licensing.init( "google" )

local function licensingListener( event )

   local verified = event.isVerified
   if not event.isVerified then
      --failed verify app from the play store, we print a message
      print( "Pirates: Walk the Plank!!!" )
      native.requestExit()  --assuming this is how we handle pirates
   end
end

licensing.verify( licensingListener )

--]]


local options =
 {
	
	effect = "crossFade",
	time = 300

}
-- load menu screen
composer.gotoScene( "mainmenu", options )

