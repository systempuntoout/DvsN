-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--require('mobdebug').start() 

display.setStatusBar(display.HiddenStatusBar);

--Libraries
   
local shake = require "shake"
local physics = require("physics")
local loadsave = require( "loadsave" )
local sheetInfo = require("spritesheet")
local defaultSettings = require("defaultSettings")
local utility = require("utility")

physics.start()
physics.setGravity(0, 15)
--physics.setDrawMode( "hybrid" )
--local performance = require('performance')
--performance:newPerformanceMeter()
--function checkMemory()
--   collectgarbage( "collect" )
--   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
--   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
--end
--timer.performWithDelay( 1000, checkMemory, 0 )

--Load settings
local loadedSettings 
loadedSettings = loadsave.loadTable( "settings.json")
if loadedSettings == nil then
    loadsave.saveTable( DEFAULT_GAME_SETTINGS, "settings.json" )
    loadedSettings = loadsave.loadTable( "settings.json")
end


--Variables
local _CENTER_HEIGHT = display.contentHeight/2
local _CENTER_WIDTH = display.contentWidth/2
local _X_BALLSTARTPOSITION = 160
local _Y_BALLSTARTPOSITION = 240
local _X_PADDLESTARTPOSITION = 160
local _Y_PADDLESTARTPOSITION = 440
local NUMBER_OF_LIFES = 3
local MASTER_VOLUME = 0.1
local MAX_VELOCITY = 700
local BALL_VELOCITY_INCREASE = 2.5
local score = 0
local paddle
local ball
local backgroundMusicEnabled = loadedSettings.backgroundMusicEnabled
local ReboundsBeforeIncreaseDifficulty = 1

-- Sheets
local myImageSheet = graphics.newImageSheet ( "images/spritesheet.png", sheetInfo:getSheet() )

-- Background sound
  local soundOptionSequenceData = {
    {
    name="soundOption",                                  
    sheet=myImageSheet,                          
    frames= { 1, 2 }
    }
}

--Music
local bgMusic = audio.loadStream("sounds/backgroundmusic.mp3");
local bounceSound = audio.loadSound("sounds/bounce.mp3");
local whistle = audio.loadSound("sounds/whistle.mp3");
local enemyOw = audio.loadSound("sounds/ow.mp3");
audio.setVolume(MASTER_VOLUME)

-- Show the Title Screen
function showTitleScreen()

	-- Place all title elements into 1 group
	titleScreenGroup = display.newGroup()	
	
	titleScreen = display.newImage("images/soccerfield.jpg", 0, 0, true);
	titleScreen.x = _CENTER_WIDTH;
	titleScreen.y = _CENTER_HEIGHT;

  
  -- DiegoNik
	diegoNik = display.newImage("images/diegonik.png")
	diegoNik.x = _CENTER_WIDTH;
	diegoNik.y = _CENTER_HEIGHT-(_CENTER_HEIGHT/2) ;
  diegoNik.xScale = 0.5
  diegoNik.yScale = 0.5
  
  -- Title
	title = display.newImage("images/gameTitle.png")
	title.x = _CENTER_WIDTH;
	title.y = _CENTER_HEIGHT-(_CENTER_HEIGHT/10) ;
  title.xScale = 0.5
  title.yScale = 0.5
  
  -- Display play button image
	playBtn = display.newImage("images/giocaButton.png")
	playBtn.x = _CENTER_WIDTH;
	playBtn.y = _CENTER_HEIGHT+(_CENTER_HEIGHT/2) ;
	playBtn.name = "playbutton";
  
  --Sound option
  soundOptionSprite = display.newSprite( myImageSheet, soundOptionSequenceData )
  soundOptionSprite.anchorX = 0
  soundOptionSprite.anchorY = 1
	soundOptionSprite.x = 2;
	soundOptionSprite.y = _CENTER_HEIGHT*2 ; 
  soundOptionSprite.xScale = 0.2
  soundOptionSprite.yScale = 0.2
  
  if backgroundMusicEnabled then
    soundOptionSprite:setFrame(2)
  else
    soundOptionSprite:setFrame(1)
  end

	-- Insert backgroudn and button into group
	titleScreenGroup:insert(titleScreen);
	titleScreenGroup:insert(playBtn);

	-- Make play button interactive
	playBtn:addEventListener("tap", loadGame);
  soundOptionSprite:addEventListener("tap", soundConfig);

end

