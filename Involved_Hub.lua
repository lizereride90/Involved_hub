-- Involved JJS Hub - Cute Pink GUI for Jujutsu Shenanigans
-- Paste this into your executor.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
if not player then
    return
end

local playerGui = player:WaitForChild("PlayerGui")

-- Remove old GUI
local oldGui = playerGui:FindFirstChild("Involved_JJS_Hub")
if oldGui then
    oldGui:Destroy()
end

local featureStates = {
    autoBlock = false,
    autoCombo = false,
    autoDomain = false,
    fly = false,
    hitboxExpander = false
}

local featureSettings = {
    autoBlockWindow = 0.12,
    autoComboDelay = 0.08,
    autoDomainDelay = 0.25,
    blackFlashCooldown = 1.20,
    flySpeed = 70,
    hitboxSize = 7,
    hitboxTransparency = 0.45
}

local function clamp(value, minValue, maxValue)
    return math.max(minValue, math.min(maxValue, value))
end

local function tween(object, time, properties, style, direction)
    local info = TweenInfo.new(
        time,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )

    TweenService:Create(object, info, properties):Play()
end

local function addCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = object
end

local function addStroke(object, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 2
    stroke.Parent = object
end

local function formatDecimal(value, decimals)
    return string.format("%." .. tostring(decimals) .. "f", value)
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Involved_JJS_Hub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main frame
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

local sizeConstraint = Instance.new("UISizeConstraint")
sizeConstraint.MinSize = Vector2.new(320, 240)
sizeConstraint.MaxSize = Vector2.new(620, 460)
sizeConstraint.Parent = main

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
headerFill.BorderSizePixel = 0
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
subtitle.Text = "Cute - Pink - Jujutsu Shenanigans"
subtitle.TextColor3 = Color3.fromRGB(255, 220, 240)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(0, 36, 0, 36)
hideButton.Position = UDim2.new(1, -14, 0.5, 0)
hideButton.AnchorPoint = Vector2.new(1, 0.5)
hideButton.BackgroundColor3 = Color3.fromRGB(255, 230, 245)
hideButton.Text = "X"
hideButton.TextColor3 = Color3.fromRGB(255, 60, 130)
hideButton.TextScaled = true
hideButton.Font = Enum.Font.GothamBold
hideButton.Parent = header
addCorner(hideButton, 999)
addStroke(hideButton, Color3.fromRGB(255, 180, 210), 2)

local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0, 140, 0, 46)
openButton.Position = UDim2.new(0, 16, 0.5, -23)
openButton.BackgroundColor3 = Color3.fromRGB(255, 80, 160)
openButton.Text = "Open JJS Hub"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextScaled = true
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.Parent = screenGui
addCorner(openButton, 20)
addStroke(openButton, Color3.fromRGB(255, 210, 230), 2)

-- Tabs area
local tabsFrame = Instance.new("Frame")
tabsFrame.Position = UDim2.new(0, 16, 0, 72)
tabsFrame.Size = UDim2.new(0, 124, 1, -92)
tabsFrame.BackgroundTransparency = 1
tabsFrame.Parent = main

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Padding = UDim.new(0, 10)
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Parent = tabsFrame

-- Content area
local content = Instance.new("Frame")
content.Position = UDim2.new(0, 154, 0, 72)
content.Size = UDim2.new(1, -170, 1, -92)
content.BackgroundColor3 = Color3.fromRGB(255, 235, 245)
content.BorderSizePixel = 0
content.Parent = main
addCorner(content, 22)
addStroke(content, Color3.fromRGB(255, 170, 200), 2)

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ScrollBarThickness = 6
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 120, 180)
    page.Visible = false
    page.Parent = content

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 12)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = page

    local function updateCanvas()
        page.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 20)
    end

    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
    task.defer(updateCanvas)

    return page
end

