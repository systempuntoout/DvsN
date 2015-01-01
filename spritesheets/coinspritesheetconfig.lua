local M = {}
local coinSheetInfo = require("spritesheets.coinspritesheet")
-- Sheets
local myCoinImageSheet = graphics.newImageSheet ( "images/coinspritesheet.png", coinSheetInfo:getSheet() )

-- Background sound
local coinSequenceData = {
  {
    name="coin",                                  
    sheet=myCoinImageSheet,
    frames= { 1, 3,4,5,6,7,8,9,10,2 },
    time=1500
  }
}

M.myCoinImageSheet = myCoinImageSheet
M.coinSequenceData = coinSequenceData
return M