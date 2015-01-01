local M = {}
local sheetInfo = require("spritesheets.spritesheet")


-- Sheets
local myImageSheet = graphics.newImageSheet ( "images/spritesheet.png", sheetInfo:getSheet() )

-- Background sound
local soundOptionSequenceData = {
  {
    name="soundOption",                                  
    sheet=myImageSheet,                          
    frames= { 1, 2 }
  }
}


M.myImageSheet = myImageSheet
M.soundOptionSequenceData = soundOptionSequenceData
return M