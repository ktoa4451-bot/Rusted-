--// Rusted Compact v2.1
--// Part 1/2
--// UI Core + Settings + Categories

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local Settings = {
    Enabled = true,

    ESP = true,
    BoxESP = true,
    NameESP = true,
    DistanceESP = true,
    HealthESP = true,
    HealthBar = true,
    Tracer = false,
    MaxDistance = 2500,

    AimAssist = false,
    AimTarget = "Head",
    AimFOV = 120,
    AimSmoothness = 0.15,
    TeamCheck = true,
    WallCheck = true,

    WalkSpeed = 16,
    JumpPower = 50,

    Crosshair = false,
    MenuVisible = true
}

--==================================================
-- COLORS
--==================================================

local Colors = {
    Main = Color3.fromRGB(18, 18, 22),
    Card = Color3.fromRGB(25, 25, 30),
    CardHover = Color3.fromRGB(32, 32, 39),

    Sidebar = Color3.fromRGB(14, 14, 18),
    Topbar = Color3.fromRGB(21, 21, 26),

    Accent = Color3.fromRGB(150, 90, 255),
    AccentDark = Color3.fromRGB(115, 65, 205),

    White = Color3.fromRGB(245, 245, 250),
    Text = Color3.fromRGB(205, 205, 215),
    Muted = Color3.fromRGB(125, 125, 140),

    Red = Color3.fromRGB(235, 75, 75),
    Green = Color3.fromRGB(75, 210, 125)
}

--==================================================
-- HELPERS
--==================================================

local function New(class, props, parent)
    local obj = Instance.new(class)

    for property, value in pairs(props or {}) do
        obj[property] = value
    end

    if parent then
        obj.Parent = parent
    end

    return obj
end

local function Corner(obj, radius)
    return New("UICorner", {
        CornerRadius = UDim.new(0, radius or 6)
    }, obj)
end

local function Stroke(obj, color, transparency)
    return New("UIStroke", {
        Color = color or Colors.Accent,
        Transparency = transparency or 0.5,
        Thickness = 1
    }, obj)
end

local function Tween(obj, time, props)
    if not obj then return end

    TweenService:Create(
        obj,
        TweenInfo.new(
            time or 0.15,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        props
    ):Play()
end

--==================================================
-- GUI
--==================================================

pcall(function()
    local old = CoreGui:FindFirstChild("RustedHub")
    if old then
        old:Destroy()
    end
end)

local GUI = New("ScreenGui", {
    Name = "RustedHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999,
    Enabled = true
})

local GUIParent

pcall(function()
    GUI.Parent = CoreGui
    GUIParent = CoreGui
end)

if not GUI.Parent then
    GUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
    GUIParent = GUI.Parent
end

--==================================================
-- MAIN WINDOW
--==================================================

local MENU_WIDTH = 650
local MENU_HEIGHT = 510

local Main = New("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(MENU_WIDTH, MENU_HEIGHT),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Colors.Main,
    BorderSizePixel = 0,
    Visible = true
}, GUI)

Corner(Main, 10)
Stroke(Main, Color3.fromRGB(55, 55, 65), 0.25)

--==================================================
-- TOPBAR
--==================================================

local Topbar = New("Frame", {
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = Colors.Topbar,
    BorderSizePixel = 0
}, Main)

Corner(Topbar, 10)

