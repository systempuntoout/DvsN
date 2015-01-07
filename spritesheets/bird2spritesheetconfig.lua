local M = {}
local bird2SheetInfo = require("spritesheets.bird2spritesheet")
-- Sheets
local myBird2ImageSheet = graphics.newImageSheet ( "images/bird2spritesheet.png", bird2SheetInfo:getSheet() )

-- Background sound
local bird2SequenceData = {
  {
    name="fly",                                  
    sheet=myBird2ImageSheet,
    start= 1,
    count = 8,
    time=1500
  }
}

M.myBirdImageSheet = myBird2ImageSheet
M.birdSequenceData = bird2SequenceData
M.xScale = 0.1
M.yScale = 0.1
M.time = 4500
return M