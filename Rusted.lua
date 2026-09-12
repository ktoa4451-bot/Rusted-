--// RUSTED HUB v2.5
--// PART 1/4
--// CORE + COMPACT MENU

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--// CONFIG
local VERSION = "2.5"

local Settings = {
    ESP = true,
    BoxESP = true,
    NameESP = true,
    DistanceESP = true,
    HealthESP = true,
    TracerESP = true,

    AimAssist = false,
    TeamCheck = true,
    WallCheck = true,

    Speed = false,
    HighJump = false,
    Crosshair = false,

    Menu = true,
    AutoUpdate = true
}

--// COLORS
local C = {
    Background = Color3.fromRGB(7,6,16),
    Sidebar = Color3.fromRGB(11,9,23),
    Card = Color3.fromRGB(17,14,32),
    Hover = Color3.fromRGB(32,22,55),

    Purple = Color3.fromRGB(145,60,255),
    LightPurple = Color3.fromRGB(190,125,255),

    White = Color3.fromRGB(245,240,255),
    Gray = Color3.fromRGB(145,138,165),
    Red = Color3.fromRGB(235,70,85)
}

--// REMOVE OLD MENU
local Old = PlayerGui:FindFirstChild("RustedHub")
if Old then
    Old:Destroy()
end

--// HELPERS
local function Corner(Object, Radius)
    local U = Instance.new("UICorner")
    U.CornerRadius = UDim.new(0, Radius or 10)
    U.Parent = Object
end

local function Border(Object)
    local S = Instance.new("UIStroke")
    S.Color = C.Purple
    S.Transparency = .55
    S.Thickness = 1
    S.Parent = Object
end

local function Tween(Object, Properties, Time)
    TweenService:Create(
        Object,
        TweenInfo.new(
            Time or .15,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        Properties
    ):Play()
end

--// GUI
local GUI = Instance.new("ScreenGui")
GUI.Name = "RustedHub"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.DisplayOrder = 999
GUI.Parent = PlayerGui

--// MAIN
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = GUI
Main.Size = UDim2.fromOffset(700,430)
Main.Position = UDim2.new(.5,-350,.5,-215)
Main.BackgroundColor3 = C.Background
Main.BorderSizePixel = 0
Main.Visible = true

Corner(Main,16)
Border(Main)

--// TOP
local Top = Instance.new("Frame")
Top.Parent = Main
Top.Size = UDim2.new(1,0,0,65)
Top.BackgroundColor3 = C.Sidebar
Top.BorderSizePixel = 0

local Logo = Instance.new("TextLabel")
Logo.Parent = Top
Logo.Position = UDim2.fromOffset(15,10)
Logo.Size = UDim2.fromOffset(45,45)
Logo.BackgroundColor3 = Color3.fromRGB(40,20,75)
Logo.Text = "R"
Logo.TextColor3 = C.LightPurple
Logo.TextSize = 24
Logo.Font = Enum.Font.GothamBold

Corner(Logo,12)

local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.Position = UDim2.fromOffset(70,10)
Title.Size = UDim2.fromOffset(250,28)
Title.BackgroundTransparency = 1
Title.Text = "RUSTED"
Title.TextColor3 = C.White
Title.TextSize = 21
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local Version = Instance.new("TextLabel")
Version.Parent = Top
Version.Position = UDim2.fromOffset(72,36)
Version.Size = UDim2.fromOffset(150,18)
Version.BackgroundTransparency = 1
Version.Text = "PRIVATE • v"..VERSION
Version.TextColor3 = C.Gray
Version.TextSize = 9
Version.Font = Enum.Font.GothamMedium
Version.TextXAlignment = Enum.TextXAlignment.Left

--// MINIMIZE
local Min = Instance.new("TextButton")
Min.Parent = Top
Min.Position = UDim2.new(1,-82,0,15)
Min.Size = UDim2.fromOffset(30,30)
Min.BackgroundTransparency = 1
Min.Text = "−"
Min.TextColor3 = C.White
Min.TextSize = 22
Min.Font = Enum.Font.GothamBold
Min.AutoButtonColor = false

--// CLOSE
local Close = Instance.new("TextButton")
Close.Parent = Top
Close.Position = UDim2.new(1,-45,0,15)
Close.Size = UDim2.fromOffset(30,30)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = C.White
Close.TextSize = 24
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false

--// SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Parent = Main
Sidebar.Position = UDim2.fromOffset(0,65)
Sidebar.Size = UDim2.new(0,155,1,-65)
Sidebar.BackgroundColor3 = C.Sidebar
Sidebar.BorderSizePixel = 0

local MenuLabel = Instance.new("TextLabel")
MenuLabel.Parent = Sidebar
MenuLabel.Position = UDim2.fromOffset(15,12)
MenuLabel.Size = UDim2.fromOffset(120,20)
MenuLabel.BackgroundTransparency = 1
MenuLabel.Text = "MENU"
MenuLabel.TextColor3 = C.Gray
MenuLabel.TextSize = 9
MenuLabel.Font = Enum.Font.GothamBold
MenuLabel.TextXAlignment = Enum.TextXAlignment.Left

--// CONTENT
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Position = UDim2.fromOffset(155,65)
Content.Size = UDim2.new(1,-155,1,-65)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0

--// SHARED DATA
_G.Rusted = _G.Rusted or {}

_G.Rusted.GUI = GUI
_G.Rusted.Main = Main
_G.Rusted.Top = Top
_G.Rusted.Sidebar = Sidebar
_G.Rusted.Content = Content
_G.Rusted.Min = Min
_G.Rusted.Close = Close
_G.Rusted.Settings = Settings
_G.Rusted.Version = VERSION
_G.Rusted.Colors = C

print("[Rusted v2.5] Part 1 loaded")

--// RUSTED HUB v2.5
--// PART 2/4
--// SIDEBAR + PAGES

local R = _G.Rusted
local Main = R.Main
local Sidebar = R.Sidebar
local Content = R.Content
local C = R.Colors

local Pages = {}
local Buttons = {}

--// PAGE DESCRIPTIONS
local Desc = {
    Visual = "Настройки визуальных функций",
    Combat = "Настройки боевых функций",
    Movement = "Настройки движения",
    Misc = "Дополнительные функции",
    Settings = "Настройки Rusted Hub"
}

--// TITLE
local PageTitle = Instance.new("TextLabel")
PageTitle.Parent = Content
PageTitle.Position = UDim2.fromOffset(20,15)
PageTitle.Size = UDim2.fromOffset(300,28)
PageTitle.BackgroundTransparency = 1
PageTitle.TextColor3 = C.White
PageTitle.TextSize = 20
PageTitle.Font = Enum.Font.GothamBold
PageTitle.TextXAlignment = Enum.TextXAlignment.Left

local PageDesc = Instance.new("TextLabel")
PageDesc.Parent = Content
PageDesc.Position = UDim2.fromOffset(21,42)
PageDesc.Size = UDim2.fromOffset(400,20)
PageDesc.BackgroundTransparency = 1
PageDesc.TextColor3 = C.Gray
PageDesc.TextSize = 10
PageDesc.Font = Enum.Font.Gotham
PageDesc.TextXAlignment = Enum.TextXAlignment.Left

--// CREATE PAGES
for _,Name in ipairs({
    "Visual",
    "Combat",
    "Movement",
    "Misc",
    "Settings"
}) do

    local Page = Instance.new("ScrollingFrame")
    Page.Name = Name
    Page.Parent = Content
    Page.Position = UDim2.fromOffset(20,70)
    Page.Size = UDim2.new(1,-40,1,-85)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = C.Purple
    Page.CanvasSize = UDim2.new()
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0,7)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    Pages[Name] = Page
end

--// BUTTON DATA
local Data = {
    {"Visual","◉"},
    {"Combat","⌁"},
    {"Movement","↗"},
    {"Misc","◆"},
    {"Settings","⚙"}
}

--// SELECT PAGE
local function SelectPage(Name)

    for PageName,Page in pairs(Pages) do
        Page.Visible = PageName == Name
    end

    for ButtonName,Button in pairs(Buttons) do

        local Active = ButtonName == Name
        local Icon = Button:FindFirstChild("Icon")
        local Label = Button:FindFirstChild("Label")

        Button.BackgroundColor3 =
            Active and C.Hover or C.Sidebar

        if Icon then
            Icon.TextColor3 =
                Active and C.LightPurple or C.Gray
        end

        if Label then
            Label.TextColor3 =
                Active and C.White or C.Gray
        end
    end

    PageTitle.Text = Name
    PageDesc.Text = Desc[Name] or ""
end

--// SIDEBAR BUTTONS
for i,Info in ipairs(Data) do

    local Name = Info[1]
    local IconText = Info[2]

    local Button = Instance.new("TextButton")
    Button.Name = Name
    Button.Parent = Sidebar
    Button.Position = UDim2.fromOffset(10,40 + ((i-1)*48))
    Button.Size = UDim2.new(1,-20,0,40)
    Button.BackgroundColor3 = C.Sidebar
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,9)
    Corner.Parent = Button

    local Icon = Instance.new("TextLabel")
    Icon.Name = "Icon"
    Icon.Parent = Button
    Icon.Position = UDim2.fromOffset(10,0)
    Icon.Size = UDim2.fromOffset(25,40)
    Icon.BackgroundTransparency = 1
    Icon.Text = IconText
    Icon.TextColor3 = C.Gray
    Icon.TextSize = 15
    Icon.Font = Enum.Font.GothamBold

    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Parent = Button
    Label.Position = UDim2.fromOffset(43,0)
    Label.Size = UDim2.new(1,-48,1,0)
    Label.BackgroundTransparency = 1
    Label.Text = Name
    Label.TextColor3 = C.Gray
    Label.TextSize = 11
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left

    Buttons[Name] = Button

    Button.MouseEnter:Connect(function()
        if PageTitle.Text ~= Name then
            Button.BackgroundColor3 = C.Hover
        end
    end)

    Button.MouseLeave:Connect(function()
        if PageTitle.Text ~= Name then
            Button.BackgroundColor3 = C.Sidebar
        end
    end)

    Button.MouseButton1Click:Connect(function()
        SelectPage(Name)
    end)
end

--// SIDEBAR FOOTER
local Footer = Instance.new("TextLabel")
Footer.Parent = Sidebar
Footer.Position = UDim2.new(0,15,1,-38)
Footer.Size = UDim2.new(1,-30,0,20)
Footer.BackgroundTransparency = 1
Footer.Text = "RUSTED v"..R.Version
Footer.TextColor3 = C.Gray
Footer.TextSize = 9
Footer.Font = Enum.Font.GothamBold
Footer.TextXAlignment = Enum.TextXAlignment.Left

--// SAVE REFERENCES
R.Pages = Pages
R.Buttons = Buttons
R.PageTitle = PageTitle
R.PageDesc = PageDesc
R.SelectPage = SelectPage

--// DEFAULT PAGE
SelectPage("Visual")

print("[Rusted v2.5] Part 2 loaded")

--// RUSTED HUB v2.5
--// PART 3/4
--// CONTROLS

local R = _G.Rusted
local Pages = R.Pages
local Settings = R.Settings
local C = R.Colors

