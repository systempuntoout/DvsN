-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--require('mobdebug').start() 

local DEBUG = false
local SKIP_MAIN_SCREEN = false


display.setStatusBar(display.HiddenStatusBar);

--Libraries

local utility = require("lib.utility")
local shake = require "lib.shake"
local physics = require("physics")
local loadsave = require( "lib.loadsave" )


local defaultSettings = require("defaultSettings")
local colors = require("lib.colors")

local sheetConfig = require("spritesheets.spritesheetconfig")
local powerupSheetConfig  = require("spritesheets.powerupspritesheetconfig")
local finalBoss1SheetConfig  = require("spritesheets.finalbossspritesheetconfig")
local finalBoss2SheetConfig  = require("spritesheets.finalboss2spritesheetconfig")
local coinSheetConfig = require("spritesheets.coinspritesheetconfig")
local theKingSheetConfig = require("spritesheets.thekingspritesheetconfig")
local birdSheetConfig = require("spritesheets.birdspritesheetconfig")
local diamondSheetConfig = require("spritesheets.diamondspritesheetconfig")

mRandom = math.random

local gameplayItemsGroup = display.newGroup()
local gameScreenGroup 

physics.start()

--Load settings
local loadedSettings 
loadedSettings = loadsave.loadTable( "settings.json")
if loadedSettings == nil then
  loadsave.saveTable( defaultSettings.DEFAULT_GAME_SETTINGS, "settings.json" )
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

local TEXT_TYPE = { SCORE = 1 , POWERUP = 2, GOAL = 3, STATIC = 4, FINALBOSS = 5, COMBO = 6 }


local _X_BALLSTARTPOSITION = 160
local _Y_BALLSTARTPOSITION = 240
local _X_PADDLESTARTPOSITION = 160
local _Y_PADDLESTARTPOSITION = 440
local NUMBER_OF_LIVES = 3
local MASTER_VOLUME = 0.3
local MAX_BALL_VELOCITY = 500
local BALL_VELOCITY_INCREASE = 2

local POWERUP_SPAWN_MIN = 15000
local POWERUP_SPAWN_MAX = 20000
local MONSTER_SPAWN_MIN = 5000
local MONSTER_SPAWN_MAX = 7000
local BALLOON_SPAWN_MIN = 30000
local BALLOON_SPAWN_MAX = 35000
local BIRD_SPAWN_MIN = 20000 
local BIRD_SPAWN_MAX = 30000
local DIAMOND_SPAWN_MIN = 10000 
local DIAMOND_SPAWN_MAX = 12000
local VELOCITY_INCREASE_MIN = 8000
local VELOCITY_INCREASE_MAX = 10000 

local COIN_SPAWN_MIN = 10000 
local COIN_SPAWN_MAX = 12000

local TIME_LAST_POWERUP = 10000
local TIME_LAST_MONSTER = 3000
local TIME_LAST_BALLOON = 20000
local TIME_LAST_BIRD = 1000
local TIME_LAST_DIAMOND = 1000
local TIME_LAST_COIN = 1000

local TIME_LAST_VELOCITY_INCREASE = 3000

local TIME_LAST_FINALBOSS_SHOOT = 4000
local TIME_LAST_FINALBOSS_MOVE = 1000
local FINALBOSS_SHOOT_MIN = 2000
local FINALBOSS_SHOOT_MAX = 3000
local FINALBOSS_MOVE_MIN = 1000
local FINALBOSS_MOVE_MAX = 2000

local SCORE_FINAL_BOSS_STAGE = 10000
local DELTA_SCORE_FINAL_BOSS_STAGE = 10000
local DELTA_SCALE_FINAL_BOSS = 0.3

local paddle
local ball
local backgroundMusicEnabled = loadedSettings.backgroundMusicEnabled
local titleScreenGroup
local playBtn
local soundOptionSprite
local wallLeft 
local wallRight 
local wallTopLeft 
local wallTopRight 
local wallTopFinalBoss
local scoreNum
local liveNum
local finalBossSprites

local score 
local increaseVelocityOnBounce
local current_lives 
local extraBallCombo 
local finalBossStage 
local timeLastPowerup 
local timeLastMonster 
local timeLastVelocityIncrease  
local timeLastFinalBossShoot 
local scoreFinalBossStage
local ballStuck
local POWER_UPS = {"r","g","b","P","B","S"}
--local POWER_UPS = {"B","B","B","B","B","B"}
local resetTimers
local backgroundMusicChannel
local theKingSprites
local timeLastBalloon
local timeLastBird
local timeLastDiamond
local timeLastCoin
local level

if DEBUG then
  physics.setDrawMode( "hybrid" )
  local performance = require('lib.performance')
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
  local fonts = native.getFontNames()
  local fontsNames = ""
  for i,fontname in ipairs(fonts) do
    fontsNames = fontname .. ',' .. fontsNames
  end
  print(fontsNames)
  --local textFontsNames = display.newText(fontsNames, 0, 0, native.systemFont, 30)

end



