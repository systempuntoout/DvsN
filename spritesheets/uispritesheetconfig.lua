local M = {}
local sheetInfo = require("spritesheets.uispritesheet")


-- Sheets
local myImageSheet = graphics.newImageSheet ( "images/uispritesheet.png", sheetInfo:getSheet() )

-- Background sound
local soundOptionSequenceData = {
  {
    name="ui",                                  
    sheet=myImageSheet,                          
    start = 1,
    count = 33
  }
}


M.uiImageSheet = myImageSheet
M.uiSequenceData = soundOptionSequenceData
return M