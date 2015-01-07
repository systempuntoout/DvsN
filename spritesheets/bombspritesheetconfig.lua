local M = {}
local sheetInfo = require("spritesheets.bombspritesheet")
-- Sheets
local imageSheet = graphics.newImageSheet ( "images/bombspritesheet.png", sheetInfo:getSheet() )

-- Background sound
local sequenceData = {
  {
    name="bomb",                                  
    sheet=imageSheet,
    start= 1,
    count = 4,
    time=1000
  }
  
}

M.bombImageSheet = imageSheet
M.bombSequenceData = sequenceData
M.xScale = 0.5
M.yScale = 0.5
return M