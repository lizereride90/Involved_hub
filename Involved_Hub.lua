local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
if not player then
	return
end

local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("Involved_Hub")
if oldGui then
	oldGui:Destroy()
end

local function tween(object, time, properties, style, direction)
	local info = TweenInfo.new(
		time,
		style or Enum.EasingStyle.Quad,
		direction or Enum.EasingDirection.Out
	)

	local animation = TweenService:Create(object, info, properties)
	animation:Play()
	return animation
end

local function addCorner(object, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = object
end

local function addStroke(object, color, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Thickness = thickness or 1
	stroke.Parent = object
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Involved_Hub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 130, 0, 44)
openButton.Position = UDim2.new(0, 14, 0.5, -22)
openButton.BackgroundColor3 = Color3.fromRGB(255, 92, 170)
openButton.Text = "Open Hub"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextScaled = true
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.Parent = screenGui
addCorner(openButton, 18)
addStroke(openButton, Color3.fromRGB(255, 220, 235), 2)

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 420, 0, 280)
main.BackgroundColor3 = Color3.fromRGB(255, 206, 228)
main.BorderSizePixel = 0
main.Parent = screenGui
addCorner(main, 24)
addStroke(main, Color3.fromRGB(255, 120, 185), 3)

local sizeConstraint = Instance.new("UISizeConstraint")
sizeConstraint.MinSize = Vector2.new(280, 220)
sizeConstraint.MaxSize = Vector2.new(520, 360)
sizeConstraint.Parent = main

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 52)
header.BackgroundColor3 = Color3.fromRGB(255, 117, 186)
header.BorderSizePixel = 0
header.Parent = main
addCorner(header, 24)

local headerFill = Instance.new("Frame")
headerFill.Size = UDim2.new(1, 0, 0, 18)
headerFill.Position = UDim2.new(0, 0, 1, -18)
headerFill.BackgroundColor3 = header.BackgroundColor3
headerFill.BorderSizePixel = 0
headerFill.Parent = header

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 16, 0, 4)
title.Size = UDim2.new(1, -120, 0, 22)
title.Text = "Involved Hub"
title.TextColor3 = Color3.fromRGB(255, 245, 250)
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 18, 0, 26)
subtitle.Size = UDim2.new(1, -150, 0, 16)
subtitle.Text = "Cute pink GUI for mobile and PC"
subtitle.TextColor3 = Color3.fromRGB(255, 230, 240)
subtitle.TextScaled = true
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Font = Enum.Font.GothamMedium
subtitle.Parent = header

local hideButton = Instance.new("TextButton")
hideButton.Name = "HideButton"
hideButton.AnchorPoint = Vector2.new(1, 0.5)
hideButton.Position = UDim2.new(1, -12, 0.5, 0)
hideButton.Size = UDim2.new(0, 34, 0, 34)
hideButton.BackgroundColor3 = Color3.fromRGB(255, 235, 244)
hideButton.Text = "X"
hideButton.TextColor3 = Color3.fromRGB(255, 85, 160)
hideButton.TextScaled = true
hideButton.Font = Enum.Font.GothamBold
hideButton.Parent = header
addCorner(hideButton, 99)
addStroke(hideButton, Color3.fromRGB(255, 190, 220), 2)

local tabs = Instance.new("Frame")
tabs.Name = "Tabs"
tabs.BackgroundTransparency = 1
tabs.Position = UDim2.new(0, 12, 0, 66)
tabs.Size = UDim2.new(0, 116, 1, -78)
tabs.Parent = main

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Padding = UDim.new(0, 8)
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Parent = tabs

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 136, 0, 66)
content.Size = UDim2.new(1, -148, 1, -78)
content.BackgroundColor3 = Color3.fromRGB(255, 235, 244)
content.BorderSizePixel = 0
content.Parent = main
addCorner(content, 20)
addStroke(content, Color3.fromRGB(255, 190, 220), 2)

local pages = {}
local tabButtons = {}
local currentPage = nil

