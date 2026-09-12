--// RUSTED VISUAL HUB
--// Part 1/2

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

--==================================================
-- SETTINGS
--==================================================

local Settings = {
    ESP = true,
    Box = true,
    Name = false,
    Distance = false,
    Health = false,
    Tracer = false,
}

--==================================================
-- GUI
--==================================================

local OldGui = PlayerGui:FindFirstChild("RustedVisualHub")
if OldGui then
    OldGui:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "RustedVisualHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 100
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--==================================================
-- HELPERS
--==================================================

local function Corner(object, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = object
    return c
end

local function Stroke(object, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0
    s.Color = Color3.fromRGB(115, 75, 210)
    s.Parent = object
    return s
end

local function Text(parent, text, size, color)
    local t = Instance.new("TextLabel")
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextSize = size or 14
    t.Font = Enum.Font.Gotham
    t.TextColor3 = color or Color3.new(1,1,1)
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = parent
    return t
end

--==================================================
-- RESPONSIVE SIZE
--==================================================

local function UpdateSize()
    local viewport = Camera.ViewportSize
    local w = viewport.X
    local h = viewport.Y

    local menuW
    local menuH

    if w < 500 then
        -- Phone
        menuW = math.floor(w * 0.88)
        menuH = math.floor(h * 0.72)
    elseif w < 900 then
        -- Small tablet
        menuW = math.floor(w * 0.72)
        menuH = math.floor(h * 0.70)
    else
        -- PC / large tablet
        menuW = math.min(680, math.floor(w * 0.55))
        menuH = math.min(520, math.floor(h * 0.70))
    end

    menuW = math.max(menuW, 300)
    menuH = math.max(menuH, 300)

    Main.Size = UDim2.fromOffset(menuW, menuH)
    Main.Position = UDim2.new(0.5, -menuW / 2, 0.5, -menuH / 2)

    Sidebar.Size = UDim2.new(0, math.clamp(menuW * 0.23, 82, 155), 1, -58)

    Content.Position = UDim2.new(
        0,
        Sidebar.AbsoluteSize.X,
        0,
        58
    )

    Content.Size = UDim2.new(
        1,
        -Sidebar.AbsoluteSize.X,
        1,
        -58
    )
end

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(17, 14, 28)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

Corner(Main, 18)
Stroke(Main, 2, 0.05)

--==================================================
-- TOP BAR
--==================================================

local TopBar = Instance.new("Frame")
TopBar.BackgroundColor3 = Color3.fromRGB(23, 19, 38)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 58)
TopBar.Parent = Main

local Logo = Text(
    TopBar,
    "◈",
    25,
    Color3.fromRGB(170, 110, 255)
)
Logo.Position = UDim2.new(0, 15, 0, 15)
Logo.Size = UDim2.fromOffset(30, 30)
Logo.TextXAlignment = Enum.TextXAlignment.Center

local Title = Text(
    TopBar,
    "RUSTED",
    17,
    Color3.fromRGB(240, 235, 255)
)
Title.Position = UDim2.new(0, 48, 0, 9)
Title.Size = UDim2.new(0, 150, 0, 22)
Title.Font = Enum.Font.GothamBold

local Version = Text(
    TopBar,
    "VISUAL",
    10,
    Color3.fromRGB(145, 120, 180)
)
Version.Position = UDim2.new(0, 49, 0, 31)
Version.Size = UDim2.new(0, 100, 0, 16)

local Close = Instance.new("TextButton")
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextSize = 25
Close.Font = Enum.Font.GothamBold
Close.TextColor3 = Color3.fromRGB(220, 210, 235)
Close.Size = UDim2.fromOffset(42, 42)
Close.Position = UDim2.new(1, -45, 0, 8)
Close.Parent = TopBar

local Minimize = Instance.new("TextButton")
Minimize.BackgroundTransparency = 1
Minimize.Text = "−"
Minimize.TextSize = 23
Minimize.Font = Enum.Font.GothamBold
Minimize.TextColor3 = Color3.fromRGB(220, 210, 235)
Minimize.Size = UDim2.fromOffset(42, 42)
Minimize.Position = UDim2.new(1, -88, 0, 8)
Minimize.Parent = TopBar

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 16, 33)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 58)
Sidebar.Parent = Main

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 8)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 14)
SidePadding.PaddingLeft = UDim.new(0, 7)
SidePadding.PaddingRight = UDim.new(0, 7)
SidePadding.Parent = Sidebar