local Title = New("TextLabel", {
    Size = UDim2.new(1, -130, 1, 0),
    Position = UDim2.fromOffset(18, 0),
    BackgroundTransparency = 1,
    Text = "Rusted Hub",
    TextColor3 = Colors.White,
    TextSize = 21,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, Topbar)

local Version = New("TextLabel", {
    Size = UDim2.fromOffset(80, 30),
    Position = UDim2.new(1, -145, 0.5, -15),
    BackgroundTransparency = 1,
    Text = "v2.1",
    TextColor3 = Colors.Accent,
    TextSize = 13,
    Font = Enum.Font.GothamMedium
}, Topbar)

local CloseButton = New("TextButton", {
    Size = UDim2.fromOffset(38, 34),
    Position = UDim2.new(1, -48, 0.5, -17),
    BackgroundColor3 = Colors.Card,
    Text = "×",
    TextColor3 = Colors.Text,
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, Topbar)

Corner(CloseButton, 7)

CloseButton.MouseEnter:Connect(function()
    Tween(CloseButton, 0.12, {
        BackgroundColor3 = Colors.Red,
        TextColor3 = Colors.White
    })
end)

CloseButton.MouseLeave:Connect(function()
    Tween(CloseButton, 0.12, {
        BackgroundColor3 = Colors.Card,
        TextColor3 = Colors.Text
    })
end)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = New("Frame", {
    Size = UDim2.new(0, 145, 1, -58),
    Position = UDim2.fromOffset(0, 58),
    BackgroundColor3 = Colors.Sidebar,
    BorderSizePixel = 0
}, Main)

local SidebarPadding = New("UIPadding", {
    PaddingTop = UDim.new(0, 12),
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10)
}, Sidebar)

local SidebarLayout = New("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Sidebar)

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {
    Size = UDim2.new(1, -145, 1, -58),
    Position = UDim2.fromOffset(145, 58),
    BackgroundTransparency = 1,
    BorderSizePixel = 0
}, Main)

local ContentTitle = New("TextLabel", {
    Size = UDim2.new(1, -35, 0, 42),
    Position = UDim2.fromOffset(18, 12),
    BackgroundTransparency = 1,
    Text = "Visual",
    TextColor3 = Colors.White,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, Content)

local Page = New("ScrollingFrame", {
    Size = UDim2.new(1, -30, 1, -62),
    Position = UDim2.fromOffset(15, 55),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Colors.Accent,
    CanvasSize = UDim2.new()
}, Content)

local PagePadding = New("UIPadding", {
    PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 10)
}, Page)

local PageLayout = New("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Page)

PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Page.CanvasSize = UDim2.new(
        0,
        0,
        0,
        PageLayout.AbsoluteContentSize.Y + 15
    )
end)

--==================================================
-- PAGES
--==================================================

local Pages = {}

local Categories = {
    "Visual",
    "Combat",
    "Movement",
    "Misc",
    "Settings"
}

for _, category in ipairs(Categories) do
    Pages[category] = New("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Visible = false
    }, Page)

    New("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, Pages[category])
end

local CurrentCategory

--==================================================
-- CATEGORY BUTTON
--==================================================

local function SelectCategory(category)
    CurrentCategory = category
    ContentTitle.Text = category

    for name, page in pairs(Pages) do
        page.Visible = (name == category)
    end

    for _, child in ipairs(Sidebar:GetChildren()) do
        if child:IsA("TextButton") then
            local selected = child.Name == category

            Tween(child, 0.12, {
                BackgroundColor3 = selected
                    and Colors.Accent
                    or Colors.Sidebar,

                TextColor3 = selected
                    and Colors.White
                    or Colors.Text
            })
        end
    end
end

for index, category in ipairs(Categories) do
    local Button = New("TextButton", {
        Name = category,
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = Colors.Sidebar,
        Text = category,
        TextColor3 = Colors.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = false,
        LayoutOrder = index
    }, Sidebar)

    Corner(Button, 7)

    Button.MouseEnter:Connect(function()
        if CurrentCategory ~= category then
            Tween(Button, 0.12, {
                BackgroundColor3 = Colors.CardHover
            })
        end
    end)

    Button.MouseLeave:Connect(function()
        if CurrentCategory ~= category then
            Tween(Button, 0.12, {
                BackgroundColor3 = Colors.Sidebar
            })
        end
    end)

    Button.MouseButton1Click:Connect(function()
        SelectCategory(category)
    end)
end

--==================================================
-- UI CONTROLS
--==================================================

local function AddSection(category, title)
    local section = New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Colors.Muted,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Pages[category])

    return section
end

