display.setStatusBar( display.HiddenStatusBar )
math.randomseed( os.time() )

--Variaveis
_W = display.contentWidth
_H = display.contentHeight
_W2 = display.contentCenterX
_H2 = display.contentCenterY

local composer = require ("composer")
composer.gotoScene( "game1" )


score = 0
score1 = 1