--Music
local backgroundIntroMusic = audio.loadStream("sounds/backgroundmusicintro.mp3");
local backgroundMusic = audio.loadStream("sounds/backgroundmusic2.mp3");
local backgroundFinalBossMusic = audio.loadStream("sounds/backgroundmusicfinalboss.mp3");
local bounceSound = audio.loadSound("sounds/bounce.mp3");
local whistleSound = audio.loadSound("sounds/whistle.mp3");
local whistle2Sound = audio.loadSound("sounds/whistle2.mp3");
local enemySound = audio.loadSound("sounds/ow.mp3");
local finalBossSound = audio.loadSound("sounds/owfinalboss.mp3");
local finalBoss2Sound = audio.loadSound("sounds/ow2finalboss.mp3");
local powerUpSound = audio.loadSound("sounds/powerup.wav");
local newLiveSound = audio.loadSound("sounds/newLive.wav");
local ironWallSound = audio.loadSound("sounds/ironWall.mp3");
local goalSound = audio.loadSound("sounds/goal.mp3");
local pew = audio.loadSound("sounds/pew.mp3");
local coinSound = audio.loadSound("sounds/coin.mp3");
local diamondSound = audio.loadSound("sounds/diamond.mp3");
local balloonSound = audio.loadSound("sounds/balloonPop.mp3");
local birdSound = audio.loadSound("sounds/bird.mp3");
local playSound = audio.loadSound("sounds/gioca.mp3");
local finalBossDefeatedSound = audio.loadSound("sounds/finalbossdefeated.mp3");
local miss1Sound = audio.loadSound("sounds/miss.mp3");
local miss2Sound = audio.loadSound("sounds/miss2.mp3");

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
  diegoNik.y = _SCREEN_CENTRE_Y-(_SCREEN_CENTRE_Y/3) ;
  diegoNik.xScale = 0.5
  diegoNik.yScale = 0.5

  -- Title
  local title = display.newImage("images/gameTitle.png")
  title.x = _SCREEN_CENTRE_X;
  title.y = _SCREEN_CENTRE_Y+(_SCREEN_CENTRE_Y/19) ;
  title.xScale = 0.5
  title.yScale = 0.5

  -- Display play button image
  playBtn = display.newImage("images/giocaButton3.png")
  playBtn.x = _SCREEN_CENTRE_X;
  playBtn.y = _SCREEN_CENTRE_Y+(_SCREEN_CENTRE_Y/2) ;
  playBtn.name = "playbutton";
  
  --Sound option
  soundOptionSprite = display.newSprite( sheetConfig.myImageSheet, sheetConfig.soundOptionSequenceData )
  soundOptionSprite.anchorX = 0
  soundOptionSprite.anchorY = 1
  soundOptionSprite.x = 2;
  soundOptionSprite.y = _SCREEN_CENTRE_Y*2 ; 
  soundOptionSprite.xScale = 0.2
  soundOptionSprite.yScale = 0.2

  if backgroundMusicEnabled then
    audio.setVolume(MASTER_VOLUME)
    soundOptionSprite:setFrame(2)
  else
    audio.setVolume(0)
    soundOptionSprite:setFrame(1)
  end

  backgroundMusicChannel = audio.play(backgroundIntroMusic, {loops =- 1});

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

  --audio
  audio.stop(backgroundMusicChannel)

  --Background
  local background = display.newImageRect( "images/soccerfield_360x570.jpg",360,570)
  background.x = _SCREEN_CENTRE_X
  background.y = _SCREEN_CENTRE_Y  
  
  --GamescreenGroups
  if (gameScreenGroup ~= nil) then
    gameScreenGroup:removeSelf()
  end
  gameScreenGroup = display.newGroup()
  
  gameScreenGroup:insert(background)
  
  -- The king
  theKingSprites = display.newSprite( theKingSheetConfig.theKingImageSheet, theKingSheetConfig.theKingSequenceData )
  theKingSprites.x = _SCREEN_CENTRE_X
  theKingSprites.y = _SCREEN_CENTRE_Y
  gameScreenGroup:insert(theKingSprites)
  theKingSprites.isVisible = false
  theKingSprites.xScale = 2
  theKingSprites.yScale = 2
  local function spriteListener( event )
    if event.phase == "ended" then
      transition.to(theKingSprites,{time = 500, alpha = 0})
    end
  end
  theKingSprites:addEventListener( "sprite", spriteListener )
  gameScreenGroup:toFront()
  
  --lives
  local live = display.newImage( "images/live.png" )
  live.y = 10
  live.x = _SCREEN_CENTRE_X+(_SCREEN_CENTRE_X/1.5)
  local liveText = display.newText("x", _SCREEN_CENTRE_X+(_SCREEN_CENTRE_X/1.5)+15, 11, "Arial", 14)
  liveText:setTextColor(255, 255, 255, 255)
  liveNum = display.newText(NUMBER_OF_LIVES, _SCREEN_CENTRE_X+(_SCREEN_CENTRE_X/1.5)+30, 11, "Arial", 14)
  liveNum:setTextColor(255, 255, 255, 255)


  --Ball
  ball = display.newImage( "images/ball3.png" )
  ball.x = _X_BALLSTARTPOSITION;  ball.y = _Y_BALLSTARTPOSITION
  ball.name = "ball"

  --Paddle
  paddle = display.newImage("images/diego2.png")
  paddle.x = _X_PADDLESTARTPOSITION;  paddle.y = _Y_PADDLESTARTPOSITION
  paddle.name = "paddle"

  --Score
  local scoreText = display.newText("Punti: ", 22, 11, "Arial", 14)
  scoreText:setTextColor(255, 255, 255, 255)
  scoreNum = display.newText("0", 60, 11, "Arial", 14)
  scoreNum:setTextColor(255, 255, 255, 255)

  --Walls
  wallLeft = display.newRect(0, display.contentHeight/2, 0 , display.contentHeight)
  wallRight = display.newRect(display.contentWidth+1, display.contentHeight/2, 0 , display.contentHeight)
  wallTopLeft = display.newRect(55, 23, 110, 0)
  wallTopRight = display.newRect(_SCREEN_RIGHT-55, 23, 110, 0)

  inGameText("Tap player to play", TEXT_TYPE.STATIC, "yellow",30)

  paddle:addEventListener("tap", startGame)