local function AddToggle(category, title, setting)
    local holder = New("Frame", {
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundColor3 = Colors.Card,
        BorderSizePixel = 0
    }, Pages[category])

    Corner(holder, 7)

    local label = New("TextLabel", {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.fromOffset(14, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Colors.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left
    }, holder)

    local button = New("TextButton", {
        Size = UDim2.fromOffset(42, 22),
        Position = UDim2.new(1, -55, 0.5, -11),
        BackgroundColor3 = Colors.Sidebar,
        Text = "",
        AutoButtonColor = false
    }, holder)

    Corner(button, 11)

    local knob = New("Frame", {
        Size = UDim2.fromOffset(16, 16),
        Position = UDim2.fromOffset(3, 3),
        BackgroundColor3 = Colors.Muted,
        BorderSizePixel = 0
    }, button)

    Corner(knob, 8)

    local function Update()
        local enabled = Settings[setting]

        Tween(button, 0.12, {
            BackgroundColor3 = enabled
                and Colors.Accent
                or Colors.Sidebar
        })

        Tween(knob, 0.12, {
            Position = enabled
                and UDim2.new(1, -19, 0, 3)
                or UDim2.fromOffset(3, 3),

            BackgroundColor3 = enabled
                and Colors.White
                or Colors.Muted
        })
    end

    button.MouseButton1Click:Connect(function()
        Settings[setting] = not Settings[setting]
        Update()
    end)

    Update()

    return holder
end

local function AddButton(category, title, callback)
    local button = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = Colors.Card,
        Text = title,
        TextColor3 = Colors.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = false
    }, Pages[category])

    Corner(button, 7)

    button.MouseEnter:Connect(function()
        Tween(button, 0.12, {
            BackgroundColor3 = Colors.CardHover,
            TextColor3 = Colors.White
        })
    end)

    button.MouseLeave:Connect(function()
        Tween(button, 0.12, {
            BackgroundColor3 = Colors.Card,
            TextColor3 = Colors.Text
        })
    end)

    button.MouseButton1Click:Connect(function()
        if callback then
            task.spawn(callback)
        end
    end)

    return button
end

--==================================================
-- VISUAL PAGE
--==================================================

AddSection("Visual", "ESP")

AddToggle("Visual", "ESP", "ESP")
AddToggle("Visual", "Box ESP", "BoxESP")
AddToggle("Visual", "Name ESP", "NameESP")
AddToggle("Visual", "Distance ESP", "DistanceESP")
AddToggle("Visual", "Health ESP", "HealthESP")
AddToggle("Visual", "Health Bar", "HealthBar")
AddToggle("Visual", "Tracer", "Tracer")

--==================================================
-- COMBAT PAGE
--==================================================

AddSection("Combat", "Aim Assist")

AddToggle("Combat", "Aim Assist", "AimAssist")
AddToggle("Combat", "Team Check", "TeamCheck")
AddToggle("Combat", "Wall Check", "WallCheck")

--==================================================
-- MOVEMENT PAGE
--==================================================

AddSection("Movement", "Player")

AddButton("Movement", "Reset Movement", function()
    Settings.WalkSpeed = 16
    Settings.JumpPower = 50

    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = Settings.WalkSpeed
        humanoid.JumpPower = Settings.JumpPower
    end
end)

--==================================================
-- MISC PAGE
--==================================================

AddSection("Misc", "Interface")

AddToggle("Misc", "Crosshair", "Crosshair")

AddButton("Misc", "Reload UI", function()
    Main.Visible = true
    GUI.Enabled = true
    Settings.MenuVisible = true
end)

--==================================================
-- SETTINGS PAGE
--==================================================

AddSection("Settings", "General")

AddToggle("Settings", "Hub Enabled", "Enabled")
AddToggle("Settings", "Menu Visible", "MenuVisible")

AddButton("Settings", "Reset Settings", function()
    Settings.Enabled = true

    Settings.ESP = true
    Settings.BoxESP = true
    Settings.NameESP = true
    Settings.DistanceESP = true
    Settings.HealthESP = true
    Settings.HealthBar = true
    Settings.Tracer = false

    Settings.AimAssist = false
    Settings.TeamCheck = true
    Settings.WallCheck = true

    Settings.Crosshair = false

    Settings.WalkSpeed = 16
    Settings.JumpPower = 50
end)

--==================================================
-- MINIMIZE / OPEN BUTTON
--==================================================

local OpenButton = New("TextButton", {
    Name = "OpenButton",
    Size = UDim2.fromOffset(48, 48),
    Position = UDim2.new(0, 18, 0.5, -24),
    BackgroundColor3 = Colors.Accent,
    Text = "R",
    TextColor3 = Colors.White,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    Visible = false,
    AutoButtonColor = false
}, GUI)

Corner(OpenButton, 10)

OpenButton.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenButton.Visible = false
    Settings.MenuVisible = true
end)

CloseButton.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenButton.Visible = true
    Settings.MenuVisible = false
end)

--==================================================
-- DRAG
--==================================================

local dragging = false
local dragStart
local startPosition

Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

--==================================================
-- MOBILE / SCREEN SIZE
--==================================================

local function UpdateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end

    local viewport = camera.ViewportSize

    if viewport.X < 700 then
        Main.Size = UDim2.new(
            0.92,
            0,
            0,
            math.min(MENU_HEIGHT, viewport.Y - 40)
        )
    else
        Main.Size = UDim2.fromOffset(
            MENU_WIDTH,
            MENU_HEIGHT
        )
    end
