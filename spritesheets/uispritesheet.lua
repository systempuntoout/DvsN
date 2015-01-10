--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c4240d26b0836d3de90a7b0ba8079375:0495ef3744f7df636503562c260b5195:4ce15cd62fa4a79a1a35af9a439d200f$
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
            -- blue_panel
            x=2,
            y=2,
            width=100,
            height=100,

        },
        {
            -- green_panel
            x=104,
            y=2,
            width=100,
            height=100,

        },
        {
            -- grey_panel
            x=206,
            y=2,
            width=100,
            height=100,

        },
        {
            -- red_panel
            x=308,
            y=2,
            width=100,
            height=100,

        },
        {
            -- slicee100_100
            x=410,
            y=2,
            width=176,
            height=186,

        },
        {
            -- slicee105_@
            x=588,
            y=2,
            width=176,
            height=185,

        },
        {
            -- slicee106_@
            x=766,
            y=2,
            width=176,
            height=185,

        },
        {
            -- slicee107_@
            x=944,
            y=2,
            width=176,
            height=185,

        },
        {
            -- slicee108_@
            x=1122,
            y=2,
            width=176,
            height=185,

        },
        {
            -- slicee113_@
            x=1300,
            y=2,
            width=176,
            height=185,

        },
        {
            -- slicee114_@
            x=1478,
            y=2,
            width=176,
            height=185,

        },
        {
            -- slicee115_@
            x=1656,
            y=2,
            width=176,
            height=185,

        },
        {
            -- slicee116_@
            x=2,
            y=190,
            width=176,
            height=185,

        },
        {
            -- slicee121_@
            x=180,
            y=190,
            width=176,
            height=185,

        },
        {
            -- slicee122_@
            x=358,
            y=190,
            width=176,
            height=185,

        },
        {
            -- slicee123_@
            x=536,
            y=190,
            width=176,
            height=185,

        },
        {
            -- slicee124_@
            x=714,
            y=190,
            width=176,
            height=185,

        },
        {
            -- slicee129_@
            x=892,
            y=190,
            width=176,
            height=185,

        },
        {
            -- slicee130_@
            x=1070,
            y=190,
            width=176,
            height=185,

        },
        {
            -- slicee131_@
            x=1248,
            y=190,
            width=176,
            height=185,

        },
        {
            -- slicee132_@
            x=1426,
            y=190,
            width=176,
            height=185,

        },
        {
            -- slicee157_@
            x=1604,
            y=190,
            width=176,
            height=185,

        },
        {
            -- slicee158_@
            x=2,
            y=377,
            width=176,
            height=185,

        },
        {
            -- slicee159_@
            x=180,
            y=377,
            width=176,
            height=185,

        },
        {
            -- slicee160_@
            x=358,
            y=377,
            width=176,
            height=185,

        },
        {
            -- slicee45_45
            x=536,
            y=377,
            width=176,
            height=185,

        },
        {
            -- slicee46_46
            x=714,
            y=377,
            width=176,
            height=185,

        },
        {
            -- slicee47_47
            x=892,
            y=377,
            width=176,
            height=185,

        },
        {
            -- slicee48_48
            x=1070,
            y=377,
            width=176,
            height=185,

        },
        {
            -- slicee97_97
            x=1248,
            y=377,
            width=176,
            height=186,

        },
        {
            -- slicee98_98
            x=1426,
            y=377,
            width=176,
            height=186,

        },
        {
            -- slicee99_99
            x=1604,
            y=377,
            width=176,
            height=186,

        },
        {
            -- yellow_panel
            x=1782,
            y=377,
            width=100,
            height=100,

        },
    },
    
    sheetContentWidth = 1884,
    sheetContentHeight = 565
}

SheetInfo.frameIndex =
{

    ["blue_panel"] = 1,
    ["green_panel"] = 2,
    ["grey_panel"] = 3,
    ["red_panel"] = 4,
    ["slicee100_100"] = 5,
    ["slicee105_@"] = 6,
    ["slicee106_@"] = 7,
    ["slicee107_@"] = 8,
    ["slicee108_@"] = 9,
    ["slicee113_@"] = 10,
    ["slicee114_@"] = 11,
    ["slicee115_@"] = 12,
    ["slicee116_@"] = 13,
    ["slicee121_@"] = 14,
    ["slicee122_@"] = 15,
    ["slicee123_@"] = 16,
    ["slicee124_@"] = 17,
    ["slicee129_@"] = 18,
    ["slicee130_@"] = 19,
    ["slicee131_@"] = 20,
    ["slicee132_@"] = 21,
    ["slicee157_@"] = 22,
    ["slicee158_@"] = 23,
    ["slicee159_@"] = 24,
    ["slicee160_@"] = 25,
    ["slicee45_45"] = 26,
    ["slicee46_46"] = 27,
    ["slicee47_47"] = 28,
    ["slicee48_48"] = 29,
    ["slicee97_97"] = 30,
    ["slicee98_98"] = 31,
    ["slicee99_99"] = 32,
    ["yellow_panel"] = 33,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
