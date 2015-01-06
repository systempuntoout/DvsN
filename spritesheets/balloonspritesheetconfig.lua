local M = {}
local sheetInfo = require("spritesheets.balloonspritesheet")


-- Sheets
local myImageSheet = graphics.newImageSheet ( "images/balloonspritesheet.png", sheetInfo:getSheet() )

-- Background sound
local balloonSequenceData = {
  {
    name="balloon",                                  
    sheet=myImageSheet,                          
    start = 1,
    count = 35
  }
}


M.myImageSheet = myImageSheet
M.balloonSequenceData = balloonSequenceData
return M