local VisualButton = Instance.new("TextButton")
VisualButton.Name = "VisualButton"
VisualButton.LayoutOrder = 1
VisualButton.Size = UDim2.new(1, 0, 0, 43)
VisualButton.BackgroundColor3 = Color3.fromRGB(86, 55, 145)
VisualButton.BorderSizePixel = 0
VisualButton.Text = "👁  Visual"
VisualButton.TextSize = 13
VisualButton.Font = Enum.Font.GothamBold
VisualButton.TextColor3 = Color3.fromRGB(255,255,255)
VisualButton.Parent = Sidebar

Corner(VisualButton, 9)

local UpdatesButton = Instance.new("TextButton")
UpdatesButton.Name = "UpdatesButton"
UpdatesButton.LayoutOrder = 2
UpdatesButton.Size = UDim2.new(1, 0, 0, 43)
UpdatesButton.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
UpdatesButton.BorderSizePixel = 0
UpdatesButton.Text = "🔄  Updates"
UpdatesButton.TextSize = 13
UpdatesButton.Font = Enum.Font.Gotham
UpdatesButton.TextColor3 = Color3.fromRGB(190,180,205)
UpdatesButton.Parent = Sidebar

Corner(UpdatesButton, 9)

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.BackgroundTransparency = 1
Content.Parent = Main

local VisualPage = Instance.new("ScrollingFrame")
VisualPage.Name = "VisualPage"
VisualPage.BackgroundTransparency = 1
VisualPage.BorderSizePixel = 0
VisualPage.ScrollBarThickness = 3
VisualPage.ScrollBarImageColor3 = Color3.fromRGB(105,70,170)
VisualPage.CanvasSize = UDim2.new(0,0,0,0)
VisualPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
VisualPage.Parent = Content

local VisualPadding = Instance.new("UIPadding")
VisualPadding.PaddingTop = UDim.new(0, 15)
VisualPadding.PaddingBottom = UDim.new(0, 15)
VisualPadding.PaddingLeft = UDim.new(0, 15)
VisualPadding.PaddingRight = UDim.new(0, 15)
VisualPadding.Parent = VisualPage

local VisualLayout = Instance.new("UIListLayout")
VisualLayout.Padding = UDim.new(0, 8)
VisualLayout.SortOrder = Enum.SortOrder.LayoutOrder
VisualLayout.Parent = VisualPage

local Header = Text(
    VisualPage,
    "Visual Settings",
    19,
    Color3.fromRGB(240,235,255)
)
Header.Size = UDim2.new(1,0,0,30)
Header.Font = Enum.Font.GothamBold
Header.LayoutOrder = 1

local Description = Text(
    VisualPage,
    "Configure player ESP",
    12,
    Color3.fromRGB(145,135,160)
)
Description.Size = UDim2.new(1,0,0,24)
Description.LayoutOrder = 2

--==================================================
-- TOGGLE CREATOR
--==================================================

local Toggles = {}

local function CreateToggle(name, description, key, order)
    local Button = Instance.new("TextButton")
    Button.Name = key
    Button.LayoutOrder = order
    Button.Size = UDim2.new(1,0,0,58)
    Button.BackgroundColor3 = Color3.fromRGB(27,23,41)
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = VisualPage

    Corner(Button, 10)

    local NameLabel = Text(
        Button,
        name,
        14,
        Color3.fromRGB(235,230,245)
    )
    NameLabel.Position = UDim2.new(0,14,0,8)
    NameLabel.Size = UDim2.new(1,-75,0,20)
    NameLabel.Font = Enum.Font.GothamMedium

    local DescLabel = Text(
        Button,
        description,
        10,
        Color3.fromRGB(135,125,150)
    )
    DescLabel.Position = UDim2.new(0,14,0,29)
    DescLabel.Size = UDim2.new(1,-75,0,18)

    local Switch = Instance.new("Frame")
    Switch.Size = UDim2.fromOffset(42,22)
    Switch.Position = UDim2.new(1,-56,0.5,-11)
    Switch.BorderSizePixel = 0
    Switch.Parent = Button

    Corner(Switch,11)

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.fromOffset(16,16)
    Circle.Position = UDim2.new(0,3,0.5,-8)
    Circle.BorderSizePixel = 0
    Circle.Parent = Switch

    Corner(Circle,8)

    local function Refresh()
        if Settings[key] then
            Switch.BackgroundColor3 = Color3.fromRGB(105,65,175)
            Circle.BackgroundColor3 = Color3.fromRGB(255,255,255)
            Circle.Position = UDim2.new(1,-19,0.5,-8)
        else
            Switch.BackgroundColor3 = Color3.fromRGB(55,48,65)
            Circle.BackgroundColor3 = Color3.fromRGB(170,165,180)
            Circle.Position = UDim2.new(0,3,0.5,-8)
        end
    end

    Button.MouseButton1Click:Connect(function()
        Settings[key] = not Settings[key]
        Refresh()
    end)

    Toggles[key] = Refresh
    Refresh()