-- Set up the game space
function initializeGameScreen()
  
  --Background
  local background = display.newImage( "images/soccerfield.jpg")
  background.x = _CENTER_WIDTH
  background.y = _CENTER_HEIGHT
  
  --lifegroup
  lifeGroup = display.newGroup()
  for i=1, NUMBER_OF_LIFES  do
    local life = display.newImage( "images/life.png" )
    life.y = 10
    life.x = _CENTER_HEIGHT + (life.width*i+3)
    lifeGroup.insert(lifeGroup, life)
  end
  lifeGroup:toFront()

  --Ball
  ball = display.newImage( "images/ball3.png" )
  ball.x = _X_BALLSTARTPOSITION;  ball.y = _Y_BALLSTARTPOSITION


  --Paddle
  paddle = display.newImage("images/diego2.png")
  paddle.x = _X_PADDLESTARTPOSITION;  paddle.y = _Y_PADDLESTARTPOSITION

  --Score
  scoreText = display.newText("Punti:", 22, 5, "Arial", 14)
  scoreText:setTextColor(255, 255, 255, 255)
  scoreNum = display.newText("0", 54, 6, "Arial", 14)
  scoreNum:setTextColor(255, 255, 255, 255)
  
  --Walls
  rectLeft = display.newRect(0, display.contentHeight/2, 0 , display.contentHeight)
  rectRight = display.newRect(display.contentWidth+1, display.contentHeight/2, 0 , display.contentHeight)
  rectTop = display.newRect(_CENTER_WIDTH, -1, _CENTER_WIDTH*2, 0)
 
	paddle:addEventListener("tap", startGame)
end

function startGame()
  if backgroundMusicEnabled then
    if audio.isChannelActive(1) then
      audio.setVolume(MASTER_VOLUME +1, {channel = 1})
    else
      audio.play(bgMusic, {channel = 1,loops =- 1});
    end
  end
	physics.addBody( ball, "dynamic", {density = 1.0, friction = 1, bounce = 1.05, radius = 25 })
  physics.addBody( paddle, "static", {density = 1.0, friction = 1, bounce = 0.1, radius = 26})
  physics.addBody(rectLeft, "static", {density = 1.0, friction = 1, bounce = 0.2})
  physics.addBody(rectRight, "static", {density = 1.0, friction = 1, bounce = 0.2})
  physics.addBody(rectTop, "static", {density = 1.0, friction = 1, bounce = 0.2})
  
  score = 0
  level = 1
  
  ball:applyAngularImpulse( math.random(100, 300) )
	paddle:removeEventListener("tap", startGame);
	gameListeners("add");
end

function gameListeners(event)
	if event == "add" then
		Runtime:addEventListener( "touch", dragPaddle )
    Runtime:addEventListener( "enterFrame", gameLoop )
    paddle:addEventListener("collision", onBounce);

	-- Remove listeners when not needed to free up memory
	elseif event == "remove" then
		Runtime:removeEventListener( "enterFrame", gameLoop )
    Runtime:removeEventListener( "touch", dragPaddle )
    paddle:removeEventListener("collision", onBounce);
	end
end

function gameLoop() 
  updateBall()
  normalizeVelocity()
  gameplay()
end

function updateBall()
  
  --Check perso vita
  if ball.y + ball.height > paddle.y + paddle.height then
             audio.play(whistle)
             Runtime:removeEventListener( "enterFrame", gameLoop )
             local tm = timer.performWithDelay( 1500, function() 
             ball.x = _X_BALLSTARTPOSITION;  ball.y = _Y_BALLSTARTPOSITION
             ball.v = 0
             ball:setLinearVelocity(0)
             paddle.x = _X_PADDLESTARTPOSITION;  paddle.y = _Y_PADDLESTARTPOSITION   
             scoreNum.text = score;
             lifeGroup:remove(1) 
             Runtime:addEventListener( "enterFrame", gameLoop )
           end )
  end
end

function normalizeVelocity()
  local thisX, thisY = ball:getLinearVelocity()
  
  if thisX >MAX_VELOCITY then
     thisX = MAX_VELOCITY
  end
  if thisX <-MAX_VELOCITY then
     thisX = -MAX_VELOCITY
  end 
  if thisY < -MAX_VELOCITY then
     thisY = -MAX_VELOCITY
  end
  ball:setLinearVelocity(thisX,thisY )
  
  
  --Force stuck
  if thisX == 0 and thisY == 0 and not (ball.x == _X_BALLSTARTPOSITION and ball.y == _Y_BALLSTARTPOSITION) then
    ball:setLinearVelocity(40, -400 )
  end
end

