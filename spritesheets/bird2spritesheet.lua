--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:312048956508c0f2d1a558af51acf1b0:af3f74d85f6c6d216bcc4e7ad71b71ba:5f5171908d2188701c020594e33fed15$
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
            -- frame-1
            x=2,
            y=2,
            width=686,
            height=559,

            sourceX = 11,
            sourceY = 8,
            sourceWidth = 706,
            sourceHeight = 576
        },
        {
            -- frame-2
            x=690,
            y=2,
            width=686,
            height=559,

            sourceX = 11,
            sourceY = 8,
            sourceWidth = 706,
            sourceHeight = 576
        },
        {
            -- frame-3
            x=1378,
            y=2,
            width=686,
            height=559,

            sourceX = 11,
            sourceY = 8,
            sourceWidth = 706,
            sourceHeight = 576
        },
        {
            -- frame-4
            x=2066,
            y=2,
            width=686,
            height=559,

            sourceX = 11,
            sourceY = 8,
            sourceWidth = 706,
            sourceHeight = 576
        },
        {
            -- frame-5
            x=2,
            y=563,
            width=685,
            height=554,

            sourceX = 12,
            sourceY = 11,
            sourceWidth = 706,
            sourceHeight = 576
        },
        {
            -- frame-6
            x=689,
            y=563,
            width=685,
            height=554,

            sourceX = 12,
            sourceY = 11,
            sourceWidth = 706,
            sourceHeight = 576
        },
        {
            -- frame-7
            x=1376,
            y=563,
            width=685,
            height=554,

            sourceX = 12,
            sourceY = 11,
            sourceWidth = 706,
            sourceHeight = 576
        },
        {
            -- frame-8
            x=2063,
            y=563,
            width=685,
            height=554,

            sourceX = 12,
            sourceY = 11,
            sourceWidth = 706,
            sourceHeight = 576
        },
    },
    
    sheetContentWidth = 2754,
    sheetContentHeight = 1119
}

SheetInfo.frameIndex =
{

    ["frame-1"] = 1,
    ["frame-2"] = 2,
    ["frame-3"] = 3,
    ["frame-4"] = 4,
    ["frame-5"] = 5,
    ["frame-6"] = 6,
    ["frame-7"] = 7,
    ["frame-8"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
