local M = {}
local finalBossSheetInfo = require("spritesheets.finalboss3spritesheet")


-- Final boos sheet
local finalBossImageSheet = graphics.newImageSheet ( "images/finalboss3spritesheet.png", finalBossSheetInfo:getSheet() )

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
    name="left",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 5,
    count = 4,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="right",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 9,
    count = 4,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="back",                                  -- name of the animation
    sheet=finalBossImageSheet,                           -- the image sheet
    start= 13,
    count = 4,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  }
}

M.finalBossImageSheet = finalBossImageSheet
M.finalBossSequenceData = finalBossSequenceData
M.radius = 30
M.xScale = 1
M.yScale = 1
M.hits = 20
M.currentHits = 20
return M