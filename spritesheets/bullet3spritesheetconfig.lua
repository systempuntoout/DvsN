local M = {}
local bullet3SheetInfo = require("spritesheets.bullet3spritesheet")
-- Sheets
local myBullet3ImageSheet = graphics.newImageSheet ( "images/bullet3spritesheet.png", bullet3SheetInfo:getSheet() )

-- Background sound
local bullet3SequenceData = {
  {
    name="bullet",                                  
    sheet=myBullet2ImageSheet,
    start= 13,
    count = 35,
    time=2000
  }
}

M.myBulletImageSheet = myBullet3ImageSheet
M.bulletSequenceData = bullet3SequenceData
M.xScale = 0.3
M.yScale = 0.3
M.radius = 30
M.density = 0.1
return M