end

function startGame(event)

  backgroundMusicChannel = audio.play(backgroundMusic, {loops =- 1});

  paddle.bounciness = 0.1;
  physics.addBody( ball, "dynamic", {density = 1.0, friction = 1, bounce = 1.05, radius = 25, filter = {groupIndex = -1} })
  physics.addBody( paddle, "static", {density = 1.0, friction = 1, bounce = paddle.bounciness, radius = 26})
  physics.addBody(wallLeft, "static", {density = 1.0, friction = 1, bounce = 0.2})
  physics.addBody(wallRight, "static", {density = 1.0, friction = 1, bounce = 0.2})
  physics.addBody(wallTopLeft, "static", {density = 1.0, friction = 1, bounce = 0.2})
  physics.addBody(wallTopRight, "static", {density = 1.0, friction = 1, bounce = 0.2})

  initializeGameplayVariable(event)
  resetTimers = true
  if (mRandom() <0.5) then
    ball:applyAngularImpulse( mRandom(200, 300) )
  else
    ball:applyAngularImpulse( mRandom(-300, -200) )
  end
  ball.angularDamping = 0.3;
  paddle.isBullet = true;
  paddle:removeEventListener("tap", startGame);
  gameListeners("add");
end

function initializeGameplayVariable(event)
  score = 0
  increaseVelocityOnBounce = false
  current_lives = NUMBER_OF_LIVES
  extraBallCombo = 0 
  finalBossStage = false
  scoreFinalBossStage = SCORE_FINAL_BOSS_STAGE
  ballStuck = false
  resetTimers = false
  level = 1
end

function initializeTimers(event)
  timeLastPowerup = TIME_LAST_POWERUP + event.time
  timeLastMonster = TIME_LAST_MONSTER + event.time
  timeLastVelocityIncrease = TIME_LAST_VELOCITY_INCREASE + event.time
  timeLastFinalBossShoot = TIME_LAST_FINALBOSS_SHOOT + event.time
  timeLastFinalBossMove = TIME_LAST_FINALBOSS_MOVE + event.time
  timeLastBalloon = TIME_LAST_BALLOON + event.time
  timeLastBird = TIME_LAST_BIRD + event.time
  timeLastDiamond = TIME_LAST_DIAMOND + event.time
  timeLastCoin = TIME_LAST_COIN + event.time
end

function gameListeners(event)
  if event == "add" then
    Runtime:addEventListener( "touch", dragPaddle )
    Runtime:addEventListener( "enterFrame", gameLoop )
    paddle:addEventListener("collision", onBounce);
    wallTopRight:addEventListener("collision", onTopWallCollision);
    wallTopLeft:addEventListener("collision", onTopWallCollision);

    -- Remove listeners when not needed to free up memory
  elseif event == "remove" then
    Runtime:removeEventListener( "enterFrame", gameLoop )
    Runtime:removeEventListener( "touch", dragPaddle )
    paddle:removeEventListener("collision", onBounce);
    wallTopRight:removeEventListener("collision", onTopWallCollision);
    wallTopLeft:removeEventListener("collision", onTopWallCollision);
  end
end

local function onFinalBossCollision(event)
  if event.phase == "began" then
    if event.other.name == "ball" then
      audio.play(finalBossSound)
      finalBossSprites:removeEventListener("collision", onFinalBossCollision)
      timer.performWithDelay(1, function()
          if finalBossSprites ~= nil and finalBossSprites.name then
            physics.removeBody(finalBossSprites)
            finalBossSprites.trans = transition.blink(finalBossSprites,{time=500})
            local function stopBlink()
              if finalBossSprites ~= nil then
                transition.cancel(finalBossSprites.trans)
                finalBossSprites.alpha = 1
                physics.addBody( finalBossSprites, "static", {density = 1.0,radius = finalBossSprites.config.radius})
                finalBossSprites:addEventListener("collision", onFinalBossCollision)
              end
            end
            timer.performWithDelay(1500, stopBlink)
          end
        end
      )
      wallTopFinalBoss.xScale = wallTopFinalBoss.xScale - (DELTA_SCALE_FINAL_BOSS / (level))
      if(wallTopFinalBoss.xScale <= 0.2) then
        level = level+1
        audio.play(finalBoss2Sound)
        theKing("dance")
        killObject(wallTopFinalBoss)
        gameListenersFinalBoss("remove")
        audio.stop(backgroundMusicChannel)
        audio.play(finalBossDefeatedSound)
        increaseScore(1000)
        inGameText("Level Complete", TEXT_TYPE.STATIC, "white")
        killObject(finalBossSprites)
        finalBossSprites = nil
        timer.performWithDelay(4000, function()
            finalBossStage = false
            resetTimers = true
            backgroundMusicChannel = audio.play(backgroundMusic, {loops = -1})
          end)
      end
    end
  end