--// TOGGLE
local function AddToggle(Page, Name, Key)

    local Row = Instance.new("Frame")
    Row.Parent = Page
    Row.Size = UDim2.new(1,0,0,44)
    Row.BackgroundColor3 = C.Card
    Row.BorderSizePixel = 0

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,9)
    Corner.Parent = Row

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = C.Purple
    Stroke.Transparency = .7
    Stroke.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Parent = Row
    Label.Position = UDim2.fromOffset(13,0)
    Label.Size = UDim2.new(1,-75,1,0)
    Label.BackgroundTransparency = 1
    Label.Text = Name
    Label.TextColor3 = C.White
    Label.TextSize = 11
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Button = Instance.new("TextButton")
    Button.Parent = Row
    Button.Position = UDim2.new(1,-55,.5,-11)
    Button.Size = UDim2.fromOffset(40,22)
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.BorderSizePixel = 0

    local BC = Instance.new("UICorner")
    BC.CornerRadius = UDim.new(1,0)
    BC.Parent = Button

    local Dot = Instance.new("Frame")
    Dot.Parent = Button
    Dot.Size = UDim2.fromOffset(16,16)
    Dot.Position = UDim2.fromOffset(3,3)
    Dot.BorderSizePixel = 0

    local DC = Instance.new("UICorner")
    DC.CornerRadius = UDim.new(1,0)
    DC.Parent = Dot

    local function Update()

        local On = Settings[Key]

        if On then
            Button.BackgroundColor3 = C.Purple
            Dot.BackgroundColor3 = C.White
            Dot.Position = UDim2.new(1,-19,0,3)
        else
            Button.BackgroundColor3 = Color3.fromRGB(45,40,55)
            Dot.BackgroundColor3 = C.Gray
            Dot.Position = UDim2.fromOffset(3,3)
        end
    end

    Button.MouseButton1Click:Connect(function()
        Settings[Key] = not Settings[Key]
        Update()
    end)

    Update()
end

--// VISUAL
AddToggle(Pages.Visual,"ESP","ESP")
AddToggle(Pages.Visual,"Box ESP","BoxESP")
AddToggle(Pages.Visual,"Name ESP","NameESP")
AddToggle(Pages.Visual,"Distance ESP","DistanceESP")
AddToggle(Pages.Visual,"Health ESP","HealthESP")
AddToggle(Pages.Visual,"Tracer ESP","TracerESP")

--// COMBAT
AddToggle(Pages.Combat,"Aim Assist","AimAssist")
AddToggle(Pages.Combat,"Team Check","TeamCheck")
AddToggle(Pages.Combat,"Wall Check","WallCheck")

--// MOVEMENT
AddToggle(Pages.Movement,"Speed","Speed")
AddToggle(Pages.Movement,"High Jump","HighJump")

--// MISC
AddToggle(Pages.Misc,"Crosshair","Crosshair")

--// SETTINGS
AddToggle(Pages.Settings,"Auto Update","AutoUpdate")

--// CHARACTER
local function ApplyMovement()

    local Character = Player.Character
    if not Character then return end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then return end

    if Settings.Speed then
        Humanoid.WalkSpeed = 24
    else
        Humanoid.WalkSpeed = 16
    end

    if Settings.HighJump then
        Humanoid.JumpPower = 75
    else
        Humanoid.JumpPower = 50
    end
end

Player.CharacterAdded:Connect(function()

    task.wait(1)
    ApplyMovement()

end)

task.spawn(function()

    while R.GUI and R.GUI.Parent do

        ApplyMovement()

        task.wait(.3)
    end

end)

R.AddToggle = AddToggle
R.ApplyMovement = ApplyMovement

print("[Rusted v2.5] Part 3 loaded")

--// RUSTED HUB v2.5
--// PART 4/4
--// FINAL

local R = _G.Rusted

local GUI = R.GUI
local Main = R.Main
local Top = R.Top
local Min = R.Min
local Close = R.Close

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local C = R.Colors

--// FLOATING BUTTON
local Mini = Instance.new("TextButton")
Mini.Name = "RustedMini"
Mini.Parent = GUI
Mini.Size = UDim2.fromOffset(48,48)
Mini.Position = UDim2.new(.5,-24,.5,-24)
Mini.BackgroundColor3 = C.Background
Mini.BorderSizePixel = 0
Mini.Text = "R"
Mini.TextColor3 = C.LightPurple
Mini.TextSize = 20
Mini.Font = Enum.Font.GothamBold
Mini.Visible = false
Mini.AutoButtonColor = false

