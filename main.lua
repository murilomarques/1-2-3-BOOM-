local physics = require("physics")
physics.start()
physics.setScale( 50 )

x = display.contentWidth
y = display.contentHeight
x2 = display.contentCenterX
y2 = display.contentCenterY




local scroll = 7

local bgScroll = {}
local scoreUp = {}

  local sceneGroup = self.view
 
  setupScore()
  setupScore1()


local bkg = display.newImageRect("Img/fundo1.png", x, y)
bkg.x = x - 1000
bkg.y = y2

local bkg2 = display.newImageRect("Img/fundo1.png", x, y)
bkg2.x = bkg.x + x
bkg2.y = y2

local bkg3 = display.newImageRect("Img/fundo1.png", x, y)
bkg3.x = bkg2.x + x
bkg3.y = y2

function bgScroll (event)
bkg.x = bkg.x - scroll
bkg2.x = bkg2.x - scroll
bkg3.x = bkg3.x - scroll

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

end

function scoreUp()
   --incrementando a distancia
    score = score + 10
    scoreTxt.text = string.format( "Distance %d", score)
end




Runtime:addEventListener("enterFrame", bgScroll)


