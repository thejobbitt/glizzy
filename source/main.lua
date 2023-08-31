import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local ui <const> = playdate.ui
local font = gfx.font.new('font/Mini Sans 2X')

-- Crank Indicator Setup
ui.crankIndicator:start()
ui.crankIndicator.clockwise = true

local x = 0
local y = 120
local speed = 1

local function loadGame()
	playdate.display.setRefreshRate(30) -- Sets framerate to 50 fps
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	gfx.setFont(font)
end
local function updateCrank()
	if playdate.isCrankDocked() then
		ui.crankIndicator:update()
	end
end
local function updateGame()
	x += speed
	local change, accChange = playdate.getCrankChange()
	speed += change / 100
end

local function drawGame()
	gfx.clear() -- Clears the screen
	gfx.fillRect(x, y, 10, 10) -- Draws a rectangle
end

loadGame()

function playdate.update()
	playdate.timer.updateTimers()
	
	updateGame()
	drawGame()
	playdate.drawFPS(0,0)
	updateCrank()
end