end

CreateToggle("ESP", "Enable player ESP", "ESP", 3)
CreateToggle("Box", "Rectangle around players", "Box", 4)
CreateToggle("Name", "Show player name", "Name", 5)
CreateToggle("Distance", "Show distance", "Distance", 6)
CreateToggle("Health", "Show HP and health bar", "Health", 7)
CreateToggle("Tracer", "Line from screen bottom", "Tracer", 8)

--==================================================
-- UPDATE LAYOUT
--==================================================

local function UpdateContent()
    VisualPage.Size = UDim2.new(1,0,1,0)
end

UpdateSize()
UpdateContent()

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    task.wait()
    UpdateSize()
    UpdateContent()
end)

print("[Rusted Visual] Menu loaded")

--// RUSTED VISUAL HUB
--// Part 2/2

--==================================================
-- ESP GUI
--==================================================

local ESPGui = Instance.new("ScreenGui")
ESPGui.Name = "RustedESP"
ESPGui.ResetOnSpawn = false
ESPGui.IgnoreGuiInset = true
ESPGui.DisplayOrder = 1
ESPGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ESPGui.Parent = PlayerGui

local ESPObjects = {}

--==================================================
-- LINE
--==================================================

local function MakeLine()
    local line = Instance.new("Frame")
    line.BorderSizePixel = 0
    line.BackgroundColor3 = Color3.fromRGB(170,100,255)
    line.AnchorPoint = Vector2.new(0.5,0.5)
    line.Visible = false
    line.ZIndex = 2
    line.Parent = ESPGui
    return line
end

local function SetLine(line, a, b, thickness)
    local dx = b.X - a.X
    local dy = b.Y - a.Y
    local length = math.sqrt(dx * dx + dy * dy)

    line.Size = UDim2.fromOffset(length, thickness or 2)
    line.Position = UDim2.fromOffset(
        (a.X + b.X) / 2,
        (a.Y + b.Y) / 2
    )

    line.Rotation = math.deg(math.atan2(dy, dx))
    line.Visible = true
end

--==================================================
-- PLAYER ESP
--==================================================

local function CreateESP(player)
    if player == LocalPlayer then
        return
    end

    if ESPObjects[player] then
        return
    end

    local data = {}

    data.Top = MakeLine()
    data.Bottom = MakeLine()
    data.Left = MakeLine()
    data.Right = MakeLine()

    data.Tracer = MakeLine()

    data.Name = Instance.new("TextLabel")
    data.Name.BackgroundTransparency = 1
    data.Name.TextColor3 = Color3.fromRGB(255,255,255)
    data.Name.TextStrokeTransparency = 0.4
    data.Name.Font = Enum.Font.GothamBold
    data.Name.TextSize = 13
    data.Name.TextXAlignment = Enum.TextXAlignment.Center
    data.Name.Visible = false
    data.Name.ZIndex = 3
    data.Name.Parent = ESPGui

    data.Distance = Instance.new("TextLabel")
    data.Distance.BackgroundTransparency = 1
    data.Distance.TextColor3 = Color3.fromRGB(190,160,255)
    data.Distance.TextStrokeTransparency = 0.4
    data.Distance.Font = Enum.Font.Gotham
    data.Distance.TextSize = 11
    data.Distance.TextXAlignment = Enum.TextXAlignment.Center
    data.Distance.Visible = false
    data.Distance.ZIndex = 3
    data.Distance.Parent = ESPGui

    data.Health = Instance.new("TextLabel")
    data.Health.BackgroundTransparency = 1
    data.Health.TextColor3 = Color3.fromRGB(100,255,120)
    data.Health.TextStrokeTransparency = 0.4
    data.Health.Font = Enum.Font.GothamBold
    data.Health.TextSize = 11
    data.Health.TextXAlignment = Enum.TextXAlignment.Center
    data.Health.Visible = false
    data.Health.ZIndex = 3
    data.Health.Parent = ESPGui

    data.HealthBack = Instance.new("Frame")
    data.HealthBack.BackgroundColor3 = Color3.fromRGB(35,35,35)
    data.HealthBack.BorderSizePixel = 0
    data.HealthBack.Visible = false
    data.HealthBack.ZIndex = 2
    data.HealthBack.Parent = ESPGui

    data.HealthFill = Instance.new("Frame")
    data.HealthFill.BackgroundColor3 = Color3.fromRGB(80,220,100)
    data.HealthFill.BorderSizePixel = 0
    data.HealthFill.Parent = data.HealthBack

    ESPObjects[player] = data