end

function gameListenersFinalBoss(event)
  if event == "add" then
    Runtime:addEventListener( "enterFrame", gameplayFinalBoss )
    finalBossSprites:addEventListener("collision", onFinalBossCollision)
    wallTopRight:removeEventListener("collision", onTopWallCollision);
    wallTopLeft:removeEventListener("collision", onTopWallCollision);

    -- Remove listeners when not needed to free up memory
  elseif event == "remove" then
    wallTopRight:addEventListener("collision", onTopWallCollision);
    wallTopLeft:addEventListener("collision", onTopWallCollision);
    Runtime:removeEventListener( "enterFrame", gameplayFinalBoss )
    if (finalBossSprites~= nil and finalBossSprites.name) then
      finalBossSprites:removeEventListener("collision", onFinalBossCollision)
    end
  end
end



function gameLoop(event) 
  if resetTimers then
    resetTimers = false
    initializeTimers(event)
  end
  updateBall()
  normalizeVelocity()
  gameplay(event)
end


function gameplayFinalBoss(event) 
  local function finalBossMove()
    local moveToX
    local moves = {"left", "right", "front", "back"}
    local randomMove = mRandom(1,#moves)


    if moves[randomMove] == "left" then
      moveToX = mRandom(finalBossSprites.contentWidth /2,finalBossSprites.x)
      moveToY = finalBossSprites.y
    end
    if moves[randomMove] == "right" then
      moveToX = mRandom(finalBossSprites.x, _SCREEN_CENTRE_X*2 - (finalBossSprites.contentWidth /2))
      moveToY = finalBossSprites.y
    end
    if moves[randomMove] == "front" then
      moveToX = finalBossSprites.x
      moveToY = mRandom(finalBossSprites.y, _SCREEN_CENTRE_Y)
    end
    if moves[randomMove] == "back" then
      moveToX = finalBossSprites.x
      moveToY = mRandom((finalBossSprites.contentHeight/2) +20, finalBossSprites.y)
    end
    finalBossSprites:setSequence(moves[randomMove])
    finalBossSprites:play()
    transition.to(finalBossSprites, {time = 1000, x = moveToX, y = moveToY}) 
  end

  local function finalBossShoot()
    local bullet = display.newImage("images/bullet.png") 
    bullet.x = finalBossSprites.x
    bullet.y = finalBossSprites.y+ (finalBossSprites.height/2)
    physics.addBody(bullet, "dynamic", {density = 1.0, radius = 9, filter = {groupIndex = -1}}) 
    bullet.gravityScale = 0
    bullet:applyForce( (paddle.x - bullet.x)*0.2  , (paddle.y - bullet.y)*0.2 , bullet.x, bullet.y )

    local function onBulletCollision(event)
      if  event.phase == "ended" then
        if event.other.name == "paddle" then
          colors.setFillColor( paddle, "green" )
          bullet:removeEventListener("collision", onBulletCollision)
          killObject(event.target)
          Runtime:removeEventListener( "touch", dragPaddle )
          local function shakePaddle()
            paddle.x = paddle.x0 + math.random(-2,2) 
          end
          timer.performWithDelay(1, function()
              paddle.x0 = paddle.x
              Runtime:addEventListener("enterFrame", shakePaddle)
            end
          )
          timer.performWithDelay(1000, function()
              if paddle and paddle.name and not gameOver() then
                paddle:setFillColor( 1,1,1)
                Runtime:addEventListener( "touch", dragPaddle )
                Runtime:removeEventListener("enterFrame", shakePaddle)
              end
            end
          )
        end  
      end
    end
    bullet:addEventListener("collision", onBulletCollision)
    audio.play(pew)
  end
  if event.time- timeLastFinalBossShoot >= mRandom(FINALBOSS_SHOOT_MIN, FINALBOSS_SHOOT_MAX) and not gameOver() then
    timeLastFinalBossShoot = event.time
    finalBossShoot()
  end
  if event.time- timeLastFinalBossMove >= mRandom(FINALBOSS_MOVE_MIN, FINALBOSS_MOVE_MAX) and not gameOver() then
    timeLastFinalBossMove = event.time
    finalBossMove()
  end
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
    theKing("serious")
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
        extraBallCombo = 0
        current_lives = current_lives -1
        liveNum.text = current_lives
        gameplayItemsGroup:removeSelf();gameplayItemsGroup = display.newGroup()

        Runtime:addEventListener( "enterFrame", gameLoop )
      end )
  end
end

function normalizeVelocity()
  local thisX, thisY = ball:getLinearVelocity()

  -- try to avoid stuck ball
  local lastYPositionWithZeroVelocity = 0
  if  thisY > -10 and thisY < 10 then
    lastYPositionWithZeroVelocity = ball.y
    if paddle.y - lastYPositionWithZeroVelocity < 100 then
      ballStuck = true
    end
  end


  -- Avoid speed of light velocity :)
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


  --In case of stuck, unstuck :)
  if thisX == 0 and thisY == 0 and not (ball.x == _X_BALLSTARTPOSITION and ball.y == _Y_BALLSTARTPOSITION) then
    ball:setLinearVelocity(40, -400 )
  end
end

function gameplay(event)

  if reachedFinalBoss() and not gameOver() then
    spawnFinalBoss()
  end

  if event.time-timeLastPowerup >= mRandom(POWERUP_SPAWN_MIN, POWERUP_SPAWN_MAX) and not gameOver() and not playingFinalBoss() then
    spawnPowerUp()
    timeLastPowerup = event.time
  end
  if event.time-timeLastMonster >= mRandom(MONSTER_SPAWN_MIN, MONSTER_SPAWN_MAX) and not gameOver() and not playingFinalBoss() then
    spawnMonster()
    timeLastMonster = event.time
  end
  if event.time-timeLastBalloon >= mRandom(BALLOON_SPAWN_MIN, BALLOON_SPAWN_MAX) and not gameOver() and not playingFinalBoss() then
    spawnBalloon()
    timeLastBalloon = event.time
  end
  if event.time-timeLastBird >= mRandom(BIRD_SPAWN_MIN, BIRD_SPAWN_MAX) and not gameOver() and not playingFinalBoss() then
    spawnBird()
    timeLastBird = event.time
  end
  if event.time-timeLastDiamond >= mRandom(DIAMOND_SPAWN_MIN, DIAMOND_SPAWN_MAX) and not gameOver() and not playingFinalBoss() then
    spawnDiamond()
    timeLastDiamond = event.time
  end
  if event.time-timeLastCoin >= mRandom(COIN_SPAWN_MIN, COIN_SPAWN_MAX) and not gameOver() and not playingFinalBoss() then
    spawnCoin()
    timeLastCoin = event.time
  end
  if event.time-timeLastVelocityIncrease >= mRandom(VELOCITY_INCREASE_MIN, VELOCITY_INCREASE_MAX) and not gameOver() then
    timeLastVelocityIncrease = event.time
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
    audio.rewind(backgroundMusic)
    audio.stop(backgroundMusicChannel)
    audio.play(whistle2Sound)
    if score > loadedSettings.highScore then
      loadedSettings.highScore = score
      loadsave.saveTable( loadedSettings, "settings.json" )
    end 

    if playingFinalBoss() then
      gameListenersFinalBoss("remove")
      killObject(wallTopFinalBoss)
      killObject(finalBossSprites)
    end 
    textBoxScreen("GAME OVER", "Punti: "..score)
  end    

end


function reachedFinalBoss() 
  if  score > scoreFinalBossStage and not playingFinalBoss() then
    finalBossStage = true
    scoreFinalBossStage = scoreFinalBossStage + DELTA_SCORE_FINAL_BOSS_STAGE
    return true
  else
    return false
  end
end

function playingFinalBoss()
  return finalBossStage
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

function unstuckBall()
  if(ball.x <= _SCREEN_CENTRE_X) then
    ball:applyLinearImpulse(20, 20,ball.x,ball.y)
  else
    ball:applyLinearImpulse(-20, -20,ball.x,ball.y)
  end
  ballStuck = false
end

function theKing(sequence)
    local lock = false
    if not lock then
      lock = true
      theKingSprites.alpha = 0.3
      theKingSprites:toFront()
      theKingSprites.isVisible = true
      theKingSprites:setSequence(sequence)
      theKingSprites:play()
      lock = false
    end  
end

