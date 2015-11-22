--IMPOSSÍVEL




local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
physics.start()
physics.setScale( 70 )

--physics.setDrawMode("hybrid")



local speed = 5850
local tm1
local tm2
local tm3
local scoreTxt
local obstaculoEsq
local obstaculoDir
local scroll = 2
local personagem
local speedTm 
local bkg
local bkg2
local bkg3
local bkg4
local bkg5
local sceneGroup




--Add funções
local bgScroll = {}
local moverInimigo = {}
local onCollision = {}
local velocidadeUp = {}
local velocidade = {}
local criarPersonagem = {}
local gameover = {}


  --setupBG()
  --setupGroups()
  --setupInimigo()
  --setupScore()



function scene:create(event)
  sceneGroup = self.view

  display.setStatusBar( display.HiddenStatusBar )
  bkg = display.newImageRect("Img/fundo1.png", x, y)
  bkg.x = x - 1000
  bkg.y = y2
  sceneGroup:insert(bkg)

  bkg2 = display.newImageRect("Img/fundo1.png", x, y)
  bkg2.x = bkg.x + x
  bkg2.y = y2
  sceneGroup:insert(bkg2)

  bkg3 = display.newImageRect("Img/fundo1.png", x, y)
  bkg3.x = bkg2.x + x
  bkg3.y = y2
  sceneGroup:insert(bkg3)

  bkg4 = display.newImageRect("Img/fundo2.png", x, y)
  bkg4.x = bkg
  bkg4.y = y2
  sceneGroup:insert(bkg4)

  bkg5 = display.newImageRect("Img/fundo2.png", x, y)
  bkg5.x = bkg3
  bkg5.y = y2
  sceneGroup:insert(bkg5)

  scoreTxt = display.newText('Score 0', x2 - 50, 300 , native.systemFontBold, 16)
  scoreTxt:setTextColor(0, 0, 0)
  sceneGroup:insert(scoreTxt)

  function scoreUp()
   --incrementando o score
    --score = score + 10
    scoreTxt.text = string.format( "Score %d", score)
end

  setupInimigo()

end



function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase
  
  local previousScene = composer.getSceneName( "previous" )
  composer.removeScene( previousScene )
  composer.removeScene( "menu")
  composer.removeScene( "gameover")
  
  --composer.removeScene( "menu")

  if(phase == "did") then
    tm1 = timer.performWithDelay(1700, criaObstaculo, -1)
    tm2 = timer.performWithDelay(10, scoreUp, 0)
    tm3 = timer.performWithDelay( 2200, moverInimigo , -1 )
    Runtime:addEventListener("enterFrame", bgScroll)
    Runtime:addEventListener("collision", onLocalCollision)
    speedTm = timer.performWithDelay( 1005, velocidadeUp, 0 )
  end
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then

    elseif (phase == "did") then
    end
end

function scene:destroy( event )

    local sceneGroup = self.view
          

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


function criaObstaculo()
  obstaculoDir = {}
  obstaculoEsq = {}
  i = math.random(0, 150)

  --Obstáculos da direita
   obstaculoDir[i] = display.newImage("Img/banana.png", x, y)
   obstaculoDir[i].isSensor = true
   obstaculoDir[i].name = "obstaculo"
   physics.addBody(obstaculoDir[i], "dynamic")
   obstaculoDir[i].isFixedRotation = true
   obstaculoDir[i]:addEventListener("touch", removeObstaculo)
   obstaculoDir[i].y = math.random(y)
   obstaculoDir[i].rotation = math.random(360)
   sceneGroup:insert(obstaculoDir[i])
   transition.to( obstaculoDir[i], {time = speed, x = -50, y = math.random(y)})
   

   --Obstáculos da esquerda
   obstaculoEsq[i] = display.newImage("Img/banana.png", 0, 150)
   obstaculoEsq[i].name = "obstaculo"
   obstaculoEsq[i].isSensor = true
   physics.addBody(obstaculoEsq[i], "dynamic")
   obstaculoEsq[i].isFixedRotation = true
   obstaculoEsq[i]:addEventListener("touch", removeObstaculo)
   obstaculoEsq[i].y = math.random(y)
   obstaculoEsq[i].rotation = math.random(360)
   sceneGroup:insert(obstaculoEsq[i])
   transition.to( obstaculoEsq[i], {time = speed, x = 1000, y = math.random(y)})
   
end



function bgScroll (event)
bkg.x = bkg.x - scroll
bkg2.x = bkg2.x - scroll
bkg3.x = bkg3.x - scroll
bkg4.x = bkg4.x - scroll
bkg5.x = bkg5.x - scroll

  -- Movendo as imagens para o fim da tela
if (bkg.x + bkg.contentWidth) < 0 then
bkg:translate( x * 3, 0 )
  end

if (bkg2.x + bkg2.contentWidth) < 0 then
bkg2:translate( x * 3, 0 )
  end

if (bkg3.x + bkg3.contentWidth) < 0 then
bkg3:translate( x * 3, 0 )
  end

if (bkg4.x + bkg4.contentWidth) < 0 then
bkg4:translate( x * 3, 0 )
  end

if (bkg5.x + bkg5.contentWidth) < 0 then
bkg5:translate( x * 3, 0 )
  end

end


function setupInimigo()
  personagem = display.newImageRect("Img/macaco.png", 50 , 60 )
  personagem.x = x2
  personagem.y = y2
  personagem.name = "personagem"
  personagem.isSensor = true
  physics.addBody( personagem, "static")
  sceneGroup:insert(personagem)
 -- transition.to( personagem, {time = 1900, x = math.random(x), y = math.random(y)})
end

function moverInimigo(event)
  transition.to( personagem, {time = 1900, x = math.random(60,420), y = math.random(300)})
end

function removeObstaculo(e)
  if e.phase == "ended" then
    score = score + 5
    display.remove(e.target)
  end
end


function velocidade()
    speed = speed - 600
    --Icon
    local icon = display.newImage('Img/speed.png', x2 , y2)
    transition.from(icon, {time = 200, alpha = 0.1, onComplete = function() timer.performWithDelay(500, function() 
      transition.to(icon, {time = 200, alpha = 0.1, onComplete = function() display.remove(icon) icon = nil end}) end) end})
end

function velocidadeUp(event)
    if (score == 100) then
        velocidade()
    end
    if (score == 170) then
        velocidade()
        scroll = 4
    end
    if (score == 200) then
        velocidade()
        scroll = 12
    end
    if (score == 250) then
      scroll = 15
    end
    if (score == 270) then
        scroll = 0
    end
    if (score == 290) then
        velocidade()
        scroll = 3
    end
end

function onLocalCollision(event)
 if ( event.phase == "began" ) then

    if(event.object1.name == "personagem" and event.object2.name == "obstaculo") then            
            gameOver()
        end        
    if(event.object1.name == "obstaculo" and event.object2.name == "personagem") then            
            gameOver()
        end
  end
end




local options1 = {  
  effect = "fade", time = 1000
}


function gameOver(  )
  Runtime:removeEventListener('enterFrame', gameLoop)
    Runtime:removeEventListener('collision', onLocalCollision) 
    timer.cancel(tm1)
    tm1 = nil
    timer.cancel(tm2)
    tm2 = nil
    timer.cancel( speedTm )
    speedTm = nil
    timer.cancel(tm3)
    tm3 = nil
  --timer.pause(tm1)
  --timer.pause( tm3 )
  display.remove(personagem)
  display.remove( obstaculo )
  composer.removeScene("game1")
  composer.gotoScene( "gameover", options1 )
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener("destroy", scene)
return scene