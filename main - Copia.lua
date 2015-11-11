local physics = require("physics")
physics.start()
physics.setScale( 50 )

x = display.contentWidth
y = display.contentHeight
x2 = display.contentCenterX
y2 = display.contentCenterY

local speed = 5500
local score = 0
local tm2
local scoreTxt
local objUm
local scroll = 3
local personagem

local velocidadeUp = {}
local velocidade = {}
local criarPersonagem = {}
local bgScroll = {}
local scoreUp = {}
local setupScore = {}


local bkg = display.newImageRect("Img/fundo1.png", x, y)
bkg.x = x - 1000
bkg.y = y2

local bkg2 = display.newImageRect("Img/fundo1.png", x, y)
bkg2.x = bkg.x + x
bkg2.y = y2

local bkg3 = display.newImageRect("Img/fundo1.png", x, y)
bkg3.x = bkg2.x + x
bkg3.y = y2

local bkg4 = display.newImageRect("Img/fundo2.png", x, y)
bkg4.x = bkg
bkg4.y = y2

local bkg5 = display.newImageRect("Img/fundo2.png", x, y)
bkg5.x = bkg3
bkg5.y = y2


--TETO E PISO
  teto = display.newRect( x2, -1, x +100, 1 )
  teto:setFillColor( 0,0,0 )
  physics.addBody( teto, "static" )
  teto.name = "teto"

  piso = display.newRect( x2, y, x +100, 1 )
  piso:setFillColor( 0, 0, 0 )
  physics.addBody( piso, "static" )
  piso.name = "piso"

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
  scoreTxt = display.newText('Distance 0', x2 - 50, 300 , native.systemFontBold, 16)
  scoreTxt:setTextColor(0, 0, 0)

end

function scoreUp()
   --incrementando a distancia
    score = score + 10
    scoreTxt.text = string.format( "Distance %d", score)
end

function criarPersonagem()
	personagem = display.newImage("Img/macaco.png", x / 6, y / 2)
	transition.to( personagem, {time = 1900, x = math.random(x), y = math.random(y)})
end

function criaObstaculo()
	 objUm = display.newImage("Img/banana.png", x, y)
	 objUm:addEventListener("touch", removeObstaculo)
	 objUm.y = math.random(25 , y)
	 objUm.rotation = math.random(x)
	 transition.to( objUm, {time = speed, x = -50, y = math.random(y)})

end

function removeObstaculo(e)
	if e.phase == "ended" then
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



criarPersonagem()
setupScore()	
tm2 = timer.performWithDelay(1500, scoreUp, 0)
Runtime:addEventListener("enterFrame", bgScroll)
criaObj = timer.performWithDelay(600, criaObstaculo, -1)
velocidade()
velocidadeUp()