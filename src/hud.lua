local class = require 'src.libs.middleclass'
require 'src.utils.BoundingBox'

Hud = {}
Hud.size = 0
Hud.selectionBox = {}
Hud.selectionBox.drawingSelectionBox = false
Hud.selectionBox.lastClicked = {}
Hud.selectionBox.rectangle = nil

Hud.textConsole = {}
Hud.textConsole.visible = false
Hud.textConsole.textPadding = 12
Hud.textConsole.fontSize = 14
Hud.textConsole.text = {}
Hud.textConsole.title = "A voice in the darkness. . . "

local gWidth, gHeight
local borderWidth
local panelSpacing
local cgSquareSize
local cgContainerWidth
local cgContainerHeight
local controlGroupViewX
local controlGroupViewY

function Hud:init()
	gWidth, gHeight = love.graphics.getWidth(), love.graphics.getHeight()
	borderWidth = 10
	panelSpacing = 5
	cgSquareSize = 32
	cgContainerWidth = (cgSquareSize * 10) + (panelSpacing * 11)
	cgContainerHeight = cgSquareSize + (0.25 * cgSquareSize)
	controlGroupViewX = math.floor((gWidth - cgContainerWidth) / 2)
	controlGroupViewY = gHeight - math.floor(cgContainerHeight) - borderWidth

	Hud.textConsole.font = love.graphics.newFont("resources/ui/fonts/GeosansLight.ttf", Hud.textConsole.fontSize)
	Hud.textConsole.titleFont = love.graphics.newFont("resources/ui/fonts/Timeless.ttf", 18)

	Hud.textConsole.text[0] = "Welcome to the dungeon"
	Hud.textConsole.text[1] = ". . . "
	Hud.textConsole.text[2] = "Now, fuck off!"
end

function Hud:startSelectionBox(x, y) 
	self.selectionBox.lastClicked = { x = x, y = y }
	self.drawingSelectionBox = true
end

function Hud:endSelectionBox()
	self.drawingSelectionBox = false
end

function Hud:update(dt)

	-- Update selectionbox
	if self.drawingSelectionBox then
		local x = Hud.selectionBox.lastClicked.x
		local y = Hud.selectionBox.lastClicked.y
		x, y = camera:scalePointToCamera(x, y)
		local otherX, otherY = love.mouse.getX(), love.mouse.getY()

		local rectWidth = math.abs(otherX - x)
		local rectHeight = math.abs(otherY - y)

		local rectX = otherX < x and otherX or x
		local rectY = otherY < y and otherY or y
		Hud.selectionBox.square = BoundingBox:new(rectX, rectY, rectX + rectWidth, rectY + rectHeight)
		Hud.selectionBox.rectangle = BoundingBox:new(rectX, rectY, rectX + rectWidth, rectY + rectHeight)
	end
end

function Hud:drawSelectionBox()
	love.graphics.setLineWidth(1)
	if self.drawingSelectionBox then
		local x, y, width, height = 
			Hud.selectionBox.square.x1, 
			Hud.selectionBox.square.y1, 
			Hud.selectionBox.square.width, 
			Hud.selectionBox.square.height
		love.graphics.setColor(90, 120, 90)
		love.graphics.rectangle('line', x, y, width, height )
		love.graphics.setColor(10, 50, 10, 40)
		love.graphics.rectangle('fill', x, y, width, height )
	end
end

-- draws a box for each control group at the bottom of the screen
function Hud:drawControlGroupView()

	local startX, startY = controlGroupViewX, controlGroupViewY
	love.graphics.setColor(32, 32, 32, 100)
	love.graphics.rectangle('fill', startX, startY, cgContainerWidth, cgContainerHeight)

	for cGroup = 0, 9 do
		panelX = startX + panelSpacing + (cGroup * (panelSpacing + cgSquareSize))
		panelY = startY + panelSpacing

		love.graphics.setColor(20, 20, 20, 255)
		love.graphics.rectangle('line', panelX, panelY, cgSquareSize, cgSquareSize)

		if cGroup == 0 then
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', panelX, panelY, cgSquareSize, cgSquareSize)
			love.graphics.setColor(255, 255, 255)
			love.graphics.setBlendMode("alpha")
			love.graphics.draw(resources.items.pickaxe, panelX, panelY, 0, 2, 2)
		else 
			love.graphics.setColor(255, 255, 255, 32)
			love.graphics.rectangle('fill', panelX, panelY, cgSquareSize, cgSquareSize)
			love.graphics.setColor(20, 20, 20, 255)
		end
		cGroup = cGroup + 1
		if cGroup == 10 then cGroup = 0 end
		love.graphics.print(tostring(cGroup), panelX + 2, panelY + 2)

		love.graphics.setColor(20, 20, 20, 192)
		local cg = Game.selection.controlGroups[cGroup]
		local numSelected = cg and cg.selected.size or 0
		love.graphics.print(tostring(numSelected), panelX + (cgSquareSize/2), panelY + (cgSquareSize/2))
	end
end

function Hud:drawHudBorder()
	love.graphics.setColor(32, 32, 32, 128)
	love.graphics.setLineWidth(borderWidth)

	local posX, posY = borderWidth/2, borderWidth/2
	love.graphics.rectangle('line', posX, posY, gWidth-borderWidth, gHeight-borderWidth)
end

function Hud:draw()
	love.graphics.setBlendMode('alpha')

	if Hud.textConsole.visible then
		love.graphics.setColor(0, 0, 0, 192)
		local w = resources.UI.textbox:getWidth()
		local h = resources.UI.textbox:getHeight()

		local x = (love.graphics.getWidth() * 0.2) - w / 2
		local y = (love.graphics.getHeight() * 0.8) - h / 2
		posX, posY = x, y

		love.graphics.rectangle('fill', posX, posY, w, h)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(resources.UI.textbox, posX, posY)

		local padding = Hud.textConsole.textPadding
	    love.graphics.setColor(255, 255, 255, 191)

	    love.graphics.setFont(Hud.textConsole.titleFont)
	    love.graphics.print(Hud.textConsole.title, posX + padding, posY + padding)

	    love.graphics.setFont(Hud.textConsole.font)

	    for i = 0, #Hud.textConsole.text do
	    	love.graphics.print(Hud.textConsole.text[i], posX + padding, posY + padding + 40 + (i * Hud.textConsole.fontSize))
	    end
	end

	Hud:drawSelectionBox()
	Hud:drawControlGroupView()
	Hud:drawHudBorder()

end