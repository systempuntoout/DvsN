local M = {}
local birdSheetInfo = require("spritesheets.birdspritesheet")
-- Sheets
local myBirdImageSheet = graphics.newImageSheet ( "images/birdspritesheet.png", birdSheetInfo:getSheet() )

-- Background sound
local birdSequenceData = {
  {
    name="fly",                                  
    sheet=myBirdImageSheet,
    start= 1,
    count = 14,
    time=1500
  }
}

M.myBirdImageSheet = myBirdImageSheet
M.birdSequenceData = birdSequenceData
return M