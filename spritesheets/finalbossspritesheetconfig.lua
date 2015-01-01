local M = {}
local finalBossSheetInfo = require("spritesheets.finalbossspritesheet")


-- Final boos sheet
local finalBossImageSheet = graphics.newImageSheet ( "images/finalbossspritesheet.png", finalBossSheetInfo:getSheet() )

local finalBossSequenceData = {
  {
    name="front",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 1,
    count = 4,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="right",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 5,
    count = 4,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="back",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 9,
    count = 4,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="left",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 13,
    count = 4,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  }
}

M.finalBossImageSheet = finalBossImageSheet
M.finalBossSequenceData = finalBossSequenceData
return M