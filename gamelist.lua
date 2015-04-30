
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
  
 -- this variable is for to know if back button is for either going back to mainmenu or going back from text to listview. if variable true then we can go back to mainmenu
  local goBackToMainMenu = true





--Box to underlay our audio status text
-- gradient same as buttons 

local gradient = {
  type = 'gradient',
  --color1 = { 1, 1, 1 }, 
  color1 = {76/255,158/255,230/255},
  color2 = { 18/255, 87/255, 150/255 }, --green color
  direction = "down"
}

--yellow
 --[[
local gradient = {
  type = 'gradient',
  --color1 = { 1, 1, 1 }, 
  color1 = {255/255,230/255,70/255},
  color2 = { 235/255, 205/255, 25/255 }, --green color taken from a background pci
  direction = "down"
}
--]]

 
-- THIS IS A TOP BOX (gray one)
local statusBoxHeight = 100
local statusBox = display.newRect( display.contentCenterX, display.screenOriginY, display.actualContentWidth, statusBoxHeight )
statusBox:setFillColor( gradient ) 
-- statusBox.fill = gradient
statusBox.alpha = 0.9
--Create a text object to show the current status
local statusText = display.newText( "Mängud", statusBox.x, statusBox.y+25, native.systemFontBold, 18 )
statusText:setTextColor( 0, 0, 0 )





--== get all data for every highscore and last game score == -----

local lastGameScore_2_game_reaction = 0 -- todo
local highScore_2_game_reaction = 0
local highScore_1_game_memory = 0
local lastGameScore_1_game_memory = 0


  -- get highscore from database
  local dbPath = system.pathForFile("gamescores.db", system.DocumentsDirectory)
  local db = sqlite3.open( dbPath ) 
  for row in db:nrows("SELECT * FROM gamescores WHERE id=1") do
  print("printing")
  --  local text = row.score.." "..row.highscore

   highScore_1_game_memory =  tonumber(row.highscorewordmemory)
   lastGameScore_1_game_memory =  tonumber(row.lastscorewordmemory)
   highScore_2_game_reaction =  tonumber(row.highscorereaction)
   lastGameScore_2_game_reaction = tonumber(row.lastscorereaction)
   highScore_3_game_word =  tonumber(row.highscoreword)
   lastGameScore_3_game_word = tonumber(row.lastscoreword)



  end

 








------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar ) 

-- Import the widget library
local widget = require( "widget" )

-- create a constant for the left spacing of the row content
local LEFT_PADDING = 0

--Set the background to white
display.setDefault( "background", 1, 1, 1 )

--Create a group to hold our widgets & images
--local widgetGroup = display.newGroup()

local data = {}

data[1] = {}
data[1].title = "Numbrite meeldejätmise mäng"
data[1].subtitle ="Rekord Skoor: "..highScore_1_game_memory.."     Viimane Skoor: "..lastGameScore_1_game_memory
data[1].gotoscene = "1_game_instructions"

data[2] = {}
data[2].title = "Reaktsiooni mäng"
data[2].subtitle ="Rekord Skoor: ".. highScore_2_game_reaction.."    Viimane Skoor: "..lastGameScore_2_game_reaction
data[2].gotoscene = "2_game_instructions"

data[3] = {}
data[3].title = "Sõnade meeldejätmise mäng"
data[3].subtitle ="Rekord Skoor: ".. highScore_3_game_word.."   Viimane Skoor: ".. lastGameScore_3_game_word
data[3].gotoscene = "3_game_instructions"





--for i=1, 3 do
--    table.insert(data, data[i])
--end


--Text to show which item we selected
local itemSelected = native.newTextBox( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.contentHeight )
local fontSize = 14
--itemSelected.font = native.newFont( "Arial",  fontSize )
itemSelected.font = native.newFont(native.systemFont, fontSize)
itemSelected.isEditable=false
--itemSelected:setFillColor(0,0,0)
itemSelected.x = display.contentWidth + itemSelected.contentWidth * 0.5
itemSelected.y = display.contentCenterY+35
--widgetGroup:insert( itemSelected )
sceneGroup:insert(itemSelected)
itemSelected.hasBackground = false

