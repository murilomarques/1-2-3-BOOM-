local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
physics.start()
physics.setScale( 50 )



local speed = 5500
local tm1
local tm2
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







--Add funções
local velocidadeUp = {}
local velocidade = {}
local criarPersonagem = {}
local bgScroll = {}





function scene:create(event)
  local sceneGroup = self.view

  setupBG()
  setupScore()
  setupInimigo()

  --Adicionar som do bg

end



function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  local previousScene = composer.getSceneName( "previous" )
  
  --composer.removeScene( "menu")



  if(phase == "did") then

    tm1 = timer.performWithDelay(1500, criaObstaculo, -1)
    tm2 = timer.performWithDelay(1500, scoreUp, 0)
    Runtime:addEventListener("enterFrame", gameLoop)
    Runtime:addEventListener("enterFrame", bgScroll)
    speedTm = timer.performWithDelay( 1005, velocidadeUp, 0 )
  end
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    Runtime:removeEventListener('enterFrame', bgScroll)
    --Runtime:removeEventListener('collision', onLocalCollision) 
    timer.cancel(tm1)
    tm1 = nil
    timer.cancel(tm2)
    tm2 = nil
    timer.cancel( speedTm )
    speedTm = nil
    elseif (phase == "did") then
    end
end


function setupBG()

  --Add imagens do bg

  bkg = display.newImageRect("Img/fundo1.png", x, y)
  bkg.x = x - 1000
  bkg.y = y2
  scene.view:insert(bkg)

  bkg2 = display.newImageRect("Img/fundo1.png", x, y)
  bkg2.x = bkg.x + x
  bkg2.y = y2
  scene.view:insert(bkg2)

  bkg3 = display.newImageRect("Img/fundo1.png", x, y)
  bkg3.x = bkg2.x + x
  bkg3.y = y2
  scene.view:insert(bkg3)

  bkg4 = display.newImageRect("Img/fundo2.png", x, y)
  bkg4.x = bkg
  bkg4.y = y2
  scene.view:insert(bkg4)

  bkg5 = display.newImageRect("Img/fundo2.png", x, y)
  bkg5.x = bkg3
  bkg5.y = y2
  scene.view:insert(bkg5)
end

--TETO E PISO
  teto = display.newRect( x2, -1, x +100, 1 )
  teto:setFillColor( 0,0,0 )
  physics.addBody( teto, "static" )
  teto.name = "teto"

  piso = display.newRect( x2, y, x +100, 1 )
  piso:setFillColor( 0, 0, 0 )
  physics.addBody( piso, "static" )
  piso.name = "piso"



function setupGroups()
  obstaculosGroup = display.newGroup( )
  personagemGroup = display.newGroup( )
  scene.view:insert(obstaculos)
  scene.view:insert(personagemGroup)
end

function criaObstaculo()

  --Obstáculos da direita
   obstaculoDir = display.newImage("Img/banana.png", x, y)
   physics.addBody(obstaculoDir, "kinematic")
   obstaculoDir:addEventListener("touch", removeObstaculo)
   obstaculoDir.y = math.random(25 , y)
   obstaculoDir.rotation = math.random(x)
   transition.to( obstaculoDir, {time = speed, x = -50, y = math.random(y)})
  -- obstaculosGroup:insert(obstaculoDir)

   --Obstáculos da esquerda
   obstaculoEsq = display.newImage("Img/banana.png", 0, 150)
   physics.addBody(obstaculoDir, "kinematic")
   obstaculoEsq:addEventListener("touch", removeObstaculo)
   obstaculoEsq.y = math.random(25 , y)
   obstaculoEsq.rotation = math.random(x)
   transition.to( obstaculoEsq, {time = speed, x = 500, y = math.random(y)})
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

function setupScore( )
  scoreTxt = display.newText('Score 0', x2 - 50, 300 , native.systemFontBold, 16)
  scoreTxt:setTextColor(0, 0, 0)

end

function scoreUp()
   --incrementando o score
    score = score + 10
    scoreTxt.text = string.format( "Score %d", score)
end


function setupInimigo()
  personagem = display.newImage("Img/macaco.png", x / 6, y / 2)
  transition.to( personagem, {time = 1900, x = math.random(x), y = math.random(y)})
end



function removeObstaculo(e)
  if e.phase == "ended" then
    score = score + 1
    display.remove(e.target)
  end
end


function velocidade()
    speed = speed - 1000
    --Icon
    local icon = display.newImage('Img/speed.png', x2 , y2)
    transition.from(icon, {time = 200, alpha = 0.1, onComplete = function() timer.performWithDelay(500, function() 
      transition.to(icon, {time = 200, alpha = 0.1, onComplete = function() display.remove(icon) icon = nil end}) end) end})
end

function velocidadeUp(event)
    if (score == 50) then
        velocidade()
    end
    if (score == 70) then
        velocidade()
    end
    if (score == 90) then
        velocidade()
    end
    if (score == 1000) then
        velocidade()
    end
end

--function onLocalCollision(event)
  --if ( event.phase == "began" ) then


  --end
--end


function gameLoop()
  bgScroll()
end


velocidade()
velocidadeUp()

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene