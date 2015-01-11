local M = {}
local sheetInfo = require("spritesheets.mushroomspritesheet")


-- Sheets
local myImageSheet = graphics.newImageSheet ( "images/mushroomspritesheet.png", sheetInfo:getSheet() )

-- Background sound
local mushroomSequenceData = {
  {
    name="mushroom",                                  
    sheet=myImageSheet,                          
    start = 1,
    count = 21
  }
}


M.mushroomImageSheet = myImageSheet
M.mushroomSequenceData = mushroomSequenceData
return M