--// RUSTED HUB v2.2
--// PART 1/4 - CORE

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--// Settings
local Settings = {
    ESP = true,
    BoxESP = true,
    NameESP = true,
    DistanceESP = true,
    HealthESP = true,
    Tracer = true,

    AimAssist = false,
    TeamCheck = true,
    WallCheck = true,

    Crosshair = false,
    WalkSpeed = 16,
    JumpPower = 50
}

--// Theme
local C = {
    BG = Color3.fromRGB(7,7,18),
    Side = Color3.fromRGB(10,9,24),
    Card = Color3.fromRGB(16,14,35),
    Hover = Color3.fromRGB(27,20,55),

    Purple = Color3.fromRGB(135,55,255),
    Purple2 = Color3.fromRGB(180,125,255),

    White = Color3.fromRGB(240,235,255),
    Gray = Color3.fromRGB(145,135,180),
    Red = Color3.fromRGB(235,75,90)
}

--// Cleanup
local Old = PlayerGui:FindFirstChild("RustedHub")
if Old then
    Old:Destroy()
end

--// Helpers
local function Corner(obj, size)
    local x = Instance.new("UICorner")
    x.CornerRadius = UDim.new(0,size or 10)
    x.Parent = obj
end

local function Stroke(obj, color)
    local x = Instance.new("UIStroke")
    x.Color = color or C.Purple
    x.Transparency = .45
    x.Thickness = 1
    x.Parent = obj
end

local function Tween(obj, props, time)
    TweenService:Create(
        obj,
        TweenInfo.new(
            time or .15,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        props
    ):Play()
end

--// ScreenGui
local GUI = Instance.new("ScreenGui")
GUI.Name = "RustedHub"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.Parent = PlayerGui

--// Main
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = GUI
Main.Size = UDim2.fromOffset(900,560)
Main.Position = UDim2.new(.5,-450,.5,-280)
Main.BackgroundColor3 = C.BG
Main.BorderSizePixel = 0
Main.Visible = true

Corner(Main,18)
Stroke(Main,C.Purple)

--// TopBar
local Top = Instance.new("Frame")
Top.Parent = Main
Top.Size = UDim2.new(1,0,0,82)
Top.BackgroundColor3 = C.Side
Top.BorderSizePixel = 0

--// Logo
local Logo = Instance.new("TextLabel")
Logo.Parent = Top
Logo.Position = UDim2.fromOffset(20,15)
Logo.Size = UDim2.fromOffset(55,55)
Logo.BackgroundColor3 = Color3.fromRGB(45,20,90)
Logo.Text = "◇"
Logo.TextColor3 = C.Purple2
Logo.TextSize = 32
Logo.Font = Enum.Font.GothamBold

Corner(Logo,15)

--// Title
local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.Position = UDim2.fromOffset(88,13)
Title.Size = UDim2.fromOffset(250,32)
Title.BackgroundTransparency = 1
Title.Text = "RUSTED"
Title.TextColor3 = C.White
Title.TextSize = 25
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local Sub = Instance.new("TextLabel")
Sub.Parent = Top
Sub.Position = UDim2.fromOffset(90,43)
Sub.Size = UDim2.fromOffset(250,20)
Sub.BackgroundTransparency = 1
Sub.Text = "PRIVATE • BEST • SAFE"
Sub.TextColor3 = C.Gray
Sub.TextSize = 10
Sub.Font = Enum.Font.GothamMedium
Sub.TextXAlignment = Enum.TextXAlignment.Left

--// Minimize
local Min = Instance.new("TextButton")
Min.Parent = Top
Min.Position = UDim2.new(1,-90,0,20)
Min.Size = UDim2.fromOffset(35,35)
Min.BackgroundTransparency = 1
Min.Text = "−"
Min.TextColor3 = C.White
Min.TextSize = 25
Min.Font = Enum.Font.GothamBold
Min.AutoButtonColor = false

--// Close
local Close = Instance.new("TextButton")
Close.Parent = Top
Close.Position = UDim2.new(1,-48,0,20)
Close.Size = UDim2.fromOffset(35,35)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = C.White
Close.TextSize = 27
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false

--// Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Parent = Main
Sidebar.Position = UDim2.fromOffset(0,82)
Sidebar.Size = UDim2.new(0,190,1,-82)
Sidebar.BackgroundColor3 = C.Side
Sidebar.BorderSizePixel = 0

--// Sidebar title
local MenuTitle = Instance.new("TextLabel")
MenuTitle.Parent = Sidebar
MenuTitle.Position = UDim2.fromOffset(20,15)
MenuTitle.Size = UDim2.fromOffset(140,25)
MenuTitle.BackgroundTransparency = 1
MenuTitle.Text = "MENU"
MenuTitle.TextColor3 = C.Gray
MenuTitle.TextSize = 10
MenuTitle.Font = Enum.Font.GothamBold
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left

--// Content
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Position = UDim2.fromOffset(190,82)
Content.Size = UDim2.new(1,-190,1,-82)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0

--// Page title
local PageTitle = Instance.new("TextLabel")
PageTitle.Parent = Content
PageTitle.Position = UDim2.fromOffset(25,18)
PageTitle.Size = UDim2.fromOffset(350,35)
PageTitle.BackgroundTransparency = 1
PageTitle.Text = "Visual"
PageTitle.TextColor3 = C.White
PageTitle.TextSize = 24
PageTitle.Font = Enum.Font.GothamBold
PageTitle.TextXAlignment = Enum.TextXAlignment.Left

local PageSub = Instance.new("TextLabel")
PageSub.Parent = Content
PageSub.Position = UDim2.fromOffset(25,50)
PageSub.Size = UDim2.fromOffset(400,22)
PageSub.BackgroundTransparency = 1
PageSub.Text = "Настройки визуальных функций"
PageSub.TextColor3 = C.Gray
PageSub.TextSize = 12
PageSub.Font = Enum.Font.Gotham
PageSub.TextXAlignment = Enum.TextXAlignment.Left

--// Pages
local Pages = {}

for _,name in ipairs({
    "Visual",
    "Combat",
    "Movement",
    "Misc",
    "Settings"
}) do

    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Parent = Content
    Page.Position = UDim2.fromOffset(20,82)
    Page.Size = UDim2.new(1,-40,1,-95)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = C.Purple
    Page.Visible = false
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new()

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0,8)

    Pages[name] = Page
