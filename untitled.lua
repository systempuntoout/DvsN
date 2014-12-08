-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--require('mobdebug').start() 

--Libraries
require "global"
require "physics"
display.setStatusBar(display.HiddenStatusBar);

--Variables
local _H = display.contentHeight/2
local _W = display.contentWidth/2
local score = 0
local level = 1
local bestScore = 0 

local background = display.newImage( "images/soccerfield.jpg")
background.x = _W
background.y = _H


--Music
local bgMusic = audio.loadStream("sounds/backgroundmusic.mp3");
local bounceSound = audio.loadSound("sounds/bounce.mp3");
audio.setVolume(0.1)
--audio.play(bgMusic, {loops =- 1});

--life
lifeGroup = display.newGroup()
for i=1, 3  do
  local life = display.newImage( "images/life.png" )
  life.y = 10
  life.x = _H + (life.width*i+3)
  lifeGroup.insert(lifeGroup, life)
end

--Ball
local ball = display.newImage( "images/ball3.png" )
ball.x = 160;  ball.y = 240


--Paddle
local paddle = display.newImage("images/diego2.png")
paddle.x = 160;  paddle.y = 440

physics.start()
--physics.setDrawMode( "hybrid" ) 

scoreText = display.newText("Score:", 22, 5, "Arial", 14)
scoreText:setTextColor(255, 255, 255, 255)
scoreNum = display.newText("0", 54, 6, "Arial", 14)
scoreNum:setTextColor(255, 255, 255, 255)

physics.addBody( ball, "dynamic", {density = 1.0, friction = 1, bounce = 1.1, radius = 25 })
physics.addBody( paddle, "static", {density = 1.0, friction = 1, bounce = 0.1, radius = 26})

local rectLeft = display.newRect(0, display.contentHeight/2, 0 , display.contentHeight)
physics.addBody(rectLeft, "static", {density = 1.0, friction = 1, bounce = 0.2})

local rectRight = display.newRect(display.contentWidth+1, display.contentHeight/2, 0 , display.contentHeight)
physics.addBody(rectRight, "static", {density = 1.0, friction = 1, bounce = 0.2})

local rectTop = display.newRect(_W, -1, _W*2, 0)
physics.addBody(rectTop, "static", {density = 1.0, friction = 1, bounce = 0.2})


ball:applyAngularImpulse( 100 )


function tick() 
  updateBall()
  forceStuck()
  gameplay()
end

function updateBall()
  
  --Check perso vita
  if ball.y + ball.height > paddle.y + paddle.height then
             ball.x = 160;  ball.y = 240
             ball.v = 0
             ball:setLinearVelocity(0)
             paddle.x = 160;  paddle.y = 440   
             if score > bestScore then
               bestScore = score
             end
             score = 0
             scoreNum.text = score;
             lifeGroup:remove(1)
             
             
  end
end

function forceStuck()
  local thisX, thisY = ball:getLinearVelocity()
  if thisX == 0 and thisY == 0 then
    ball:setLinearVelocity(40, -400)
  end
end

function gameplay()
    if score== 3 * level then
      updateBallVelocity()
      level = level +1
    end
    
    if lifeGroup.numChildren == 0 then
      Runtime:removeEventListener( "enterFrame", tick )
      Runtime:removeEventListener( "touch", dragPaddle )
      ball:removeSelf()
      paddle:removeSelf()
      textBoxScreen("GAME OVER", "Punti:"..bestScore)
      
      
    end
end

function updateBallVelocity()
      local vx, vy = ball:getLinearVelocity()
      ball:setLinearVelocity(vx*1.8,vy*1.8)
end

function onBounce(event)

  if event.phase == "began" then
    audio.play(bounceSound);
    score = score + 1;
    scoreNum.text = score;
  end 
end

function dragPaddle(event)

          if event.phase == "began" then
             moveX = event.x - paddle.x
          elseif event.phase == "moved" then
             paddle.x = event.x - moveX
          end
          
          if((paddle.x - paddle.width * 0.5) < 0) then
             paddle.x = paddle.width * 0.5
          elseif((paddle.x + paddle.width * 0.5) > display.contentWidth) then
             paddle.x = display.contentWidth - paddle.width * 0.5
          end
end 

function restart()
  
end

function textBoxScreen(title, message)
 
	-- Display text box with win or lose message
	textBox = display.newImage("images/textBox.png");
	textBox.x = _W;
	textBox.y = _H;
 
	-- Win or Lose Text
	conditionDisplay = display.newText(title, 0, 0, "Arial", 38);
	conditionDisplay:setTextColor(255,255,255,255);
	conditionDisplay.xScale = 0.5;
	conditionDisplay.yScale = 0.5;
	conditionDisplay.x = display.contentCenterX;
	conditionDisplay.y = display.contentCenterY - 15;
 
	--Try Again or Congrats Text
	messageText = display.newText(message, 0, 0, "Arial", 24);
	messageText:setTextColor(255,255,255,255);
	messageText.xScale = 0.5;
	messageText.yScale = 0.5;
	messageText.x = display.contentCenterX;
	messageText.y = display.contentCenterY + 15;
 
	-- Add all elements into a new group
	textBoxGroup = display.newGroup();
	textBoxGroup:insert(textBox);
	textBoxGroup:insert(conditionDisplay);
	textBoxGroup:insert(messageText);
 
	-- Make text box interactive
	textBox:addEventListener("tap", restart);
end

Runtime:addEventListener( "touch", dragPaddle )
Runtime:addEventListener( "enterFrame", tick )
paddle:addEventListener("collision", onBounce);