function spawnMonster()
  local enemy = display.newImage("images/enemy" .. mRandom(1,6) .. ".png")
  enemy.name = "Monster"
  enemy.isVisible = false
  enemy.xScale = 0.8
  enemy.yScale = 0.8
  local randomX = mRandom(enemy.width /2 , _SCREEN_CENTRE_X*2 - enemy.width)
  local randomY = mRandom(enemy.height /2, _SCREEN_CENTRE_Y-(_SCREEN_CENTRE_Y/2))
  enemy.x = randomX
  enemy.y = randomY
  gameplayItemsGroup:insert(enemy)
  gameplayItemsGroup:toFront()
  local esisteEnemy = physics.queryRegion( randomX, randomY, randomX+enemy.width, randomY+enemy.height )
  if not esisteEnemy then
    enemy.isVisible = true
    enemy.alpha=0.7
    local easingFunctions = {easing.outInElastic, easing.inElastic, easing.inExpo,easing.inQuad, easing.linear }
    if enemy ~= nil and enemy.name then
      timer.performWithDelay(1, function()
          if enemy ~= nil and enemy.name then
            physics.addBody(enemy, "static", {density = 1.0, friction = 1, bounce = 0.2, radius = 25}) 
            local function randomEnemy()
              if enemy and enemy.y and enemy.x and mRandom(1,10) <= 7 then
                transition.to(enemy, {time = 5000, 
                    alpha=1, 
                    y = enemy.y+50, 
                    x = enemy.x+ mRandom(-20,20) , 
                    transition= easingFunctions[mRandom(1,#easingFunctions)]}) 
              end
            end
            transition.to(enemy, {alpha=1, onComplete = randomEnemy})  
          end
        end)
      enemy:addEventListener("collision", destroyMonster);
    end
  else
    killObject(enemy)
  end
end

function spawnDiamond(x,y,bypassQuery)
  local myDiamondSprites = display.newSprite( diamondSheetConfig.myDiamondImageSheet, diamondSheetConfig.diamondSequenceData )
  physics.addBody( myDiamondSprites, "static", {density = 1, radius = 15, isSensor = true})
  myDiamondSprites.name = "diamond"
  myDiamondSprites.isVisible = false
  --myDiamondSprites.xScale = 0.07;
  --myDiamondSprites.yScale = 0.07;
  local randomX = x or mRandom(myDiamondSprites.contentWidth /2 , _SCREEN_CENTRE_X*2 - myDiamondSprites.contentWidth)
  local randomY = y or mRandom(myDiamondSprites.contentHeight /2, _SCREEN_CENTRE_Y-(_SCREEN_CENTRE_Y/2))
  local esisteDiamond = physics.queryRegion( randomX, randomY, randomX+myDiamondSprites.contentWidth, randomY+myDiamondSprites.contentHeight )

  if (not esisteDiamond) or bypassQuery then
    myDiamondSprites.isVisible = true
    gameplayItemsGroup:insert(myDiamondSprites)
    gameplayItemsGroup:toFront()
    myDiamondSprites.x = randomX
    myDiamondSprites.y = randomY
    myDiamondSprites:setSequence("diamond"..mRandom(8))
    myDiamondSprites:play()

    local function onDiamondCollision(event)
      if event.phase == "began" then
        if event.other.name == "ball" or event.other.name == "extraBall" then
          audio.play(diamondSound)
          increaseScore(60)
          killObject(myDiamondSprites)
          myDiamondSprites = nil
        end
      end
    end
    myDiamondSprites:addEventListener("collision", onDiamondCollision);
  else
    killObject(myDiamondSprites)
    myDiamondSprites = nil
  end
end


function spawnCoin(x,y,bypassQuery)
  local myCoinSprites = display.newSprite( coinSheetConfig.myCoinImageSheet, coinSheetConfig.coinSequenceData )
  physics.addBody( myCoinSprites, "static", {density = 1, radius = 15, isSensor = true})
  myCoinSprites.name = "coin"
  myCoinSprites.isVisible = false
  myCoinSprites.xScale = 0.07;
  myCoinSprites.yScale = 0.07;
  local randomX = x or mRandom(myCoinSprites.contentWidth /2 , _SCREEN_CENTRE_X*2 - myCoinSprites.contentWidth)
  local randomY = y or mRandom(myCoinSprites.contentHeight /2, _SCREEN_CENTRE_Y-(_SCREEN_CENTRE_Y/2))
  local esisteCoin = physics.queryRegion( randomX, randomY, randomX+myCoinSprites.contentWidth, randomY+myCoinSprites.contentHeight )

  if (not esisteCoin) or bypassQuery then
    myCoinSprites.isVisible = true
    gameplayItemsGroup:insert(myCoinSprites)
    gameplayItemsGroup:toFront()
    myCoinSprites.x = randomX
    myCoinSprites.y = randomY
    myCoinSprites:setSequence("coin")
    myCoinSprites:play()

    local function onCoinCollision(event)
      if event.phase == "began" then
        if event.other.name == "ball"  or event.other.name == "extraBall" then
          audio.play(coinSound)
          increaseScore(50)
          killObject(myCoinSprites)
          myCoinSprites = nil
        end
      end
    end
    myCoinSprites:addEventListener("collision", onCoinCollision);
  else
    killObject(myCoinSprites)
    myCoinSprites = nil
  end
end

function spawnMultiDiamonds()
  gameplayItemsGroup:removeSelf();gameplayItemsGroup = display.newGroup()
  for y=1,7 do
    for x = 1, 7 do
      spawnDiamond(40*x+5,40*y+5,true)
    end
  end
end 

function spawnMultiCoins()
  gameplayItemsGroup:removeSelf();gameplayItemsGroup = display.newGroup()
  for y=1,7 do
    for x = 1, 7 do
      spawnCoin(40*x+5,40*y+5,true)
    end
  end
end 
function spawnBird()
  local birdSprites = display.newSprite( birdSheetConfig.myBirdImageSheet, birdSheetConfig.birdSequenceData )
  birdSprites.name = "bird"
  
  local function onBirdTouch(event)
    if event.phase == "began" then
      audio.play(birdSound)
      spawnMultiDiamonds()
      killObject(event.target)
      event.target = nil
    end
  end
  
  birdSprites.x = -birdSprites.contentWidth
  birdSprites.y = mRandom(_SCREEN_CENTRE_Y-(_SCREEN_CENTRE_Y/2),_SCREEN_CENTRE_Y)
  birdSprites.xScale = 0.3
  birdSprites.yScale = 0.3
  gameplayItemsGroup:insert(birdSprites)
  gameplayItemsGroup:toFront()
  birdSprites:setSequence("fly")
  birdSprites:play()
  transition.to(birdSprites, {time = 4000, x = _SCREEN_CENTRE_X*2+birdSprites.contentWidth, onComplete = killObject})
  birdSprites:addEventListener("touch", onBirdTouch)
end

function spawnBalloon()
  local balloon = display.newImageRect( "images/balloon.png",40,40 )
  physics.addBody( balloon, "dynamic", {density = 1, radius = 15, isSensor = true})
  balloon.name = "balloon"
  balloon.gravityScale = -0.2
  gameplayItemsGroup:insert(balloon)
  gameplayItemsGroup:toFront()
  balloon.x =  mRandom(balloon.contentWidth, _SCREEN_CENTRE_X*2 - balloon.contentWidth)
  balloon.y = _SCREEN_CENTRE_Y + (_SCREEN_CENTRE_Y/2)
  local function onBalloonTouch(event)
    if event.phase == "began" then
      audio.play(balloonSound)
      increaseScore(100)
      spawnMultiCoins()
      Runtime:removeEventListener("enterFrame", balloonGameLogic)
      killObject(balloon)
      balloon = nil
    end
  end
  local function balloonGameLogic(event)
    if balloon ~= nil then
      if balloon.y and balloon.y < _SCREEN_TOP then
        balloon:removeEventListener("touch", onBalloonTouch)
        Runtime:removeEventListener("enterFrame", balloonGameLogic)
        killObject(balloon)
        balloon = nil
      end
    end
  end

  balloon:addEventListener("touch", onBalloonTouch)
  Runtime:addEventListener("enterFrame", balloonGameLogic)
end


function spawnExtraBall()
  local extraBall = display.newImage("images/extraball" .. mRandom(1,3) ..".png")
  extraBall.x = mRandom(extraBall.width,_SCREEN_CENTRE_X*2-extraBall.width); extraBall.y = _SCREEN_CENTRE_Y
  extraBall.name = "extraBall"; 
  extraBall.xScale = 0.8;
  extraBall.yScale = 0.8;
  extraBall.alpha=0.7
  extraBall.angularDamping = 2;
  timer.performWithDelay(200, function()
      physics.addBody( extraBall, "dynamic", {density = 3, friction = 2, bounce = 1.2, radius = 23, filter = {groupIndex = -1} })
      transition.to(extraBall, {alpha=1})  
    end)
  gameplayItemsGroup:insert(extraBall)
  gameplayItemsGroup:toFront()
  local function extraBallGameLogic(event)
    if extraBall.getLinearVelocity then
      local vx, vy = extraBall:getLinearVelocity()
      if vx >MAX_BALL_VELOCITY then
        vx = MAX_BALL_VELOCITY
      end
      if vx <-MAX_BALL_VELOCITY then
        vx = -MAX_BALL_VELOCITY
      end 
      if vy < -MAX_BALL_VELOCITY then
        vy = -MAX_BALL_VELOCITY
      end
      extraBall:setLinearVelocity(vx,vy )
    end 
    -- Goal
    if extraBall.height~= nil and extraBall.y - (extraBall.height/2) < 0 then
      goal()
      killObject(extraBall)
      Runtime:removeEventListener("enterFrame", extraBallGameLogic)  
    end
    -- Lost
    if extraBall.height~= nil and extraBall.y + (extraBall.height/2) >=_SCREEN_CENTRE_Y*2   then
      killObject(extraBall)
      Runtime:removeEventListener("enterFrame", extraBallGameLogic)
      extraBallCombo = 0
    end

  end
  Runtime:addEventListener("enterFrame", extraBallGameLogic)
end

function spawnFinalBoss()
  gameplayItemsGroup:removeSelf();gameplayItemsGroup = display.newGroup()
  audio.rewind(backgroundMusic)
  audio.stop(backgroundMusicChannel)
  backgroundMusicChannel = audio.play(backgroundFinalBossMusic, {loops =- 1});

  wallTopFinalBoss = display.newImage('images/wall.png',_SCREEN_CENTRE_X,13)
  physics.addBody( wallTopFinalBoss, "static", {density = 1.0})
  inGameText("Final Boss",TEXT_TYPE.FINALBOSS,"white")

  timer.performWithDelay(2500, function()
      local sheetConfig 
      if level == 1 then 
        sheetConfig = finalBoss1SheetConfig
      else
        sheetConfig = finalBoss2SheetConfig
      end
      
      finalBossSprites = display.newSprite( sheetConfig.finalBossImageSheet, sheetConfig.finalBossSequenceData )
      finalBossSprites.config = sheetConfig
      physics.addBody( finalBossSprites, "static", {density = 1.0,radius = sheetConfig.radius})
      finalBossSprites.x = mRandom(finalBossSprites.width,_SCREEN_CENTRE_X*2-finalBossSprites.width); 
      finalBossSprites.y = finalBossSprites.height+20
      finalBossSprites.xScale = sheetConfig.xScale
      finalBossSprites.yScale = sheetConfig.yScale
      finalBossSprites.name = "finalBoss"
      gameListenersFinalBoss("add");
    end)

end

function spawnPowerUp()
  -- create sprite, set animation, play
  local myPowerUpSprites = display.newSprite( powerupSheetConfig.myPowerUpImageSheet, powerupSheetConfig.powerUpSequenceData )
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
        theKing("laugh")
        addLive()
        inGameText(".Life.", TEXT_TYPE.POWERUP, "red")
      elseif myPowerUpSprites.name == "powerUp_B" then
        audio.play(powerUpSound)
        spawnExtraBall()
        increaseScore(100)
        inGameText(".ExtraBall.", TEXT_TYPE.POWERUP, "gold")
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
    timer.performWithDelay(2, function() if event.target~=nil then physics.removeBody(event.target) end  end)
    transition.to(event.target, { time=400, x = _SCREEN_CENTRE_X*2, y = 0, alpha= 0, onComplete=killObject })
  end
end

function addLifeSaver()
  local lifeSaver = display.newImage("images/ironWall.png", _SCREEN_CENTRE_X, _SCREEN_CENTRE_Y*2-1)
  physics.addBody(lifeSaver, "static", {bounce = 1.5, friction=2})
  gameplayItemsGroup:insert(lifeSaver)
  gameplayItemsGroup:toFront()
  transition.to(lifeSaver, { time=20000,alpha= 0, onComplete=killObject })
end

function increaseScore(delta)
  score = score + delta
  inGameText("+" .. delta, TEXT_TYPE.SCORE)
  scoreNum.text = score;
end

function goal()
  audio.play(goalSound)
  theKing("yes")
  startShake()
  timer.performWithDelay( 500, stopShake )
  inGameText("GOAL!", TEXT_TYPE.GOAL)
  increaseScore(500)
end

function updatePaddleBounciness()
  local bounce = paddle.bounciness
  paddle.bounciness = bounce + 0.5
  physics.removeBody( paddle)
  physics.addBody( paddle, "static", {density = 1.0, friction = 1, bounce =  paddle.bounciness, radius = 26})
end


function onTopWallCollision(event)
  if event.other.name == "ball" or event.other.name == "extraBall" then
    if event.phase == "began" then
      ran = mRandom(3) 
      if ran == 1 then
        audio.play(miss1Sound);
      elseif ran == 2 then
        audio.play(miss2Sound);
      end
    end
  end
end

function onBounce(event)

  if event.other.name == "ball" or event.other.name == "extraBall" then
    if event.phase == "began" then
      audio.play(bounceSound);

      if event.other.name == "extraBall" then
        extraBallCombo = extraBallCombo +1
        inGameText("Combo " .. extraBallCombo .."X", TEXT_TYPE.COMBO)
        score = score + (30 * extraBallCombo)
      else
        increaseScore(10)
      end

      if increaseVelocityOnBounce and event.other.name == "ball" then
        updateBallVelocity()
        paddle:setFillColor( 1, 1, 1 )
        increaseVelocityOnBounce = false
      end
      if ballStuck and event.other.name == "ball" then
        unstuckBall()
      end
    end
  end
end

function inGameText(text, textType, color, size)

  if textType == TEXT_TYPE.SCORE then
    local points_Text = display.newText(text, 10, 100,"ComicSansMS-Bold",25)
    points_Text.anchorX = 0
    points_Text.anchorY = 0
    colors.setTextColor(points_Text, color or 'yellow')
    transition.to(points_Text,{time = 1500, alpha = 0, y = 25, onComplete=killObject})
  elseif textType == TEXT_TYPE.COMBO then
    local points_Text = display.newText(text, 190, 100,"ComicSansMS-Bold",25)
    points_Text.anchorX = 0
    points_Text.anchorY = 0
    colors.setTextColor(points_Text, color or 'silver')
    transition.to(points_Text,{time = 1500, alpha = 0, y = 25, onComplete=killObject})  
  elseif textType == TEXT_TYPE.POWERUP then
    local powerUp_Text = display.newText(text, _SCREEN_CENTRE_X*2, _SCREEN_CENTRE_Y,"ComicSansMS-Bold",size or 50)
    colors.setTextColor(powerUp_Text, color)
    transition.to(powerUp_Text,{time = 500, 
        x = _SCREEN_CENTRE_X, 
        onComplete = function()  
          transition.to(powerUp_Text,{time = 500, 
              alpha = 0, 
              y = 0, 
              onComplete=killObject})
        end})
  elseif textType == TEXT_TYPE.FINALBOSS then
    local finalBoss_Text = display.newText(text, _SCREEN_CENTRE_X*2, _SCREEN_CENTRE_Y,"ComicSansMS-Bold",size or 40)
    colors.setTextColor(finalBoss_Text, color)
    transition.to(finalBoss_Text,{time = 2000, 
        x = _SCREEN_CENTRE_X, 
        onComplete = function()  
          transition.to(finalBoss_Text,{time = 2000, 
              alpha = 0, 
              y = 0, 
              onComplete=killObject})
        end})
  elseif textType == TEXT_TYPE.STATIC then
    local static_text = display.newText(text, _SCREEN_CENTRE_X, _SCREEN_CENTRE_Y,"ComicSansMS-Bold",size or 40)
    colors.setTextColor(static_text, color)

    transition.to(static_text,{time = 2000, 
        alpha = 0, 
        y = 0, 
        onComplete=killObject})

  elseif textType == TEXT_TYPE.GOAL then
    local goal_Text = display.newText(text, _SCREEN_CENTRE_X, _SCREEN_CENTRE_Y-(_SCREEN_CENTRE_Y/2),"ComicSansMS-Bold",size or 50)
    colors.setTextColor(goal_Text, color or 'yellow')
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
    audio.setVolume(0)
    backgroundMusicEnabled = false
    soundOptionSprite:setFrame(1)
  else
    backgroundMusicEnabled = true
    audio.setVolume(MASTER_VOLUME)
    soundOptionSprite:setFrame(2)
  end
  loadedSettings.backgroundMusicEnabled = backgroundMusicEnabled
  loadsave.saveTable( loadedSettings, "settings.json" )
end




function loadGame(event)

  transition.to(titleScreenGroup,{time = 0, alpha=0, onComplete = initializeGameScreen});
  audio.play(playSound)
  playBtn:removeEventListener("tap", loadGame);
  soundOptionSprite:removeEventListener("tap", soundConfig);

end


-- Main Function
function main()
  showTitleScreen();
end
main()


