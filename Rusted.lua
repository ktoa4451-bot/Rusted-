--// 🌙 RUSTED ESP
--// Lunar Visual Menu

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local Settings = {
    ESP = true,
    BoxESP = true,
    NameESP = true,
    DistanceESP = true,
    Tracer = true
}

--==================================================
-- GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RustedLunar"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 520, 0, 430)
Main.Position = UDim2.new(0.5, -260, 0.5, -215)
Main.BackgroundColor3 = Color3.fromRGB(11, 9, 22)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 20)
Corner.Parent = Main

local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(155, 105, 235)
Border.Transparency = 0.2
Border.Thickness = 1.5
Border.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local Top = Instance.new("Frame")
Top.Parent = Main
Top.Position = UDim2.new(0, 2, 0, 2)
Top.Size = UDim2.new(1, -4, 0, 62)
Top.BackgroundColor3 = Color3.fromRGB(20, 16, 38)
Top.BorderSizePixel = 0

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 17)
TopCorner.Parent = Top

local Logo = Instance.new("TextLabel")
Logo.Parent = Top
Logo.BackgroundTransparency = 1
Logo.Position = UDim2.new(0, 16, 0, 8)
Logo.Size = UDim2.new(0, 42, 0, 42)
Logo.Text = "🌙"
Logo.TextSize = 27
Logo.Font = Enum.Font.GothamBold

local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 62, 0, 8)
Title.Size = UDim2.new(0, 180, 0, 27)
Title.Text = "LUNAR RUSTED"
Title.TextColor3 = Color3.fromRGB(245, 240, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local Version = Instance.new("TextLabel")
Version.Parent = Top
Version.BackgroundTransparency = 1
Version.Position = UDim2.new(0, 63, 0, 34)
Version.Size = UDim2.new(0, 100, 0, 18)
Version.Text = "v1.0 • Visual"
Version.TextColor3 = Color3.fromRGB(160, 150, 185)
Version.TextSize = 11
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left

--==================================================
-- CLOSE
--==================================================

local Close = Instance.new("TextButton")
Close.Parent = Top
Close.BackgroundTransparency = 1
Close.Position = UDim2.new(1, -43, 0, 14)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(245, 240, 255)
Close.TextSize = 25
Close.Font = Enum.Font.GothamBold

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Parent = Main
Sidebar.Position = UDim2.new(0, 2, 0, 64)
Sidebar.Size = UDim2.new(0, 145, 1, -66)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 12, 29)
Sidebar.BorderSizePixel = 0

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 17)
SideCorner.Parent = Sidebar

local VisualButton = Instance.new("TextButton")
VisualButton.Parent = Sidebar
VisualButton.Position = UDim2.new(0, 10, 0, 18)
VisualButton.Size = UDim2.new(1, -20, 0, 45)
VisualButton.BackgroundColor3 = Color3.fromRGB(27, 21, 48)
VisualButton.BorderSizePixel = 0
VisualButton.Text = "👁  Visual"
VisualButton.TextColor3 = Color3.fromRGB(245, 240, 255)
VisualButton.TextSize = 14
VisualButton.Font = Enum.Font.GothamBold
VisualButton.TextXAlignment = Enum.TextXAlignment.Left

local VisualCorner = Instance.new("UICorner")
VisualCorner.CornerRadius = UDim.new(0, 12)
VisualCorner.Parent = VisualButton

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Parent = Main
Content.Position = UDim2.new(0, 157, 0, 64)
Content.Size = UDim2.new(1, -159, 1, -66)
Content.BackgroundColor3 = Color3.fromRGB(16, 13, 30)
Content.BorderSizePixel = 0

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 17)
ContentCorner.Parent = Content

local Header = Instance.new("TextLabel")
Header.Parent = Content
Header.BackgroundTransparency = 1
Header.Position = UDim2.new(0, 20, 0, 18)
Header.Size = UDim2.new(1, -40, 0, 30)
Header.Text = "👁  Visual"
Header.TextColor3 = Color3.fromRGB(245, 240, 255)
Header.TextSize = 21
Header.Font = Enum.Font.GothamBold
Header.TextXAlignment = Enum.TextXAlignment.Left