end

if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
end

UpdateScale()

--==================================================
-- START UI FIRST
--==================================================

SelectCategory("Visual")

Main.Visible = true
GUI.Enabled = true
Settings.MenuVisible = true

print("[Rusted Compact v2.1] UI loaded")

--==================================================
-- PART 2 WILL START HERE
--==================================================

--==================================================
-- RUSTED COMPACT v2.1
-- PART 2 / 2
-- FEATURES
--==================================================

--==================================================
-- SERVICES
--==================================================

local Camera = workspace.CurrentCamera

--==================================================
-- FEATURE FOLDERS
--==================================================

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "ESP"
ESPFolder.Parent = GUI

local MiscFolder = Instance.new("Folder")
MiscFolder.Name = "Misc"
MiscFolder.Parent = GUI

--==================================================
-- ESP STORAGE
--==================================================

local ESPObjects = {}

local function ClearESP(player)
    local data = ESPObjects[player]

    if not data then
        return
    end

    for _, object in pairs(data) do
        pcall(function()
            object:Destroy()
        end)
    end

    ESPObjects[player] = nil
end

local function CreateESP(player)
    if player == LocalPlayer then
        return
    end

    if ESPObjects[player] then
        return
    end

    local box = New("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 1,
        BorderColor3 = Colors.Purple,
        Visible = false
    }, ESPFolder)

    local name = New("TextLabel", {
        BackgroundTransparency = 1,
        TextColor3 = Colors.White,
        TextStrokeTransparency = 0.4,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        Visible = false
    }, ESPFolder)

    local distance = New("TextLabel", {
        BackgroundTransparency = 1,
        TextColor3 = Colors.Gray,
        TextStrokeTransparency = 0.5,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        Visible = false
    }, ESPFolder)

    local healthBack = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Visible = false
    }, ESPFolder)

    local health = New("Frame", {
        BackgroundColor3 = Colors.Green,
        BorderSizePixel = 0,
        Visible = false
    }, healthBack)

    local tracer = New("Frame", {
        BackgroundColor3 = Colors.Purple,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Visible = false
    }, ESPFolder)

    ESPObjects[player] = {
        Box = box,
        Name = name,
        Distance = distance,
        HealthBack = healthBack,
        Health = health,
        Tracer = tracer
    }
end

local function HideESP(data)
    if not data then
        return
    end

    for _, object in pairs(data) do
        if object:IsA("GuiObject") then
            object.Visible = false
        end
    end
end

--==================================================
-- ESP UPDATE
--==================================================

local function UpdateESP(player, data)
    if not Settings.Enabled or not Settings.ESP then
        HideESP(data)
        return
    end

    local character = player.Character

    if not character then
        HideESP(data)
        return
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root or humanoid.Health <= 0 then
        HideESP(data)
        return
    end

    local position, visible = Camera:WorldToViewportPoint(root.Position)

    if not visible or position.Z <= 0 then
        HideESP(data)
        return
    end

    local distance = (Camera.CFrame.Position - root.Position).Magnitude

    if distance > Settings.MaxDistance then
        HideESP(data)
        return
    end

    -- approximate character size
    local scale = math.clamp(1800 / math.max(position.Z, 1), 18, 260)

    local width = scale * 0.55
    local height = scale

    local x = position.X - width / 2
    local y = position.Y - height / 2

    -- BOX
    if Settings.BoxESP then
        data.Box.Position = UDim2.fromOffset(x, y)
        data.Box.Size = UDim2.fromOffset(width, height)
        data.Box.BorderSizePixel = Settings.BoxThickness
        data.Box.Visible = true
    else
        data.Box.Visible = false
    end

    -- NAME
    if Settings.NameESP then
        data.Name.Text = player.Name
        data.Name.Position = UDim2.fromOffset(
            x,
            y - 20
        )
        data.Name.Size = UDim2.fromOffset(
            width,
            18
        )
        data.Name.Visible = true
    else
        data.Name.Visible = false
    end

    -- DISTANCE
    if Settings.DistanceESP then
        data.Distance.Text =
            string.format("[%dm]", math.floor(distance))

        data.Distance.Position = UDim2.fromOffset(
            x,
            y + height + 2
        )

        data.Distance.Size = UDim2.fromOffset(
            width,
            18
        )

        data.Distance.Visible = true
    else
        data.Distance.Visible = false
    end

    -- HEALTH
    if Settings.HealthBar and Settings.HealthESP then
        local healthPercent =
            math.clamp(
                humanoid.Health / humanoid.MaxHealth,
                0,
                1
            )

        data.HealthBack.Position = UDim2.fromOffset(
            x - 7,
            y
        )

        data.HealthBack.Size = UDim2.fromOffset(
            4,
            height
        )

        data.HealthBack.Visible = true

        data.Health.Size = UDim2.new(
            1,
            0,
            healthPercent,
            0
        )

        data.Health.Position = UDim2.new(
            0,
            0,
            1 - healthPercent,
            0
        )

        data.Health.BackgroundColor3 =
            healthPercent > 0.6
            and Colors.Green
            or healthPercent > 0.3
            and Colors.Yellow
            or Colors.Red
    else
        data.HealthBack.Visible = false
    end

    -- TRACER
    if Settings.Tracer then
        local start = Vector2.new(
            Camera.ViewportSize.X / 2,
            Camera.ViewportSize.Y
        )

        local finish = Vector2.new(
            position.X,
            position.Y
        )

        local delta = finish - start
        local length = delta.Magnitude

        data.Tracer.Position = UDim2.fromOffset(
            (start.X + finish.X) / 2,
            (start.Y + finish.Y) / 2
        )

        data.Tracer.Size = UDim2.fromOffset(
            length,
            Settings.TracerThickness
        )

        data.Tracer.Rotation =
            math.deg(math.atan2(delta.Y, delta.X))

        data.Tracer.Visible = true
    else
        data.Tracer.Visible = false
    end
