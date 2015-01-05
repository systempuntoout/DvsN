local M = {}
local bulletSheetInfo = require("spritesheets.bulletspritesheet")
-- Sheets
local myBulletImageSheet = graphics.newImageSheet ( "images/bulletspritesheet.png", bulletSheetInfo:getSheet() )

-- Background sound
local bulletSequenceData = {
  {
    name="bullet",                                  
    sheet=myBulletImageSheet,
    start= 1,
    count = 1,
    time=1500
  }
}

M.myBulletImageSheet = myBulletImageSheet
M.bulletSequenceData = bulletSequenceData
M.xScale = 0.3
M.yScale = 0.3
M.density = 1
return M