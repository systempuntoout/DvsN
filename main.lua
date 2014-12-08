-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--require('mobdebug').start() 

--Libraries
local shake = require "shake"
local physics = require("physics")
local loadsave = require( "loadsave" )
local sheetInfo = require("spritesheet")
local defaultSettings = require("defaultSettings")
display.setStatusBar(display.HiddenStatusBar);
physics.start()
--physics.setDrawMode( "hybrid" )

--Load settings
local loadedSettings = loadsave.loadTable( "settings.json")
if loadedSettings == nil then
    loadsave.saveTable( DEFAULT_GAME_SETTINGS, "settings.json" )
end

--Variables
local _H = display.contentHeight/2
local _W = display.contentWidth/2
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

-- Sheets
local myImageSheet = graphics.newImageSheet ( "images/spritesheet.png", sheetInfo:getSheet() )

-- Background sound
  local soundOptionSequenceData = {
    {
    name="soundOption",                                  
    sheet=myImageSheet,                          
    frames= { 12, 18 }
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
	titleScreen.x = _W;
	titleScreen.y = _H;

  
  -- DiegoNik
	diegoNik = display.newImage("images/diegonik.png")
	diegoNik.x = _W;
	diegoNik.y = _H-(_H/2) ;
  diegoNik.xScale = 0.5
  diegoNik.yScale = 0.5
  
  -- Title
	title = display.newImage("images/gameTitle.png")
	title.x = _W;
	title.y = _H-(_H/10) ;
  title.xScale = 0.5
  title.yScale = 0.5
  
  -- Display play button image
	playBtn = display.newImage("images/giocaButton.png")
	playBtn.x = _W;
	playBtn.y = _H+(_H/2) ;
	playBtn.name = "playbutton";
  
  --Sound option
  soundOptionSprite = display.newSprite( myImageSheet, soundOptionSequenceData )
  soundOptionSprite.anchorX = 0
  soundOptionSprite.anchorY = 1
	soundOptionSprite.x = 2;
	soundOptionSprite.y = _H*2 ; 
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
  background.x = _W
  background.y = _H
  
  --lifegroup
  lifeGroup = display.newGroup()
  for i=1, NUMBER_OF_LIFES  do
    local life = display.newImage( "images/life.png" )
    life.y = 10
    life.x = _H + (life.width*i+3)
    lifeGroup.insert(lifeGroup, life)
  end

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
  rectTop = display.newRect(_W, -1, _W*2, 0)
 
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
    Runtime:addEventListener( "enterFrame", tick )
    paddle:addEventListener("collision", onBounce);

	-- Remove listeners when not needed to free up memory
	elseif event == "remove" then
		Runtime:removeEventListener( "enterFrame", tick )
    Runtime:removeEventListener( "touch", dragPaddle )
    paddle:removeEventListener("collision", onBounce);
	end
end

function tick() 
  updateBall()
  normalizeVelocity()
  gameplay()
end

function updateBall()
  
  --Check perso vita
  if ball.y + ball.height > paddle.y + paddle.height then
             audio.play(whistle)
             Runtime:removeEventListener( "enterFrame", tick )
             local tm = timer.performWithDelay( 1500, function() 
             ball.x = _X_BALLSTARTPOSITION;  ball.y = _Y_BALLSTARTPOSITION
             ball.v = 0
             ball:setLinearVelocity(0)
             paddle.x = _X_PADDLESTARTPOSITION;  paddle.y = _Y_PADDLESTARTPOSITION   
             scoreNum.text = score;
             lifeGroup:remove(1) 
             Runtime:addEventListener( "enterFrame", tick )
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
    if score > 5 * level then
      updateBallVelocity()
      generateMonster()
      level = level +1
    end
    
    
    if lifeGroup.numChildren == 0 then
      gameListeners("remove");
      ball:removeSelf(); ball= nil
      paddle:removeSelf(); paddle = nil
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
    enemy.isVisible = false
    enemy.anchorX = 0
    enemy.anchorY = 0
    local randomX = math.random(0, _W*2 - enemy.width)
    local randomY = math.random(0, _H-(_H/2))
    
    enemy.x = randomX
    enemy.y = randomY
    
    local esisteEnemy = physics.queryRegion( randomX, randomY, randomX+enemy.width, randomY+enemy.height )
    if not esisteEnemy then
      enemy.isVisible = true
      physics.addBody(enemy, "static", {density = 1.0, friction = 1, bounce = 0.2, radius = 27})
      enemy:addEventListener("collision", function()
          audio.play(enemyOw)
          startShake()
          timer.performWithDelay( 300, stopShake )
          enemy:removeSelf();enemy = nil
      end);
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


