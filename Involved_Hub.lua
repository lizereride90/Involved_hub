-- Involved JJS Hub - Clean Base + Auto Vessel Black Flash
-- Feature added: Auto Black Flash on Divergent Fist (Vessel)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("Involved_JJS_Hub") then
    playerGui.Involved_JJS_Hub:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Involved_JJS_Hub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local function tween(object, time, properties)
    local info = TweenInfo.new(time, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    TweenService:Create(object, info, properties):Play()
end

local function addCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 16)
    corner.Parent = object
end

local function addStroke(object, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 2
    stroke.Parent = object
end

-- Main Frame (same clean pink design)
local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 460, 0, 330)
main.BackgroundColor3 = Color3.fromRGB(255, 195, 215)
main.BorderSizePixel = 0
main.Parent = screenGui
addCorner(main, 28)
addStroke(main, Color3.fromRGB(255, 85, 155), 4)

local sizeConstraint = Instance.new("UISizeConstraint")
sizeConstraint.MinSize = Vector2.new(340, 260)
sizeConstraint.MaxSize = Vector2.new(560, 420)
sizeConstraint.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(255, 75, 145)
header.BorderSizePixel = 0
header.Parent = main
addCorner(header, 28)

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 22, 0, 8)
title.Size = UDim2.new(1, -150, 0, 26)
title.Text = "Involved JJS"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 24, 0, 34)
subtitle.Size = UDim2.new(1, -160, 0, 16)
subtitle.Text = "Cute Pink • Auto Vessel Black Flash Added"
subtitle.TextColor3 = Color3.fromRGB(255, 220, 235)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

local hideButton = Instance.new("TextButton")
hideButton.AnchorPoint = Vector2.new(1, 0.5)
hideButton.Position = UDim2.new(1, -16, 0.5, 0)
hideButton.Size = UDim2.new(0, 38, 0, 38)
hideButton.BackgroundColor3 = Color3.fromRGB(255, 230, 240)
hideButton.Text = "✕"
hideButton.TextColor3 = Color3.fromRGB(255, 50, 120)
hideButton.TextScaled = true
hideButton.Font = Enum.Font.GothamBold
hideButton.Parent = header
addCorner(hideButton, 999)
addStroke(hideButton, Color3.fromRGB(255, 180, 210), 2)

local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0, 145, 0, 48)
openButton.Position = UDim2.new(0, 18, 0.5, -24)
openButton.BackgroundColor3 = Color3.fromRGB(255, 70, 150)
openButton.Text = "Open Involved JJS"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextScaled = true
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.Parent = screenGui
addCorner(openButton, 22)
addStroke(openButton, Color3.fromRGB(255, 210, 230), 2)

-- Tabs & Content (clean)
local tabs = Instance.new("Frame")
tabs.Position = UDim2.new(0, 18, 0, 78)
tabs.Size = UDim2.new(0, 130, 1, -100)
tabs.BackgroundTransparency = 1
tabs.Parent = main

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Padding = UDim.new(0, 10)
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Parent = tabs

local content = Instance.new("Frame")
content.Position = UDim2.new(0, 160, 0, 78)
content.Size = UDim2.new(1, -180, 1, -100)
content.BackgroundColor3 = Color3.fromRGB(255, 235, 245)
content.BorderSizePixel = 0
content.Parent = main
addCorner(content, 24)
addStroke(content, Color3.fromRGB(255, 160, 195), 2)

local pages = {}
local tabButtons = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 500)
    page.ScrollBarThickness = 6
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 120, 180)
    page.Visible = false
    page.Parent = content

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 14)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = page

    pages[name] = page
    return page
end

local function showPage(name)
    for _, p in pairs(pages) do p.Visible = false end
    if pages[name] then pages[name].Visible = true end

    for n, btn in pairs(tabButtons) do
        if n == name then
            tween(btn, 0.18, {BackgroundColor3 = Color3.fromRGB(255, 110, 175)})
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            tween(btn, 0.18, {BackgroundColor3 = Color3.fromRGB(255, 225, 240)})
            btn.TextColor3 = Color3.fromRGB(255, 90, 150)
        end
    end
end

local function createTab(name, order)
    local btn = Instance.new("TextButton")
    btn.LayoutOrder = order
    btn.Size = UDim2.new(1, 0, 0, 48)
    btn.BackgroundColor3 = Color3.fromRGB(255, 225, 240)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 90, 150)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = tabs
    addCorner(btn, 18)
    addStroke(btn, Color3.fromRGB(255, 180, 210), 2)

    btn.MouseButton1Click:Connect(function() showPage(name) end)
    tabButtons[name] = btn
end

local combatPage = createPage("Combat")
createPage("Movement")
createPage("Visuals")
createPage("Misc")

