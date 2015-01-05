--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0816d0475e71746394e11fbbb1e0eb69:e635c3fbd8605e75845f04b668b4acbb:a7844659a454da6d91cc21933f69cd87$
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
            -- slice01_01
            x=2,
            y=2,
            width=51,
            height=76,

        },
        {
            -- slice02_02
            x=2,
            y=80,
            width=51,
            height=79,

        },
        {
            -- slice03_03
            x=2,
            y=161,
            width=51,
            height=77,

        },
        {
            -- slice04_04
            x=2,
            y=240,
            width=54,
            height=76,

        },
    },
    
    sheetContentWidth = 58,
    sheetContentHeight = 318
}

SheetInfo.frameIndex =
{

    ["slice01_01"] = 1,
    ["slice02_02"] = 2,
    ["slice03_03"] = 3,
    ["slice04_04"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
