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
local colors = require("colors")

mRandom = math.random

local gameplayItemsGroup = display.newGroup()

physics.start()

--Load settings
local loadedSettings 
loadedSettings = loadsave.loadTable( "settings.json")
if loadedSettings == nil then
  loadsave.saveTable( DEFAULT_GAME_SETTINGS, "settings.json" )
  loadedSettings = loadsave.loadTable( "settings.json")
end


--Variables
local _SCREEN_CENTRE_Y = display.contentHeight/2
local _SCREEN_CENTRE_X = display.contentWidth/2
local _SCREEN_WIDTH = display.contentWidth - (display.screenOriginX*2)
local _SCREEN_HEIGHT = display.contentHeight - (display.screenOriginY*2)
local _SCREEN_TOP = display.screenOriginY 
local _SCREEN_RIGHT = display.contentWidth - display.screenOriginX
local _SCREEN_BOTTOM = display.contentHeight - display.screenOriginY
local _SCREEN_LEFT  = display.screenOriginX
local _SCREEN_REALHEIGHT  = _SCREEN_HEIGHT / display.contentScaleY
local _SCREEN_REALWIDTH =  _SCREEN_WIDTH / display.contentScaleX

local TEXT_TYPE = { SCORE = 1 , POWERUP = 2, GOAL = 3 }

local DEBUG = false
local _X_BALLSTARTPOSITION = 160
local _Y_BALLSTARTPOSITION = 240
local _X_PADDLESTARTPOSITION = 160
local _Y_PADDLESTARTPOSITION = 440
local NUMBER_OF_LIVES = 3
local MASTER_VOLUME = 0.3
local MAX_BALL_VELOCITY = 700
local BALL_VELOCITY_INCREASE = 2
local SKIP_MAIN_SCREEN = true


local POWERUP_SPAWN_MIN = 15000
local POWERUP_SPAWN_MAX = 20000
local MONSTER_SPAWN_MIN = 5000
local MONSTER_SPAWN_MAX = 8000
local VELOCITY_INCREASE_MIN = 10000
local VELOCITY_INCREASE_MAX = 15000 

local TIME_LAST_POWERUP = 1000
local TIME_LAST_MONSTER = 10000
local TIME_LAST_VELOCITY_INCREASE = 5000

local score = 0
local increaseVelocityOnBounce = false
local paddle
local ball
local backgroundMusicEnabled = loadedSettings.backgroundMusicEnabled
local current_lives = NUMBER_OF_LIVES
local titleScreenGroup
local playBtn
local soundOptionSprite
local wallLeft 
local wallRight 
local wallTopLeft 
local wallTopRight 
local scoreNum
local liveNum


local POWER_UPS = {"r","g","b","P","B","S"}

if DEBUG then
  physics.setDrawMode( "hybrid" )
  local performance = require('performance')
  performance:newPerformanceMeter()
  function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
  end
  timer.performWithDelay( 1000, checkMemory, 0 )
  print("_SCREEN_CENTRE_Y :" .. _SCREEN_CENTRE_Y)
  print("_SCREEN_CENTRE_X :" .. _SCREEN_CENTRE_X)
  print("_SCREEN_WIDTH :" .. _SCREEN_WIDTH)
  print("_SCREEN_HEIGHT :" .. _SCREEN_HEIGHT)
  print("_SCREEN_TOP :" .. _SCREEN_TOP)
  print("_SCREEN_RIGHT :" .. _SCREEN_RIGHT)
  print("_SCREEN_BOTTOM :" .. _SCREEN_BOTTOM)
  print("_SCREEN_LEFT :" .. _SCREEN_LEFT)
  print("_SCREEN_REALHEIGHT :" .. _SCREEN_REALHEIGHT)
  print("_SCREEN_REALWIDTH :" .. _SCREEN_REALWIDTH)