end

print("[Rusted] Part 1 loaded")

--// RUSTED HUB v2.2
--// PART 2/4 - SIDEBAR + PAGES

--// Category buttons
local Categories = {
    {Name = "Visual",   Icon = "◉"},
    {Name = "Combat",   Icon = "⌁"},
    {Name = "Movement", Icon = "↗"},
    {Name = "Misc",     Icon = "◆"},
    {Name = "Settings", Icon = "⚙"}
}

local Buttons = {}

local function SelectPage(Name)
    -- pages
    for PageName, Page in pairs(Pages) do
        Page.Visible = (PageName == Name)
    end

    -- button colors
    for ButtonName, Button in pairs(Buttons) do
        local Selected = ButtonName == Name

        if Selected then
            Button.BackgroundColor3 = C.Hover
        else
            Button.BackgroundColor3 = C.Side
        end

        local Icon = Button:FindFirstChild("Icon")
        local Label = Button:FindFirstChild("Label")

        if Icon then
            Icon.TextColor3 = Selected and C.Purple2 or C.Gray
        end

        if Label then
            Label.TextColor3 = Selected and C.White or C.Gray
        end
    end

    PageTitle.Text = Name

    local Descriptions = {
        Visual = "Настройки визуальных функций",
        Combat = "Настройки боевых функций",
        Movement = "Настройки движения",
        Misc = "Дополнительные функции",
        Settings = "Настройки Rusted Hub"
    }

    PageSub.Text = Descriptions[Name] or ""

    print("[Rusted] Page:", Name)
end

--// Create buttons
for i,Data in ipairs(Categories) do

    local Button = Instance.new("TextButton")
    Button.Name = Data.Name
    Button.Parent = Sidebar
    Button.Position = UDim2.fromOffset(12,45 + ((i-1) * 52))
    Button.Size = UDim2.new(1,-24,0,44)
    Button.BackgroundColor3 = C.Side
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false

    Corner(Button,10)

    local Icon = Instance.new("TextLabel")
    Icon.Name = "Icon"
    Icon.Parent = Button
    Icon.Position = UDim2.fromOffset(13,0)
    Icon.Size = UDim2.fromOffset(25,44)
    Icon.BackgroundTransparency = 1
    Icon.Text = Data.Icon
    Icon.TextColor3 = C.Gray
    Icon.TextSize = 17
    Icon.Font = Enum.Font.GothamBold

    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Parent = Button
    Label.Position = UDim2.fromOffset(48,0)
    Label.Size = UDim2.new(1,-55,1,0)
    Label.BackgroundTransparency = 1
    Label.Text = Data.Name
    Label.TextColor3 = C.Gray
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left

    Buttons[Data.Name] = Button

    -- hover
    Button.MouseEnter:Connect(function()
        if PageTitle.Text ~= Data.Name then
            Tween(Button,{
                BackgroundColor3 = C.Hover
            },.12)
        end
    end)

    Button.MouseLeave:Connect(function()
        if PageTitle.Text ~= Data.Name then
            Tween(Button,{
                BackgroundColor3 = C.Side
            },.12)
        end
    end)

    Button.MouseButton1Click:Connect(function()
        SelectPage(Data.Name)
    end)
