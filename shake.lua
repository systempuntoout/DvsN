--
-- The shake code
--
local shakeCount = 0
local xShake = 8
local yShake = 4
local shakePeriod = 2
local currentStageX = display.currentStage.x
local currentStageY = display.currentStage.y 

local function shake()
   if(shakeCount % shakePeriod == 0 ) then
      display.currentStage.x = currentStageX + mRandom( -xShake, xShake )
      display.currentStage.y = currentStageY + mRandom( -yShake, yShake )
   end
   shakeCount = shakeCount + 1
end

function startShake()
   --display.currentStage.x0 = currentStageX
   --display.currentStage.y0 = currentStageY
   shakeCount = 0
   Runtime:addEventListener( "enterFrame", shake )
end

function stopShake()
   Runtime:removeEventListener( "enterFrame", shake )
   timer.performWithDelay( 50, 
   function() 
      display.currentStage.x = currentStageX 
      display.currentStage.y = currentStageY
   end )
end 