local function addSectionLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 28)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 70, 120)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local function addInfoLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 26)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(215, 95, 140)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local function addToggle(parent, text, initialState, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(255, 245, 250)
    frame.Parent = parent
    addCorner(frame, 14)
    addStroke(frame, Color3.fromRGB(255, 220, 235), 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.72, 0, 1, 0)
    label.Position = UDim2.new(0, 16, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 60, 110)
    label.TextScaled = true
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 56, 0, 30)
    toggleButton.Position = UDim2.new(1, -68, 0.5, -15)
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 140, 190)
    toggleButton.Text = ""
    toggleButton.Parent = frame
    addCorner(toggleButton, 999)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 24, 0, 24)
    knob.Position = UDim2.new(0, 3, 0.5, -12)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = toggleButton
    addCorner(knob, 999)

    local enabled = false

    local function setState(value, fireCallback)
        enabled = value
        if enabled then
            tween(toggleButton, 0.2, {BackgroundColor3 = Color3.fromRGB(100, 255, 140)})
            tween(knob, 0.2, {Position = UDim2.new(1, -27, 0.5, -12)})
        else
            tween(toggleButton, 0.2, {BackgroundColor3 = Color3.fromRGB(255, 140, 190)})
            tween(knob, 0.2, {Position = UDim2.new(0, 3, 0.5, -12)})
        end

        if fireCallback and callback then
            callback(enabled)
        end
    end

    toggleButton.MouseButton1Click:Connect(function()
        setState(not enabled, true)
    end)

    setState(initialState == true, false)

    return {
        get = function()
            return enabled
        end,
        set = function(value)
            setState(value, true)
        end,
        frame = frame
    }
end

local function addActionButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(255, 130, 180)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = parent
    addCorner(button, 16)
    addStroke(button, Color3.fromRGB(255, 205, 225), 2)

    button.MouseButton1Click:Connect(function()
        tween(button, 0.12, {Size = UDim2.new(1, -16, 0, 52)}, Enum.EasingStyle.Back)
        task.delay(0.12, function()
            tween(button, 0.12, {Size = UDim2.new(1, -20, 0, 50)}, Enum.EasingStyle.Back)
        end)

        if callback then
            callback(button)
        end
    end)

    return button
end

local function addStepper(parent, labelText, getter, setter, options)
    local minValue = options.min or 0
    local maxValue = options.max or 100
    local stepValue = options.step or 1
    local formatter = options.formatter or function(v)
        return tostring(v)
    end
    local onChanged = options.onChanged

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 56)
    frame.BackgroundColor3 = Color3.fromRGB(255, 245, 250)
    frame.Parent = parent
    addCorner(frame, 14)
    addStroke(frame, Color3.fromRGB(255, 220, 235), 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -120, 1, 0)
    label.Position = UDim2.new(0, 16, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(200, 60, 110)
    label.TextScaled = true
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local minusButton = Instance.new("TextButton")
    minusButton.Size = UDim2.new(0, 38, 0, 30)
    minusButton.Position = UDim2.new(1, -92, 0.5, -15)
    minusButton.BackgroundColor3 = Color3.fromRGB(255, 180, 210)
    minusButton.Text = "-"
    minusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusButton.TextScaled = true
    minusButton.Font = Enum.Font.GothamBold
    minusButton.Parent = frame
    addCorner(minusButton, 10)

    local plusButton = Instance.new("TextButton")
    plusButton.Size = UDim2.new(0, 38, 0, 30)
    plusButton.Position = UDim2.new(1, -48, 0.5, -15)
    plusButton.BackgroundColor3 = Color3.fromRGB(255, 120, 180)
    plusButton.Text = "+"
    plusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusButton.TextScaled = true
    plusButton.Font = Enum.Font.GothamBold
    plusButton.Parent = frame
    addCorner(plusButton, 10)

    local function updateLabel()
        label.Text = labelText .. ": " .. formatter(getter())
    end

    local function changeValue(delta)
        local current = getter()
        local nextValue = clamp(current + delta, minValue, maxValue)
        setter(nextValue)
        updateLabel()

        if onChanged then
            onChanged(nextValue)
        end
    end

    minusButton.MouseButton1Click:Connect(function()
        changeValue(-stepValue)
    end)

    plusButton.MouseButton1Click:Connect(function()
        changeValue(stepValue)
    end)

    updateLabel()

    return {
        update = updateLabel,
        frame = frame
    }
end

local pages = {}
local tabs = {}
local currentPage = "Combat"

local function showPage(name)
    for _, page in pairs(pages) do
        page.Visible = false
    end

    local selectedPage = pages[name]
    if selectedPage then
        selectedPage.Visible = true
    end

    for tabName, button in pairs(tabs) do
        if tabName == name then
            tween(button, 0.2, {BackgroundColor3 = Color3.fromRGB(255, 110, 175)})
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            tween(button, 0.2, {BackgroundColor3 = Color3.fromRGB(255, 225, 240)})
            button.TextColor3 = Color3.fromRGB(255, 90, 150)
        end
    end

    currentPage = name
end

local function createTab(name, order)
    local button = Instance.new("TextButton")
    button.LayoutOrder = order
    button.Size = UDim2.new(1, 0, 0, 46)
    button.BackgroundColor3 = Color3.fromRGB(255, 225, 240)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 90, 150)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = tabsFrame
    addCorner(button, 18)
    addStroke(button, Color3.fromRGB(255, 180, 210), 2)

    button.MouseButton1Click:Connect(function()
        showPage(name)
    end)

    tabs[name] = button
