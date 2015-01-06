--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a752b4214ac6c0d5d5e56eb305be0a1f:a5257eb48b77a7e05d801e2272650885:a1860757c9e11f040c5a1a3707afd0a8$
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
            -- slicee01_01
            x=2,
            y=2,
            width=77,
            height=47,

        },
        {
            -- slicee02_02
            x=81,
            y=2,
            width=93,
            height=42,

        },
        {
            -- slicee03_03
            x=176,
            y=2,
            width=82,
            height=50,

        },
        {
            -- slicee04_04
            x=260,
            y=2,
            width=75,
            height=56,

        },
        {
            -- slicee05_05
            x=337,
            y=2,
            width=70,
            height=55,

        },
        {
            -- slicee06_06
            x=409,
            y=2,
            width=70,
            height=76,

        },
        {
            -- slicee07_07
            x=481,
            y=2,
            width=75,
            height=56,

        },
        {
            -- slicee08_08
            x=558,
            y=2,
            width=70,
            height=55,

        },
        {
            -- slicee09_09
            x=630,
            y=2,
            width=70,
            height=76,

        },
        {
            -- slicee10_10
            x=702,
            y=2,
            width=91,
            height=57,

        },
        {
            -- slicee11_11
            x=795,
            y=2,
            width=95,
            height=56,

        },
        {
            -- slicee12_12
            x=892,
            y=2,
            width=79,
            height=83,

        },
    },
    
    sheetContentWidth = 973,
    sheetContentHeight = 87
}

SheetInfo.frameIndex =
{

    ["slicee01_01"] = 1,
    ["slicee02_02"] = 2,
    ["slicee03_03"] = 3,
    ["slicee04_04"] = 4,
    ["slicee05_05"] = 5,
    ["slicee06_06"] = 6,
    ["slicee07_07"] = 7,
    ["slicee08_08"] = 8,
    ["slicee09_09"] = 9,
    ["slicee10_10"] = 10,
    ["slicee11_11"] = 11,
    ["slicee12_12"] = 12,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