end

--==================================================
-- PLAYER CONNECTIONS
--==================================================

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        CreateESP(player)

        player.CharacterRemoving:Connect(function()
            local data = ESPObjects[player]

            if data then
                HideESP(data)
            end
        end)
    end
end

Players.PlayerAdded:Connect(function(player)
    CreateESP(player)

    player.CharacterRemoving:Connect(function()
        local data = ESPObjects[player]

        if data then
            HideESP(data)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    ClearESP(player)
end)

--==================================================
-- ESP LOOP
--==================================================

RunService.RenderStepped:Connect(function()
    Camera = workspace.CurrentCamera or Camera

    for player, data in pairs(ESPObjects) do
        if player.Parent then
            UpdateESP(player, data)
        else
            ClearESP(player)
        end
    end
end)

--==================================================
-- AIM ASSIST
--==================================================

local function GetTarget()
    if not Settings.AimAssist then
        return nil
    end

    local closest
    local closestDistance = Settings.AimFOV

    local center = Vector2.new(
        Camera.ViewportSize.X / 2,
        Camera.ViewportSize.Y / 2
    )

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then

            if Settings.TeamCheck
                and LocalPlayer.Team
                and player.Team == LocalPlayer.Team then
                continue
            end

            local character = player.Character

            if character then
                local humanoid =
                    character:FindFirstChildOfClass("Humanoid")

                local targetPart =
                    character:FindFirstChild(Settings.AimTarget)

                if humanoid
                    and targetPart
                    and humanoid.Health > 0 then

                    local screen, visible =
                        Camera:WorldToViewportPoint(
                            targetPart.Position
                        )

                    if visible and screen.Z > 0 then
                        local distance =
                            (
                                Vector2.new(
                                    screen.X,
                                    screen.Y
                                ) - center
                            ).Magnitude

                        if distance < closestDistance then

                            local allowed = true

                            if Settings.WallCheck then
                                local params =
                                    RaycastParams.new()

                                params.FilterType =
                                    Enum.RaycastFilterType.Exclude

                                params.FilterDescendantsInstances = {
                                    LocalPlayer.Character,
                                    character
                                }

                                local result =
                                    workspace:Raycast(
                                        Camera.CFrame.Position,
                                        targetPart.Position
                                            - Camera.CFrame.Position,
                                        params
                                    )

                                if result then
                                    allowed = false
                                end
                            end

                            if allowed then
                                closestDistance = distance
                                closest = targetPart
                            end
                        end
                    end
                end
            end
        end
    end

    return closest
end

RunService.RenderStepped:Connect(function()
    if not Settings.Enabled then
        return
    end

    if not Settings.AimAssist then
        return
    end

    local target = GetTarget()

    if not target then
        return
    end

    local cameraPosition = Camera.CFrame.Position

    local desired =
        CFrame.lookAt(
            cameraPosition,
            target.Position
        )

    Camera.CFrame =
        Camera.CFrame:Lerp(
            desired,
            math.clamp(
                Settings.AimSmoothness,
                0.01,
                1
            )
        )
end)

--==================================================
-- CROSSHAIR
--==================================================

local Crosshair = New("Frame", {
    Size = UDim2.fromOffset(80, 80),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    BackgroundTransparency = 1,
    Visible = false
}, MiscFolder)

local CrosshairH = New("Frame", {
    Size = UDim2.fromOffset(24, 2),
    Position = UDim2.new(0.5, -12, 0.5, -1),
    BackgroundColor3 = Colors.White,
    BorderSizePixel = 0
}, Crosshair)

local CrosshairV = New("Frame", {
    Size = UDim2.fromOffset(2, 24),
    Position = UDim2.new(0.5, -1, 0.5, -12),
    BackgroundColor3 = Colors.White,
    BorderSizePixel = 0
}, Crosshair)

--==================================================
-- CROSSHAIR UPDATE
--==================================================

RunService.RenderStepped:Connect(function()
    Crosshair.Visible =
        Settings.Enabled
        and Settings.Crosshair
end)

--==================================================
-- MOVEMENT
--==================================================

local function ApplyMovement()
    local character = LocalPlayer.Character

    if not character then
        return
    end

    local humanoid =
        character:FindFirstChildOfClass("Humanoid")

    if not humanoid then
        return
    end

    if Settings.Enabled then
        humanoid.WalkSpeed = Settings.WalkSpeed
        humanoid.JumpPower = Settings.JumpPower
    else
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    ApplyMovement()
end)

