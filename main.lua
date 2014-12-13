-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--require('mobdebug').start() 

display.setStatusBar(display.HiddenStatusBar);

--Libraries

local utility = require("utility")
local shake = require "shake"
local physics = require("physics")
local loadsave = require( "loadsave" )
local powerupSheetInfo = require("powerupspritesheet")
local sheetInfo = require("spritesheet")
local defaultSettings = require("defaultSettings")

mRandom = math.random

local gameplayItemsGroup = display.newGroup()

physics.start()
--physics.setGravity(0, 15)
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
local NUMBER_OF_LIVES = 3
local MASTER_VOLUME = 0.1
local MAX_BALL_VELOCITY = 700
local BALL_VELOCITY_INCREASE = 1
local REBOUNDS_FOR_VELOCITY_INCREASE = 3
local SKIP_MAIN_SCREEN = true
local score = 0
local paddle
local ball
local backgroundMusicEnabled = loadedSettings.backgroundMusicEnabled
local current_lives = NUMBER_OF_LIVES

local timeLastPowerUp = 1000
local timeLastMonster = 100000


local POWER_UPS = {"r","g","b","P","B","S"}



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

-- Sheets
local myPowerUpImageSheet = graphics.newImageSheet ( "images/powerupspritesheet.png", powerupSheetInfo:getSheet() )

local powerUpSequenceData = {
    {
    name="r",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 1,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="g",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 9,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
    },
  {
    name="b",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 17,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="P",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 25,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="B",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 33,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
  },
  {
    name="S",                                  -- name of the animation
    sheet=myPowerUpImageSheet,                           -- the image sheet
    start= 41,
    count = 8,-- number of frames
    time=1000,                                    -- speed
    loopCount=0                                   -- repeat
    }
  
}




--Music
local bgMusic = audio.loadStream("sounds/backgroundmusic.mp3");
local bounceSound = audio.loadSound("sounds/bounce.mp3");
local whistle = audio.loadSound("sounds/whistle.mp3");
local enemyOw = audio.loadSound("sounds/ow.mp3");
local powerUp = audio.loadSound("sounds/powerup.wav");
local newLive = audio.loadSound("sounds/newLive.wav");
local ironWall = audio.loadSound("sounds/ironWall.mp3");
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


  -- Insert background and button into group
  titleScreenGroup:insert(titleScreen);
  titleScreenGroup:insert(playBtn);

  -- Make play button interactive
  playBtn:addEventListener("tap", loadGame);
  soundOptionSprite:addEventListener("tap", soundConfig);
  if SKIP_MAIN_SCREEN then
    loadGame()
  end 
end

-- Set up the game space
function initializeGameScreen()

  --Background
  local background = display.newImage( "images/soccerfield.jpg")
  background.x = _CENTER_WIDTH
  background.y = _CENTER_HEIGHT

  --lives
  local live = display.newImage( "images/live.png" )
  live.y = 10
  live.x = _CENTER_WIDTH+(_CENTER_WIDTH/1.5)
  liveText = display.newText("x", _CENTER_WIDTH+(_CENTER_WIDTH/1.5)+15, 10, "Arial", 14)
  liveText:setTextColor(255, 255, 255, 255)
  liveNum = display.newText(NUMBER_OF_LIVES, _CENTER_WIDTH+(_CENTER_WIDTH/1.5)+30, 10, "Arial", 14)
  liveNum:setTextColor(255, 255, 255, 255)
  

  --Ball
  ball = display.newImage( "images/ball3.png" )
  ball.x = _X_BALLSTARTPOSITION;  ball.y = _Y_BALLSTARTPOSITION


  --Paddle
  paddle = display.newImage("images/diego2.png")
  paddle.x = _X_PADDLESTARTPOSITION;  paddle.y = _Y_PADDLESTARTPOSITION

  --Score
  scoreText = display.newText("Punti:", 22, 10, "Arial", 14)
  scoreText:setTextColor(255, 255, 255, 255)
  scoreNum = display.newText("0", 54, 10, "Arial", 14)
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
  physics.addBody( ball, "dynamic", {density = 1.0, friction = 1, bounce = 1.05, radius = 25, filter = {groupIndex = -1} })
  physics.addBody( paddle, "static", {density = 1.0, friction = 1, bounce = 0.1, radius = 26})
  physics.addBody(rectLeft, "static", {density = 1.0, friction = 1, bounce = 0.2})
  physics.addBody(rectRight, "static", {density = 1.0, friction = 1, bounce = 0.2})
  physics.addBody(rectTop, "static", {density = 1.0, friction = 1, bounce = 0.2})

  score = 0
  level = 1

  ball:applyAngularImpulse( mRandom(100, 300) )
  ball.angularDamping = 1.5;
  paddle.isBullet = true;
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

