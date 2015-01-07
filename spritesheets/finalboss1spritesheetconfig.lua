local M = {}
local finalBossSheetInfo = require("spritesheets.finalboss1spritesheet")


-- Final boos sheet
local finalBossImageSheet = graphics.newImageSheet ( "images/finalboss1spritesheet.png", finalBossSheetInfo:getSheet() )

local finalBossSequenceData = {
  {
    name="front",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 1,
    count = 3,-- number of frames
    time=500,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="left",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 4,
    count = 3,-- number of frames
    time=500,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="right",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 7,
    count = 3,-- number of frames
    time=500,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="back",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 10,
    count = 3,-- number of frames
    time=500,                                    -- speed
    loopCount=0                                   -- repeat
  }
}

M.finalBossImageSheet = finalBossImageSheet
M.finalBossSequenceData = finalBossSequenceData
M.radius = 34
M.xScale = 1
M.yScale = 1
return M