function gameplay()
    if score >= ReboundsBeforeIncreaseDifficulty * level then
      updateBallVelocity()
      generateMonster()
      level = level +1
    end
    
    
    if lifeGroup.numChildren == 0 then
      gameListeners("remove");
      killObject(ball)
      killObject(paddle)
      audio.fade(1)
      audio.play(whistle, {channel = 2, loops = 2})
      if score > loadedSettings.highScore then
        loadedSettings.highScore = score
        loadsave.saveTable( loadedSettings, "settings.json" )
      end 
      
      textBoxScreen("GAME OVER", "Punti: "..score)
    end
end


function updateBallVelocity()
      local vx, vy = ball:getLinearVelocity()      
      ball:setLinearVelocity(vx*BALL_VELOCITY_INCREASE,vy*BALL_VELOCITY_INCREASE)
end

function generateMonster()
    local enemy = display.newImage("images/enemy.png")
    enemy.name = "Niki"
    enemy.isVisible = false
    enemy.anchorX = 0
    enemy.anchorY = 0
    local randomX = math.random(0, _CENTER_WIDTH*2 - enemy.width)
    local randomY = math.random(0, _CENTER_HEIGHT-(_CENTER_HEIGHT/2))
    enemy.name = "Niki" .. randomX .. "|" .. randomY
    enemy.x = randomX
    enemy.y = randomY
    
    local esisteEnemy = physics.queryRegion( randomX, randomY, randomX+enemy.width, randomY+enemy.height )
    if not esisteEnemy then
      enemy.isVisible = true
      enemy.alpha=0.7
      timer.performWithDelay(100, function()
                                    physics.addBody(enemy, "static", {density = 1.0, friction = 1, bounce = 0.2, radius = 27}) 
                                    transition.to(enemy, {alpha=1})  
                                  end)
      enemy:addEventListener("collision", destroyMonster);
    else
      killObject(enemy)
    end
end


function spawnEnemy()
    local foo = display.newImage("images/ball3.png")
    foo.x = _CENTER_WIDTH; foo.y = _CENTER_HEIGHT
    foo.name = "enemy"; 
    physics.addBody( foo, "dynamic" )
    local function checkLocation()
        if foo.y ==_CENTER_HEIGHT*2+45 then
            Runtime:removeEventListener("enterFrame", checkLocation)
        end
    end
    Runtime:addEventListener("enterFrame", checkLocation)
end

function destroyMonster(event)
  if event.phase == "ended" then
   local ballVelocityX, ballVelocityY = event.other:getLinearVelocity()
   audio.play(enemyOw)
   startShake()
   timer.performWithDelay( 300, stopShake )
   timer.performWithDelay(2, function() physics.removeBody(event.target) end)
   transition.to(event.target, { time=400, x = _CENTER_WIDTH*2, y = 0, alpha= 0, onComplete=killObject })
  end
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

function textBoxScreen(title, message)
 
	-- Display text box with win or lose message
	textBox = display.newImage("images/textBox.png");
	textBox.x = _CENTER_WIDTH;
	textBox.y = _CENTER_HEIGHT;
 
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
  
  --Try Again or Congrats Text
	bestScoreText = display.newText("Record: "..loadedSettings.highScore, 0, 0, "Arial", 24);
	bestScoreText:setTextColor(255,255,255,255);
	bestScoreText.xScale = 0.5;
	bestScoreText.yScale = 0.5;
	bestScoreText.x = display.contentCenterX;
	bestScoreText.y = display.contentCenterY + 30;
 
	-- Add all elements into a new group
	textBoxGroup = display.newGroup();
	textBoxGroup:insert(textBox);
	textBoxGroup:insert(conditionDisplay);
  textBoxGroup:insert(bestScoreText)
	textBoxGroup:insert(messageText);
 
	-- Make text box interactive
	textBox:addEventListener("tap", restart);
end

function restart()
	initializeGameScreen()
  textBox:removeEventListener("tap", restart);
end


function soundConfig()
  if backgroundMusicEnabled then
     backgroundMusicEnabled = false
     soundOptionSprite:setFrame(1)
  else
    backgroundMusicEnabled = true
    soundOptionSprite:setFrame(2)
  end
  loadedSettings.backgroundMusicEnabled = backgroundMusicEnabled
  loadsave.saveTable( loadedSettings, "settings.json" )
end




function loadGame(event)

	if event.target.name == "playbutton" then
		transition.to(titleScreenGroup,{time = 0, alpha=0, onComplete = initializeGameScreen});
		playBtn:removeEventListener("tap", loadGame);
    soundOptionSprite:removeEventListener("tap", soundConfig);
	end
end


-- Main Function
function main()
	showTitleScreen();
end
main()


