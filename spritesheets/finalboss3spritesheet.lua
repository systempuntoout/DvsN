--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:1160e061d8cbbb8edbe1f8c5efa14b47:96a4f5c472ecc30ff810c98b8cea7650:d598f94604a3972cedeb0a60e3254d43$
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
            width=52,
            height=58,

        },
        {
            -- slicee02_02
            x=2,
            y=62,
            width=52,
            height=60,

        },
        {
            -- slicee03_03
            x=2,
            y=2,
            width=52,
            height=58,

        },
        {
            -- slicee04_04
            x=2,
            y=124,
            width=52,
            height=60,

        },
        {
            -- slicee05_05
            x=2,
            y=186,
            width=38,
            height=58,

        },
        {
            -- slicee06_06
            x=2,
            y=246,
            width=40,
            height=64,

        },
        {
            -- slicee07_07
            x=2,
            y=312,
            width=38,
            height=58,

        },
        {
            -- slicee08_08
            x=2,
            y=372,
            width=38,
            height=64,

        },
        {
            -- slicee09_09
            x=2,
            y=438,
            width=38,
            height=58,

        },
        {
            -- slicee10_10
            x=2,
            y=498,
            width=40,
            height=64,

        },
        {
            -- slicee11_11
            x=2,
            y=438,
            width=38,
            height=58,

        },
        {
            -- slicee12_12
            x=2,
            y=564,
            width=38,
            height=64,

        },
        {
            -- slicee13_13
            x=2,
            y=630,
            width=52,
            height=58,

        },
        {
            -- slicee14_14
            x=2,
            y=690,
            width=52,
            height=60,

        },
        {
            -- slicee15_15
            x=2,
            y=630,
            width=52,
            height=58,

        },
        {
            -- slicee16_16
            x=2,
            y=752,
            width=52,
            height=60,

        },
    },
    
    sheetContentWidth = 56,
    sheetContentHeight = 814
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
    ["slicee13_13"] = 13,
    ["slicee14_14"] = 14,
    ["slicee15_15"] = 15,
    ["slicee16_16"] = 16,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
