local M = {}
local finalBoss2SheetInfo = require("spritesheets.finalboss2spritesheet")


-- Final boos sheet
local finalBoss2ImageSheet = graphics.newImageSheet ( "images/finalboss2spritesheet.png", finalBoss2SheetInfo:getSheet() )

local finalBoss2SequenceData = {
  {
    name="front",                                  -- name of the animation
    sheet=finalBoss2ImageSheet,                           -- the image sheet
    frames = {1,3,5},
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="right",                                  -- name of the animation
    sheet=finalBoss2ImageSheet,                           -- the image sheet
    frames = {15,18,20},
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="back",                                  -- name of the animation
    sheet=finalBoss2ImageSheet,                           -- the image sheet
    frames = {8,10,11},
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="left",                                  -- name of the animation
    sheet=finalBoss2ImageSheet,                           -- the image sheet
    frames = {6,7,9},
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  }
}

M.finalBossImageSheet = finalBoss2ImageSheet
M.finalBossSequenceData = finalBoss2SequenceData
M.xScale = 1.3
M.yScale = 1.3
M.radius = 28
M.hits = 8
M.currentHits = 8
return M