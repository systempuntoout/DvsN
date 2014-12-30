--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0eb537e13d331a51f2e69199af434dc5:37732604a8b7d825b8757f9384166fcc:25dba21559871554dd29f1ef90526510$
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
            -- frame-1
            x=2,
            y=2,
            width=494,
            height=496,

        },
        {
            -- frame-10
            x=498,
            y=2,
            width=494,
            height=496,

        },
        {
            -- frame-2
            x=994,
            y=2,
            width=494,
            height=496,

        },
        {
            -- frame-3
            x=2,
            y=500,
            width=494,
            height=496,

        },
        {
            -- frame-4
            x=498,
            y=500,
            width=494,
            height=496,

        },
        {
            -- frame-5
            x=994,
            y=500,
            width=494,
            height=496,

        },
        {
            -- frame-6
            x=2,
            y=998,
            width=494,
            height=496,

        },
        {
            -- frame-7
            x=994,
            y=500,
            width=494,
            height=496,

        },
        {
            -- frame-8
            x=498,
            y=998,
            width=494,
            height=496,

        },
        {
            -- frame-9
            x=994,
            y=998,
            width=494,
            height=496,

        },
    },
    
    sheetContentWidth = 1490,
    sheetContentHeight = 1496
}

SheetInfo.frameIndex =
{

    ["frame-1"] = 1,
    ["frame-10"] = 2,
    ["frame-2"] = 3,
    ["frame-3"] = 4,
    ["frame-4"] = 5,
    ["frame-5"] = 6,
    ["frame-6"] = 7,
    ["frame-7"] = 8,
    ["frame-8"] = 9,
    ["frame-9"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
