--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c1e09f75ca337ac74f3b7eb88c784fae:8c2e0a39df38eaabc250d8ef34c3baad:ded8f584ee06c629dcc2762006391b4c$
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
            width=26,
            height=46,

        },
        {
            -- slice02_11
            x=30,
            y=2,
            width=29,
            height=44,

        },
        {
            -- slice03_02
            x=61,
            y=2,
            width=26,
            height=46,

        },
        {
            -- slice04_12
            x=89,
            y=2,
            width=34,
            height=43,

        },
        {
            -- slice05_03
            x=125,
            y=2,
            width=26,
            height=46,

        },
        {
            -- slice06_13
            x=153,
            y=2,
            width=26,
            height=45,

        },
        {
            -- slice07_14
            x=181,
            y=2,
            width=28,
            height=44,

        },
        {
            -- slice08_04
            x=211,
            y=2,
            width=27,
            height=46,

        },
        {
            -- slice09_15
            x=240,
            y=2,
            width=35,
            height=44,

        },
        {
            -- slice10_05
            x=277,
            y=2,
            width=26,
            height=46,

        },
        {
            -- slice11_06
            x=305,
            y=2,
            width=27,
            height=46,

        },
        {
            -- slice12_16
            x=334,
            y=2,
            width=33,
            height=46,

        },
        {
            -- slice13_17
            x=369,
            y=2,
            width=34,
            height=43,

        },
        {
            -- slice14_07
            x=405,
            y=2,
            width=28,
            height=44,

        },
        {
            -- slice14_07_b
            x=435,
            y=2,
            width=28,
            height=44,

        },
        {
            -- slice15_18
            x=465,
            y=2,
            width=34,
            height=43,

        },
        {
            -- slice16_08
            x=501,
            y=2,
            width=26,
            height=45,

        },
        {
            -- slice16_08_b
            x=529,
            y=2,
            width=26,
            height=45,

        },
        {
            -- slice17_09
            x=557,
            y=2,
            width=29,
            height=44,

        },
        {
            -- slice17_09_b
            x=588,
            y=2,
            width=29,
            height=44,

        },
        {
            -- slice18_19
            x=619,
            y=2,
            width=26,
            height=45,

        },
        {
            -- slice19_20
            x=647,
            y=2,
            width=35,
            height=46,

        },
        {
            -- slice20_10
            x=684,
            y=2,
            width=26,
            height=37,

        },
        {
            -- slice21_21
            x=712,
            y=2,
            width=35,
            height=46,

        },
        {
            -- slice22_22
            x=749,
            y=2,
            width=28,
            height=46,

        },
        {
            -- slice22_31
            x=749,
            y=2,
            width=28,
            height=46,

        },
        {
            -- slice23_22
            x=779,
            y=2,
            width=26,
            height=46,

        },
        {
            -- slice23_23
            x=779,
            y=2,
            width=26,
            height=46,

        },
        {
            -- slice24_24
            x=807,
            y=2,
            width=26,
            height=45,

        },
    },
    
    sheetContentWidth = 835,
    sheetContentHeight = 50
}

SheetInfo.frameIndex =
{

    ["slice01_01"] = 1,
    ["slice02_11"] = 2,
    ["slice03_02"] = 3,
    ["slice04_12"] = 4,
    ["slice05_03"] = 5,
    ["slice06_13"] = 6,
    ["slice07_14"] = 7,
    ["slice08_04"] = 8,
    ["slice09_15"] = 9,
    ["slice10_05"] = 10,
    ["slice11_06"] = 11,
    ["slice12_16"] = 12,
    ["slice13_17"] = 13,
    ["slice14_07"] = 14,
    ["slice14_07_b"] = 15,
    ["slice15_18"] = 16,
    ["slice16_08"] = 17,
    ["slice16_08_b"] = 18,
    ["slice17_09"] = 19,
    ["slice17_09_b"] = 20,
    ["slice18_19"] = 21,
    ["slice19_20"] = 22,
    ["slice20_10"] = 23,
    ["slice21_21"] = 24,
    ["slice22_22"] = 25,
    ["slice22_31"] = 26,
    ["slice23_22"] = 27,
    ["slice23_23"] = 28,
    ["slice24_24"] = 29,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
