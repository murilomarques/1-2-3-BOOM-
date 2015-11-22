
local composer = require("composer")
local scene = composer.newScene( )
local menuBG
local playBtn
local creditsBtn
local bg
local logo
local bgScroll = {}
local setupPlayer = {}
local howToPlay = {}



function scene:create( event )
	local sceneGroup = self.view

	bg = display.newImageRect("Img/bgAzul.png", x + 25, y + 25)
	bg.x = x2
	bg.y = y2 - 10
	sceneGroup:insert( bg )	

	logo = display.newImageRect("Img/logo.png",350,170)
	logo.x = x2
	logo.y = y2 - 70
	sceneGroup:insert(logo)
	
	playBtn = display.newImageRect( "Img/play.png",110,90)
	playBtn.x = x2 - 120
	playBtn.y = y2 + 110
	sceneGroup:insert(playBtn)


	creditsBtn = display.newImageRect( "Img/credits.png", 110,90)
	creditsBtn.x = x2 + 120
	creditsBtn.y = y2 + 100
	sceneGroup:insert(creditsBtn)
		
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then		
	elseif (phase == "did") then
		playBtn:addEventListener( "touch", startGame )
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

function startGame( )
		
	composer.removeScene('menu')
	composer.gotoScene( "game1", options)
end



scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene

