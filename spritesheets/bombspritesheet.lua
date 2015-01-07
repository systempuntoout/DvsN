--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:e34f508df82c01c5321f0e02409ec496:dc246c1c4ce3dd95da1b689a8105ea74:6d399bbd1fad47776f2464b5b2239f15$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- b0
            x=2,
            y=2,
            width=110,
            height=114,

            sourceX = 10,
            sourceY = 7,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- b1
            x=114,
            y=2,
            width=109,
            height=114,

            sourceX = 10,
            sourceY = 7,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- b2
            x=225,
            y=2,
            width=92,
            height=114,

            sourceX = 10,
            sourceY = 7,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- b3
            x=319,
            y=2,
            width=110,
            height=114,

            sourceX = 10,
            sourceY = 7,
            sourceWidth = 128,
            sourceHeight = 128
        },
    },
    
    sheetContentWidth = 431,
    sheetContentHeight = 118
}

SheetInfo.frameIndex =
{

    ["b0"] = 1,
    ["b1"] = 2,
    ["b2"] = 3,
    ["b3"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
