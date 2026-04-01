local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Involved_Hub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local function makeCorner(object, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = object
	return corner
end

local function makeStroke(object, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0
	stroke.Parent = object
	return stroke
end

local function tween(object, duration, properties, style, direction)
	local info = TweenInfo.new(
		duration,
		style or Enum.EasingStyle.Quad,
		direction or Enum.EasingDirection.Out
	)

	local tw = TweenService:Create(object, info, properties)
	tw:Play()
	return tw
end

local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.AnchorPoint = Vector2.new(0, 0.5)
openButton.Position = UDim2.new(0, 14, 0.5, 0)
openButton.Size = UDim2.new(0, 132, 0, 48)
openButton.BackgroundColor3 = Color3.fromRGB(255, 95, 170)
openButton.Text = "Open Hub"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextScaled = true
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.AutoButtonColor = true
openButton.Parent = screenGui
makeCorner(openButton, 18)
makeStroke(openButton, Color3.fromRGB(255, 228, 240), 2, 0.1)

local hub = Instance.new("Frame")
hub.Name = "Hub"
hub.AnchorPoint = Vector2.new(0.5, 0.5)
hub.Position = UDim2.new(0.5, 0, 0.5, 0)
hub.Size = UDim2.new(0, 420, 0, 280)
hub.BackgroundColor3 = Color3.fromRGB(255, 205, 226)
hub.BorderSizePixel = 0
hub.Parent = screenGui
makeCorner(hub, 24)
makeStroke(hub, Color3.fromRGB(255, 120, 185), 3, 0)

local sizeConstraint = Instance.new("UISizeConstraint")
sizeConstraint.MinSize = Vector2.new(280, 220)
sizeConstraint.MaxSize = Vector2.new(520, 360)
sizeConstraint.Parent = hub

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 8)
shadow.Size = UDim2.new(1, 36, 1, 38)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(255, 145, 200)
shadow.ImageTransparency = 0.45
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = 0
shadow.Parent = hub
hub.ZIndex = 2

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 52)
topBar.BackgroundColor3 = Color3.fromRGB(255, 118, 186)
topBar.BorderSizePixel = 0
topBar.Parent = hub
makeCorner(topBar, 24)

local topFill = Instance.new("Frame")
topFill.Size = UDim2.new(1, 0, 0, 18)
topFill.Position = UDim2.new(0, 0, 1, -18)
topFill.BackgroundColor3 = Color3.fromRGB(255, 118, 186)
topFill.BorderSizePixel = 0
topFill.Parent = topBar

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 16, 0, 0)
title.Size = UDim2.new(1, -120, 1, 0)
title.Text = "Involved Hub"
title.TextColor3 = Color3.fromRGB(255, 245, 250)
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.Parent = topBar

local subTitle = Instance.new("TextLabel")
subTitle.BackgroundTransparency = 1
subTitle.Position = UDim2.new(0, 18, 0, 29)
subTitle.Size = UDim2.new(1, -160, 0, 16)
subTitle.Text = "Cute pink mobile + PC panel"
subTitle.TextColor3 = Color3.fromRGB(255, 230, 240)
subTitle.TextScaled = true
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Font = Enum.Font.GothamMedium
subTitle.Parent = topBar

local hideButton = Instance.new("TextButton")
hideButton.Name = "HideButton"
hideButton.AnchorPoint = Vector2.new(1, 0.5)
hideButton.Position = UDim2.new(1, -12, 0.5, 0)
hideButton.Size = UDim2.new(0, 34, 0, 34)
hideButton.BackgroundColor3 = Color3.fromRGB(255, 235, 244)
hideButton.Text = "X"
hideButton.TextColor3 = Color3.fromRGB(255, 90, 160)
hideButton.TextScaled = true
hideButton.Font = Enum.Font.GothamBold
hideButton.Parent = topBar
makeCorner(hideButton, 999)
makeStroke(hideButton, Color3.fromRGB(255, 180, 215), 2, 0)

local tabsFrame = Instance.new("Frame")
tabsFrame.Name = "Tabs"
tabsFrame.BackgroundTransparency = 1
tabsFrame.Position = UDim2.new(0, 12, 0, 66)
tabsFrame.Size = UDim2.new(0, 116, 1, -78)
tabsFrame.Parent = hub

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Padding = UDim.new(0, 8)
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Parent = tabsFrame

local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.BackgroundColor3 = Color3.fromRGB(255, 233, 242)
contentFrame.Position = UDim2.new(0, 136, 0, 66)
contentFrame.Size = UDim2.new(1, -148, 1, -78)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = hub
makeCorner(contentFrame, 20)
makeStroke(contentFrame, Color3.fromRGB(255, 185, 215), 2, 0)

local pages = {}
local currentPage

