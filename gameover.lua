local composer = require("composer")
local scene = composer.newScene( )
local gameoverBG
local retryBtn
local menuBtn
local scoreTxt
local iconGameOver
local finalScore = {}



function scene:create( event )
	local sceneGroup = self.view	

	finalScore()

	gameoverBG = display.newImageRect( "Img/gameoverBG.png", x, y )
	gameoverBG.x = x2
	gameoverBG.y = y2
	sceneGroup:insert(gameoverBG)	

	menuBtn = display.newImage( "Img/menu.png")
	menuBtn.x = 80
	menuBtn.y = y2 + 120
	sceneGroup:insert(menuBtn)

	retryBtn = display.newImage( "Img/retry.png")
	retryBtn.x = 240
	retryBtn.y = y2 + 120
	sceneGroup:insert(retryBtn)

	scoreTxt = display.newText('' .. score, x2 - 25, y2 + 20, native.systemFontBold, 16)
  	scoreTxt:setTextColor(255, 255, 255)
  	scene.view:insert( scoreTxt )


end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	local previousScene = composer.getSceneName( "previous" )
    composer.removeScene( previousScene )
    
	if (phase == "will") then
	end
		
	if (phase == "did") then
		menuBtn:addEventListener( "tap", menuGame )
		retryBtn:addEventListener( "tap", startGame )	
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		menuBtn:removeEventListener( "tap", menuGame )
		retryBtn:removeEventListener( "tap", startGame )	
	end
end


function finalScore( )
	scoreFinal = score * score1
end

local options = {
	
	effect = "fade", time = 250
}

function menuGame( )		
	composer.gotoScene( "menu", options )
	score = 0
	score1 = 1
end

function startGame( )
	composer.gotoScene( "stage", options )
	score = 0
	score1 = 1
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene

