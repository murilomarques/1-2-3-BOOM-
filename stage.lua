
local composer = require("composer")
local scene = composer.newScene( )
local menuBG
local easy
local hard
local creditsBtn
local bg
local logo
local playEasy = {}
local playHard = {}



function scene:create( event )
	local sceneGroup = self.view

	bg = display.newImageRect("Img/playrules.png", x, y)
	bg.x = x2
	bg.y = y2 
	sceneGroup:insert( bg )	
	
	easy = display.newImageRect( "Img/easyticket.png",100,120)
	easy.x = x2 + 50
	easy.y = y2 + 100
	sceneGroup:insert(easy)


	hard = display.newImageRect( "Img/hardticket.png", 100,120)
	hard.x = x2 + 180
	hard.y = y2 + 100
	sceneGroup:insert(hard)
		
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then		
	elseif (phase == "did") then
		easy:addEventListener( "touch", playEasy )
		hard:addEventListener( "touch", playHard )
		--creditsBtn:addEventListener( "touch", credits )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		--playBtn:removeEventListener( "tap", startGame )
		--creditsBtn:removeEventListener( "tap", credits )
		end
end


local options = {
	
	effect = "fade", time = 500
}

function playEasy( )
	composer.removeScene('menu')
	composer.gotoScene( "game1", options)
end

function playHard( )
	composer.removeScene('menu')
	composer.gotoScene( "game2", options)
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene

