-- Involved JJS Hub - Cute Pink GUI for Jujutsu Shenanigans
-- Paste this into your executor (Synapse, Fluxus, Delta, etc.)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old GUI
local oldGui = playerGui:FindFirstChild("Involved_JJS_Hub")
if oldGui then oldGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Involved_JJS_Hub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Tween function
local function tween(obj, time, props, style, dir)
    local info = TweenInfo.new(time, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
    TweenService:Create(obj, info, props):Play()
end

local function addCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 12)
    c.Parent = obj
end

local function addStroke(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 2
    s.Parent = obj
end

-- Main Frame
local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 460, 0, 320)
main.BackgroundColor3 = Color3.fromRGB(255, 200, 220)
main.BorderSizePixel = 0
main.Parent = screenGui
addCorner(main, 28)
addStroke(main, Color3.fromRGB(255, 100, 170), 4)

-- Size constraints (good for mobile)
local sizeConst = Instance.new("UISizeConstraint")
sizeConst.MinSize = Vector2.new(320, 240)
sizeConst.MaxSize = Vector2.new(560, 420)
sizeConst.Parent = main

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 58)
header.BackgroundColor3 = Color3.fromRGB(255, 90, 160)
header.BorderSizePixel = 0
header.Parent = main
addCorner(header, 28)

local headerFill = Instance.new("Frame")
headerFill.Size = UDim2.new(1, 0, 0, 20)
headerFill.Position = UDim2.new(0, 0, 1, -20)
headerFill.BackgroundColor3 = header.BackgroundColor3
headerFill.Parent = header

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 20, 0, 6)
title.Size = UDim2.new(1, -140, 0, 26)
title.Text = "Involved JJS"
title.TextColor3 = Color3.fromRGB(255, 245, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 22, 0, 30)
subtitle.Size = UDim2.new(1, -160, 0, 16)
subtitle.Text = "Cute • Pink • Jujutsu Shenanigans"
subtitle.TextColor3 = Color3.fromRGB(255, 220, 240)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

-- Hide Button
local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0, 36, 0, 36)
hideBtn.Position = UDim2.new(1, -14, 0.5, 0)
hideBtn.AnchorPoint = Vector2.new(1, 0.5)
hideBtn.BackgroundColor3 = Color3.fromRGB(255, 230, 245)
hideBtn.Text = "✕"
hideBtn.TextColor3 = Color3.fromRGB(255, 60, 130)
hideBtn.TextScaled = true
hideBtn.Font = Enum.Font.GothamBold
hideBtn.Parent = header
addCorner(hideBtn, 999)
addStroke(hideBtn, Color3.fromRGB(255, 180, 210), 2)

-- Open Button (hidden initially)
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 140, 0, 46)
openBtn.Position = UDim2.new(0, 16, 0.5, -23)
openBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 160)
openBtn.Text = "Open JJS Hub"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.TextScaled = true
openBtn.Font = Enum.Font.GothamBold
openBtn.Visible = false
openBtn.Parent = screenGui
addCorner(openBtn, 20)
addStroke(openBtn, Color3.fromRGB(255, 210, 230), 2)

-- Tabs Container
local tabsFrame = Instance.new("Frame")
tabsFrame.Position = UDim2.new(0, 16, 0, 72)
tabsFrame.Size = UDim2.new(0, 124, 1, -92)
tabsFrame.BackgroundTransparency = 1
tabsFrame.Parent = main

local tabsList = Instance.new("UIListLayout")
tabsList.Padding = UDim.new(0, 10)
tabsList.SortOrder = Enum.SortOrder.LayoutOrder
tabsList.Parent = tabsFrame

-- Content Area
local content = Instance.new("Frame")
content.Position = UDim2.new(0, 154, 0, 72)
content.Size = UDim2.new(1, -170, 1, -92)
content.BackgroundColor3 = Color3.fromRGB(255, 235, 245)
content.BorderSizePixel = 0
content.Parent = main
addCorner(content, 22)
addStroke(content, Color3.fromRGB(255, 170, 200), 2)

-- Scrolling for content pages
local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 400)
    page.ScrollBarThickness = 6
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 120, 180)
    page.Visible = false
    page.Parent = content

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 12)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = page

    return page
end

local pages = {}
local tabButtons = {}
local currentPage = "Combat"

local function showPage(name)
    for _, p in pairs(pages) do p.Visible = false end
    if pages[name] then pages[name].Visible = true end

    for n, btn in pairs(tabButtons) do
        if n == name then
            tween(btn, 0.2, {BackgroundColor3 = Color3.fromRGB(255, 110, 175)})
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            tween(btn, 0.2, {BackgroundColor3 = Color3.fromRGB(255, 225, 240)})
            btn.TextColor3 = Color3.fromRGB(255, 90, 150)
        end
    end
    currentPage = name
end

local function createTab(name, order)
    local btn = Instance.new("TextButton")
    btn.LayoutOrder = order
    btn.Size = UDim2.new(1, 0, 0, 46)
    btn.BackgroundColor3 = Color3.fromRGB(255, 225, 240)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 90, 150)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = tabsFrame
    addCorner(btn, 18)
    addStroke(btn, Color3.fromRGB(255, 180, 210), 2)

    btn.MouseButton1Click:Connect(function()
        showPage(name)
    end)

    tabButtons[name] = btn
end

-- Create Pages
pages.Combat = createPage("Combat")
pages.Movement = createPage("Movement")
pages.Visuals = createPage("Visuals")
pages.Settings = createPage("Settings")

-- Combat Page Example (ready for your JJS features)
local combatPage = pages.Combat

local function addToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(255, 245, 250)
    frame.Parent = parent
    addCorner(frame, 14)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 16, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 60, 110)
    label.TextScaled = true
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 48, 0, 28)
    toggleBtn.Position = UDim2.new(1, -60, 0.5, -14)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 190)
    toggleBtn.Text = ""
    toggleBtn.Parent = frame
    addCorner(toggleBtn, 999)

    local enabled = false
    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            tween(toggleBtn, 0.25, {BackgroundColor3 = Color3.fromRGB(100, 255, 140)})
        else
            tween(toggleBtn, 0.25, {BackgroundColor3 = Color3.fromRGB(255, 140, 190)})
        end
        if callback then callback(enabled) end
    end)
end

addToggle(combatPage, "Auto Block / Parry", function(state)
    print("Auto Block:", state)
    -- Put your auto block code here (e.g. loop checking incoming attacks)
end)

addToggle(combatPage, "Auto Combo / M1 Spam", function(state)
    print("Auto Combo:", state)
end)

addToggle(combatPage, "Infinite Cursed Energy", function(state)
    print("Infinite CE:", state)
end)

addToggle(combatPage, "Auto Domain Expansion", function(state)
    print("Auto Domain:", state)
end)

local blackFlashBtn = Instance.new("TextButton")
blackFlashBtn.Size = UDim2.new(1, -20, 0, 50)
blackFlashBtn.BackgroundColor3 = Color3.fromRGB(255, 130, 180)
blackFlashBtn.Text = "Force Black Flash"
blackFlashBtn.TextColor3 = Color3.fromRGB(255,255,255)
blackFlashBtn.TextScaled = true
blackFlashBtn.Font = Enum.Font.GothamBold
blackFlashBtn.Parent = combatPage
addCorner(blackFlashBtn, 16)

blackFlashBtn.MouseButton1Click:Connect(function()
    print("Black Flash triggered! (add your remote/fire code here)")
end)

-- Other tabs (you can expand them)
createTab("Combat", 1)
createTab("Movement", 2)
createTab("Visuals", 3)
createTab("Settings", 4)

showPage("Combat")

-- Drag support
local dragging, dragInput, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position

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
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Open / Close with animation
local isOpen = true
local openSize = main.Size

local function closeGui()
    if not isOpen then return end
    isOpen = false
    tween(main, 0.22, {Size = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    task.delay(0.2, function()
        main.Visible = false
        openBtn.Visible = true
        tween(openBtn, 0.2, {Size = UDim2.new(0, 140, 0, 46)})
    end)
end

local function openGui()
    if isOpen then return end
    isOpen = true
    openBtn.Visible = false
    main.Visible = true
    main.Size = UDim2.new(0, 0, 0, 0)
    tween(main, 0.25, {Size = openSize}, Enum.EasingStyle.Back)
end

hideBtn.MouseButton1Click:Connect(closeGui)
openBtn.MouseButton1Click:Connect(openGui)

-- Initial open animation
tween(main, 0.3, {Size = UDim2.new(openSize.X.Scale, openSize.X.Offset + 12, openSize.Y.Scale, openSize.Y.Offset + 12)}, Enum.EasingStyle.Back)
task.wait(0.12)
tween(main, 0.18, {Size = openSize}, Enum.EasingStyle.Back)

print("Involved JJS Hub loaded! Stay cute and dominate the lobby 💖")