end



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
local musicBackground = audio.loadStream("sounds/backgroundmusic2.mp3");
local bounceSound = audio.loadSound("sounds/bounce.mp3");
local whistleSound = audio.loadSound("sounds/whistle.mp3");
local enemySound = audio.loadSound("sounds/ow.mp3");
local powerUpSound = audio.loadSound("sounds/powerup.wav");
local newLiveSound = audio.loadSound("sounds/newLive.wav");
local ironWallSound = audio.loadSound("sounds/ironWall.mp3");
local goalSound = audio.loadSound("sounds/goal.mp3");
audio.setVolume(MASTER_VOLUME)

-- Show the Title Screen
function showTitleScreen()

  -- Place all title elements into 1 group
  titleScreenGroup = display.newGroup()	

  local titleScreen = display.newImageRect( "images/soccerfield_360x570.jpg",360,570,true)
  titleScreen.x = _SCREEN_CENTRE_X;
  titleScreen.y = _SCREEN_CENTRE_Y;


  -- DiegoNik
  local diegoNik = display.newImage("images/diegonik.png")
  diegoNik.x = _SCREEN_CENTRE_X;
  diegoNik.y = _SCREEN_CENTRE_Y-(_SCREEN_CENTRE_Y/2) ;
  diegoNik.xScale = 0.5
  diegoNik.yScale = 0.5

  -- Title
  local title = display.newImage("images/gameTitle.png")
  title.x = _SCREEN_CENTRE_X;
  title.y = _SCREEN_CENTRE_Y-(_SCREEN_CENTRE_Y/10) ;
  title.xScale = 0.5
  title.yScale = 0.5

  -- Display play button image
  playBtn = display.newImage("images/giocaButton.png")
  playBtn.x = _SCREEN_CENTRE_X;
  playBtn.y = _SCREEN_CENTRE_Y+(_SCREEN_CENTRE_Y/2) ;
  playBtn.name = "playbutton";

  --Sound option
  soundOptionSprite = display.newSprite( myImageSheet, soundOptionSequenceData )
  soundOptionSprite.anchorX = 0
  soundOptionSprite.anchorY = 1
  soundOptionSprite.x = 2;
  soundOptionSprite.y = _SCREEN_CENTRE_Y*2 ; 
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
  local background = display.newImageRect( "images/soccerfield_360x570.jpg",360,570)
  background.x = _SCREEN_CENTRE_X
  background.y = _SCREEN_CENTRE_Y

  --lives
  local live = display.newImage( "images/live.png" )
  live.y = 10
  live.x = _SCREEN_CENTRE_X+(_SCREEN_CENTRE_X/1.5)
  local liveText = display.newText("x", _SCREEN_CENTRE_X+(_SCREEN_CENTRE_X/1.5)+15, 10, "Arial", 14)
  liveText:setTextColor(255, 255, 255, 255)
  liveNum = display.newText(NUMBER_OF_LIVES, _SCREEN_CENTRE_X+(_SCREEN_CENTRE_X/1.5)+30, 10, "Arial", 14)
  liveNum:setTextColor(255, 255, 255, 255)


  --Ball
  ball = display.newImage( "images/ball3.png" )
  ball.x = _X_BALLSTARTPOSITION;  ball.y = _Y_BALLSTARTPOSITION

  --Paddle
  paddle = display.newImage("images/diego2.png")
  paddle.x = _X_PADDLESTARTPOSITION;  paddle.y = _Y_PADDLESTARTPOSITION

  --Score
  local scoreText = display.newText("Punti: ", 22, 10, "Arial", 14)
  scoreText:setTextColor(255, 255, 255, 255)
  scoreNum = display.newText("0", 54, 10, "Arial", 14)
  scoreNum:setTextColor(255, 255, 255, 255)

  --Walls
  wallLeft = display.newRect(0, display.contentHeight/2, 0 , display.contentHeight)
  wallRight = display.newRect(display.contentWidth+1, display.contentHeight/2, 0 , display.contentHeight)
  wallTopLeft = display.newRect(55, 23, 110, 0)
  wallTopRight = display.newRect(_SCREEN_RIGHT-55, 23, 110, 0)
  paddle:addEventListener("tap", startGame)