createTab("Combat", 1)
createTab("Movement", 2)
createTab("Visuals", 3)
createTab("Misc", 4)

showPage("Combat")

-- ==================== AUTO VESSEL BLACK FLASH ====================
local autoBlackFlashEnabled = false
local blackFlashConnection = nil
local lastDivergentPress = 0
local BLACK_FLASH_DELAY = 0.32  -- Optimal timing window (~0.3-0.35s) for Vessel Divergent Fist → Black Flash

local function triggerSecondDivergentFist()
    -- Simulate pressing the 3rd skill (works on both PC and Mobile)
    pcall(function()
        -- This is the most reliable client-side way to fire skills in many fighting games like JJS
        -- If the game uses a specific remote, replace this with the real remote fire
        -- For now, we use VirtualInput to simulate key/skill press (works well for mobile too)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Three, false, game)
        task.wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Three, false, game)
    end)
end

local function setupAutoBlackFlash()
    if blackFlashConnection then blackFlashConnection:Disconnect() end

    blackFlashConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end

        if autoBlackFlashEnabled then
            local currentTime = tick()

            -- Detect Divergent Fist activation (Key 3 on PC or skill tap on mobile)
            local isDivergentFist = false

            if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Three then
                isDivergentFist = true
            elseif input.UserInputType == Enum.UserInputType.Touch then
                -- Mobile skill detection is trickier; we assume tapping skill 3 triggers similar input
                -- Many executors handle mobile skill taps via InputBegan
                isDivergentFist = true
            end

            if isDivergentFist and (currentTime - lastDivergentPress > 1) then
                lastDivergentPress = currentTime
                -- Wait for optimal timing then trigger second press for Black Flash
                task.delay(BLACK_FLASH_DELAY, function()
                    if autoBlackFlashEnabled then
                        triggerSecondDivergentFist()
                        print("Auto Vessel Black Flash triggered!")
                    end
                end)
            end
        end
    end)
end

-- Add Toggle to Combat Page
local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(1, -20, 0, 58)
toggleFrame.BackgroundColor3 = Color3.fromRGB(255, 245, 250)
toggleFrame.Parent = combatPage
addCorner(toggleFrame, 16)

local toggleLabel = Instance.new("TextLabel")
toggleLabel.Size = UDim2.new(0.65, 0, 1, 0)
toggleLabel.Position = UDim2.new(0, 18, 0, 0)
toggleLabel.BackgroundTransparency = 1
toggleLabel.Text = "Auto Vessel Black Flash"
toggleLabel.TextColor3 = Color3.fromRGB(190, 50, 100)
toggleLabel.TextScaled = true
toggleLabel.Font = Enum.Font.GothamSemibold
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleLabel.Parent = toggleFrame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 58, 0, 34)
toggleBtn.Position = UDim2.new(1, -72, 0.5, -17)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 190)
toggleBtn.Text = ""
toggleBtn.Parent = toggleFrame
addCorner(toggleBtn, 999)

toggleBtn.MouseButton1Click:Connect(function()
    autoBlackFlashEnabled = not autoBlackFlashEnabled
    if autoBlackFlashEnabled then
        tween(toggleBtn, 0.25, {BackgroundColor3 = Color3.fromRGB(80, 255, 120)})
        setupAutoBlackFlash()
        print("Auto Vessel Black Flash ENABLED")
    else
        tween(toggleBtn, 0.25, {BackgroundColor3 = Color3.fromRGB(255, 140, 190)})
        if blackFlashConnection then 
            blackFlashConnection:Disconnect() 
            blackFlashConnection = nil 
        end
        print("Auto Vessel Black Flash DISABLED")
    end
end)

-- Drag, Open/Close, Initial Animation (same as before)
local dragging = false
local dragStart, startPosition, dragInput

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
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
        main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
    end
end)

local isOpen = true
local originalSize = main.Size

local function closeGui()
    if not isOpen then return end
    isOpen = false
    tween(main, 0.22, {Size = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    task.delay(0.19, function()
        main.Visible = false
        openButton.Visible = true
    end)
end

local function openGui()
    if isOpen then return end
    isOpen = true
    openButton.Visible = false
    main.Visible = true
    main.Size = UDim2.new(0, 0, 0, 0)
    tween(main, 0.25, {Size = originalSize}, Enum.EasingStyle.Back)
end

hideButton.MouseButton1Click:Connect(closeGui)
openButton.MouseButton1Click:Connect(openGui)

-- Initial open animation
main.Size = UDim2.new(0, 0, 0, 0)
tween(main, 0.28, {Size = originalSize}, Enum.EasingStyle.Back)

print("✅ Involved JJS Hub Loaded with Auto Vessel Black Flash! 💖")
print("Toggle it in Combat tab. Timing is ~0.32s — adjust BLACK_FLASH_DELAY if needed.")