end

local function HideObject(object)
    if not object then
        return
    end

    object.Top.Visible = false
    object.Bottom.Visible = false
    object.Left.Visible = false
    object.Right.Visible = false

    object.Tracer.Visible = false

    object.Name.Visible = false
    object.Distance.Visible = false
    object.Health.Visible = false

    object.HealthBack.Visible = false
end

--==================================================
-- REMOVE ESP
--==================================================

local function RemoveESP(player)
    local object = ESPObjects[player]

    if not object then
        return
    end

    for _, value in pairs(object) do
        if typeof(value) == "Instance" then
            value:Destroy()
        end
    end

    ESPObjects[player] = nil
end

--==================================================
-- GET SCREEN BOUNDS
--==================================================

local function GetBounds(character)
    local cf, size = character:GetBoundingBox()

    local corners = {
        Vector3.new(-size.X/2,-size.Y/2,-size.Z/2),
        Vector3.new(-size.X/2,-size.Y/2,size.Z/2),
        Vector3.new(-size.X/2,size.Y/2,-size.Z/2),
        Vector3.new(-size.X/2,size.Y/2,size.Z/2),
        Vector3.new(size.X/2,-size.Y/2,-size.Z/2),
        Vector3.new(size.X/2,-size.Y/2,size.Z/2),
        Vector3.new(size.X/2,size.Y/2,-size.Z/2),
        Vector3.new(size.X/2,size.Y/2,size.Z/2),
    }

    local minX = math.huge
    local minY = math.huge
    local maxX = -math.huge
    local maxY = -math.huge

    local visible = false

    for _, corner in ipairs(corners) do
        local world = cf:PointToWorldSpace(corner)
        local screen, onScreen = Camera:WorldToViewportPoint(world)

        if screen.Z > 0 then
            visible = true

            minX = math.min(minX, screen.X)
            minY = math.min(minY, screen.Y)
            maxX = math.max(maxX, screen.X)
            maxY = math.max(maxY, screen.Y)
        end
    end

    if not visible then
        return nil
    end

    return minX, minY, maxX, maxY
end

--==================================================
-- UPDATE ESP
--==================================================

local function UpdatePlayerESP(player, object)
    if not Settings.ESP then
        HideObject(object)
        return
    end

    local character = player.Character

    if not character then
        HideObject(object)
        return
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root or humanoid.Health <= 0 then
        HideObject(object)
        return
    end

    local minX, minY, maxX, maxY = GetBounds(character)

    if not minX then
        HideObject(object)
        return
    end

    local width = maxX - minX
    local height = maxY - minY

    -- BOX
    if Settings.Box then
        SetLine(
            object.Top,
            Vector2.new(minX,minY),
            Vector2.new(maxX,minY),
            2
        )

        SetLine(
            object.Bottom,
            Vector2.new(minX,maxY),
            Vector2.new(maxX,maxY),
            2
        )

        SetLine(
            object.Left,
            Vector2.new(minX,minY),
            Vector2.new(minX,maxY),
            2
        )

        SetLine(
            object.Right,
            Vector2.new(maxX,minY),
            Vector2.new(maxX,maxY),
            2
        )
    else
        object.Top.Visible = false
        object.Bottom.Visible = false
        object.Left.Visible = false
        object.Right.Visible = false
    end

    -- NAME
    if Settings.Name then
        object.Name.Text = player.DisplayName

        object.Name.Size = UDim2.fromOffset(
            math.max(width,80),
            20
        )

        object.Name.Position = UDim2.fromOffset(
            (minX + maxX)/2 - math.max(width,80)/2,
            minY - 22
        )

        object.Name.Visible = true
    else
        object.Name.Visible = false
    end

    -- DISTANCE
    if Settings.Distance then
        local distance = (Camera.CFrame.Position - root.Position).Magnitude

        object.Distance.Text = math.floor(distance) .. " studs"

        object.Distance.Size = UDim2.fromOffset(
            math.max(width,80),
            18
        )

        object.Distance.Position = UDim2.fromOffset(
            (minX + maxX)/2 - math.max(width,80)/2,
            maxY + 2
        )

        object.Distance.Visible = true
    else
        object.Distance.Visible = false
    end

    -- HEALTH
    if Settings.Health then
        local hp = math.max(0, humanoid.Health)
        local maxHP = math.max(1, humanoid.MaxHealth)
        local percent = math.clamp(hp / maxHP, 0, 1)

        object.Health.Text =
            math.floor(hp) .. " / " .. math.floor(maxHP)

        object.Health.Size = UDim2.fromOffset(
            80,
            18
        )

        object.Health.Position = UDim2.fromOffset(
            minX - 85,
            minY
        )

        object.Health.Visible = true

        object.HealthBack.Size = UDim2.fromOffset(
            5,
            height
        )

        object.HealthBack.Position = UDim2.fromOffset(
            minX - 9,
            minY
        )

        object.HealthBack.Visible = true

        object.HealthFill.Size = UDim2.new(
            1,
            0,
            percent,
            0
        )

        object.HealthFill.Position = UDim2.new(
            0,
            0,
            1 - percent,
            0
        )

        if percent > 0.6 then
            object.HealthFill.BackgroundColor3 =
                Color3.fromRGB(80,220,100)
        elseif percent > 0.3 then
            object.HealthFill.BackgroundColor3 =
                Color3.fromRGB(255,190,60)
        else
            object.HealthFill.BackgroundColor3 =
                Color3.fromRGB(255,70,70)
        end
    else
        object.Health.Visible = false
        object.HealthBack.Visible = false
    end

    -- TRACER
    if Settings.Tracer then
        local screen = Camera.ViewportSize

        SetLine(
            object.Tracer,
            Vector2.new(screen.X / 2, screen.Y),
            Vector2.new((minX + maxX)/2, maxY),
            1.5
        )
    else
        object.Tracer.Visible = false
    end
end

--==================================================
-- PLAYER CONNECTIONS
--==================================================

for _, player in ipairs(Players:GetPlayers()) do
    CreateESP(player)
end

Players.PlayerAdded:Connect(function(player)
    CreateESP(player)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

--==================================================
-- RENDER LOOP
--==================================================

RunService.RenderStepped:Connect(function()
    for player, object in pairs(ESPObjects) do
        if player.Parent == Players then
            UpdatePlayerESP(player, object)
        else
            RemoveESP(player)
        end
    end
end)

--==================================================
-- MINIMIZE
--==================================================

local minimized = false
local savedSize = Main.Size
local savedPosition = Main.Position

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized

    if minimized then
        savedSize = Main.Size
        savedPosition = Main.Position

        Sidebar.Visible = false
        Content.Visible = false

        Main.Size = UDim2.fromOffset(
            math.min(300, Camera.ViewportSize.X * 0.7),
            58
        )

        Main.Position = UDim2.new(
            0.5,
            -Main.AbsoluteSize.X / 2,
            0,
            10
        )
    else
        Sidebar.Visible = true
        Content.Visible = true

        UpdateSize()
    end
end)

--==================================================
-- CLOSE
--==================================================

Close.MouseButton1Click:Connect(function()
    Gui.Enabled = false

    -- ESP остаётся работать.
end)

--==================================================
-- DRAG
--==================================================

local dragging = false
local dragStart
local startPosition

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        if input.Position.X > Close.AbsolutePosition.X - 10 then
            return
        end

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
    if not dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local delta = input.Position - dragStart

    Main.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end)

--==================================================
-- REOPEN MENU
--==================================================

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenRustedMenu"
OpenButton.Size = UDim2.fromOffset(45,45)
OpenButton.Position = UDim2.new(0,15,0.5,-22)
OpenButton.BackgroundColor3 = Color3.fromRGB(25,20,40)
OpenButton.BorderSizePixel = 0
OpenButton.Text = "◈"
OpenButton.TextSize = 20
OpenButton.TextColor3 = Color3.fromRGB(180,110,255)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.Parent = Gui

Corner(OpenButton,12)
Stroke(OpenButton,1,0.1)

Close.MouseButton1Click:Connect(function()
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    Gui.Enabled = true
    OpenButton.Visible = false
    UpdateSize()
end)

--==================================================
-- START
--==================================================

Gui.Enabled = true
UpdateSize()

print("[Rusted Visual] ESP + Menu started")