end

--// Sidebar separator
local Separator = Instance.new("Frame")
Separator.Parent = Sidebar
Separator.Position = UDim2.fromOffset(20,315)
Separator.Size = UDim2.new(1,-40,0,1)
Separator.BackgroundColor3 = C.Purple
Separator.BackgroundTransparency = .75
Separator.BorderSizePixel = 0

--// Status
local Status = Instance.new("TextLabel")
Status.Parent = Sidebar
Status.Position = UDim2.new(0,20,1,-45)
Status.Size = UDim2.new(1,-40,0,25)
Status.BackgroundTransparency = 1
Status.Text = "●  RUSTED ONLINE"
Status.TextColor3 = C.Purple2
Status.TextSize = 10
Status.Font = Enum.Font.GothamBold
Status.TextXAlignment = Enum.TextXAlignment.Left

--// Select default page
SelectPage("Visual")

print("[Rusted] Part 2 loaded")

--// RUSTED HUB v2.2
--// PART 3/4 - CONTROLS

local function Toggle(Page, Name, Default, Callback)

    local Row = Instance.new("Frame")
    Row.Parent = Page
    Row.Size = UDim2.new(1,0,0,52)
    Row.BackgroundColor3 = C.Card
    Row.BorderSizePixel = 0

    Corner(Row,10)
    Stroke(Row,Color3.fromRGB(55,35,90))

    local Text = Instance.new("TextLabel")
    Text.Parent = Row
    Text.Position = UDim2.fromOffset(15,0)
    Text.Size = UDim2.new(1,-80,1,0)
    Text.BackgroundTransparency = 1
    Text.Text = Name
    Text.TextColor3 = C.White
    Text.TextSize = 13
    Text.Font = Enum.Font.GothamMedium
    Text.TextXAlignment = Enum.TextXAlignment.Left

    local Switch = Instance.new("TextButton")
    Switch.Parent = Row
    Switch.Position = UDim2.new(1,-60,.5,-13)
    Switch.Size = UDim2.fromOffset(45,26)
    Switch.Text = ""
    Switch.AutoButtonColor = false
    Switch.BorderSizePixel = 0

    Corner(Switch,13)

    local Dot = Instance.new("Frame")
    Dot.Parent = Switch
    Dot.Size = UDim2.fromOffset(20,20)
    Dot.Position = UDim2.fromOffset(3,3)
    Dot.BorderSizePixel = 0

    Corner(Dot,10)

    local Value = Default

    local function Update()

        if Value then
            Switch.BackgroundColor3 = C.Purple
            Dot.BackgroundColor3 = C.White

            Tween(Dot,{
                Position = UDim2.new(1,-23,0,3)
            },.12)
        else
            Switch.BackgroundColor3 = Color3.fromRGB(45,40,60)
            Dot.BackgroundColor3 = C.Gray

            Tween(Dot,{
                Position = UDim2.fromOffset(3,3)
            },.12)
        end

        if Callback then
            Callback(Value)
        end
    end

    Switch.MouseButton1Click:Connect(function()
        Value = not Value
        Update()
    end)

    Update()

    return function()
        return Value
    end
end

--// VISUAL
local Visual = Pages.Visual

Toggle(
    Visual,
    "ESP",
    Settings.ESP,
    function(v)
        Settings.ESP = v
    end
)

Toggle(
    Visual,
    "Box ESP",
    Settings.BoxESP,
    function(v)
        Settings.BoxESP = v
    end
)

Toggle(
    Visual,
    "Name ESP",
    Settings.NameESP,
    function(v)
        Settings.NameESP = v
    end
)

