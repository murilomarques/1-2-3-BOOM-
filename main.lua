local physics = require("physics")
physics.start()
physics.setScale( 50 )

local x = display.contentCenterX
local y = display.contentCenterY

local game = display.newGroup( )

local bkg = display.newImage("Img/bkg_fundo2.png")
bkg.x = x
bkg.y = y
game:insert(bkg)

local circle = display.newCircle(  -0.5 , 600, 15 )
physics.addBody( circle, "dinamic", {density = 1.0, friction = 0.3, bounce = 0.2 ,
radius = 40	} )
game:insert( circle )

local canhao = display.newImage("Img/canhao2.png")
canhao.x = 1
canhao.y = 600
game:insert( canhao )

local floor = display.newImage( "Img/bkg_chao.jpg" )	
floor.x = 200
floor.y = 720
physics.addBody( floor, "static",{density = 1.0, friction = 2.0, bounce = 0.1} )
game:insert(floor)


--for i = 0, 0 do

--	local rect = display.newRect(800, 260 + i*30, 100, 40)
--	physics.addBody( rect, "dinamic", {density = 1.0, friction = 0.3, bounce = 0.2} )
--game:insert(rect)
--	end

function circleTouched(event)
	if event.phase == "began" then 
		display.getCurrentStage( ) :setFocus( circle )
	elseif event.phase == "ended" then

		circle:applyLinearImpulse( event.xStart - event.x, event.yStart - event.y, circle.x,
		circle.y )
display.getCurrentStage():setFocus( nil )

end
end

circle:addEventListener( "touch", circleTouched )


function loop(e)
	local targetx = 2 - circle.x
	game.x = game.x + ((targetx - game.x)*0.1)

end

Runtime:addEventListener("enterFrame", loop)