local function createPage(name, headerText, bodyText)
	local page = Instance.new("Frame")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = contentFrame

	local header = Instance.new("TextLabel")
	header.BackgroundTransparency = 1
	header.Position = UDim2.new(0, 16, 0, 14)
	header.Size = UDim2.new(1, -32, 0, 34)
	header.Text = headerText
	header.TextColor3 = Color3.fromRGB(255, 98, 166)
	header.TextScaled = true
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.Font = Enum.Font.GothamBold
	header.Parent = page

	local body = Instance.new("TextLabel")
	body.BackgroundTransparency = 1
	body.Position = UDim2.new(0, 16, 0, 52)
	body.Size = UDim2.new(1, -32, 0, 66)
	body.TextWrapped = true
	body.Text = bodyText
	body.TextColor3 = Color3.fromRGB(160, 80, 120)
	body.TextScaled = true
	body.TextXAlignment = Enum.TextXAlignment.Left
	body.TextYAlignment = Enum.TextYAlignment.Top
	body.Font = Enum.Font.GothamMedium
	body.Parent = page

	local action = Instance.new("TextButton")
	action.Name = "Action"
	action.AnchorPoint = Vector2.new(0.5, 1)
	action.Position = UDim2.new(0.5, 0, 1, -16)
	action.Size = UDim2.new(0.7, 0, 0, 40)
	action.BackgroundColor3 = Color3.fromRGB(255, 150, 200)
	action.Text = "Select " .. name
	action.TextColor3 = Color3.fromRGB(255, 255, 255)
	action.TextScaled = true
	action.Font = Enum.Font.GothamBold
	action.Parent = page
	makeCorner(action, 16)
	makeStroke(action, Color3.fromRGB(255, 235, 245), 2, 0)

	action.MouseButton1Click:Connect(function()
		action.Text = name .. " Ready"
		tween(action, 0.15, {Size = UDim2.new(0.74, 0, 0, 42)}, Enum.EasingStyle.Back)
		task.wait(0.15)
		tween(action, 0.15, {Size = UDim2.new(0.7, 0, 0, 40)}, Enum.EasingStyle.Back)
		task.wait(0.7)
		action.Text = "Select " .. name
	end)

	pages[name] = page
	return page
end

createPage("Home", "Welcome", "A cute animated hub layout with draggable support, pink styling, and responsive sizing.")
createPage("Player", "Player", "Use this page for movement, speed, jump, or personal options in your own project.")
createPage("Visuals", "Visuals", "Use this page for ESP, color themes, or screen effects if you are building a normal interface.")
createPage("Settings", "Settings", "Store toggles, keybinds, and UI options here. The hide button keeps the hub easy to reopen.")

local tabButtons = {}

local function setActiveTab(name)
	if currentPage == name then
		return
	end

	for tabName, page in pairs(pages) do
		if tabName == name then
			page.Visible = true
			page.BackgroundTransparency = 1
			page.Position = UDim2.new(0, 14, 0, 0)
			tween(page, 0.22, {Position = UDim2.new(0, 0, 0, 0)})
		else
			page.Visible = false
			page.Position = UDim2.new(0, 0, 0, 0)
		end
	end

	for tabName, button in pairs(tabButtons) do
		if tabName == name then
			tween(button, 0.18, {BackgroundColor3 = Color3.fromRGB(255, 137, 194)})
			button.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			tween(button, 0.18, {BackgroundColor3 = Color3.fromRGB(255, 231, 240)})
			button.TextColor3 = Color3.fromRGB(255, 105, 165)
		end
	end

	currentPage = name
end

local function createTab(name, order)
	local button = Instance.new("TextButton")
	button.Name = name .. "Tab"
	button.LayoutOrder = order
	button.Size = UDim2.new(1, 0, 0, 42)
	button.BackgroundColor3 = Color3.fromRGB(255, 231, 240)
	button.Text = name
	button.TextColor3 = Color3.fromRGB(255, 105, 165)
	button.TextScaled = true
	button.Font = Enum.Font.GothamBold
	button.Parent = tabsFrame
	makeCorner(button, 16)
	makeStroke(button, Color3.fromRGB(255, 185, 220), 2, 0)

	button.MouseEnter:Connect(function()
		if currentPage ~= name then
			tween(button, 0.15, {BackgroundColor3 = Color3.fromRGB(255, 240, 246)})
		end
	end)

	button.MouseLeave:Connect(function()
		if currentPage ~= name then
			tween(button, 0.15, {BackgroundColor3 = Color3.fromRGB(255, 231, 240)})
		end
	end)

	button.MouseButton1Click:Connect(function()
		setActiveTab(name)
	end)

	tabButtons[name] = button
end

createTab("Home", 1)
createTab("Player", 2)
createTab("Visuals", 3)
createTab("Settings", 4)
setActiveTab("Home")

if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
	hub.Size = UDim2.new(0.9, 0, 0, 250)
	openButton.Size = UDim2.new(0, 120, 0, 44)
end

local dragging = false
local dragInput
local dragStart
local startPos

local function updateDrag(input)
	local delta = input.Position - dragStart
	hub.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = hub.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		updateDrag(input)
	end
end)

local hubOpen = true
local openSize = hub.Size
local openTransparency = hub.BackgroundTransparency

local function closeHub()
	if not hubOpen then
		return
	end

	hubOpen = false
	tween(hub, 0.22, {
		Size = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1
	}, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	tween(shadow, 0.18, {ImageTransparency = 1})

	task.delay(0.2, function()
		hub.Visible = false
		openButton.Visible = true
		openButton.Size = UDim2.new(0, 110, 0, 42)
		tween(openButton, 0.2, {Size = UDim2.new(0, 132, 0, 48)}, Enum.EasingStyle.Back)
	end)
end

local function openHub()
	if hubOpen then
		return
	end

	hubOpen = true
	openButton.Visible = false
	hub.Visible = true
	hub.Size = UDim2.new(0, 0, 0, 0)
	hub.BackgroundTransparency = 1
	shadow.ImageTransparency = 1
	tween(hub, 0.26, {
		Size = openSize,
		BackgroundTransparency = openTransparency
	}, Enum.EasingStyle.Back)
	tween(shadow, 0.22, {ImageTransparency = 0.45})
end

hideButton.MouseButton1Click:Connect(closeHub)
openButton.MouseButton1Click:Connect(openHub)

tween(hub, 0.28, {Size = UDim2.new(openSize.X.Scale, openSize.X.Offset + 8, openSize.Y.Scale, openSize.Y.Offset + 8)}, Enum.EasingStyle.Back)
task.wait(0.12)
tween(hub, 0.2, {Size = openSize}, Enum.EasingStyle.Back)
