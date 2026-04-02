-- Involved JJS Hub - Fly + Lock-On

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

local function tween(object, time, properties, easingStyle, easingDirection)
    local info = TweenInfo.new(
        time,
        easingStyle or Enum.EasingStyle.Back,
        easingDirection or Enum.EasingDirection.Out
    )
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
subtitle.Text = "Cute Pink • Fly + Lock-On"
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
local movementPage = createPage("Movement")
createPage("Visuals")
createPage("Misc")

createTab("Combat", 1)
createTab("Movement", 2)
createTab("Visuals", 3)
createTab("Misc", 4)

showPage("Combat")

-- ==================== FEATURE CONSTANTS ====================
local FLY_SPEED = 82
local FLY_VERTICAL_SPEED = 65
local LOCKON_MAX_SCREEN_DISTANCE = 190
local LOCKON_KEY = Enum.KeyCode.T
local isTouchDevice = UserInputService.TouchEnabled

-- ==================== FLY ====================
local flyEnabled = false
local flyVelocity = nil
local flyGyro = nil
local flyConnection = nil
local flyInput = {
    Forward = false,
    Back = false,
    Left = false,
    Right = false,
    Up = false,
    Down = false
}

local flyMobileControls = Instance.new("Frame")
flyMobileControls.Size = UDim2.new(0, 66, 0, 132)
flyMobileControls.Position = UDim2.new(1, -78, 1, -162)
flyMobileControls.BackgroundTransparency = 1
flyMobileControls.Visible = false
flyMobileControls.Parent = screenGui

local flyUpButton = Instance.new("TextButton")
flyUpButton.Size = UDim2.new(0, 62, 0, 62)
flyUpButton.Position = UDim2.new(0, 2, 0, 0)
flyUpButton.BackgroundColor3 = Color3.fromRGB(255, 110, 175)
flyUpButton.Text = "UP"
flyUpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyUpButton.TextScaled = true
flyUpButton.Font = Enum.Font.GothamBold
flyUpButton.Parent = flyMobileControls
addCorner(flyUpButton, 999)
addStroke(flyUpButton, Color3.fromRGB(255, 210, 230), 2)

local flyDownButton = Instance.new("TextButton")
flyDownButton.Size = UDim2.new(0, 62, 0, 62)
flyDownButton.Position = UDim2.new(0, 2, 0, 70)
flyDownButton.BackgroundColor3 = Color3.fromRGB(255, 110, 175)
flyDownButton.Text = "DN"
flyDownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyDownButton.TextScaled = true
flyDownButton.Font = Enum.Font.GothamBold
flyDownButton.Parent = flyMobileControls
addCorner(flyDownButton, 999)
addStroke(flyDownButton, Color3.fromRGB(255, 210, 230), 2)

local function resetFlyInput()
    for key, _ in pairs(flyInput) do
        flyInput[key] = false
    end
end

local function getLocalCharacterParts()
    local character = player.Character
    if not character then
        return nil, nil
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    return humanoid, root
end

local function stopFly()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if flyVelocity then
        flyVelocity:Destroy()
        flyVelocity = nil
    end
    if flyGyro then
        flyGyro:Destroy()
        flyGyro = nil
    end

    local humanoid = getLocalCharacterParts()
    if humanoid then
        humanoid.PlatformStand = false
    end

    resetFlyInput()
    flyMobileControls.Visible = false
end

local function startFly()
    stopFly()

    local humanoid, root = getLocalCharacterParts()
    if not humanoid or not root then
        flyEnabled = false
        return
    end

    flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.Name = "InvolvedFlyVelocity"
    flyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    flyVelocity.P = 1250
    flyVelocity.Velocity = Vector3.new(0, 0, 0)
    flyVelocity.Parent = root

    flyGyro = Instance.new("BodyGyro")
    flyGyro.Name = "InvolvedFlyGyro"
    flyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    flyGyro.P = 5000
    flyGyro.CFrame = root.CFrame
    flyGyro.Parent = root

    humanoid.PlatformStand = false
    flyMobileControls.Visible = isTouchDevice

    flyConnection = RunService.RenderStepped:Connect(function()
        if not flyEnabled then return end

        local currentHumanoid, currentRoot = getLocalCharacterParts()
        if not currentHumanoid or not currentRoot or not flyVelocity or not flyGyro then
            return
        end

        local camera = workspace.CurrentCamera
        if not camera then
            return
        end

        local forward = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local direction = currentHumanoid.MoveDirection

        -- Keyboard fallback for executors where MoveDirection is unreliable during fly.
        if flyInput.Forward then direction = direction + forward end
        if flyInput.Back then direction = direction - forward end
        if flyInput.Right then direction = direction + right end
        if flyInput.Left then direction = direction - right end

        local horizontalVelocity = Vector3.new(0, 0, 0)
        if direction.Magnitude > 0 then
            horizontalVelocity = direction.Unit * FLY_SPEED
        end

        local verticalVelocity = 0
        if flyInput.Up then verticalVelocity = verticalVelocity + FLY_VERTICAL_SPEED end
        if flyInput.Down then verticalVelocity = verticalVelocity - FLY_VERTICAL_SPEED end

        flyVelocity.Velocity = Vector3.new(horizontalVelocity.X, verticalVelocity, horizontalVelocity.Z)
        flyGyro.CFrame = CFrame.new(currentRoot.Position, currentRoot.Position + camera.CFrame.LookVector)
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

    if input.KeyCode == Enum.KeyCode.W then flyInput.Forward = true end
    if input.KeyCode == Enum.KeyCode.S then flyInput.Back = true end
    if input.KeyCode == Enum.KeyCode.A then flyInput.Left = true end
    if input.KeyCode == Enum.KeyCode.D then flyInput.Right = true end
    if input.KeyCode == Enum.KeyCode.Space then flyInput.Up = true end
    if input.KeyCode == Enum.KeyCode.LeftControl then flyInput.Down = true end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

    if input.KeyCode == Enum.KeyCode.W then flyInput.Forward = false end
    if input.KeyCode == Enum.KeyCode.S then flyInput.Back = false end
    if input.KeyCode == Enum.KeyCode.A then flyInput.Left = false end
    if input.KeyCode == Enum.KeyCode.D then flyInput.Right = false end
    if input.KeyCode == Enum.KeyCode.Space then flyInput.Up = false end
    if input.KeyCode == Enum.KeyCode.LeftControl then flyInput.Down = false end
end)

local function bindHoldToFly(button, keyName)
    button.MouseButton1Down:Connect(function()
        flyInput[keyName] = true
    end)
    button.MouseButton1Up:Connect(function()
        flyInput[keyName] = false
    end)
    button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            flyInput[keyName] = false
        end
    end)
end

bindHoldToFly(flyUpButton, "Up")
bindHoldToFly(flyDownButton, "Down")

UserInputService.TouchEnded:Connect(function()
    flyInput.Up = false
    flyInput.Down = false
end)

-- ==================== LOCK-ON ====================
local lockOnEnabled = false
local lockOnTarget = nil
local lockOnConnection = nil

local lockOnButton = Instance.new("TextButton")
lockOnButton.Size = UDim2.new(0, 56, 0, 56)
lockOnButton.Position = UDim2.new(0, 12, 0, 12)
lockOnButton.BackgroundColor3 = Color3.fromRGB(255, 110, 175)
lockOnButton.Text = "LOCK"
lockOnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
lockOnButton.TextScaled = true
lockOnButton.Font = Enum.Font.GothamBold
lockOnButton.Visible = false
lockOnButton.Parent = screenGui
addCorner(lockOnButton, 999)
addStroke(lockOnButton, Color3.fromRGB(255, 210, 230), 2)

local function updateLockOnButtonVisual()
    if lockOnTarget then
        tween(lockOnButton, 0.2, {BackgroundColor3 = Color3.fromRGB(80, 255, 120)})
        lockOnButton.Text = "ON"
    else
        tween(lockOnButton, 0.2, {BackgroundColor3 = Color3.fromRGB(255, 110, 175)})
        lockOnButton.Text = "LOCK"
    end
end

local function clearLockOn()
    lockOnTarget = nil
    updateLockOnButtonVisual()
end

local function getValidTargetParts(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        return nil, nil
    end

    local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
    local root = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not humanoid or humanoid.Health <= 0 or not root then
        return nil, nil
    end

    return humanoid, root
end

local function getTargetInView()
    local camera = workspace.CurrentCamera
    if not camera then return nil end

    local center = Vector2.new(camera.ViewportSize.X * 0.5, camera.ViewportSize.Y * 0.5)
    local closestPlayer = nil
    local closestDistance = LOCKON_MAX_SCREEN_DISTANCE

    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local _, root = getValidTargetParts(otherPlayer)
            if root then
                local viewportPoint, onScreen = camera:WorldToViewportPoint(root.Position)
                if onScreen and viewportPoint.Z > 0 then
                    local distance = (Vector2.new(viewportPoint.X, viewportPoint.Y) - center).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = otherPlayer
                    end
                end
            end
        end
    end

    return closestPlayer
end

local function toggleLockOnTarget()
    if not lockOnEnabled then
        return
    end

    if lockOnTarget then
        clearLockOn()
        print("Lock-On released.")
        return
    end

    local target = getTargetInView()
    if target then
        lockOnTarget = target
        updateLockOnButtonVisual()
        print("Lock-On target: " .. target.Name)
    else
        print("No target near screen center to lock.")
    end
end

local function setupLockOnLoop()
    if lockOnConnection then
        lockOnConnection:Disconnect()
        lockOnConnection = nil
    end

    lockOnConnection = RunService.RenderStepped:Connect(function()
        if not lockOnEnabled or not lockOnTarget then return end

        local _, targetRoot = getValidTargetParts(lockOnTarget)
        if not targetRoot then
            clearLockOn()
            return
        end

        local localHumanoid, localRoot = getLocalCharacterParts()
        if not localHumanoid or not localRoot then
            clearLockOn()
            return
        end

        local targetPosition = targetRoot.Position
        localRoot.CFrame = CFrame.new(
            localRoot.Position,
            Vector3.new(targetPosition.X, localRoot.Position.Y, targetPosition.Z)
        )

        local camera = workspace.CurrentCamera
        if camera then
            camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
        end
    end)
end

setupLockOnLoop()

lockOnButton.MouseButton1Click:Connect(function()
    toggleLockOnTarget()
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == LOCKON_KEY then
        if lockOnEnabled then
            toggleLockOnTarget()
        else
            print("Enable Lock-On first from Combat tab.")
        end
    end
end)

local lockToggleFrame = Instance.new("Frame")
lockToggleFrame.Size = UDim2.new(1, -20, 0, 58)
lockToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 245, 250)
lockToggleFrame.Parent = combatPage
addCorner(lockToggleFrame, 16)

local lockToggleLabel = Instance.new("TextLabel")
lockToggleLabel.Size = UDim2.new(0.65, 0, 1, 0)
lockToggleLabel.Position = UDim2.new(0, 18, 0, 0)
lockToggleLabel.BackgroundTransparency = 1
lockToggleLabel.Text = "Enable Lock-On (T on PC)"
lockToggleLabel.TextColor3 = Color3.fromRGB(190, 50, 100)
lockToggleLabel.TextScaled = true
lockToggleLabel.Font = Enum.Font.GothamSemibold
lockToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
lockToggleLabel.Parent = lockToggleFrame

local lockToggleBtn = Instance.new("TextButton")
lockToggleBtn.Size = UDim2.new(0, 58, 0, 34)
lockToggleBtn.Position = UDim2.new(1, -72, 0.5, -17)
lockToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 190)
lockToggleBtn.Text = ""
lockToggleBtn.Parent = lockToggleFrame
addCorner(lockToggleBtn, 999)

lockToggleBtn.MouseButton1Click:Connect(function()
    lockOnEnabled = not lockOnEnabled
    if lockOnEnabled then
        tween(lockToggleBtn, 0.25, {BackgroundColor3 = Color3.fromRGB(80, 255, 120)})
        lockOnButton.Visible = isTouchDevice
        if isTouchDevice then
            print("Lock-On ENABLED. Tap top-left LOCK button.")
        else
            print("Lock-On ENABLED. Press T to lock/unlock.")
        end
    else
        tween(lockToggleBtn, 0.25, {BackgroundColor3 = Color3.fromRGB(255, 140, 190)})
        lockOnButton.Visible = false
        clearLockOn()
        print("Lock-On button DISABLED.")
    end
end)

local flyToggleFrame = Instance.new("Frame")
flyToggleFrame.Size = UDim2.new(1, -20, 0, 58)
flyToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 245, 250)
flyToggleFrame.Parent = movementPage
addCorner(flyToggleFrame, 16)

local flyToggleLabel = Instance.new("TextLabel")
flyToggleLabel.Size = UDim2.new(0.65, 0, 1, 0)
flyToggleLabel.Position = UDim2.new(0, 18, 0, 0)
flyToggleLabel.BackgroundTransparency = 1
flyToggleLabel.Text = "Fly (PC: WASD, Mobile: Joystick)"
flyToggleLabel.TextColor3 = Color3.fromRGB(190, 50, 100)
flyToggleLabel.TextScaled = true
flyToggleLabel.Font = Enum.Font.GothamSemibold
flyToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
flyToggleLabel.Parent = flyToggleFrame

local flyToggleBtn = Instance.new("TextButton")
flyToggleBtn.Size = UDim2.new(0, 58, 0, 34)
flyToggleBtn.Position = UDim2.new(1, -72, 0.5, -17)
flyToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 190)
flyToggleBtn.Text = ""
flyToggleBtn.Parent = flyToggleFrame
addCorner(flyToggleBtn, 999)

flyToggleBtn.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    if flyEnabled then
        startFly()
        if flyEnabled then
            tween(flyToggleBtn, 0.25, {BackgroundColor3 = Color3.fromRGB(80, 255, 120)})
            print("Fly ENABLED")
        else
            tween(flyToggleBtn, 0.25, {BackgroundColor3 = Color3.fromRGB(255, 140, 190)})
            print("Fly failed to start (missing character/root).")
        end
    else
        stopFly()
        tween(flyToggleBtn, 0.25, {BackgroundColor3 = Color3.fromRGB(255, 140, 190)})
        print("Fly DISABLED")
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(0.35)
    if flyEnabled then
        startFly()
    end
    clearLockOn()
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

print("✅ Involved JJS Hub Loaded (Fly + Lock-On) 💖")
print("PC Lock-On key: T | Mobile Lock-On: top-left LOCK button")
