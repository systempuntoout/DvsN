--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:ddb6788cf2037b3acf9c8f2289e1befd:d12c98659fd187949b63a6ae96c67150:c46243f411ca86fe596665ab352bd775$
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
            -- mute
            x=2,
            y=2,
            width=128,
            height=128,

        },
        {
            -- unmute
            x=132,
            y=2,
            width=128,
            height=128,

        },
    },
    
    sheetContentWidth = 262,
    sheetContentHeight = 132
}

SheetInfo.frameIndex =
{

    ["mute"] = 1,
    ["unmute"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
