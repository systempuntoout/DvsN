--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:77abc2df1aafd7e7a7dce7494946efe9:3348d8282824d2296a7e46fa01f111f0:47fdcfc71e499b06fe8717f997edc702$
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
            -- chest closed
            x=2,
            y=175,
            width=101,
            height=121,

            sourceX = 0,
            sourceY = 50,
            sourceWidth = 101,
            sourceHeight = 171
        },
        {
            -- chest open_golden2
            x=2,
            y=2,
            width=101,
            height=171,

        },
        {
            -- lock
            x=2,
            y=298,
            width=24,
            height=26,

        },
        {
            -- lock_1
            x=2,
            y=326,
            width=24,
            height=26,

        },
        {
            -- lock_2
            x=28,
            y=298,
            width=24,
            height=26,

        },
        {
            -- lock_3
            x=28,
            y=326,
            width=24,
            height=26,

        },
        {
            -- lock_broken1
            x=54,
            y=298,
            width=12,
            height=13,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 24,
            sourceHeight = 26
        },
        {
            -- lock_broken2
            x=68,
            y=298,
            width=12,
            height=13,

            sourceX = 12,
            sourceY = 0,
            sourceWidth = 24,
            sourceHeight = 26
        },
        {
            -- lock_broken3
            x=82,
            y=298,
            width=12,
            height=12,

            sourceX = 0,
            sourceY = 13,
            sourceWidth = 24,
            sourceHeight = 26
        },
        {
            -- lock_broken4
            x=82,
            y=312,
            width=12,
            height=12,

            sourceX = 12,
            sourceY = 13,
            sourceWidth = 24,
            sourceHeight = 26
        },
    },
    
    sheetContentWidth = 105,
    sheetContentHeight = 354
}

SheetInfo.frameIndex =
{

    ["chest closed"] = 1,
    ["chest open_golden2"] = 2,
    ["lock"] = 3,
    ["lock_1"] = 4,
    ["lock_2"] = 5,
    ["lock_3"] = 6,
    ["lock_broken1"] = 7,
    ["lock_broken2"] = 8,
    ["lock_broken3"] = 9,
    ["lock_broken4"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
