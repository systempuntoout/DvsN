local M = {}
local sheetInfo = require("spritesheets.chestspritesheet")


-- Sheets
local myImageSheet = graphics.newImageSheet ( "images/chestspritesheet.png", sheetInfo:getSheet() )

-- Background sound
local chestSequenceData = {
  {
    name="chest",                                  
    sheet=myImageSheet,                          
    start = 1,
    count = 10
  }
}


M.chestImageSheet = myImageSheet
M.chestSequenceData = chestSequenceData
return M