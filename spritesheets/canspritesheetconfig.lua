local M = {}
local canSheetInfo = require("spritesheets.canspritesheet")
-- Sheets
local myCanImageSheet = graphics.newImageSheet ( "images/canspritesheet.png", canSheetInfo:getSheet() )

-- Background sound
local canSequenceData = {
  {
    name="can1",                                  
    sheet=myCanImageSheet,
    start = 1,
    count = 8,
    time=800
  },
  {
    name="can2",                                  
    sheet=myCanImageSheet,
    start = 17,
    count = 8,
    time=800
  },
  {
    name="can3",                                  
    sheet=myCanImageSheet,
    start = 25,
    count = 8,
    time=800
  },
  {
    name="can4",                                  
    sheet=myCanImageSheet,
    start = 33,
    count = 8,
    time=800
  },
  {
    name="can5",                                  
    sheet=myCanImageSheet,
    start = 41,
    count = 8,
    time=800
  },
  
}

M.myCanImageSheet = myCanImageSheet
M.canSequenceData = canSequenceData
return M