RunService.Heartbeat:Connect(function()
    if Settings.Enabled then
        ApplyMovement()
    end
end)

--==================================================
-- MENU HOTKEY
--==================================================

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then
        return
    end

    if input.KeyCode == Enum.KeyCode.RightShift then

        if Main.Visible then
            Main.Visible = false
            OpenButton.Visible = true
            Settings.MenuVisible = false
        else
            Main.Visible = true
            OpenButton.Visible = false
            Settings.MenuVisible = true
        end
    end
end)

--==================================================
-- SAFE CLOSE
--==================================================

CloseButton.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenButton.Visible = true
    Settings.MenuVisible = false
end)

--==================================================
-- MINIMIZE
--==================================================

MinButton.MouseButton1Click:Connect(function()

    if Minimized then
        Main.Size = UDim2.fromOffset(
            MENU_WIDTH,
            MENU_HEIGHT
        )

        Sidebar.Visible = true
        Content.Visible = true

        Minimized = false
    else
        Main.Size = UDim2.fromOffset(
            MENU_WIDTH,
            62
        )

        Sidebar.Visible = false
        Content.Visible = false

        Minimized = true
    end
end)

--==================================================
-- DRAGGING
--==================================================

local Dragging = false
local DragStart
local StartPosition

TopBar.InputBegan:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

        input.Changed:Connect(function()

            if input.UserInputState ==
                Enum.UserInputState.End then

                Dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        local Delta =
            input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

--==================================================
-- BUTTON EFFECTS
--==================================================

MinButton.MouseEnter:Connect(function()
    Tween(MinButton, 0.12, {
        TextColor3 = Colors.PurpleLight
    })
end)

MinButton.MouseLeave:Connect(function()
    Tween(MinButton, 0.12, {
        TextColor3 = Colors.White
    })
end)

CloseButton.MouseEnter:Connect(function()
    Tween(CloseButton, 0.12, {
        TextColor3 = Colors.Red
    })
end)

CloseButton.MouseLeave:Connect(function()
    Tween(CloseButton, 0.12, {
        TextColor3 = Colors.White
    })
end)

--==================================================
-- SETTINGS SYNC
--==================================================

local function RefreshMovement()
    ApplyMovement()
end

task.spawn(function()
    while task.wait(1) do
        if Settings.Enabled then
            RefreshMovement()
        end
    end
end)

--==================================================
-- FINAL INIT
--==================================================

Main.Visible = true
GUI.Enabled = true
Settings.MenuVisible = true

SelectCategory("Visual")

print("================================")
print("Rusted Compact v2.1 loaded")
print("UI: OK")
print("ESP: OK")
print("Combat: OK")
print("Movement: OK")
print("Misc: OK")
print("================================")