local function createPage(name, headingText, bodyText)
	local page = Instance.new("Frame")
	page.Name = name .. "Page"
	page.BackgroundTransparency = 1
	page.Size = UDim2.new(1, 0, 1, 0)
	page.Visible = false
	page.Parent = content

	local heading = Instance.new("TextLabel")
	heading.BackgroundTransparency = 1
	heading.Position = UDim2.new(0, 16, 0, 14)
	heading.Size = UDim2.new(1, -32, 0, 32)
	heading.Text = headingText
	heading.TextColor3 = Color3.fromRGB(255, 98, 166)
	heading.TextScaled = true
	heading.TextXAlignment = Enum.TextXAlignment.Left
	heading.Font = Enum.Font.GothamBold
	heading.Parent = page

	local body = Instance.new("TextLabel")
	body.BackgroundTransparency = 1
	body.Position = UDim2.new(0, 16, 0, 50)
	body.Size = UDim2.new(1, -32, 0, 84)
	body.Text = bodyText
	body.TextWrapped = true
	body.TextColor3 = Color3.fromRGB(155, 78, 118)
	body.TextScaled = true
	body.TextXAlignment = Enum.TextXAlignment.Left
	body.TextYAlignment = Enum.TextYAlignment.Top
	body.Font = Enum.Font.GothamMedium
	body.Parent = page

	local action = Instance.new("TextButton")
	action.AnchorPoint = Vector2.new(0.5, 1)
	action.Position = UDim2.new(0.5, 0, 1, -16)
	action.Size = UDim2.new(0.7, 0, 0, 40)
	action.BackgroundColor3 = Color3.fromRGB(255, 150, 200)
	action.Text = "Select " .. name
	action.TextColor3 = Color3.fromRGB(255, 255, 255)
	action.TextScaled = true
	action.Font = Enum.Font.GothamBold
	action.Parent = page
	addCorner(action, 16)
	addStroke(action, Color3.fromRGB(255, 235, 245), 2)

	action.MouseButton1Click:Connect(function()
		action.Text = name .. " Ready"
		tween(action, 0.12, {Size = UDim2.new(0.74, 0, 0, 42)}, Enum.EasingStyle.Back)
		task.wait(0.12)
		tween(action, 0.12, {Size = UDim2.new(0.7, 0, 0, 40)}, Enum.EasingStyle.Back)
		task.wait(0.6)
		action.Text = "Select " .. name
	end)

	pages[name] = page
end

local function showPage(name)
	if currentPage == name then
		return
	end

	for pageName, page in pairs(pages) do
		page.Visible = pageName == name
		if page.Visible then
			page.Position = UDim2.new(0, 12, 0, 0)
			tween(page, 0.18, {Position = UDim2.new(0, 0, 0, 0)})
		end
	end

	for tabName, button in pairs(tabButtons) do
		if tabName == name then
			tween(button, 0.15, {BackgroundColor3 = Color3.fromRGB(255, 137, 194)})
			button.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			tween(button, 0.15, {BackgroundColor3 = Color3.fromRGB(255, 231, 240)})
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
	button.Parent = tabs
	addCorner(button, 16)
	addStroke(button, Color3.fromRGB(255, 190, 220), 2)

	button.MouseButton1Click:Connect(function()
		showPage(name)
	end)

	tabButtons[name] = button
end

createPage("Home", "Welcome", "This is a clean animated pink GUI with drag support, category tabs, and a hide button.")
createPage("Player", "Player", "Use this section for player related controls in your own project.")
createPage("Visuals", "Visuals", "Use this section for colors, overlays, and visual interface options.")
createPage("Settings", "Settings", "Use this section for UI settings, keybinds, and extra toggles.")

createTab("Home", 1)
createTab("Player", 2)
createTab("Visuals", 3)
createTab("Settings", 4)

if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
	main.Size = UDim2.new(0.9, 0, 0, 250)
	openButton.Size = UDim2.new(0, 120, 0, 42)
end

showPage("Home")

local dragging = false
local dragStart = nil
local startPosition = nil
local dragInput = nil

local function updateDrag(input)
	if not dragStart or not startPosition then
		return
	end

	local delta = input.Position - dragStart
	main.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)
end

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPosition = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

header.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		updateDrag(input)
	end
end)

local isOpen = true
local openSize = main.Size

local function closeGui()
	if not isOpen then
		return
	end

	isOpen = false
	tween(main, 0.2, {Size = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	task.delay(0.18, function()
		main.Visible = false
		openButton.Visible = true
		openButton.Size = UDim2.new(0, 100, 0, 40)
		tween(openButton, 0.18, {Size = UDim2.new(0, 130, 0, 44)}, Enum.EasingStyle.Back)
	end)
end

local function openGui()
	if isOpen then
		return
	end

	isOpen = true
	openButton.Visible = false
	main.Visible = true
	main.Size = UDim2.new(0, 0, 0, 0)
	tween(main, 0.22, {Size = openSize}, Enum.EasingStyle.Back)
end

hideButton.MouseButton1Click:Connect(closeGui)
openButton.MouseButton1Click:Connect(openGui)

tween(main, 0.24, {Size = UDim2.new(openSize.X.Scale, openSize.X.Offset + 8, openSize.Y.Scale, openSize.Y.Offset + 8)}, Enum.EasingStyle.Back)
task.wait(0.1)
tween(main, 0.16, {Size = openSize}, Enum.EasingStyle.Back)