end

function startGame()
  if backgroundMusicEnabled then
    if audio.isChannelActive(1) then
      audio.setVolume(MASTER_VOLUME +1, {channel = 1})
    else
      audio.play(musicBackground, {channel = 1,loops =- 1});
    end
  end
  paddle.bounciness = 0.1;
  physics.addBody( ball, "dynamic", {density = 1.0, friction = 1, bounce = 1.05, radius = 25, filter = {groupIndex = -1} })
  physics.addBody( paddle, "static", {density = 1.0, friction = 1, bounce = paddle.bounciness, radius = 26})
  physics.addBody(wallLeft, "static", {density = 1.0, friction = 1, bounce = 0.2})
  physics.addBody(wallRight, "static", {density = 1.0, friction = 1, bounce = 0.2})
  physics.addBody(wallTopLeft, "static", {density = 1.0, friction = 1, bounce = 0.2})
  physics.addBody(wallTopRight, "static", {density = 1.0, friction = 1, bounce = 0.2})

  score = 0
  current_lives = NUMBER_OF_LIVES

  ball:applyAngularImpulse( mRandom(100, 300) )
  ball.angularDamping = 0.3;
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

  --Check goal
  if ball.y - (ball.height/2) < 0 then
    goal()
    ball.x = _X_BALLSTARTPOSITION;  ball.y = _Y_BALLSTARTPOSITION
    ball.v = 0
    ball:applyAngularImpulse( mRandom(200, 400) )
    ball:setLinearVelocity(0)
    return
  end

  -- Lost ball
  if ball.y + (ball.height/2) > _SCREEN_CENTRE_Y*2 then
    audio.play(whistleSound)
    ball.isVisible = false;
    Runtime:removeEventListener( "enterFrame", gameLoop )
    local tm = timer.performWithDelay( 1000, function() 
        ball.x = _X_BALLSTARTPOSITION;  ball.y = _Y_BALLSTARTPOSITION
        ball.isVisible = true;
        ball.v = 0
        ball:setLinearVelocity(0)
        ball:applyAngularImpulse( mRandom(100, 300) )
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

  if event.time-TIME_LAST_POWERUP >= mRandom(POWERUP_SPAWN_MIN, POWERUP_SPAWN_MAX) and not gameOver() then
    spawnPowerUp()
    TIME_LAST_POWERUP = event.time
  end
  if event.time-TIME_LAST_MONSTER >= mRandom(MONSTER_SPAWN_MIN, MONSTER_SPAWN_MAX) and not gameOver() then
    spawnMonster()
    TIME_LAST_MONSTER = event.time
  end
  if event.time-TIME_LAST_VELOCITY_INCREASE >= mRandom(VELOCITY_INCREASE_MIN, VELOCITY_INCREASE_MAX) and not gameOver() then
    TIME_LAST_VELOCITY_INCREASE = event.time
    paddle.trans = transition.blink(paddle,{time=500})
    local function stopBlink()
      transition.cancel(paddle.trans)
      paddle.alpha = 1
      paddle:setFillColor( 1, 0.5, 0.5 )
      increaseVelocityOnBounce = true
    end
    timer.performWithDelay(500, stopBlink)
  end


  if gameOver() then
    gameListeners("remove");
    killObject(ball)
    killObject(paddle)
    audio.fade(1)
    audio.play(whistleSound, {channel = 2, loops = 2})
    if score > loadedSettings.highScore then
      loadedSettings.highScore = score
      loadsave.saveTable( loadedSettings, "settings.json" )
    end 

    textBoxScreen("GAME OVER", "Punti: "..score)
  end    

end


function addLive()
  audio.play(newLiveSound)
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
  local randomX = mRandom(0, _SCREEN_CENTRE_X*2 - enemy.width)
  local randomY = mRandom(0, _SCREEN_CENTRE_Y-(_SCREEN_CENTRE_Y/2))
  enemy.name = "Niki" .. randomX .. "|" .. randomY
  enemy.x = randomX
  enemy.y = randomY

  local esisteEnemy = physics.queryRegion( randomX, randomY, randomX+enemy.width, randomY+enemy.height )
  if not esisteEnemy then
    enemy.isVisible = true
    enemy.alpha=0.7
    local easingFunctions = {easing.outInElastic, easing.inElastic, easing.inExpo,easing.inQuad, easing.linear }
    timer.performWithDelay(100, function()
        physics.addBody(enemy, "static", {density = 1.0, friction = 1, bounce = 0.2, radius = 27}) 
        local function randomEnemy()
          if mRandom(1,10) <= 5 then
            transition.to(enemy, {time = 5000, 
                                  alpha=1, 
                                  y = enemy.y+50, 
                                  x = enemy.x+ mRandom(-20,20) , 
                                  transition= easingFunctions[mRandom(1,#easingFunctions)]}) 
          end
        end
        transition.to(enemy, {alpha=1, onComplete = randomEnemy})  
      end)


    enemy:addEventListener("collision", destroyMonster);
  else
    killObject(enemy)
  end
end


function spawnAdditionalBall()
  local additionalBall = display.newImage("images/additionalball.png")
  additionalBall.x = mRandom(additionalBall.width,_SCREEN_CENTRE_X*2-additionalBall.width); additionalBall.y = _SCREEN_CENTRE_Y
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
    -- Goal
    if additionalBall.height~= nil and additionalBall.y - (additionalBall.height/2) < 0 then
      goal()
      killObject(additionalBall)
      Runtime:removeEventListener("enterFrame", additionalBallGameLogic)      
    end
    -- Lost
    if additionalBall.height~= nil and additionalBall.y + (additionalBall.height/2) >=_SCREEN_CENTRE_Y*2   then
      killObject(additionalBall)
      Runtime:removeEventListener("enterFrame", additionalBallGameLogic)
    end

  end
  Runtime:addEventListener("enterFrame", additionalBallGameLogic)
end

function updatePaddleBounciness()
  local bounce = paddle.bounciness
  paddle.bounciness = bounce + 0.5
  physics.removeBody( paddle)
  physics.addBody( paddle, "static", {density = 1.0, friction = 1, bounce =  paddle.bounciness, radius = 26})
end

function spawnPowerUp()
  -- create sprite, set animation, play
  local myPowerUpSprites = display.newSprite( myPowerUpImageSheet, powerUpSequenceData )
  gameplayItemsGroup:insert(myPowerUpSprites)
  gameplayItemsGroup:toFront()
  myPowerUpSprites.x = mRandom(myPowerUpSprites.width,_SCREEN_CENTRE_X*2-myPowerUpSprites.width); myPowerUpSprites.y = myPowerUpSprites.height
  local power_up = POWER_UPS[mRandom(1,#POWER_UPS)]
  myPowerUpSprites:setSequence(power_up)
  myPowerUpSprites:play()
  myPowerUpSprites.name = "powerUp_" .. power_up; 
  myPowerUpSprites.alpha=0.7
  timer.performWithDelay(200, function()
      transition.to(myPowerUpSprites, { time=5000, 
          y = _SCREEN_CENTRE_Y*2, 
          alpha= 1, 
          onComplete=function()
            Runtime:removeEventListener("enterFrame", powerUpGameLogic)
            killObject(myPowerUpSprites)
          end
        })  
    end)
  local function powerUpGameLogic(event)


    if myPowerUpSprites ~= nil and myPowerUpSprites.x~=nil  and hasCollidedCircle(myPowerUpSprites,paddle) then
      if myPowerUpSprites.name == "powerUp_r" then      
        audio.play(powerUpSound)
        updatePaddleBounciness()
        increaseScore(100)
        inGameText(".Bounce.", TEXT_TYPE.POWERUP, "yellow")
      elseif myPowerUpSprites.name == "powerUp_g" then
        audio.play(powerUpSound)
        increaseScore(1000)
        inGameText(".1000 Points.", TEXT_TYPE.POWERUP, "skyblue")
      elseif myPowerUpSprites.name == "powerUp_b" then
        audio.play(ironWallSound)
        addLifeSaver()
        increaseScore(100)
        inGameText(".Shield.", TEXT_TYPE.POWERUP, "silver")
      elseif myPowerUpSprites.name == "powerUp_P" then
        addLive()
        inGameText(".Life.", TEXT_TYPE.POWERUP, "red")
      elseif myPowerUpSprites.name == "powerUp_B" then
        audio.play(powerUpSound)
        spawnAdditionalBall()
        increaseScore(100)
        inGameText(".ExtraBall.", TEXT_TYPE.POWERUP, "blue")
      elseif myPowerUpSprites.name == "powerUp_S" then
        audio.play(powerUpSound)
        updateBallVelocity()
        increaseScore(100)
        inGameText(".Speed.", TEXT_TYPE.POWERUP, "orange")
      end

      killObject(myPowerUpSprites)
    end

  end
  Runtime:addEventListener("enterFrame", powerUpGameLogic)

end

function destroyMonster(event)
  if event.phase == "ended" then
    local ballVelocityX, ballVelocityY = event.other:getLinearVelocity()
    increaseScore(50)
    audio.play(enemySound)
    timer.performWithDelay(2, function() physics.removeBody(event.target) end)
    transition.to(event.target, { time=400, x = _SCREEN_CENTRE_X*2, y = 0, alpha= 0, onComplete=killObject })
  end
end

function addLifeSaver()
  local lifeSaver = display.newImage("images/ironWall.png", _SCREEN_CENTRE_X, _SCREEN_CENTRE_Y*2-1)
  physics.addBody(lifeSaver, "static", {bounce = 1.5, friction=2})
  transition.to(lifeSaver, { time=20000,alpha= 0, onComplete=killObject })
end

function increaseScore(delta)
  score = score + delta
  inGameText("+" .. delta, TEXT_TYPE.SCORE)
  scoreNum.text = score;
end

function goal()
  audio.play(goalSound)
  startShake()
  timer.performWithDelay( 300, stopShake )
  inGameText("GOAL!", TEXT_TYPE.GOAL)
  increaseScore(500)
end


function onBounce(event)

  if event.phase == "began" then
    audio.play(bounceSound);
    increaseScore(10)
    if increaseVelocityOnBounce then
      updateBallVelocity()
      paddle:setFillColor( 1, 1, 1 )
      increaseVelocityOnBounce = false
    end
  end 
end

function inGameText(text, textType, color)

  if textType == TEXT_TYPE.SCORE then
    local points_Text = display.newText(text, 30, 100,native.systemFontBold,25)
    colors.setTextColor(points_Text, 'whitesmoke')
    transition.to(points_Text,{time = 1500, alpha = 0, y = 25, onComplete=killObject})
  elseif textType == TEXT_TYPE.POWERUP then
    local powerUp_Text = display.newText(text, _SCREEN_CENTRE_X*2, _SCREEN_CENTRE_Y,native.systemFontBold,50)
    colors.setTextColor(powerUp_Text, color)
    transition.to(powerUp_Text,{time = 500, 
        x = _SCREEN_CENTRE_X, 
        onComplete = function()  
          transition.to(powerUp_Text,{time = 500, 
              alpha = 0, 
              y = 0, 
              onComplete=killObject})
        end})
  elseif textType == TEXT_TYPE.GOAL then
    local goal_Text = display.newText(text, _SCREEN_CENTRE_X, _SCREEN_CENTRE_Y-(_SCREEN_CENTRE_Y/2),native.systemFontBold,50)
    colors.setTextColor(goal_Text,'yellow')
    transition.to(goal_Text,{time = 1000, 
        alpha = 0, 
        y = 0, 
        onComplete=killObject})
  end

end


function dragPaddle(event)
  local moveX = 0
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
  textBox.x = _SCREEN_CENTRE_X;
  textBox.y = _SCREEN_CENTRE_Y;

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