function gameLoop(event) 
  updateBall()
  normalizeVelocity()
  gameplay(event)
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
        current_lives = current_lives -1
        liveNum.text = current_lives
        gameplayItemsGroup:removeSelf();gameplayItemsGroup = display.newGroup()

        Runtime:addEventListener( "enterFrame", gameLoop )
      end )
  end
end

function normalizeVelocity()
  local thisX, thisY = ball:getLinearVelocity()

  if thisX >MAX_BALL_VELOCITY then
    thisX = MAX_BALL_VELOCITY
  end
  if thisX <-MAX_BALL_VELOCITY then
    thisX = -MAX_BALL_VELOCITY
  end 
  if thisY < -MAX_BALL_VELOCITY then
    thisY = -MAX_BALL_VELOCITY
  end
  ball:setLinearVelocity(thisX,thisY )


  --Force stuck
  if thisX == 0 and thisY == 0 and not (ball.x == _X_BALLSTARTPOSITION and ball.y == _Y_BALLSTARTPOSITION) then
    ball:setLinearVelocity(40, -400 )
  end
end

function gameplay(event)

  if event.time-timeLastPowerUp >= mRandom(5000, 6000) and not gameOver() then
    spawnPowerUp()
    timeLastPowerUp = event.time
  end
  if event.time-timeLastMonster >= mRandom(8000, 12000) and not gameOver() then
    spawnMonster()
    timeLastMonster = event.time
  end
  if score >= REBOUNDS_FOR_VELOCITY_INCREASE * level then
    updateBallVelocity()
    level = level +1
  end


  if gameOver() then
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


function addLive()
  audio.play(newLive)
  current_lives = current_lives + 1
  liveNum.text = current_lives
end 

function gameOver()
  return current_lives == 0
end

function updateBallVelocity()
  local vx, vy = ball:getLinearVelocity()      
  ball:setLinearVelocity(vx*BALL_VELOCITY_INCREASE,vy*BALL_VELOCITY_INCREASE)
end

function spawnMonster()
  local enemy = display.newImage("images/enemy.png")
  enemy.name = "Niki"
  enemy.isVisible = false
  enemy.anchorX = 0
  enemy.anchorY = 0
  local randomX = mRandom(0, _CENTER_WIDTH*2 - enemy.width)
  local randomY = mRandom(0, _CENTER_HEIGHT-(_CENTER_HEIGHT/2))
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


function spawnAdditionalBall()
  local additionalBall = display.newImage("images/additionalball.png")
  additionalBall.x = mRandom(additionalBall.width,_CENTER_WIDTH*2-additionalBall.width); additionalBall.y = _CENTER_HEIGHT
  additionalBall.name = "enemy"; 
  additionalBall.xScale = 0.7;
  additionalBall.yScale = 0.7;
  additionalBall.alpha=0.7
  additionalBall.angularDamping = 2;
    timer.performWithDelay(200, function()
        physics.addBody( additionalBall, "dynamic", {density = 3, friction = 2, bounce = 1.2, radius = 20, filter = {groupIndex = -1} })
        transition.to(additionalBall, {alpha=1})  
      end)
  gameplayItemsGroup:insert(additionalBall)
  gameplayItemsGroup:toFront()
  local function additionalBallGameLogic(event)
    if additionalBall.getLinearVelocity then
      local vx, vy = additionalBall:getLinearVelocity()
      if vx >MAX_BALL_VELOCITY then
        vx = MAX_BALL_VELOCITY
      end
      if vx <-MAX_BALL_VELOCITY then
        vx = -MAX_BALL_VELOCITY
      end 
      if vy < -MAX_BALL_VELOCITY then
        vy = -MAX_BALL_VELOCITY
      end
      additionalBall:setLinearVelocity(vx,vy )
    end 
    if additionalBall.height~= nil and additionalBall.y >=_CENTER_HEIGHT*2+additionalBall.height then
        Runtime:removeEventListener("enterFrame", additionalBallGameLogic)
    end
    
  end
  Runtime:addEventListener("enterFrame", additionalBallGameLogic)
end

function spawnPowerUp()
    -- create sprite, set animation, play
    local myPowerUpSprites = display.newSprite( myPowerUpImageSheet, powerUpSequenceData )
    gameplayItemsGroup:insert(myPowerUpSprites)
    gameplayItemsGroup:toFront()
    myPowerUpSprites.x = mRandom(myPowerUpSprites.width,_CENTER_WIDTH*2-myPowerUpSprites.width); myPowerUpSprites.y = myPowerUpSprites.height
    local power_up = POWER_UPS[mRandom(1,#POWER_UPS)]
    myPowerUpSprites:setSequence(power_up)
    myPowerUpSprites:play()
    myPowerUpSprites.name = "powerUp_" .. power_up; 
    myPowerUpSprites.alpha=0.7
    timer.performWithDelay(200, function()
        transition.to(myPowerUpSprites, { time=5000, 
                                          y = _CENTER_HEIGHT*2, 
                                          alpha= 1, 
                                          onComplete=function()
                                                      Runtime:removeEventListener("enterFrame", checkLocation)
                                                      killObject(myPowerUpSprites)
                                                     end
                                          })  
                                 end)
    local function powerUpGameLogic(event)
      
      
      if myPowerUpSprites ~= nil and myPowerUpSprites.x~=nil  and hasCollidedCircle(myPowerUpSprites,paddle) then
          if myPowerUpSprites.name == "powerUp_r" then      
            audio.play(powerUp)
            score = score+100
          elseif myPowerUpSprites.name == "powerUp_g" then
            audio.play(powerUp)
            score = score+100
          elseif myPowerUpSprites.name == "powerUp_b" then
            audio.play(ironWall)
            addLifeSaver()
          elseif myPowerUpSprites.name == "powerUp_P" then
            addLive()
            score = score+100
          elseif myPowerUpSprites.name == "powerUp_B" then
            audio.play(powerUp)
            spawnAdditionalBall()
            score = score+100
          elseif myPowerUpSprites.name == "powerUp_S" then
            audio.play(powerUp)
            score = score+100
          end

          killObject(myPowerUpSprites)
      end
      
    end
  Runtime:addEventListener("enterFrame", powerUpGameLogic)
  
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

function addLifeSaver()
  local lifeSaver = display.newImage("images/ironWall.png", _CENTER_WIDTH, _CENTER_HEIGHT*2-5)
  physics.addBody(lifeSaver, "static", {bounce = 1.5})
  transition.to(lifeSaver, { time=10000,alpha= 0, onComplete=killObject })
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

    transition.to(titleScreenGroup,{time = 0, alpha=0, onComplete = initializeGameScreen});
    playBtn:removeEventListener("tap", loadGame);
    soundOptionSprite:removeEventListener("tap", soundConfig);

end


-- Main Function
function main()
  showTitleScreen();
end
main()


