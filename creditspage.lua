local composer = require("composer")
local scene = composer.newScene( )
local bg
local menuIcon
local menu = {}




function scene:create( event )
	local sceneGroup = self.view

	bg = display.newImageRect("Img/creditsPage.png", x, y)
	bg.x = x2
	bg.y = y2 
	sceneGroup:insert( bg )	

	menuIcon = display.newImageRect("Img/menu.png",110,70)
	menuIcon.x = x2 + 90
	menuIcon.y = y2 + 85
	sceneGroup:insert(menuIcon)
		
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then		
	elseif (phase == "did") then
		menuIcon:addEventListener( "touch", menu )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		end
end


local options = {
	
	effect = "fade", time = 500
}

function menu( )	
	composer.removeScene('menu')
	composer.gotoScene( "menu", options)
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene

