local composer = require("composer")
local scene = composer.newScene( )
local physycs = require( "physics")
physics.start( )


local bg
local bg1
local scroll = 2


local bgScroll = {}


function scene:create( event )  
  local sceneGroup = self.view
 
  setupBG()  
  setupGroups()

end

function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase
  
  local previousScene = composer.getSceneName( "previous" )
  composer.removeScene( previousScene )
  composer.removeScene( "menu")
  composer.removeScene( "gameover")
   
  if (phase == "did") then    
   
    Runtime:addEventListener("enterFrame", gameLoop)
    Runtime:addEventListener("collision", onLocalCollision)
    end
end


function setupBG( )
  --add Imagens do BG

  bg = display.newImageRect("img/fundo1.png", _W, _H)
  bg.x = _W2
  bg.y = _H2
  scene.view:insert( bg)

  bg1 = display.newImageRect("img/fundo2.png", _W, _H)
  bg1.x = _W2
  bg1.y = _H2
  scene.view:insert( bg1 )



  --add Teto e piso
  teto = display.newRect( _W2, -1, _W+100, 1 )
  teto:setFillColor( 0,0,0 )
  physics.addBody( teto, "static" )
  teto.name = "teto"
  scene.view:insert( teto )

  piso = display.newRect( _W2, _H, _W+100, 1 )
  piso:setFillColor( 0, 0, 0 )
  physics.addBody( piso, "static" )
  piso.name = "piso"
  scene.view:insert( piso )
end


function bgScroll (event)
bg.x = bg.x - scroll	
bg1.x = bg1.x - scroll


  -- Movendo as imagens para o fim da tela
if (bg.x + bg.contentWidth) < 0 then
bg2:translate( _W * 3, 0 )
  end

if (bg1.x + bg1.contentWidth) < 0 then
bg1:translate( _W * 3, 0 )
  end


end


function gameLoop() 
  bgScroll() 
end