end

pages.Combat = createPage("Combat")
pages.Movement = createPage("Movement")
pages.Visuals = createPage("Visuals")
pages.Settings = createPage("Settings")

local combatPage = pages.Combat
local movementPage = pages.Movement
local visualsPage = pages.Visuals
local settingsPage = pages.Settings

-- Hitbox expander system (other players only)
local hitboxConnection
local hitboxCache = {}

local function cacheHitboxPart(part)
    if not hitboxCache[part] then
        hitboxCache[part] = {
            size = part.Size,
            transparency = part.Transparency,
            color = part.Color,
            material = part.Material,
            canCollide = part.CanCollide
        }
    end
end

local function applyHitboxToPart(part)
    cacheHitboxPart(part)
    part.Size = Vector3.new(featureSettings.hitboxSize, featureSettings.hitboxSize, featureSettings.hitboxSize)
    part.Transparency = featureSettings.hitboxTransparency
    part.Color = Color3.fromRGB(255, 110, 170)
    part.Material = Enum.Material.ForceField
    part.CanCollide = false
end

local function restoreHitboxPart(part, original)
    if not part or not original then
        return
    end

    if part.Parent then
        part.Size = original.size
        part.Transparency = original.transparency
        part.Color = original.color
        part.Material = original.material
        part.CanCollide = original.canCollide
    end
end

local function restoreAllHitboxes()
    for part, original in pairs(hitboxCache) do
        restoreHitboxPart(part, original)
        hitboxCache[part] = nil
    end
end

local function refreshHitboxes()
    if not featureStates.hitboxExpander then
        return
    end

    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= player then
            local character = targetPlayer.Character
            if character then
                local root = character:FindFirstChild("HumanoidRootPart")
                if root and root:IsA("BasePart") then
                    applyHitboxToPart(root)
                end
            end
        end
    end
end

local function stopHitboxExpander()
    if hitboxConnection then
        hitboxConnection:Disconnect()
        hitboxConnection = nil
    end
    restoreAllHitboxes()
end

local function startHitboxExpander()
    if hitboxConnection then
        hitboxConnection:Disconnect()
        hitboxConnection = nil
    end

    hitboxConnection = RunService.Heartbeat:Connect(function()
        refreshHitboxes()
    end)

    refreshHitboxes()
end

-- Fly system
local flyUpPressed = false
local flyDownPressed = false
local flyConnection
local flyVelocity
local flyGyro

local function setHoldState(button, setState)
    button.MouseButton1Down:Connect(function()
        setState(true)
    end)

    button.MouseButton1Up:Connect(function()
        setState(false)
    end)

    button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            setState(false)
        end
    end)
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
end

local function startFly()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    local camera = workspace.CurrentCamera

    if not humanoid or not root or not camera then
        return
    end

    stopFly()

    flyGyro = Instance.new("BodyGyro")
    flyGyro.P = 90000
    flyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyGyro.CFrame = camera.CFrame
    flyGyro.Parent = root

    flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyVelocity.Velocity = Vector3.new(0, 0, 0)
    flyVelocity.Parent = root

    flyConnection = RunService.Heartbeat:Connect(function()
        if not featureStates.fly then
            stopFly()
            return
        end

        if not root.Parent then
            stopFly()
            return
        end

        local currentCamera = workspace.CurrentCamera
        if not currentCamera then
            return
        end

        local moveDirection = humanoid.MoveDirection
        local verticalDirection = 0

        if UserInputService:IsKeyDown(Enum.KeyCode.Space) or flyUpPressed then
            verticalDirection = verticalDirection + 1
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
            or UserInputService:IsKeyDown(Enum.KeyCode.C)
            or flyDownPressed then
            verticalDirection = verticalDirection - 1
        end

        flyVelocity.Velocity = moveDirection * featureSettings.flySpeed + Vector3.new(0, verticalDirection * featureSettings.flySpeed, 0)
        flyGyro.CFrame = currentCamera.CFrame
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end)
end

-- Combat UI
addSectionLabel(combatPage, "Combat Features")

