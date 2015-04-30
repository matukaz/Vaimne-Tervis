-- More info about config.lua
-- http://coronalabs.com/blog/2012/12/04/the-ultimate-config-lua-file/


-- new version, modernized version http://coronalabs.com/blog/2013/09/10/modernizing-the-config-lua/


--calculate the aspect ratio of the device
--[[]
local aspectRatio = display.pixelHeight / display.pixelWidth
application = {
   content = {
      width = aspectRatio > 1.5 and 800 or math.ceil( 1200 / aspectRatio ),
      height = aspectRatio < 1.5 and 1200 or math.ceil( 800 * aspectRatio ),
      scale = "letterBox",
      fps = 30,

      imageSuffix = {
         ["@2x"] = 1.3,
      },
   },
}
]]--

-- config.lua

application =
{
    content =
    {
        width = 320,
        height = 480,
       -- scale = "zoomEven",
        scale = "letterbox", -- zoom to screen dimensions (may add extra space at top or sides)
    },
}