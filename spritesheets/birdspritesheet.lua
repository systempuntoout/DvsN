--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:946da46d79519c2c94956f1cc020cbf9:14dd20b7a90d54471e0e63ea78ef6c29:90a5698b7426f3124d38a47d2e12605a$
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
            width=146,
            height=142,

        },
        {
            -- slice02_02
            x=2,
            y=146,
            width=146,
            height=140,

        },
        {
            -- slice03_03
            x=2,
            y=288,
            width=146,
            height=130,

        },
        {
            -- slice04_04
            x=2,
            y=420,
            width=171,
            height=122,

        },
        {
            -- slice05_05
            x=2,
            y=544,
            width=181,
            height=88,

        },
        {
            -- slice06_06
            x=2,
            y=634,
            width=146,
            height=118,

        },
        {
            -- slice07_07
            x=2,
            y=754,
            width=146,
            height=123,

        },
        {
            -- slice08_08
            x=2,
            y=879,
            width=146,
            height=119,

        },
        {
            -- slice09_09
            x=2,
            y=1000,
            width=146,
            height=109,

        },
        {
            -- slice10_10
            x=2,
            y=1111,
            width=146,
            height=109,

        },
        {
            -- slice11_11
            x=2,
            y=1222,
            width=146,
            height=108,

        },
        {
            -- slice12_12
            x=2,
            y=1332,
            width=146,
            height=104,

        },
        {
            -- slice13_13
            x=2,
            y=1438,
            width=168,
            height=87,

        },
        {
            -- slice14_14
            x=2,
            y=1527,
            width=180,
            height=113,

        },
    },
    
    sheetContentWidth = 185,
    sheetContentHeight = 1642
}

SheetInfo.frameIndex =
{

    ["slice01_01"] = 1,
    ["slice02_02"] = 2,
    ["slice03_03"] = 3,
    ["slice04_04"] = 4,
    ["slice05_05"] = 5,
    ["slice06_06"] = 6,
    ["slice07_07"] = 7,
    ["slice08_08"] = 8,
    ["slice09_09"] = 9,
    ["slice10_10"] = 10,
    ["slice11_11"] = 11,
    ["slice12_12"] = 12,
    ["slice13_13"] = 13,
    ["slice14_14"] = 14,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
