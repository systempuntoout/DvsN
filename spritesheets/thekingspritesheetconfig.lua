local M = {}
local theKingSheetInfo = require("spritesheets.thekingspritesheet")
-- Sheets
local theKingImageSheet = graphics.newImageSheet ( "images/thekingspritesheet.png", theKingSheetInfo:getSheet() )

-- Background sound
local theKingSequenceData = {
  {
    name="laugh",                                  
    sheet=theKingImageSheet,
    frames= { 1, 2},
    time=1000,
    loopCount = 2
  },
  {
    name="say",                                  
    sheet=theKingImageSheet,
    frames= { 3, 4,5,6,7},
    time=1000,
    loopCount = 1
  },
  {
    name="no",                                  
    sheet=theKingImageSheet,
    frames= { 8,9,10},
    time=1000,
    loopCount = 3
  },
  {
    name="yes",                                  
    sheet=theKingImageSheet,
    frames= { 11,12},
    time=1000,
    loopCount = 3
  },
  {
    name="serious",                                  
    sheet=theKingImageSheet,
    frames= { 13,14,15},
    time=1000,
    loopCount = 2
  },
  {
    name="dance",                                  
    sheet=theKingImageSheet,
    frames= { 16,17,18,19,20},
    time=1000,
    loopCount = 4
  },
   {
    name="final",                                  
    sheet=theKingImageSheet,
    frames= { 1, 2,1, 2,1, 2,1,2,1,2,1,1, 2,1, 2,1, 2,1,2,1,2,1,11,12,11,12,11,12,11,12,11,12},
    time=15000
  },
}

M.theKingImageSheet = theKingImageSheet
M.theKingSequenceData = theKingSequenceData
return M