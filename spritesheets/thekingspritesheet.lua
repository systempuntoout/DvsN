--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:21c6960eea4cd6f867fb15d403e3b0b4:89b2c57d055cfcb4f77d35a8910caaae:686ac40b0a0eb01dec1b776749ece024$
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
            width=119,
            height=99,

        },
        {
            -- slice02_02
            x=123,
            y=2,
            width=119,
            height=104,

        },
        {
            -- slice05_05
            x=244,
            y=2,
            width=119,
            height=94,

        },
        {
            -- slice06_06
            x=365,
            y=2,
            width=119,
            height=94,

        },
        {
            -- slice07_07
            x=486,
            y=2,
            width=119,
            height=94,

        },
        {
            -- slice08_08
            x=607,
            y=2,
            width=119,
            height=94,

        },
        {
            -- slice09_09
            x=728,
            y=2,
            width=119,
            height=94,

        },
        {
            -- slice11_11
            x=849,
            y=2,
            width=119,
            height=99,

        },
        {
            -- slice12_12
            x=970,
            y=2,
            width=119,
            height=97,

        },
        {
            -- slice13_13
            x=1091,
            y=2,
            width=119,
            height=97,

        },
        {
            -- slice14_14
            x=2,
            y=108,
            width=119,
            height=96,

        },
        {
            -- slice15_15
            x=123,
            y=108,
            width=119,
            height=99,

        },
        {
            -- slice17_17
            x=244,
            y=108,
            width=136,
            height=94,

        },
        {
            -- slice18_18
            x=382,
            y=108,
            width=136,
            height=94,

        },
        {
            -- slice19_19
            x=520,
            y=108,
            width=136,
            height=94,

        },
        {
            -- slice21_21
            x=658,
            y=108,
            width=116,
            height=93,

        },
        {
            -- slice22_22
            x=776,
            y=108,
            width=116,
            height=93,

        },
        {
            -- slice23_23
            x=894,
            y=108,
            width=116,
            height=93,

        },
        {
            -- slice24_24
            x=1012,
            y=108,
            width=121,
            height=94,

        },
        {
            -- slice25_25
            x=1135,
            y=108,
            width=119,
            height=93,

        },
    },
    
    sheetContentWidth = 1256,
    sheetContentHeight = 209
}

SheetInfo.frameIndex =
{

    ["slice01_01"] = 1,
    ["slice02_02"] = 2,
    ["slice05_05"] = 3,
    ["slice06_06"] = 4,
    ["slice07_07"] = 5,
    ["slice08_08"] = 6,
    ["slice09_09"] = 7,
    ["slice11_11"] = 8,
    ["slice12_12"] = 9,
    ["slice13_13"] = 10,
    ["slice14_14"] = 11,
    ["slice15_15"] = 12,
    ["slice17_17"] = 13,
    ["slice18_18"] = 14,
    ["slice19_19"] = 15,
    ["slice21_21"] = 16,
    ["slice22_22"] = 17,
    ["slice23_23"] = 18,
    ["slice24_24"] = 19,
    ["slice25_25"] = 20,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
