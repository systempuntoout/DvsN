local M = {}
local sheetInfo = require("spritesheets.explosionspritesheet")
-- Sheets
local imageSheet = graphics.newImageSheet ( "images/explosionspritesheet.png", sheetInfo:getSheet() )

-- Background sound
local sequenceData = {
  {
    name="explosion1",                                  
    sheet=imageSheet,
    start= 1,
    count = 24,
    time=1300,
    loopCount = 1
  },
  {
    name="explosion2",                                  
    sheet=imageSheet,
    start= 25,
    count = 24,
    time=1300,
    loopCount = 1
  },
  {
    name="explosion3",                                  
    sheet=imageSheet,
    start= 49,
    count = 23,
    time=1300,
    loopCount = 1
  }
  ,
  {
    name="explosion4",                                  
    sheet=imageSheet,
    start= 72,
    count = 24,
    time=1300,
    loopCount = 1
  }  ,
  {
    name="explosion5",                                  
    sheet=imageSheet,
    start= 96,
    count = 24,
    time=1300,
    loopCount = 1
  },
  {
    name="explosion6",                                  
    sheet=imageSheet,
    start= 120,
    count = 32,
    time=1500,
    loopCount = 1
  },
  {
    name="explosion7",                                  
    sheet=imageSheet,
    start= 152,
    count = 32,
    time=1500,
    loopCount = 1
  }
  ,
  {
    name="explosion8",                                  
    sheet=imageSheet,
    start= 184,
    count = 32,
    time=1500,
    loopCount = 1
  },
  {
    name="explosion9",                                  
    sheet=imageSheet,
    start= 216,
    count = 32,
    time=1500,
    loopCount = 1
  },
  {
    name="explosion10",                                  
    sheet=imageSheet,
    start= 248,
    count = 32,
    time=1500,
    loopCount = 1
  }
  ,
  {
    name="explosion10",                                  
    sheet=imageSheet,
    start= 280,
    count = 24,
    time=1500,
    loopCount = 1
  }
}

M.explosionImageSheet = imageSheet
M.explosionSequenceData = sequenceData
M.xScale = 2
M.yScale = 2
return M