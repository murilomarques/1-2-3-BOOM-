
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
	--local somBG = audio.loadStream( "sound/DST-AmbientKingdom.mp3" )
  	--audio.play(somBG, {loops = -1, channel = 1})

	setupBG()
	setupGroups()
		
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	composer.removeScene( "howtoplay1")
	composer.removeScene( "howtoplay2")
	composer.removeScene( "credits1")
	composer.removeScene( "credits2")
	composer.removeScene( "credits3")
	if (phase == "will") then		
	elseif (phase == "did") then
		playBtn:addEventListener( "tap", startGame )
		creditsBtn:addEventListener( "tap", credits )
		Runtime:addEventListener( "enterFrame", bgScroll )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		playBtn:removeEventListener( "tap", startGame )
		creditsBtn:removeEventListener( "tap", credits )
		Runtime:removeEventListener( "enterFrame", bgScroll )
		end
end

function setupGroups( )
  playerGroup = display.newGroup( )
  scene.view:insert( playerGroup )
end

function setupBG(  )
	bg = display.newImageRect("Img/bgAzul.png", x + 25, y + 25)
	bg.x = x2
	bg.y = y2 - 10
	scene.view:insert( bg )

	logo = display.newImageRect("Img/logo.png",350,170)
	logo.x = x2
	logo.y = y2 - 70
	scene.view:insert(logo)
	
	playBtn = display.newImageRect( "Img/play.png",110,90)
	playBtn.x = x2 - 120
	playBtn.y = y2 + 110
	scene.view:insert(playBtn)


	creditsBtn = display.newImageRect( "Img/credits.png", 110,90)
	creditsBtn.x = x2 + 120
	creditsBtn.y = y2 + 100
	scene.view:insert(creditsBtn)

end


local options = {
	
	effect = "fade", time = 500
}

function startGame( )
		
	composer.gotoScene( "game1", options)
end


function credits( )
	audio.stop(1)
	composer.gotoScene( "credits1", options)
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene

