local M = {}
local diamondSheetInfo = require("spritesheets.diamondspritesheet")
-- Sheets
local myDiamondImageSheet = graphics.newImageSheet ( "images/diamondspritesheet.png", diamondSheetInfo:getSheet() )

-- Background sound
local diamondSequenceData = {
  {
    name="diamond1",                                  
    sheet=myDiamondImageSheet,
    frames= { 1,2,3,4 },
    time=800
  },
  {
    name="diamond2",                                  
    sheet=myDiamondImageSheet,
    frames= { 18,19,20,21 },
    time=800
  },
  {
    name="diamond3",                                  
    sheet=myDiamondImageSheet,
    frames= { 22,23,24,25 },
    time=800
  },
  {
    name="diamond4",                                  
    sheet=myDiamondImageSheet,
    frames= { 43,44,45,46 },
    time=800
  },
  {
    name="diamond5",                                  
    sheet=myDiamondImageSheet,
    frames= { 27,29,31,33 },
    time=800
  },
  {
    name="diamond6",                                  
    sheet=myDiamondImageSheet,
    frames= { 26,28,30,32 },
    time=800
  },
  {
    name="diamond7",                                  
    sheet=myDiamondImageSheet,
    frames= { 36,38,40,42 },
    time=800
  },
   {
    name="diamond8",                                  
    sheet=myDiamondImageSheet,
    frames= { 35,37,39,41 },
    time=800
  },
   {
    name="diamondBig",                                  
    sheet=myDiamondImageSheet,
    frames= { 17 },
    time=800
  }
}

M.myDiamondImageSheet = myDiamondImageSheet
M.diamondSequenceData = diamondSequenceData
return M