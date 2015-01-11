--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c3201ee8c8b17ddf1f43e1ba7e79e955:340f3e71d481d08be7c2ed9c415deccc:b6b228c2b7af7720bbef01dd35a138d9$
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
            -- Mushrooms_01_64x64_Alt_00_001
            x=2,
            y=2,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_00_002
            x=68,
            y=2,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_00_003
            x=134,
            y=2,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_00_004
            x=200,
            y=2,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_00_005
            x=266,
            y=2,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_00_006
            x=332,
            y=2,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_00_007
            x=398,
            y=2,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_01_001
            x=2,
            y=68,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_01_002
            x=68,
            y=68,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_01_003
            x=134,
            y=68,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_01_004
            x=200,
            y=68,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_01_005
            x=266,
            y=68,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_01_006
            x=332,
            y=68,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_01_007
            x=398,
            y=68,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_02_001
            x=2,
            y=134,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_02_002
            x=68,
            y=134,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_02_003
            x=134,
            y=134,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_02_004
            x=200,
            y=134,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_02_005
            x=266,
            y=134,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_02_006
            x=332,
            y=134,
            width=64,
            height=64,

        },
        {
            -- Mushrooms_01_64x64_Alt_02_007
            x=398,
            y=134,
            width=64,
            height=64,

        },
    },
    
    sheetContentWidth = 464,
    sheetContentHeight = 200
}

SheetInfo.frameIndex =
{

    ["Mushrooms_01_64x64_Alt_00_001"] = 1,
    ["Mushrooms_01_64x64_Alt_00_002"] = 2,
    ["Mushrooms_01_64x64_Alt_00_003"] = 3,
    ["Mushrooms_01_64x64_Alt_00_004"] = 4,
    ["Mushrooms_01_64x64_Alt_00_005"] = 5,
    ["Mushrooms_01_64x64_Alt_00_006"] = 6,
    ["Mushrooms_01_64x64_Alt_00_007"] = 7,
    ["Mushrooms_01_64x64_Alt_01_001"] = 8,
    ["Mushrooms_01_64x64_Alt_01_002"] = 9,
    ["Mushrooms_01_64x64_Alt_01_003"] = 10,
    ["Mushrooms_01_64x64_Alt_01_004"] = 11,
    ["Mushrooms_01_64x64_Alt_01_005"] = 12,
    ["Mushrooms_01_64x64_Alt_01_006"] = 13,
    ["Mushrooms_01_64x64_Alt_01_007"] = 14,
    ["Mushrooms_01_64x64_Alt_02_001"] = 15,
    ["Mushrooms_01_64x64_Alt_02_002"] = 16,
    ["Mushrooms_01_64x64_Alt_02_003"] = 17,
    ["Mushrooms_01_64x64_Alt_02_004"] = 18,
    ["Mushrooms_01_64x64_Alt_02_005"] = 19,
    ["Mushrooms_01_64x64_Alt_02_006"] = 20,
    ["Mushrooms_01_64x64_Alt_02_007"] = 21,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
