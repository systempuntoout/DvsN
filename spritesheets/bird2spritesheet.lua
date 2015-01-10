--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:34b3d462fcff9dce480e64b3b3c1a014:b29b5dfa2a5cd09fd50a48818a228c79:5f5171908d2188701c020594e33fed15$
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
            width=137,
            height=113,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 141,
            sourceHeight = 115
        },
        {
            -- frame-2
            x=141,
            y=2,
            width=137,
            height=113,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 141,
            sourceHeight = 115
        },
        {
            -- frame-3
            x=280,
            y=2,
            width=137,
            height=113,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 141,
            sourceHeight = 115
        },
        {
            -- frame-4
            x=419,
            y=2,
            width=137,
            height=113,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 141,
            sourceHeight = 115
        },
        {
            -- frame-5
            x=558,
            y=2,
            width=137,
            height=111,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 141,
            sourceHeight = 115
        },
        {
            -- frame-6
            x=697,
            y=2,
            width=137,
            height=111,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 141,
            sourceHeight = 115
        },
        {
            -- frame-7
            x=836,
            y=2,
            width=137,
            height=111,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 141,
            sourceHeight = 115
        },
        {
            -- frame-8
            x=975,
            y=2,
            width=137,
            height=111,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 141,
            sourceHeight = 115
        },
    },
    
    sheetContentWidth = 1114,
    sheetContentHeight = 117
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