Toggle(
    Visual,
    "Distance ESP",
    Settings.DistanceESP,
    function(v)
        Settings.DistanceESP = v
    end
)

Toggle(
    Visual,
    "Health ESP",
    Settings.HealthESP,
    function(v)
        Settings.HealthESP = v
    end
)

Toggle(
    Visual,
    "Tracer ESP",
    Settings.Tracer,
    function(v)
        Settings.Tracer = v
    end
)

--// COMBAT
local Combat = Pages.Combat

Toggle(
    Combat,
    "Aim Assist",
    Settings.AimAssist,
    function(v)
        Settings.AimAssist = v
    end
)

Toggle(
    Combat,
    "Team Check",
    Settings.TeamCheck,
    function(v)
        Settings.TeamCheck = v
    end
)

Toggle(
    Combat,
    "Wall Check",
    Settings.WallCheck,
    function(v)
        Settings.WallCheck = v
    end
)

--// MOVEMENT
local Movement = Pages.Movement

Toggle(
    Movement,
    "Speed",
    false,
    function(v)
        if v then
            Settings.WalkSpeed = 24
        else
            Settings.WalkSpeed = 16
        end
    end
)

Toggle(
    Movement,
    "High Jump",
    false,
    function(v)
        if v then
            Settings.JumpPower = 75
        else
            Settings.JumpPower = 50
        end
    end
)

--// MISC
local Misc = Pages.Misc

Toggle(
    Misc,
    "Crosshair",
    Settings.Crosshair,
    function(v)
        Settings.Crosshair = v
    end
)

--// SETTINGS
local SetPage = Pages.Settings

Toggle(
    SetPage,
    "Enable ESP",
    Settings.ESP,
    function(v)
        Settings.ESP = v
    end
)

print("[Rusted] Part 3 loaded")

--// RUSTED HUB v2.2
--// PART 4/4 - FINAL

--// Minimize
local Minimized = false

Min.MouseButton1Click:Connect(function()

    Minimized = not Minimized

    if Minimized then
        Min.Text = "+"
        Sidebar.Visible = false
        Content.Visible = false

        Tween(Main,{
            Size = UDim2.fromOffset(900,82)
        },.2)

    else
        Min.Text = "−"

        Tween(Main,{
            Size = UDim2.fromOffset(900,560)
        },.2)

        task.delay(.12,function()
            Sidebar.Visible = true
            Content.Visible = true
        end)
    end
end)

--// Close
Close.MouseButton1Click:Connect(function()

    Tween(Main,{
        BackgroundTransparency = 1
    },.15)

    task.wait(.16)

    GUI.Enabled = false
end)

--// Drag system
local Dragging = false
local DragStart
local StartPos

local function UpdateDrag(input)

    local Delta = input.Position - DragStart

    Main.Position = UDim2.new(
        StartPos.X.Scale,
        StartPos.X.Offset + Delta.X,
        StartPos.Y.Scale,
        StartPos.Y.Offset + Delta.Y
    )
end

Top.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPos = Main.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end

        end)
    end
end)

Top.InputChanged:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then

        UIS.InputChanged:Connect(function(move)

            if Dragging and move == input then
                UpdateDrag(move)
            end

        end)
    end
end)

--// Character settings
local function ApplyCharacter()

    local Character = Player.Character
    if not Character then return end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid then return end

    Humanoid.WalkSpeed = Settings.WalkSpeed
    Humanoid.JumpPower = Settings.JumpPower
end

Player.CharacterAdded:Connect(function()

    task.wait(1)
    ApplyCharacter()

end)

--// Apply movement every short interval
task.spawn(function()

    while GUI.Parent do

        if Settings.WalkSpeed ~= 16
        or Settings.JumpPower ~= 50 then

            ApplyCharacter()
        end

        task.wait(.25)
    end

end)

--// Hover effects
Min.MouseEnter:Connect(function()
    Min.TextColor3 = C.Purple2
end)

Min.MouseLeave:Connect(function()
    Min.TextColor3 = C.White
end)

Close.MouseEnter:Connect(function()
    Close.TextColor3 = C.Red
end)

Close.MouseLeave:Connect(function()
    Close.TextColor3 = C.White
end)

--// Open animation
Main.BackgroundTransparency = 1

Tween(Main,{
    BackgroundTransparency = 0
},.3)

GUI.Enabled = true
Main.Visible = true

print("================================")
print("       RUSTED HUB v2.2")
print("       ALL PARTS LOADED")
print("================================")