local MC = Instance.new("UICorner")
MC.CornerRadius = UDim.new(1,0)
MC.Parent = Mini

local MS = Instance.new("UIStroke")
MS.Color = C.Purple
MS.Thickness = 2
MS.Parent = Mini

--// MINIMIZE
local Minimized = false

local function Minimize()

    Minimized = true

    Main.Visible = false
    Mini.Visible = true

end

local function Restore()

    Minimized = false

    Mini.Visible = false
    Main.Visible = true

end

Min.MouseButton1Click:Connect(Restore)

Mini.MouseEnter:Connect(function()
    TweenService:Create(
        Mini,
        TweenInfo.new(.12),
        {BackgroundColor3 = C.Hover}
    ):Play()
end)

Mini.MouseLeave:Connect(function()
    TweenService:Create(
        Mini,
        TweenInfo.new(.12),
        {BackgroundColor3 = C.Background}
    ):Play()
end)

Min.MouseButton1Click:Connect(Minimize)

--// CLOSE
Close.MouseButton1Click:Connect(function()

    GUI.Enabled = false

end)

--// CLOSE HOVER
Close.MouseEnter:Connect(function()

    TweenService:Create(
        Close,
        TweenInfo.new(.1),
        {TextColor3 = C.Red}
    ):Play()

end)

Close.MouseLeave:Connect(function()

    TweenService:Create(
        Close,
        TweenInfo.new(.1),
        {TextColor3 = C.White}
    ):Play()

end)

--// MIN HOVER
Min.MouseEnter:Connect(function()

    TweenService:Create(
        Min,
        TweenInfo.new(.1),
        {TextColor3 = C.LightPurple}
    ):Play()

end)

Min.MouseLeave:Connect(function()

    TweenService:Create(
        Min,
        TweenInfo.new(.1),
        {TextColor3 = C.White}
    ):Play()

end)

--// DRAG SYSTEM
local Dragging = false
local DragStart
local StartPosition
local DragInput

local function UpdateDrag(Input)

    local Delta = Input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end

Top.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position

        Input.Changed:Connect(function()

            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end

        end)
    end
end)

Top.InputChanged:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseMovement
    or Input.UserInputType == Enum.UserInputType.Touch then

        DragInput = Input

    end
end)

UIS.InputChanged:Connect(function(Input)

    if Input == DragInput and Dragging then
        UpdateDrag(Input)
    end

end)

--// MINI BUTTON DRAG
local MiniDragging = false
local MiniStart
local MiniPosition
local MiniInput

Mini.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        MiniDragging = true
        MiniStart = Input.Position
        MiniPosition = Mini.Position

        Input.Changed:Connect(function()

            if Input.UserInputState == Enum.UserInputState.End then
                MiniDragging = false
            end

        end)
    end
end)

Mini.InputChanged:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseMovement
    or Input.UserInputType == Enum.UserInputType.Touch then

        MiniInput = Input

    end
end)

UIS.InputChanged:Connect(function(Input)

    if Input == MiniInput and MiniDragging then

        local Delta = Input.Position - MiniStart

        Mini.Position = UDim2.new(
            MiniPosition.X.Scale,
            MiniPosition.X.Offset + Delta.X,
            MiniPosition.Y.Scale,
            MiniPosition.Y.Offset + Delta.Y
        )
    end
end)

--// START ANIMATION
Main.BackgroundTransparency = 1

TweenService:Create(
    Main,
    TweenInfo.new(
        .25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    ),
    {
        BackgroundTransparency = 0
    }
):Play()

GUI.Enabled = true
Main.Visible = true

print("================================")
print("       RUSTED HUB v2.5")
print("       ALL PARTS LOADED")
print("       COMPACT UI READY")
print("================================")