--==================================================
-- TOGGLE FUNCTION
--==================================================

local function CreateToggle(text, y, setting)

    local Button = Instance.new("TextButton")
    Button.Parent = Content

    Button.Position = UDim2.new(
        0,
        18,
        0,
        y
    )

    Button.Size = UDim2.new(
        1,
        -36,
        0,
        48
    )

    Button.BackgroundColor3 =
        Color3.fromRGB(24, 20, 43)

    Button.BorderSizePixel = 0

    Button.Text = ""
    Button.AutoButtonColor = false

    local C = Instance.new("UICorner")
    C.CornerRadius = UDim.new(0, 12)
    C.Parent = Button

    local Label = Instance.new("TextLabel")
    Label.Parent = Button
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 14, 0, 0)
    Label.Size = UDim2.new(1, -85, 1, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(235, 230, 245)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Toggle = Instance.new("Frame")
    Toggle.Parent = Button
    Toggle.Position = UDim2.new(1, -55, 0.5, -11)
    Toggle.Size = UDim2.new(0, 40, 0, 22)
    Toggle.BorderSizePixel = 0

    local TC = Instance.new("UICorner")
    TC.CornerRadius = UDim.new(1, 0)
    TC.Parent = Toggle

    local Dot = Instance.new("Frame")
    Dot.Parent = Toggle
    Dot.Size = UDim2.new(0, 16, 0, 16)
    Dot.Position = UDim2.new(0, 3, 0.5, -8)
    Dot.BorderSizePixel = 0

    local DC = Instance.new("UICorner")
    DC.CornerRadius = UDim.new(1, 0)
    DC.Parent = Dot

    local function Update()

        if Settings[setting] then

            Toggle.BackgroundColor3 =
                Color3.fromRGB(145, 90, 225)

            Dot.BackgroundColor3 =
                Color3.fromRGB(255, 255, 255)

            Dot.Position =
                UDim2.new(1, -19, 0.5, -8)

        else

            Toggle.BackgroundColor3 =
                Color3.fromRGB(55, 48, 72)

            Dot.BackgroundColor3 =
                Color3.fromRGB(170, 160, 185)

            Dot.Position =
                UDim2.new(0, 3, 0.5, -8)

        end
    end

    Button.MouseButton1Click:Connect(function()
        Settings[setting] = not Settings[setting]
        Update()
    end)

    Update()

    return Button
end

--==================================================
-- VISUAL SETTINGS
--==================================================

CreateToggle(
    "ESP",
    62,
    "ESP"
)

CreateToggle(
    "Box ESP",
    118,
    "BoxESP"
)

CreateToggle(
    "Name ESP",
    174,
    "NameESP"
)

CreateToggle(
    "Distance ESP",
    230,
    "DistanceESP"
)

CreateToggle(
    "Tracer",
    286,
    "Tracer"
)

--==================================================
-- ESP SYSTEM
--==================================================

local ESPObjects = {}

local function RemoveESP(player)

    local data = ESPObjects[player]

    if not data then
        return
    end

    if data.Highlight then
        data.Highlight:Destroy()
    end

    if data.Billboard then
        data.Billboard:Destroy()
    end

    if data.Tracer then
        data.Tracer:Remove()
    end

    ESPObjects[player] = nil
end

local function CreateESP(player)

    if player == LocalPlayer then
        return
    end

    RemoveESP(player)

    local character = player.Character

    if not character then
        return
    end

    local root =
        character:FindFirstChild("HumanoidRootPart")

    if not root then
        return
    end

    -- Highlight / Box base
    local Highlight = Instance.new("Highlight")

    Highlight.Name = "RustedESP"
    Highlight.Adornee = character
    Highlight.DepthMode =
        Enum.HighlightDepthMode.AlwaysOnTop

    Highlight.FillColor =
        Color3.fromRGB(145, 90, 225)

    Highlight.OutlineColor =
        Color3.fromRGB(220, 180, 255)

    Highlight.FillTransparency = 0.82
    Highlight.OutlineTransparency = 0

    Highlight.Parent = game:GetService("CoreGui")

    -- Name + distance
    local Billboard = Instance.new("BillboardGui")

    Billboard.Name = "RustedInfo"
    Billboard.Adornee = root
    Billboard.Size = UDim2.new(0, 200, 0, 45)
    Billboard.StudsOffset = Vector3.new(0, 3.2, 0)
    Billboard.AlwaysOnTop = true
    Billboard.Parent = game:GetService("CoreGui")

    local Text = Instance.new("TextLabel")

    Text.Parent = Billboard
    Text.BackgroundTransparency = 1
    Text.Size = UDim2.new(1, 0, 1, 0)

    Text.Font = Enum.Font.GothamBold
    Text.TextSize = 13

    Text.TextColor3 =
        Color3.fromRGB(220, 190, 255)

    Text.TextStrokeTransparency = 0.2

    -- Tracer
    local Tracer = Drawing.new("Line")

    Tracer.Thickness = 1.5
    Tracer.Transparency = 1
    Tracer.Color =
        Color3.fromRGB(185, 130, 255)

    ESPObjects[player] = {
        Character = character,
        Highlight = Highlight,
        Billboard = Billboard,
        Text = Text,
        Tracer = Tracer
    }
end

--==================================================
-- PLAYER TRACKING
--==================================================

local function SetupPlayer(player)

    if player == LocalPlayer then
        return
    end

    if player.Character then
        task.defer(function()
            CreateESP(player)
        end)
    end

    player.CharacterAdded:Connect(function()
        task.wait(0.15)
        CreateESP(player)
    end)

    player.CharacterRemoving:Connect(function()
        RemoveESP(player)
    end)
end

for _, player in ipairs(
    Players:GetPlayers()
) do
    SetupPlayer(player)
end

Players.PlayerAdded:Connect(function(player)
    SetupPlayer(player)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

--==================================================
-- UPDATE ESP
--==================================================

local Camera = workspace.CurrentCamera

RunService.RenderStepped:Connect(function()

    for player, data in pairs(ESPObjects) do

        local character = player.Character

        local root =
            character
            and character:FindFirstChild(
                "HumanoidRootPart"
            )

        if not character or not root then
            continue
        end

        -- Main ESP
        data.Highlight.Enabled =
            Settings.ESP and Settings.BoxESP

        -- Name / Distance
        data.Billboard.Enabled =
            Settings.ESP and
            (Settings.NameESP or Settings.DistanceESP)

        if data.Billboard.Enabled then

            local text = ""

            if Settings.NameESP then
                text = player.DisplayName
            end

            if Settings.DistanceESP then

                local myCharacter =
                    LocalPlayer.Character

                local myRoot =
                    myCharacter
                    and myCharacter:FindFirstChild(
                        "HumanoidRootPart"
                    )

                if myRoot then

                    local distance =
                        math.floor(
                            (
                                myRoot.Position -
                                root.Position
                            ).Magnitude
                        )

                    if text ~= "" then
                        text = text ..
                            "\n[" ..
                            distance ..
                            " studs]"
                    else
                        text =
                            "[" ..
                            distance ..
                            " studs]"
                    end
                end
            end

            data.Text.Text = text
        end

        -- Tracer
        if Settings.ESP and Settings.Tracer then

            local position, visible =
                Camera:WorldToViewportPoint(
                    root.Position
                )

            if visible then

                data.Tracer.Visible = true

                data.Tracer.From =
                    Vector2.new(
                        Camera.ViewportSize.X / 2,
                        Camera.ViewportSize.Y
                    )

                data.Tracer.To =
                    Vector2.new(
                        position.X,
                        position.Y
                    )

            else
                data.Tracer.Visible = false
            end

        else
            data.Tracer.Visible = false
        end
    end
end)

--==================================================
-- CLOSE
--==================================================

Close.MouseButton1Click:Connect(function()

    for player in pairs(ESPObjects) do
        RemoveESP(player)
    end

    ScreenGui:Destroy()
end)

--==================================================
-- DRAG
--==================================================

local Dragging = false
local DragStart
local StartPosition

Top.InputBegan:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        if input.Position.X >
            Top.AbsolutePosition.X +
            Top.AbsoluteSize.X - 90 then
            return
        end

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)

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

UIS.InputEnded:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = false
    end
end)

print("🌙 Rusted Lunar Visual loaded!")
