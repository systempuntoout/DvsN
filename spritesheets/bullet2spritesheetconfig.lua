local M = {}
local bullet2SheetInfo = require("spritesheets.bullet2spritesheet")
-- Sheets
local myBullet2ImageSheet = graphics.newImageSheet ( "images/bullet2spritesheet.png", bullet2SheetInfo:getSheet() )

-- Background sound
local bullet2SequenceData = {
  {
    name="bullet",                                  
    sheet=myBullet2ImageSheet,
    start= 1,
    count = 4,
    time=1500
  }
}

M.myBulletImageSheet = myBullet2ImageSheet
M.bulletSequenceData = bullet2SequenceData
M.xScale = 0.3
M.yScale = 0.3
M.radius = 20
M.density = 0.3
return M