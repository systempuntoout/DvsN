--
-- The shake code
--
local shakeCount = 0
local xShake = 8
local yShake = 4
local shakePeriod = 2

local function shake()
   if(shakeCount % shakePeriod == 0 ) then
      display.currentStage.x = display.currentStage.x0 + math.random( -xShake, xShake )
      display.currentStage.y = display.currentStage.y0 + math.random( -yShake, yShake )
   end
   shakeCount = shakeCount + 1
end

function startShake()
   display.currentStage.x0 = display.currentStage.x
   display.currentStage.y0 = display.currentStage.y
   shakeCount = 0
   Runtime:addEventListener( "enterFrame", shake )
end

function stopShake()
   Runtime:removeEventListener( "enterFrame", shake )
   timer.performWithDelay( 50, 
   function() 
      display.currentStage.x = display.currentStage.x0 
      display.currentStage.y = display.currentStage.y0
   end )
end 