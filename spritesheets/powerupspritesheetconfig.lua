local M = {}

local powerupSheetInfo = require("spritesheets.powerupspritesheet")

-- Sheets
local myPowerUpImageSheet = graphics.newImageSheet ( "images/powerupspritesheet.png", powerupSheetInfo:getSheet() )

local powerUpSequenceData = {
  {
    name="r",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 1,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="g",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 9,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="b",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 17,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="P",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 25,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="B",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 33,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="S",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 41,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  }

}

M.myPowerUpImageSheet = myPowerUpImageSheet
M.powerUpSequenceData = powerUpSequenceData
return M