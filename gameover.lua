local composer = require("composer")
local scene = composer.newScene( )
local gameoverBG
local retryBtn
local menuBtn
local scoreTxt
local iconGameOver




function scene:create( event )
	local sceneGroup = self.view	


	gameoverBG = display.newImageRect( "Img/gameoverBG.png", x, y )
	gameoverBG.x = x2
	gameoverBG.y = y2
	sceneGroup:insert(gameoverBG)	

	menuBtn = display.newImageRect( "Img/menu.png",110,70)
	menuBtn.x = 280
	menuBtn.y = y2 + 120
	sceneGroup:insert(menuBtn)

	retryBtn = display.newImageRect( "Img/retry.png",110,70)
	retryBtn.x = 150
	retryBtn.y = y2 + 120
	sceneGroup:insert(retryBtn)

	scoreTxt = display.newText('' .. score, x2 + 6, y2 + 9, native.systemFontBold, 16)
  	scoreTxt:setTextColor(0, 0, 0)
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
		menuBtn:addEventListener( "touch", menuGame )
		retryBtn:addEventListener( "touch", startGame )	
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



function menuGame( )	
	composer.removeScene('gameover')	
	composer.gotoScene( "menu", options )
	score = 0
	score1 = 1
end

function startGame( )
	composer.removeScene('gameover')
	composer.gotoScene( "game1", options )
	score = 0
	score1 = 1
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene

