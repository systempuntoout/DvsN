--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:ff8a86d8458bc653508be7002c1a9a3b:56cd4ace3f25c8a1a85315d66a983778:44daf06835a0372f6e10337eda3a72c3$
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
            -- BlackAngel [www.imagesplitter.net]-0-0
            x=2,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-0-1
            x=36,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-0-2
            x=70,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-0-3
            x=104,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-1-0
            x=138,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-1-1
            x=172,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-1-2
            x=206,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-1-3
            x=240,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-2-0
            x=274,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-2-1
            x=308,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-2-2
            x=274,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-2-3
            x=342,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-3-0
            x=376,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-3-1
            x=410,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-3-2
            x=444,
            y=2,
            width=32,
            height=32,

        },
        {
            -- BlackAngel [www.imagesplitter.net]-3-3
            x=478,
            y=2,
            width=32,
            height=32,

        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 36
}

SheetInfo.frameIndex =
{

    ["BlackAngel [www.imagesplitter.net]-0-0"] = 1,
    ["BlackAngel [www.imagesplitter.net]-0-1"] = 2,
    ["BlackAngel [www.imagesplitter.net]-0-2"] = 3,
    ["BlackAngel [www.imagesplitter.net]-0-3"] = 4,
    ["BlackAngel [www.imagesplitter.net]-1-0"] = 5,
    ["BlackAngel [www.imagesplitter.net]-1-1"] = 6,
    ["BlackAngel [www.imagesplitter.net]-1-2"] = 7,
    ["BlackAngel [www.imagesplitter.net]-1-3"] = 8,
    ["BlackAngel [www.imagesplitter.net]-2-0"] = 9,
    ["BlackAngel [www.imagesplitter.net]-2-1"] = 10,
    ["BlackAngel [www.imagesplitter.net]-2-2"] = 11,
    ["BlackAngel [www.imagesplitter.net]-2-3"] = 12,
    ["BlackAngel [www.imagesplitter.net]-3-0"] = 13,
    ["BlackAngel [www.imagesplitter.net]-3-1"] = 14,
    ["BlackAngel [www.imagesplitter.net]-3-2"] = 15,
    ["BlackAngel [www.imagesplitter.net]-3-3"] = 16,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
