--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:1de06c69bd2a4e29d3a571bc23bf77b9:5b3428d66ca55f3c3cebda2d0b059a72:3a1617d709ad9af8af2282bc4fd70d6c$
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
            -- bullet
            x=2,
            y=2,
            width=16,
            height=16,

        },
    },
    
    sheetContentWidth = 20,
    sheetContentHeight = 20
}

SheetInfo.frameIndex =
{

    ["bullet"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