addToggle(combatPage, "Auto Block / Parry", false, function(state)
    featureStates.autoBlock = state
    print("Auto Block:", state, "Window", featureSettings.autoBlockWindow)
end)

addToggle(combatPage, "Auto Combo / M1 Spam", false, function(state)
    featureStates.autoCombo = state
    print("Auto Combo:", state, "Delay", featureSettings.autoComboDelay)
end)

addToggle(combatPage, "Auto Domain Expansion", false, function(state)
    featureStates.autoDomain = state
    print("Auto Domain:", state, "Delay", featureSettings.autoDomainDelay)
end)

addToggle(combatPage, "Hitbox Expander (Others Only)", false, function(state)
    featureStates.hitboxExpander = state
    if state then
        startHitboxExpander()
    else
        stopHitboxExpander()
    end
end)

local blackFlashReady = true
addActionButton(combatPage, "Force Black Flash", function(button)
    if not blackFlashReady then
        return
    end

    blackFlashReady = false
    button.Text = "Black Flash Used"
    print("Black Flash triggered! Cooldown", featureSettings.blackFlashCooldown)

    task.delay(featureSettings.blackFlashCooldown, function()
        blackFlashReady = true
        if button and button.Parent then
            button.Text = "Force Black Flash"
        end
    end)
end)

addInfoLabel(combatPage, "Hitbox expander only modifies other players.")

-- Movement UI
addSectionLabel(movementPage, "Movement Features")

local flyToggle = addToggle(movementPage, "Fly (Space up / Ctrl down)", false, function(state)
    featureStates.fly = state
    if state then
        startFly()
    else
        flyUpPressed = false
        flyDownPressed = false
        stopFly()
    end
end)

local flySpeedStepper = addStepper(
    movementPage,
    "Fly Speed",
    function()
        return featureSettings.flySpeed
    end,
    function(value)
        featureSettings.flySpeed = value
    end,
    {
        min = 20,
        max = 220,
        step = 10,
        formatter = function(value)
            return tostring(math.floor(value))
        end
    }
)

addInfoLabel(movementPage, "Mobile: hold Fly Up/Fly Down for vertical movement.")

local verticalFrame = Instance.new("Frame")
verticalFrame.Size = UDim2.new(1, -20, 0, 56)
verticalFrame.BackgroundColor3 = Color3.fromRGB(255, 245, 250)
verticalFrame.Parent = movementPage
addCorner(verticalFrame, 14)
addStroke(verticalFrame, Color3.fromRGB(255, 220, 235), 1)

local flyUpButton = Instance.new("TextButton")
flyUpButton.Size = UDim2.new(0.48, 0, 0.7, 0)
flyUpButton.Position = UDim2.new(0.02, 0, 0.15, 0)
flyUpButton.BackgroundColor3 = Color3.fromRGB(255, 135, 190)
flyUpButton.Text = "Fly Up"
flyUpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyUpButton.TextScaled = true
flyUpButton.Font = Enum.Font.GothamBold
flyUpButton.Parent = verticalFrame
addCorner(flyUpButton, 12)

local flyDownButton = Instance.new("TextButton")
flyDownButton.Size = UDim2.new(0.48, 0, 0.7, 0)
flyDownButton.Position = UDim2.new(0.50, 0, 0.15, 0)
flyDownButton.BackgroundColor3 = Color3.fromRGB(255, 115, 175)
flyDownButton.Text = "Fly Down"
flyDownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyDownButton.TextScaled = true
flyDownButton.Font = Enum.Font.GothamBold
flyDownButton.Parent = verticalFrame
addCorner(flyDownButton, 12)

setHoldState(flyUpButton, function(value)
    flyUpPressed = value
end)

setHoldState(flyDownButton, function(value)
    flyDownPressed = value
end)

-- Visuals UI
addSectionLabel(visualsPage, "Visuals")
addInfoLabel(visualsPage, "Hitbox style is customizable from Settings.")
addInfoLabel(visualsPage, "More visuals can be added here later.")

-- Settings UI (for every feature)
addSectionLabel(settingsPage, "Feature Settings")

addStepper(
    settingsPage,
    "Auto Block Window (s)",
    function()
        return featureSettings.autoBlockWindow
    end,
    function(value)
        featureSettings.autoBlockWindow = value
    end,
    {
        min = 0.05,
        max = 1.00,
        step = 0.01,
        formatter = function(value)
            return formatDecimal(value, 2)
        end
    }
)