-- Forward reference for our back button & tableview
local backButton, list

-- Handle row rendering
local function onRowRender( event )
    local phase = event.phase
    local row = event.row
    local id = row.index
    -- in graphics 2.0, the group contentWidth / contentHeight are initially 0, and expand once elements are inserted into the group.
    -- in order to use contentHeight properly, we cache the variable before inserting objects into the group

    local groupContentHeight = row.contentHeight





    local rowTitle = display.newText( row, data[id].title,0,0, native.systemFontBold, 18 )
    rowTitle:setFillColor(0,0,0)
    -- in Graphics 2.0, the row.x is the center of the row, no longer the top left.
    rowTitle.x = LEFT_PADDING + 10

    -- we also set the anchorX of the text to 0, so the object is x-anchored at the left
    rowTitle.anchorX = 0

    rowTitle.y = groupContentHeight * 0.4

    local rowSubTitle = display.newText( row, data[id].subtitle,0,0, native.systemFontBold, 12 )
    rowSubTitle:setFillColor(.2,.2,.2)
    -- in Graphics 2.0, the row.x is the center of the row, no longer the top left.
    rowSubTitle.x = LEFT_PADDING + 10

    -- we also set the anchorX of the text to 0, so the object is x-anchored at the left
    rowSubTitle.anchorX = 0

    rowSubTitle.y = groupContentHeight * 0.7
-- see tekitab double lines
   local rowArrow = display.newImage( row, "images/listItemBg.png",false )
   rowArrow.x = row.contentWidth - 30 --row.contenctwidth -  size of listItemBG+padding
   rowArrow.y = groupContentHeight * 0.5

    -- we set the image anchorX to 1, so the object is x-anchored at the right
  rowArrow.anchorX = 1
    --data[id]=row.index
   
end

-- Hande row touch events
local function onRowTouch( event )

    local phase = event.phase
    local row = event.target
    local id = row.index

    if "press" == phase then
        print( "Pressed row: " .. row.index )

    elseif "release" == phase then

        composer.removeScene( "gamelist" )   
        composer.gotoScene( data[id].gotoscene, "crossFade", 150 )
      
 
        print( "Tapped and/or Released row: " .. row.index )
    end
end




-- Create a tableView
list = widget.newTableView
{
    --top = 25,
    top = statusBox.y+40, -- padding
    width = display.actualContentWidth, 
    height = display.actualContentHeight,
    hideBackground = false,

    onRowRender = onRowRender,
    onRowTouch = onRowTouch,
    rowTouchDelay=5,
}

--Insert widgets/images into a group
--widgetGroup:insert( list )
sceneGroup:insert(list)





--Handle the back button release event
function onBackRelease()
    --Transition in the list, transition out the item selected text and the back button
 print("backtomainmenu")
 composer.gotoScene( "mainmenu", "fade", 100 )

end


for i = 1, #data do

    local isCategory = false
    local rowHeight = 100
    local rowColor = { default={ 1, 1, 1 }, over={ 1, 0.5, 0, 0.2 } }
 --   local lineColor = { 0.5, 0.5, 0.5 }

 
    -- Insert a row into the tableView
    list:insertRow(
        {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,

           -- lineColor = lineColor
        }
    )
end


function backButtonRelease()

  print("back to menu")
  composer.removeScene( "gamelist" )
  composer.gotoScene( "mainmenu", "fade", 100 )
  
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
  
  onRelease = onBackRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
backButton.x = 30; backButton.y = statusBox.y+25



--  sceneGroup:insert()
sceneGroup:insert(backButton)
sceneGroup:insert(statusBox)
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

      print("back to menu")
  composer.removeScene( "gamelist" )
  composer.gotoScene( "mainmenu", "fade", 100 )  
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
