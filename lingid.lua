
-----------------------------------------------------------------------------------------
--
-- 
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )

local scene = composer.newScene()
-- Require the widget library
local widget = require( "widget" )
local data = {}

-- CREATE OBJECTS
function scene:create( event )
  local sceneGroup = self.view
  




--------------------------------------------------------------------------------------------------------------------------------

local gradient = {
  type = 'gradient',
  --color1 = { 1, 1, 1 }, 
  color1 = {177/255,178/255,186/255},
  color2 = { 111/255, 113/255, 122/255 }, --green color taken from a background pci
  direction = "down"
}

  
local statusBoxHeight = 100
local statusBox = display.newRect( display.contentCenterX, display.screenOriginY, display.actualContentWidth, statusBoxHeight )
statusBox:setFillColor( gradient ) 
-- statusBox.fill = gradient
statusBox.alpha = 0.9

--Create a text object to show the current status
local statusText = display.newText( "Lingid ja Partnerid", statusBox.x, statusBox.y+25, native.systemFontBold, 18 )
statusText:setTextColor( 0, 0, 0 )


------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar ) 


--Set the background to white
display.setDefault( "background", 1, 1, 1 )

--Create a group to hold our widgets & images




--------------------------------------------------------------------------------------------------------------------------------


--Create a text object for the scrollViews title
local titleText_kasulikk = display.newText("Lisa infot", display.contentCenterX, display.screenOriginY+statusBoxHeight/2+20, native.systemFontBold, 18)
titleText_kasulikk:setFillColor( 0 )


sceneGroup:insert(titleText_kasulikk)

---------------------------------------------------------------------------------------------------------------------------------


-- this function is for opening the links in a browser
local function webListener( event )
    if event.url then
        -- Open external links (http://) in a new window in the device browser.
        -- Open internal links (file://) normally.
        local index = string.find(event.url, "#http", 1, true)
        if (index ~= nil) then
            system.openURL(string.sub(event.url, index+1)) -- open links in new window; removing # at first char
            return true
        end
    end

    if event.errorCode then
        native.showAlert( "Error!", event.errorMessage, { "OK" } )
    end
end
--------------------------------------------------------------------------------------------------------------------------------

local webView = native.newWebView( display.contentCenterX, titleText_kasulikk.y+90, 320, 160 )
webView:addEventListener( "urlRequest", webListener )
webView:request( "file.html", system.ResourceDirectory  )




local titleText_koostoo = display.newText("Koostöö Partnerid:", display.contentCenterX, webView.y+90, native.systemFontBold, 18)
titleText_koostoo:setFillColor( 0 )
sceneGroup:insert(titleText_koostoo)

--------------------------------------------------------------------------------------------------------------------------------

function backButtonRelease()

  print("backButtonRelease function")
  print("back to menu")

  if (webView ~= nil) then 

    webView:removeSelf()
    webView = nil
  end

  composer.removeScene( "lingid" )
  composer.gotoScene( "mainmenu", "fade", 0 )
  
 -- return true -- indicates successful touch
end



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

--------------------------------------------------------------------------------------------------------------------------------

-- proovime panna tabelisse



data[1] = {}
data[1].title = "MTÜ Peaasjad"
data[1].picture="images/logod/peaasi.png"
data[1].link = "http://www.peaasi.ee"

data[2] = {}
data[2].title = "Eesti Rahvusringhääling"
data[2].picture="images/logod/err_eesti_ok.png"
data[2].link = "www.err.ee"


data[3] = {}
data[3].title = "Mad Art Lab"
data[3].picture="images/logod/MAD_ART_LAB.png"
data[3].link = "madartlab.com"


data[4] = {}
data[4].title = "Eesti Keele Instituut"
data[4].picture="images/logod/eki.png"
data[4].link = "portaal.eki.ee"

data[5] = {}
data[5].title = "Tallinna Vaimse Tervise Keskus"
data[5].picture="images/logod/tvtk.png"
data[5].link = "www.vaimnetervis.ee"


--data[1] = {}
--data[1].title = "MTÜ Peaasi"
--data[1].picture="images/logod/peaasi.png"
--------------------------------------------------------------------------------------------------------------------------------
local maxData = 5 -- #data dosen't work, because there are a lot more info in the data.

for i=1, maxData do
    table.insert(data, data[i])
end

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
   rowTitle.x = display.contentCenterX
   rowTitle.y = groupContentHeight * 0.1


   local picture = display.newImage( row, data[id].picture ,false )
   picture.x = display.contentCenterX
   picture.y = picture.height/2+25

end


local function onRowTouch( event )

    local phase = event.phase
    local row = event.target
    local id = row.index

    if "press" == phase then
        print( "Pressed row: " .. row.index )

    elseif "release" == phase then

system.openURL( data[id].link )
    end
end



list = widget.newTableView
{

    isBounceEnabled = false,
    top = titleText_koostoo.y+30,
    width = 360, 
    height = display.contentHeight-titleText_koostoo.y,
    hideBackground = true,
    noLines = true,
    onRowRender = onRowRender,
    onRowTouch = onRowTouch,
}



for i = 1, maxData do
--

tempPicture = display.newImage(  data[i].picture)
tempPicture.isVisible = false

print(tempPicture.height)
  -- need this to know how large is image
    local isCategory = false
--   print(data[i].tempPicture.height)
    local rowHeight = tempPicture.height+40




    -- max picture height allowed is 100 but +20 for padding
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


--------------------------------------------------------------------------------------------------------------------------------




  -- sceneGroup:insert()
  sceneGroup:insert(backButton)
  sceneGroup:insert(statusBox)
  sceneGroup:insert(statusText)
  sceneGroup:insert(list)
  sceneGroup:insert(webView)

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
  -- remove the webView as with any other display object
 
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

 backButtonRelease()   
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