addStepper(
    settingsPage,
    "Auto Combo Delay (s)",
    function()
        return featureSettings.autoComboDelay
    end,
    function(value)
        featureSettings.autoComboDelay = value
    end,
    {
        min = 0.01,
        max = 0.80,
        step = 0.01,
        formatter = function(value)
            return formatDecimal(value, 2)
        end
    }
)

addStepper(
    settingsPage,
    "Auto Domain Delay (s)",
    function()
        return featureSettings.autoDomainDelay
    end,
    function(value)
        featureSettings.autoDomainDelay = value
    end,
    {
        min = 0.05,
        max = 2.00,
        step = 0.05,
        formatter = function(value)
            return formatDecimal(value, 2)
        end
    }
)

addStepper(
    settingsPage,
    "Black Flash Cooldown (s)",
    function()
        return featureSettings.blackFlashCooldown
    end,
    function(value)
        featureSettings.blackFlashCooldown = value
    end,
    {
        min = 0.20,
        max = 10.00,
        step = 0.10,
        formatter = function(value)
            return formatDecimal(value, 2)
        end
    }
)

addStepper(
    settingsPage,
    "Fly Speed",
    function()
        return featureSettings.flySpeed
    end,
    function(value)
        featureSettings.flySpeed = value
        flySpeedStepper.update()
    end,
    {
        min = 20,
        max = 220,
        step = 10,
        formatter = function(value)
            return tostring(math.floor(value))
        end
    }
)

addStepper(
    settingsPage,
    "Hitbox Size",
    function()
        return featureSettings.hitboxSize
    end,
    function(value)
        featureSettings.hitboxSize = value
    end,
    {
        min = 3,
        max = 25,
        step = 1,
        formatter = function(value)
            return tostring(math.floor(value))
        end,
        onChanged = function()
            if featureStates.hitboxExpander then
                refreshHitboxes()
            end
        end
    }
)

addStepper(
    settingsPage,
    "Hitbox Transparency",
    function()
        return featureSettings.hitboxTransparency
    end,
    function(value)
        featureSettings.hitboxTransparency = value
    end,
    {
        min = 0.00,
        max = 0.90,
        step = 0.05,
        formatter = function(value)
            return formatDecimal(value, 2)
        end,
        onChanged = function()
            if featureStates.hitboxExpander then
                refreshHitboxes()
            end
        end
    }
)

addInfoLabel(settingsPage, "All feature settings can be changed here.")

-- Tabs
createTab("Combat", 1)
createTab("Movement", 2)
createTab("Visuals", 3)
createTab("Settings", 4)

showPage("Combat")

-- Drag support
local dragging = false
local dragInput
local dragStart
local startPosition

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
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- Open / Close
local isOpen = true
local openSize = main.Size

local function closeGui()
    if not isOpen then
        return
    end

    isOpen = false
    tween(main, 0.22, {Size = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    task.delay(0.2, function()
        main.Visible = false
        openButton.Visible = true
        tween(openButton, 0.2, {Size = UDim2.new(0, 140, 0, 46)})
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
    tween(main, 0.25, {Size = openSize}, Enum.EasingStyle.Back)
end

hideButton.MouseButton1Click:Connect(closeGui)
openButton.MouseButton1Click:Connect(openGui)

-- Character events
player.CharacterAdded:Connect(function()
    task.wait(0.6)

    if featureStates.fly then
        startFly()
    end

    if featureStates.hitboxExpander then
        refreshHitboxes()
    end
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    local character = leavingPlayer.Character
    if not character then
        return
    end

    local root = character:FindFirstChild("HumanoidRootPart")
    if root and hitboxCache[root] then
        restoreHitboxPart(root, hitboxCache[root])
        hitboxCache[root] = nil
    end
end)

-- Cleanup when GUI is removed
screenGui.AncestryChanged:Connect(function(_, parent)
    if parent ~= nil then
        return
    end

    featureStates.fly = false
    featureStates.hitboxExpander = false
    stopFly()
    stopHitboxExpander()
end)

-- Initial animation
tween(
    main,
    0.3,
    {
        Size = UDim2.new(
            openSize.X.Scale,
            openSize.X.Offset + 12,
            openSize.Y.Scale,
            openSize.Y.Offset + 12
        )
    },
    Enum.EasingStyle.Back
)
task.wait(0.12)
tween(main, 0.18, {Size = openSize}, Enum.EasingStyle.Back)

print("Involved JJS Hub loaded.")
