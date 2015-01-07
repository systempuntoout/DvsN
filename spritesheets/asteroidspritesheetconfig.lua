local M = {}
local sheetInfo = require("spritesheets.asteroidspritesheet")
-- Sheets
local imageSheet = graphics.newImageSheet ( "images/asteroidspritesheet.png", sheetInfo:getSheet() )

-- Background sound
local sequenceData = {
  {
    name="asteroid1",                                  
    sheet=imageSheet,
    start= 1,
    count = 16,
    time=2000
  },
  {
    name="asteroid2",                                  
    sheet=imageSheet,
    start= 17,
    count = 16,
    time=1500
  },
  {
    name="asteroid3",                                  
    sheet=imageSheet,
    start= 33,
    count = 16,
    time=2000
  },
  {
    name="asteroid4",                                  
    sheet=imageSheet,
    start= 49,
    count = 16,
    time=1500
  },
  {
    name="asteroid5",                                  
    sheet=imageSheet,
    start= 65,
    count = 16,
    time=2000
  },
  {
    name="asteroid6",                                  
    sheet=imageSheet,
    start= 81,
    count = 16,
    time=1500
  },
  
}

M.asteroidImageSheet = imageSheet
M.asteroidSequenceData = sequenceData
M.xScale = 1
M.yScale = 1
M.time = 4500
return M