--[[
====================================================
                 RUSTED v3.0
                    PART 1/6
====================================================
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local RUSTED_NAME = "RUSTED"
local RUSTED_VERSION = "3.0"

----------------------------------------------------
-- REMOVE OLD VERSION
----------------------------------------------------

pcall(function()
    local Old = PlayerGui:FindFirstChild("RustedV3")
    if Old then
        Old:Destroy()
    end
end)

----------------------------------------------------
-- GLOBAL
----------------------------------------------------

_G.RustedV3 = {}
local Hub = _G.RustedV3

Hub.Name = RUSTED_NAME
Hub.Version = RUSTED_VERSION
Hub.Player = Player
Hub.PlayerGui = PlayerGui

----------------------------------------------------
-- THEME
----------------------------------------------------

Hub.Theme = {
    Background = Color3.fromRGB(7, 6, 14),
    Background2 = Color3.fromRGB(10, 8, 19),

    Panel = Color3.fromRGB(12, 10, 23),
    Panel2 = Color3.fromRGB(17, 13, 31),

    Row = Color3.fromRGB(18, 14, 31),
    RowHover = Color3.fromRGB(27, 18, 48),

    Purple = Color3.fromRGB(126, 52, 255),
    Purple2 = Color3.fromRGB(155, 91, 255),
    PurpleDark = Color3.fromRGB(48, 23, 91),

    Border = Color3.fromRGB(65, 35, 115),

    Text = Color3.fromRGB(242, 239, 255),
    Text2 = Color3.fromRGB(181, 174, 205),
    Text3 = Color3.fromRGB(112, 104, 136),

    White = Color3.fromRGB(255, 255, 255),
    Green = Color3.fromRGB(70, 220, 125),
    Red = Color3.fromRGB(245, 70, 85),
    Blue = Color3.fromRGB(55, 125, 255),
    Pink = Color3.fromRGB(245, 75, 180),
    Orange = Color3.fromRGB(255, 135, 50),
}

local Theme = Hub.Theme

----------------------------------------------------
-- SETTINGS
----------------------------------------------------

Hub.Settings = {

    ------------------------------------------------
    -- VISUAL
    ------------------------------------------------

    ESP = false,
    BoxESP = false,
    NameESP = false,
    HealthESP = false,
    DistanceESP = false,
    TracerESP = false,

    FOVChanger = false,
    FOV = 90,

    Skybox = false,

    CustomHands = false,
    HandX = 0,
    HandY = 0,
    HandZ = 0,

    ------------------------------------------------
    -- COMBAT
    ------------------------------------------------

    SilentAim = false,
    TeamCheck = true,

    ShowFOV = false,
    Snapline = false,

    FOVRadius = 150,
    HitPart = "Head",

    BulletTracer = false,
    TracerLifetime = 1,
    TracerType = "Laser",
    TracerColor = "Purple",

    ------------------------------------------------
    -- MOVEMENT
    ------------------------------------------------

    SpeedHack = false,
    Speed = 16,

    Noclip = false,

    JumpShot = false,

    Jump = false,
    JumpPower = 50,

    ------------------------------------------------
    -- MISC
    ------------------------------------------------

    Fullbright = false,
    NeonGuns = false,

    ------------------------------------------------
    -- SETTINGS
    ------------------------------------------------

    MenuColor = "Purple",

    MenuOpen = true,

    AutoUpdate = true,
}

local Settings = Hub.Settings

----------------------------------------------------
-- SCREEN GUI
----------------------------------------------------

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "RustedV3"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ScreenGui.Parent = PlayerGui

Hub.ScreenGui = ScreenGui

----------------------------------------------------
-- MAIN
----------------------------------------------------

local Main = Instance.new("Frame")

Main.Name = "Main"

-- Компактный размер
Main.Size = UDim2.fromOffset(760, 460)

Main.Position = UDim2.new(
    0.5,
    -380,
    0.5,
    -230
)

Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

Main.Parent = ScreenGui

Hub.Main = Main

----------------------------------------------------
-- MAIN CORNER
----------------------------------------------------

local MainCorner = Instance.new("UICorner")

MainCorner.CornerRadius = UDim.new(0, 10)

MainCorner.Parent = Main

----------------------------------------------------
-- MAIN BORDER
----------------------------------------------------

local MainStroke = Instance.new("UIStroke")

MainStroke.Color = Theme.Border
MainStroke.Thickness = 1.2
MainStroke.Transparency = 0.15

MainStroke.Parent = Main

Hub.MainStroke = MainStroke

----------------------------------------------------
-- RESPONSIVE SCALE
----------------------------------------------------

local UIScale = Instance.new("UIScale")

UIScale.Name = "ResponsiveScale"

UIScale.Scale = 1

UIScale.Parent = Main

Hub.UIScale = UIScale

----------------------------------------------------
-- RESPONSIVE SIZE
----------------------------------------------------

local function UpdateScale()

    local Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize
    local Width = Viewport.X

    if Width <= 420 then

        UIScale.Scale = 0.62

    elseif Width <= 500 then

        UIScale.Scale = 0.70

    elseif Width <= 650 then

        UIScale.Scale = 0.80

    elseif Width <= 800 then

        UIScale.Scale = 0.90

    else

        UIScale.Scale = 1

    end
end

UpdateScale()

if workspace.CurrentCamera then

    workspace.CurrentCamera
        :GetPropertyChangedSignal("ViewportSize")
        :Connect(UpdateScale)

end

----------------------------------------------------
-- STORAGE
----------------------------------------------------

Hub.Pages = {}
Hub.PageButtons = {}

Hub.Controls = {}

Hub.ToggleObjects = {}
Hub.SliderObjects = {}
Hub.DropdownObjects = {}

Hub.Connections = {}

Hub.ESPObjects = {}

Hub.CurrentPage = nil

----------------------------------------------------
-- CREATE OBJECT
----------------------------------------------------

function Hub.New(ClassName, Properties, Parent)

    local Object = Instance.new(ClassName)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    Object.Parent = Parent

    return Object
end

----------------------------------------------------
-- CORNER
----------------------------------------------------

function Hub.Corner(Object, Radius)

    local Corner = Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(0, Radius or 6)

    Corner.Parent = Object

    return Corner
end

----------------------------------------------------
-- STROKE
----------------------------------------------------

function Hub.Stroke(
    Object,
    Color,
    Thickness,
    Transparency
)

    local Stroke = Instance.new("UIStroke")

    Stroke.Color =
        Color or Theme.Border

    Stroke.Thickness =
        Thickness or 1

    Stroke.Transparency =
        Transparency or 0

    Stroke.Parent = Object

    return Stroke
end

----------------------------------------------------
-- TWEEN
----------------------------------------------------

function Hub.Tween(
    Object,
    Properties,
    Duration
)

    local Tween = TweenService:Create(

        Object,

        TweenInfo.new(
            Duration or 0.15,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),

        Properties
    )

    Tween:Play()

    return Tween
end

----------------------------------------------------
-- SAFE CALLBACK
----------------------------------------------------

function Hub.SafeCall(Callback, ...)

    if typeof(Callback) ~= "function" then
        return
    end

    local Args = {...}

    task.spawn(function()

        pcall(function()

            Callback(
                table.unpack(Args)
            )

        end)

    end)
end

----------------------------------------------------
-- CHARACTER
----------------------------------------------------

function Hub.GetCharacter()

    return Player.Character
        or Player.CharacterAdded:Wait()

end

----------------------------------------------------
-- HUMANOID
----------------------------------------------------

function Hub.GetHumanoid()

    local Character = Player.Character

    if not Character then
        return nil
    end

    return Character:FindFirstChildOfClass(
        "Humanoid"
    )
end

----------------------------------------------------
-- ROOT
----------------------------------------------------

function Hub.GetRoot()

    local Character = Player.Character

    if not Character then
        return nil
    end

    return Character:FindFirstChild(
        "HumanoidRootPart"
    )
end

----------------------------------------------------
-- CAMERA FOV
----------------------------------------------------

Hub.DefaultFOV = 70

pcall(function()

    if workspace.CurrentCamera then

        Hub.DefaultFOV =
            workspace.CurrentCamera.FieldOfView

    end

end)

----------------------------------------------------
-- CONNECTION
----------------------------------------------------

function Hub.Connect(
    Signal,
    Callback
)

    local Connection =
        Signal:Connect(Callback)

    table.insert(
        Hub.Connections,
        Connection
    )

    return Connection
end

----------------------------------------------------
-- CLEANUP
----------------------------------------------------

function Hub.Cleanup()

    for _, Connection in ipairs(
        Hub.Connections
    ) do

        pcall(function()
            Connection:Disconnect()
        end)

    end

    Hub.Connections = {}

    for _, Object in pairs(
        Hub.ESPObjects
    ) do

        pcall(function()
            Object:Destroy()
        end)

    end

    Hub.ESPObjects = {}

end

----------------------------------------------------
-- MENU COLORS
----------------------------------------------------

Hub.MenuColors = {

    Purple = Color3.fromRGB(
        126,
        52,
        255
    ),

    Red = Color3.fromRGB(
        245,
        70,
        85
    ),

    Blue = Color3.fromRGB(
        55,
        125,
        255
    ),

    Green = Color3.fromRGB(
        65,
        210,
        120
    ),

    Pink = Color3.fromRGB(
        245,
        75,
        180
    ),

    Orange = Color3.fromRGB(
        255,
        135,
        50
    ),
}

----------------------------------------------------
-- GET MENU COLOR
----------------------------------------------------

function Hub.GetMenuColor()

    return Hub.MenuColors[
        Settings.MenuColor
    ]
    or Hub.MenuColors.Purple

end

----------------------------------------------------
-- APPLY MENU COLOR
----------------------------------------------------

function Hub.ApplyMenuColor()

    local Color =
        Hub.GetMenuColor()

    if Hub.MainStroke then
        Hub.MainStroke.Color = Color
    end

    if Hub.FloatingButton then

        Hub.FloatingButton.TextColor3 =
            Color

    end

    if Hub.FloatingStroke then

        Hub.FloatingStroke.Color =
            Color

    end

    if Hub.FloatingAccent then

        Hub.FloatingAccent.BackgroundColor3 =
            Color

    end

end

----------------------------------------------------
-- MENU STATE
----------------------------------------------------

function Hub.SetMenuOpen(State)

    Settings.MenuOpen = State

    if Hub.Main then

        Hub.Main.Visible = State

    end

    if Hub.FloatingButton then

        Hub.FloatingButton.Visible =
            not State

    end

end

----------------------------------------------------
-- FLOATING BUTTON
----------------------------------------------------

local FloatingButton = Instance.new("TextButton")

FloatingButton.Name =
    "FloatingButton"

FloatingButton.Size =
    UDim2.fromOffset(46, 46)

FloatingButton.Position =
    UDim2.new(
        0,
        18,
        0.5,
        -23
    )

FloatingButton.BackgroundColor3 =
    Theme.Background2

FloatingButton.BorderSizePixel = 0

FloatingButton.AutoButtonColor = false

FloatingButton.Text = "R"

FloatingButton.TextColor3 =
    Theme.Purple

FloatingButton.Font =
    Enum.Font.GothamBlack

FloatingButton.TextSize = 19

FloatingButton.Visible = false

FloatingButton.ZIndex = 100

FloatingButton.Parent = ScreenGui

Hub.FloatingButton =
    FloatingButton

----------------------------------------------------
-- FLOATING CORNER
----------------------------------------------------

Hub.Corner(
    FloatingButton,
    8
)

----------------------------------------------------
-- FLOATING BORDER
----------------------------------------------------

local FloatingStroke =
    Instance.new("UIStroke")

FloatingStroke.Color =
    Theme.Purple

FloatingStroke.Thickness = 1.3

FloatingStroke.Transparency = 0

FloatingStroke.Parent =
    FloatingButton

Hub.FloatingStroke =
    FloatingStroke

----------------------------------------------------
-- FLOATING ACCENT
----------------------------------------------------

local FloatingAccent =
    Instance.new("Frame")

FloatingAccent.Size =
    UDim2.new(1, 0, 0, 2)

FloatingAccent.Position =
    UDim2.new(0, 0, 1, -2)

FloatingAccent.BackgroundColor3 =
    Theme.Purple

FloatingAccent.BorderSizePixel = 0

FloatingAccent.ZIndex = 101

FloatingAccent.Parent =
    FloatingButton

Hub.FloatingAccent =
    FloatingAccent

----------------------------------------------------
-- RESTORE
----------------------------------------------------

FloatingButton.Activated:Connect(function()

    Hub.SetMenuOpen(true)

end)

----------------------------------------------------
-- HOVER
----------------------------------------------------

FloatingButton.MouseEnter:Connect(function()

    Hub.Tween(
        FloatingButton,
        {
            BackgroundColor3 =
                Theme.RowHover
        },
        0.12
    )

end)

FloatingButton.MouseLeave:Connect(function()

    Hub.Tween(
        FloatingButton,
        {
            BackgroundColor3 =
                Theme.Background2
        },
        0.12
    )

end)

----------------------------------------------------
-- MOBILE DRAG SUPPORT FOR FLOATING BUTTON
----------------------------------------------------

local FloatingDragging = false
local FloatingDragStart
local FloatingStartPosition

FloatingButton.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch then

        FloatingDragging = true

        FloatingDragStart =
            Input.Position

        FloatingStartPosition =
            FloatingButton.Position

    end

end)

FloatingButton.InputChanged:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch then

        Hub.FloatingDragInput = Input

    end

end)

UserInputService.InputChanged:Connect(
    function(Input)

        if not FloatingDragging then
            return
        end

        if Input ~= Hub.FloatingDragInput then
            return
        end

        local Delta =
            Input.Position
            - FloatingDragStart

        FloatingButton.Position =
            UDim2.new(
                FloatingStartPosition.X.Scale,
                FloatingStartPosition.X.Offset
                    + Delta.X,

                FloatingStartPosition.Y.Scale,
                FloatingStartPosition.Y.Offset
                    + Delta.Y
            )

    end
)

UserInputService.InputEnded:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch then

            FloatingDragging = false

        end

    end
)

----------------------------------------------------
-- INITIAL STATE
----------------------------------------------------

Hub.SetMenuOpen(true)

Hub.ApplyMenuColor()

----------------------------------------------------
-- READY
----------------------------------------------------

print(
    "Rusted v"
    .. RUSTED_VERSION
    .. " | Part 1/6 loaded"
)
--[[
====================================================
                 RUSTED v3.0
                    PART 2/6
             SIDEBAR / PAGES / HEADER
====================================================
]]

----------------------------------------------------
-- HEADER
----------------------------------------------------

local Header = Hub.New("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 56),
    Position = UDim2.fromOffset(0, 0),
    BackgroundColor3 = Theme.Background2,
    BorderSizePixel = 0,
}, Main)

local HeaderLine = Hub.New("Frame", {
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, -1),
    BackgroundColor3 = Theme.Border,
    BorderSizePixel = 0,
}, Header)

----------------------------------------------------
-- LOGO
----------------------------------------------------

local Logo = Hub.New("TextLabel", {
    Name = "Logo",
    Size = UDim2.fromOffset(140, 27),
    Position = UDim2.fromOffset(18, 7),
    BackgroundTransparency = 1,
    Text = "RUSTED",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBlack,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left,
}, Header)

local LogoAccent = Hub.New("Frame", {
    Size = UDim2.fromOffset(3, 23),
    Position = UDim2.fromOffset(0, 2),
    BackgroundColor3 = Theme.Purple,
    BorderSizePixel = 0,
}, Logo)

local Version = Hub.New("TextLabel", {
    Size = UDim2.fromOffset(70, 17),
    Position = UDim2.fromOffset(19, 33),
    BackgroundTransparency = 1,
    Text = "v" .. Hub.Version,
    TextColor3 = Theme.Text3,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
}, Header)

----------------------------------------------------
-- MINIMIZE
----------------------------------------------------

local MinimizeButton = Hub.New("TextButton", {
    Name = "Minimize",
    Size = UDim2.fromOffset(32, 32),
    Position = UDim2.new(1, -73, 0, 12),
    BackgroundColor3 = Theme.Panel2,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "—",
    TextColor3 = Theme.Text2,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
}, Header)

Hub.Corner(MinimizeButton, 5)
Hub.Stroke(MinimizeButton, Theme.Border, 1, 0.25)

----------------------------------------------------
-- CLOSE
----------------------------------------------------

local CloseButton = Hub.New("TextButton", {
    Name = "Close",
    Size = UDim2.fromOffset(32, 32),
    Position = UDim2.new(1, -37, 0, 12),
    BackgroundColor3 = Theme.Panel2,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "×",
    TextColor3 = Theme.Text2,
    Font = Enum.Font.GothamBold,
    TextSize = 18,
}, Header)

Hub.Corner(CloseButton, 5)
Hub.Stroke(CloseButton, Theme.Border, 1, 0.25)

----------------------------------------------------
-- SIDEBAR
----------------------------------------------------

local Sidebar = Hub.New("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 158, 1, -56),
    Position = UDim2.fromOffset(0, 56),
    BackgroundColor3 = Theme.Background2,
    BorderSizePixel = 0,
}, Main)

local SidebarLine = Hub.New("Frame", {
    Size = UDim2.fromOffset(1, 1),
    Position = UDim2.new(1, -1, 0, 0),
    SizeConstraint = Enum.SizeConstraint.RelativeYY,
    BackgroundColor3 = Theme.Border,
    BorderSizePixel = 0,
}, Sidebar)

local SidebarTitle = Hub.New("TextLabel", {
    Size = UDim2.new(1, -28, 0, 22),
    Position = UDim2.fromOffset(14, 13),
    BackgroundTransparency = 1,
    Text = "MENU",
    TextColor3 = Theme.Text3,
    Font = Enum.Font.GothamBold,
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left,
}, Sidebar)

----------------------------------------------------
-- NAVIGATION
----------------------------------------------------

local Navigation = Hub.New("Frame", {
    Name = "Navigation",
    Size = UDim2.new(1, -18, 1, -48),
    Position = UDim2.fromOffset(9, 40),
    BackgroundTransparency = 1,
}, Sidebar)

local NavLayout = Hub.New("UIListLayout", {
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, Navigation)

----------------------------------------------------
-- CONTENT
----------------------------------------------------

local Content = Hub.New("Frame", {
    Name = "Content",
    Size = UDim2.new(1, -158, 1, -56),
    Position = UDim2.fromOffset(158, 56),
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, Main)

----------------------------------------------------
-- PAGE HEADER
----------------------------------------------------

local ContentHeader = Hub.New("Frame", {
    Size = UDim2.new(1, -32, 0, 68),
    Position = UDim2.fromOffset(16, 0),
    BackgroundTransparency = 1,
}, Content)

local PageTitle = Hub.New("TextLabel", {
    Name = "PageTitle",
    Size = UDim2.new(1, -10, 0, 28),
    Position = UDim2.fromOffset(0, 11),
    BackgroundTransparency = 1,
    Text = "Visual",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 19,
    TextXAlignment = Enum.TextXAlignment.Left,
}, ContentHeader)

local PageDescription = Hub.New("TextLabel", {
    Name = "PageDescription",
    Size = UDim2.new(1, -10, 0, 22),
    Position = UDim2.fromOffset(0, 39),
    BackgroundTransparency = 1,
    Text = "Visual player information and camera settings.",
    TextColor3 = Theme.Text3,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
}, ContentHeader)

Hub.PageTitle = PageTitle
Hub.PageDescription = PageDescription

----------------------------------------------------
-- PAGE HOLDER
----------------------------------------------------

local PageHolder = Hub.New("Frame", {
    Name = "PageHolder",
    Size = UDim2.new(1, -32, 1, -78),
    Position = UDim2.fromOffset(16, 72),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
}, Content)

Hub.PageHolder = PageHolder

----------------------------------------------------
-- CREATE PAGE
----------------------------------------------------

function Hub.CreatePage(Name)

    local Page = Hub.New("ScrollingFrame", {
        Name = Name,
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromOffset(0, 0),

        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Theme.Purple,
        ScrollBarImageTransparency = 0.2,

        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,

        ScrollingDirection =
            Enum.ScrollingDirection.Y,

        Visible = false,
    }, PageHolder)

    local Layout = Hub.New("UIListLayout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, Page)

    local Padding = Hub.New("UIPadding", {
        PaddingRight = UDim.new(0, 7),
        PaddingBottom = UDim.new(0, 8),
    }, Page)

    Hub.Pages[Name] = Page

    return Page
end

----------------------------------------------------
-- PAGES
----------------------------------------------------

local VisualPage =
    Hub.CreatePage("Visual")

local CombatPage =
    Hub.CreatePage("Combat")

local MovementPage =
    Hub.CreatePage("Movement")

local MiscPage =
    Hub.CreatePage("Misc")

local SettingsPage =
    Hub.CreatePage("Settings")

----------------------------------------------------
-- PAGE BUTTON
----------------------------------------------------

function Hub.CreatePageButton(
    Name,
    Icon,
    Order
)

    local Button = Hub.New("TextButton", {

        Name = Name .. "Button",

        Size = UDim2.new(1, 0, 0, 37),

        BackgroundColor3 =
            Theme.Background2,

        BorderSizePixel = 0,

        AutoButtonColor = false,

        Text = "",

        LayoutOrder =
            Order or 1,

    }, Navigation)

    Hub.Corner(Button, 5)

    ------------------------------------------------
    -- ACTIVE BAR
    ------------------------------------------------

    local Accent = Hub.New("Frame", {

        Name = "Accent",

        Size = UDim2.fromOffset(3, 21),

        Position =
            UDim2.new(0, 0, 0.5, -10),

        BackgroundColor3 =
            Theme.Purple,

        BorderSizePixel = 0,

        Visible = false,

    }, Button)

    ------------------------------------------------
    -- ICON
    ------------------------------------------------

    local IconLabel = Hub.New("TextLabel", {

        Name = "Icon",

        Size = UDim2.fromOffset(28, 37),

        Position =
            UDim2.fromOffset(9, 0),

        BackgroundTransparency = 1,

        Text = Icon,

        TextColor3 =
            Theme.Text3,

        Font =
            Enum.Font.GothamBold,

        TextSize = 12,

    }, Button)

    ------------------------------------------------
    -- NAME
    ------------------------------------------------

    local TextLabel = Hub.New("TextLabel", {

        Name = "Text",

        Size =
            UDim2.new(1, -44, 1, 0),

        Position =
            UDim2.fromOffset(39, 0),

        BackgroundTransparency = 1,

        Text = Name,

        TextColor3 =
            Theme.Text2,

        Font =
            Enum.Font.GothamMedium,

        TextSize = 11,

        TextXAlignment =
            Enum.TextXAlignment.Left,

    }, Button)

    Hub.PageButtons[Name] = {

        Button = Button,
        Accent = Accent,
        Icon = IconLabel,
        Text = TextLabel,

    }

    ------------------------------------------------
    -- CLICK
    ------------------------------------------------

    Button.Activated:Connect(function()

        Hub.SwitchPage(Name)

    end)

    ------------------------------------------------
    -- HOVER
    ------------------------------------------------

    Button.MouseEnter:Connect(function()

        if Hub.CurrentPage ~= Name then

            Hub.Tween(
                Button,
                {
                    BackgroundColor3 =
                        Theme.RowHover
                },
                0.1
            )

        end

    end)

    Button.MouseLeave:Connect(function()

        if Hub.CurrentPage ~= Name then

            Hub.Tween(
                Button,
                {
                    BackgroundColor3 =
                        Theme.Background2
                },
                0.1
            )

        end

    end)

    return Button
end

----------------------------------------------------
-- NAV BUTTONS
----------------------------------------------------

Hub.CreatePageButton(
    "Visual",
    "◈",
    1
)

Hub.CreatePageButton(
    "Combat",
    "⌁",
    2
)

Hub.CreatePageButton(
    "Movement",
    "↗",
    3
)

Hub.CreatePageButton(
    "Misc",
    "◆",
    4
)

Hub.CreatePageButton(
    "Settings",
    "⚙",
    5
)

----------------------------------------------------
-- PAGE SWITCH
----------------------------------------------------

function Hub.SwitchPage(Name)

    local Page =
        Hub.Pages[Name]

    if not Page then
        return
    end

    ------------------------------------------------
    -- SHOW PAGE
    ------------------------------------------------

    for PageName, PageObject
        in pairs(Hub.Pages) do

        PageObject.Visible =
            PageName == Name

    end

    ------------------------------------------------
    -- UPDATE SIDEBAR
    ------------------------------------------------

    for PageName, Data
        in pairs(Hub.PageButtons) do

        local Active =
            PageName == Name

        Data.Accent.Visible =
            Active

        if Active then

            Data.Button.BackgroundColor3 =
                Theme.RowHover

            Data.Icon.TextColor3 =
                Hub.GetMenuColor()

            Data.Text.TextColor3 =
                Theme.Text

        else

            Data.Button.BackgroundColor3 =
                Theme.Background2

            Data.Icon.TextColor3 =
                Theme.Text3

            Data.Text.TextColor3 =
                Theme.Text2

        end

    end

    ------------------------------------------------
    -- DESCRIPTION
    ------------------------------------------------

    local Descriptions = {

        Visual =
            "Visual player information and camera settings.",

        Combat =
            "Combat assistance and targeting settings.",

        Movement =
            "Movement and character controls.",

        Misc =
            "Additional gameplay and visual options.",

        Settings =
            "Rusted interface and configuration.",
    }

    Hub.CurrentPage =
        Name

    Hub.SetPageTitle(
        Name,
        Descriptions[Name] or ""
    )

end

----------------------------------------------------
-- HEADER BUTTON HOVER
----------------------------------------------------

MinimizeButton.MouseEnter:Connect(function()

    Hub.Tween(
        MinimizeButton,
        {
            BackgroundColor3 =
                Theme.RowHover
        },
        0.1
    )

end)

MinimizeButton.MouseLeave:Connect(function()

    Hub.Tween(
        MinimizeButton,
        {
            BackgroundColor3 =
                Theme.Panel2
        },
        0.1
    )

end)

CloseButton.MouseEnter:Connect(function()

    Hub.Tween(
        CloseButton,
        {
            BackgroundColor3 =
                Theme.RowHover
        },
        0.1
    )

end)

CloseButton.MouseLeave:Connect(function()

    Hub.Tween(
        CloseButton,
        {
            BackgroundColor3 =
                Theme.Panel2
        },
        0.1
    )

end)

----------------------------------------------------
-- MINIMIZE
----------------------------------------------------

MinimizeButton.Activated:Connect(function()

    Hub.SetMenuOpen(false)

end)

----------------------------------------------------
-- CLOSE
----------------------------------------------------

CloseButton.Activated:Connect(function()

    Hub.Settings.MenuOpen = false

    Main.Visible = false

    FloatingButton.Visible = false

    task.delay(0.1, function()

        if ScreenGui then
            ScreenGui:Destroy()
        end

    end)

end)

----------------------------------------------------
-- DEFAULT PAGE
----------------------------------------------------

Hub.SwitchPage("Visual")

print(
    "Rusted v"
    .. Hub.Version
    .. " | Part 2/6 loaded"
)
--[[
====================================================
                 RUSTED v3.0
                    PART 3/6
          TOGGLE / SLIDER / DROPDOWN
====================================================
]]

----------------------------------------------------
-- CONTROL COLORS
----------------------------------------------------

local function GetAccent()
    return Hub.GetMenuColor()
end

----------------------------------------------------
-- CONTROL HOVER
----------------------------------------------------

local function RowHover(Row)
    Row.MouseEnter:Connect(function()
        Hub.Tween(Row, {
            BackgroundColor3 = Theme.RowHover
        }, 0.10)
    end)

    Row.MouseLeave:Connect(function()
        Hub.Tween(Row, {
            BackgroundColor3 = Theme.Row
        }, 0.10)
    end)
end

----------------------------------------------------
-- SECTION
----------------------------------------------------

function Hub.CreateSection(Page, Text)

    local Section = Hub.New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 24),
        BackgroundTransparency = 1,

        Text = string.upper(Text),

        TextColor3 = Theme.Text3,
        Font = Enum.Font.GothamBold,
        TextSize = 9,

        TextXAlignment = Enum.TextXAlignment.Left,
    }, Page)

    return Section
end

----------------------------------------------------
-- TOGGLE
----------------------------------------------------

function Hub.CreateToggle(
    Page,
    Name,
    Description,
    SettingName,
    Callback
)

    local Row = Hub.New("Frame", {
        Name = Name .. "Toggle",

        Size = UDim2.new(1, 0, 0, 48),

        BackgroundColor3 = Theme.Row,

        BorderSizePixel = 0,
    }, Page)

    Hub.Corner(Row, 5)
    Hub.Stroke(Row, Theme.Border, 1, 0.55)

    ------------------------------------------------
    -- TITLE
    ------------------------------------------------

    local Title = Hub.New("TextLabel", {
        Size = UDim2.new(1, -75, 0, 19),
        Position = UDim2.fromOffset(12, 6),

        BackgroundTransparency = 1,

        Text = Name,

        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,

        TextXAlignment = Enum.TextXAlignment.Left,
    }, Row)

    ------------------------------------------------
    -- DESCRIPTION
    ------------------------------------------------

    local Desc = Hub.New("TextLabel", {
        Size = UDim2.new(1, -75, 0, 16),
        Position = UDim2.fromOffset(12, 26),

        BackgroundTransparency = 1,

        Text = Description or "",

        TextColor3 = Theme.Text3,
        Font = Enum.Font.Gotham,
        TextSize = 8,

        TextXAlignment = Enum.TextXAlignment.Left,

        TextTruncate =
            Enum.TextTruncate.AtEnd,
    }, Row)

    ------------------------------------------------
    -- TOGGLE BUTTON
    ------------------------------------------------

    local Button = Hub.New("TextButton", {
        Size = UDim2.fromOffset(38, 20),
        Position = UDim2.new(1, -51, 0.5, -10),

        BackgroundColor3 =
            Theme.Panel2,

        BorderSizePixel = 0,

        AutoButtonColor = false,

        Text = "",
    }, Row)

    Hub.Corner(Button, 10)

    Hub.Stroke(
        Button,
        Theme.Border,
        1,
        0.25
    )

    ------------------------------------------------
    -- KNOB
    ------------------------------------------------

    local Knob = Hub.New("Frame", {
        Size = UDim2.fromOffset(14, 14),

        Position =
            UDim2.fromOffset(3, 3),

        BackgroundColor3 =
            Theme.Text3,

        BorderSizePixel = 0,
    }, Button)

    Hub.Corner(Knob, 7)

    ------------------------------------------------
    -- STATE
    ------------------------------------------------

    local State =
        Settings[SettingName] == true

    local function Update(Value)

        State = Value

        Settings[SettingName] =
            Value

        if Value then

            Hub.Tween(
                Button,
                {
                    BackgroundColor3 =
                        GetAccent()
                },
                0.12
            )

            Hub.Tween(
                Knob,
                {
                    Position =
                        UDim2.new(
                            1,
                            -17,
                            0,
                            3
                        ),

                    BackgroundColor3 =
                        Theme.White,
                },
                0.12
            )

        else

            Hub.Tween(
                Button,
                {
                    BackgroundColor3 =
                        Theme.Panel2
                },
                0.12
            )

            Hub.Tween(
                Knob,
                {
                    Position =
                        UDim2.fromOffset(3, 3),

                    BackgroundColor3 =
                        Theme.Text3,
                },
                0.12
            )

        end

        Hub.SafeCall(
            Callback,
            Value
        )
    end

    ------------------------------------------------
    -- CLICK
    ------------------------------------------------

    Button.Activated:Connect(function()

        Update(not State)

    end)

    ------------------------------------------------
    -- SAVE
    ------------------------------------------------

    Hub.ToggleObjects[SettingName] = {
        Row = Row,
        Button = Button,
        Knob = Knob,
        Update = Update,
    }

    Hub.Controls[SettingName] = Row

    RowHover(Row)

    Update(State)

    return Row
end

----------------------------------------------------
-- SLIDER
----------------------------------------------------

function Hub.CreateSlider(
    Page,
    Name,
    Description,
    SettingName,
    Minimum,
    Maximum,
    Step,
    Callback
)

    local Row = Hub.New("Frame", {
        Name = Name .. "Slider",

        Size = UDim2.new(1, 0, 0, 57),

        BackgroundColor3 = Theme.Row,

        BorderSizePixel = 0,
    }, Page)

    Hub.Corner(Row, 5)
    Hub.Stroke(Row, Theme.Border, 1, 0.55)

    ------------------------------------------------
    -- TITLE
    ------------------------------------------------

    local Title = Hub.New("TextLabel", {
        Size = UDim2.new(1, -75, 0, 18),
        Position = UDim2.fromOffset(12, 5),

        BackgroundTransparency = 1,

        Text = Name,

        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,

        TextXAlignment =
            Enum.TextXAlignment.Left,
    }, Row)

    ------------------------------------------------
    -- DESCRIPTION
    ------------------------------------------------

    local Desc = Hub.New("TextLabel", {
        Size = UDim2.new(1, -75, 0, 15),
        Position = UDim2.fromOffset(12, 22),

        BackgroundTransparency = 1,

        Text = Description or "",

        TextColor3 = Theme.Text3,
        Font = Enum.Font.Gotham,
        TextSize = 8,

        TextXAlignment =
            Enum.TextXAlignment.Left,
    }, Row)

    ------------------------------------------------
    -- VALUE
    ------------------------------------------------

    local ValueLabel = Hub.New("TextLabel", {
        Size = UDim2.fromOffset(50, 18),

        Position =
            UDim2.new(1, -61, 0, 8),

        BackgroundTransparency = 1,

        TextColor3 =
            GetAccent(),

        Font =
            Enum.Font.GothamBold,

        TextSize = 10,

        TextXAlignment =
            Enum.TextXAlignment.Right,

        Text = tostring(
            Settings[SettingName]
            or Minimum
        ),
    }, Row)

    ------------------------------------------------
    -- BAR
    ------------------------------------------------

    local Bar = Hub.New("Frame", {
        Size =
            UDim2.new(1, -24, 0, 5),

        Position =
            UDim2.new(0, 12, 1, -13),

        BackgroundColor3 =
            Theme.Panel2,

        BorderSizePixel = 0,
    }, Row)

    Hub.Corner(Bar, 3)

    ------------------------------------------------
    -- FILL
    ------------------------------------------------

    local Fill = Hub.New("Frame", {
        Size =
            UDim2.new(0, 0, 1, 0),

        BackgroundColor3 =
            GetAccent(),

        BorderSizePixel = 0,
    }, Bar)

    Hub.Corner(Fill, 3)

    ------------------------------------------------
    -- VALUE
    ------------------------------------------------

    local Current =
        tonumber(Settings[SettingName])
        or Minimum

    local Dragging = false

    local function RoundValue(Value)

        if not Step or Step <= 0 then
            return Value
        end

        return math.floor(
            (Value / Step) + 0.5
        ) * Step
    end

    local function SetValue(Value)

        Value = math.clamp(
            Value,
            Minimum,
            Maximum
        )

        Value = RoundValue(Value)

        Current = Value

        Settings[SettingName] =
            Value

        local Alpha =
            (Value - Minimum)
            / (Maximum - Minimum)

        Fill.Size =
            UDim2.new(
                Alpha,
                0,
                1,
                0
            )

        ValueLabel.Text =
            tostring(Value)

        Hub.SafeCall(
            Callback,
            Value
        )
    end

    local function SetFromPosition(X)

        local Start =
            Bar.AbsolutePosition.X

        local Width =
            Bar.AbsoluteSize.X

        local Alpha =
            math.clamp(
                (X - Start) / Width,
                0,
                1
            )

        local Value =
            Minimum
            + ((Maximum - Minimum) * Alpha)

        SetValue(Value)
    end

    ------------------------------------------------
    -- INPUT
    ------------------------------------------------

    Bar.InputBegan:Connect(function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging = true

            SetFromPosition(
                Input.Position.X
            )

        end

    end)

    UserInputService.InputChanged:Connect(
        function(Input)

            if not Dragging then
                return
            end

            if Input.UserInputType ==
                Enum.UserInputType.MouseMovement
                or
                Input.UserInputType ==
                Enum.UserInputType.Touch then

                SetFromPosition(
                    Input.Position.X
                )

            end

        end
    )

    UserInputService.InputEnded:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1
                or
                Input.UserInputType ==
                Enum.UserInputType.Touch then

                Dragging = false

            end

        end
    )

    ------------------------------------------------
    -- SAVE
    ------------------------------------------------

    Hub.SliderObjects[SettingName] = {
        Row = Row,
        Bar = Bar,
        Fill = Fill,
        ValueLabel = ValueLabel,
        SetValue = SetValue,
    }

    Hub.Controls[SettingName] = Row

    RowHover(Row)

    SetValue(Current)

    return Row
end

----------------------------------------------------
-- DROPDOWN
----------------------------------------------------

function Hub.CreateDropdown(
    Page,
    Name,
    Description,
    SettingName,
    Options,
    Callback
)

    local Row = Hub.New("Frame", {
        Name = Name .. "Dropdown",

        Size = UDim2.new(1, 0, 0, 48),

        BackgroundColor3 = Theme.Row,

        BorderSizePixel = 0,

        ClipsDescendants = true,
    }, Page)

    Hub.Corner(Row, 5)
    Hub.Stroke(Row, Theme.Border, 1, 0.55)

    ------------------------------------------------
    -- TITLE
    ------------------------------------------------

    local Title = Hub.New("TextLabel", {
        Size =
            UDim2.new(1, -150, 0, 18),

        Position =
            UDim2.fromOffset(12, 6),

        BackgroundTransparency = 1,

        Text = Name,

        TextColor3 =
            Theme.Text,

        Font =
            Enum.Font.GothamMedium,

        TextSize = 11,

        TextXAlignment =
            Enum.TextXAlignment.Left,
    }, Row)

    ------------------------------------------------
    -- DESCRIPTION
    ------------------------------------------------

    local Desc = Hub.New("TextLabel", {
        Size =
            UDim2.new(1, -150, 0, 15),

        Position =
            UDim2.fromOffset(12, 25),

        BackgroundTransparency = 1,

        Text = Description or "",

        TextColor3 =
            Theme.Text3,

        Font =
            Enum.Font.Gotham,

        TextSize = 8,

        TextXAlignment =
            Enum.TextXAlignment.Left,
    }, Row)

    ------------------------------------------------
    -- BUTTON
    ------------------------------------------------

    local Button = Hub.New("TextButton", {
        Size = UDim2.fromOffset(110, 28),

        Position =
            UDim2.new(1, -121, 0, 10),

        BackgroundColor3 =
            Theme.Panel2,

        BorderSizePixel = 0,

        AutoButtonColor = false,

        Text = "",
    }, Row)

    Hub.Corner(Button, 5)
    Hub.Stroke(Button, Theme.Border, 1, 0.3)

    ------------------------------------------------
    -- CURRENT VALUE
    ------------------------------------------------

    local CurrentValue =
        Settings[SettingName]
        or Options[1]

    local ValueText = Hub.New("TextLabel", {

        Size =
            UDim2.new(1, -25, 1, 0),

        Position =
            UDim2.fromOffset(8, 0),

        BackgroundTransparency = 1,

        Text =
            tostring(CurrentValue),

        TextColor3 =
            Theme.Text2,

        Font =
            Enum.Font.GothamMedium,

        TextSize = 9,

        TextXAlignment =
            Enum.TextXAlignment.Left,

    }, Button)

    local Arrow = Hub.New("TextLabel", {

        Size =
            UDim2.fromOffset(20, 28),

        Position =
            UDim2.new(1, -22, 0, 0),

        BackgroundTransparency = 1,

        Text = "›",

        TextColor3 =
            Theme.Text3,

        Font =
            Enum.Font.GothamBold,

        TextSize = 14,

    }, Button)

    ------------------------------------------------
    -- DROPDOWN LIST
    ------------------------------------------------

    local List = Hub.New("Frame", {

        Name = "List",

        Size =
            UDim2.new(1, -24, 0, 0),

        Position =
            UDim2.fromOffset(12, 43),

        BackgroundColor3 =
            Theme.Panel2,

        BorderSizePixel = 0,

        Visible = false,

    }, Row)

    Hub.Corner(List, 5)
    Hub.Stroke(List, Theme.Border, 1, 0.2)

    local ListLayout = Hub.New(
        "UIListLayout",
        {
            Padding = UDim.new(0, 2),
            SortOrder =
                Enum.SortOrder.LayoutOrder,
        },
        List
    )

    ------------------------------------------------
    -- UPDATE
    ------------------------------------------------

    local Open = false

    local function Select(Value)

        CurrentValue = Value

        Settings[SettingName] =
            Value

        ValueText.Text =
            tostring(Value)

        Hub.SafeCall(
            Callback,
            Value
        )

        Open = false

        List.Visible = false

        Row.Size =
            UDim2.new(1, 0, 0, 48)
    end

    ------------------------------------------------
    -- OPTIONS
    ------------------------------------------------

    for Index, Option in ipairs(Options) do

        local OptionButton =
            Hub.New("TextButton", {

                Size =
                    UDim2.new(1, -4, 0, 27),

                BackgroundColor3 =
                    Theme.Panel2,

                BorderSizePixel = 0,

                AutoButtonColor = false,

                Text =
                    tostring(Option),

                TextColor3 =
                    Theme.Text2,

                Font =
                    Enum.Font.GothamMedium,

                TextSize = 9,

                LayoutOrder = Index,

            }, List)

        Hub.Corner(
            OptionButton,
            4
        )

        OptionButton.Activated:Connect(
            function()

                Select(Option)

            end
        )

        OptionButton.MouseEnter:Connect(
            function()

                OptionButton.BackgroundColor3 =
                    Theme.RowHover

            end
        )

        OptionButton.MouseLeave:Connect(
            function()

                OptionButton.BackgroundColor3 =
                    Theme.Panel2

            end
        )

    end

    ------------------------------------------------
    -- OPEN / CLOSE
    ------------------------------------------------

    Button.Activated:Connect(function()

        Open = not Open

        List.Visible = Open

        if Open then

            Row.Size =
                UDim2.new(
                    1,
                    0,
                    0,
                    50
                    + (#Options * 29)
                )

        else

            Row.Size =
                UDim2.new(
                    1,
                    0,
                    0,
                    48
                )

        end

    end)

    ------------------------------------------------
    -- SAVE
    ------------------------------------------------

    Hub.DropdownObjects[SettingName] = {

        Row = Row,

        Button = Button,

        List = List,

        ValueText = ValueText,

        Select = Select,

    }

    Hub.Controls[SettingName] =
        Row

    RowHover(Row)

    Hub.SafeCall(
        Callback,
        CurrentValue
    )

    return Row
end

----------------------------------------------------
-- COLOR UPDATE
----------------------------------------------------

function Hub.RefreshControlColors()

    local Accent =
        GetAccent()

    for _, Data in pairs(
        Hub.ToggleObjects
    ) do

        if Data.Button then

            local Enabled =
                Settings[
                    Data.SettingName
                ]

            if Enabled then
                Data.Button.BackgroundColor3 =
                    Accent
            end

        end

    end

    for _, Data in pairs(
        Hub.SliderObjects
    ) do

        if Data.Fill then

            Data.Fill.BackgroundColor3 =
                Accent

        end

        if Data.ValueLabel then

            Data.ValueLabel.TextColor3 =
                Accent

        end

    end

end

----------------------------------------------------
-- READY
----------------------------------------------------

print(
    "Rusted v"
    .. Hub.Version
    .. " | Part 3/6 loaded"
)
--[[
====================================================
                 RUSTED v3.0
                    PART 4/6
              VISUAL / COMBAT
====================================================
]]

----------------------------------------------------
-- VISUAL PAGE
----------------------------------------------------

Hub.CreateSection(
    VisualPage,
    "PLAYER ESP"
)

----------------------------------------------------
-- ESP DATA
----------------------------------------------------

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "RustedESP"
ESPFolder.Parent = ScreenGui

Hub.ESPFolder = ESPFolder

local function IsTeammate(Target)

    if not Settings.TeamCheck then
        return false
    end

    if not Player.Team or not Target.Team then
        return false
    end

    return Player.Team == Target.Team
end

----------------------------------------------------
-- REMOVE ESP
----------------------------------------------------

local function RemoveESP(Target)

    local Data = Hub.ESPObjects[Target]

    if not Data then
        return
    end

    for _, Object in pairs(Data) do
        pcall(function()
            Object:Destroy()
        end)
    end

    Hub.ESPObjects[Target] = nil
end

----------------------------------------------------
-- CREATE ESP
----------------------------------------------------

local function CreateESP(Target)

    if Target == Player then
        return
    end

    if Hub.ESPObjects[Target] then
        return
    end

    local Character = Target.Character

    if not Character then
        return
    end

    local Head =
        Character:FindFirstChild("Head")

    local Root =
        Character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not Head or not Root then
        return
    end

    local Data = {}

    ------------------------------------------------
    -- HIGHLIGHT
    ------------------------------------------------

    local Highlight = Instance.new("Highlight")

    Highlight.Name =
        "ESP_" .. Target.Name

    Highlight.Adornee =
        Character

    Highlight.FillColor =
        GetAccent()

    Highlight.FillTransparency =
        0.82

    Highlight.OutlineColor =
        GetAccent()

    Highlight.OutlineTransparency =
        0

    Highlight.DepthMode =
        Enum.HighlightDepthMode.AlwaysOnTop

    Highlight.Enabled =
        Settings.ESP

    Highlight.Parent =
        ESPFolder

    Data.Highlight = Highlight

    ------------------------------------------------
    -- BILLBOARD
    ------------------------------------------------

    local Billboard =
        Instance.new("BillboardGui")

    Billboard.Name =
        "Info_" .. Target.Name

    Billboard.Adornee =
        Head

    Billboard.Size =
        UDim2.fromOffset(150, 45)

    Billboard.StudsOffset =
        Vector3.new(0, 2.8, 0)

    Billboard.AlwaysOnTop =
        true

    Billboard.Enabled =
        Settings.ESP

    Billboard.Parent =
        ESPFolder

    Data.Billboard =
        Billboard

    ------------------------------------------------
    -- NAME
    ------------------------------------------------

    local NameLabel =
        Instance.new("TextLabel")

    NameLabel.Size =
        UDim2.new(1, 0, 0, 17)

    NameLabel.BackgroundTransparency =
        1

    NameLabel.Text =
        Target.DisplayName

    NameLabel.TextColor3 =
        GetAccent()

    NameLabel.Font =
        Enum.Font.GothamBold

    NameLabel.TextSize =
        11

    NameLabel.TextStrokeTransparency =
        0.35

    NameLabel.Visible =
        Settings.NameESP

    NameLabel.Parent =
        Billboard

    Data.Name = NameLabel

    ------------------------------------------------
    -- INFO
    ------------------------------------------------

    local InfoLabel =
        Instance.new("TextLabel")

    InfoLabel.Size =
        UDim2.new(1, 0, 0, 16)

    InfoLabel.Position =
        UDim2.fromOffset(0, 17)

    InfoLabel.BackgroundTransparency =
        1

    InfoLabel.TextColor3 =
        Theme.Text

    InfoLabel.Font =
        Enum.Font.Gotham

    InfoLabel.TextSize =
        9

    InfoLabel.TextStrokeTransparency =
        0.45

    InfoLabel.Visible =
        Settings.DistanceESP
        or Settings.HealthESP

    InfoLabel.Parent =
        Billboard

    Data.Info = InfoLabel

    ------------------------------------------------
    -- STORE
    ------------------------------------------------

    Hub.ESPObjects[Target] =
        Data
end

----------------------------------------------------
-- UPDATE ESP
----------------------------------------------------

local function UpdateESP()

    for _, Target in ipairs(
        Players:GetPlayers()
    ) do

        if Target ~= Player then

            if not Target.Character then
                RemoveESP(Target)
            elseif IsTeammate(Target) then
                RemoveESP(Target)
            else
                CreateESP(Target)
            end

        end

    end

    for Target, Data in pairs(
        Hub.ESPObjects
    ) do

        local Character =
            Target.Character

        local Humanoid =
            Character
            and Character:FindFirstChildOfClass(
                "Humanoid"
            )

        local Root =
            Character
            and Character:FindFirstChild(
                "HumanoidRootPart"
            )

        if not Character
            or not Humanoid
            or not Root then

            RemoveESP(Target)

        else

            local Enabled =
                Settings.ESP
                and not IsTeammate(Target)

            if Data.Highlight then

                Data.Highlight.Enabled =
                    Enabled

                Data.Highlight.FillColor =
                    GetAccent()

                Data.Highlight.OutlineColor =
                    GetAccent()

            end

            if Data.Billboard then

                Data.Billboard.Enabled =
                    Enabled

            end

            if Data.Name then

                Data.Name.Visible =
                    Enabled
                    and Settings.NameESP

                Data.Name.TextColor3 =
                    GetAccent()

            end

            if Data.Info then

                Data.Info.Visible =
                    Enabled
                    and (
                        Settings.DistanceESP
                        or Settings.HealthESP
                    )

                local Parts = {}

                if Settings.HealthESP then

                    table.insert(
                        Parts,
                        "HP "
                        .. math.floor(
                            Humanoid.Health
                        )
                    )

                end

                if Settings.DistanceESP then

                    local MyRoot =
                        Hub.GetRoot()

                    if MyRoot then

                        local Distance =
                            (
                                MyRoot.Position
                                - Root.Position
                            ).Magnitude

                        table.insert(
                            Parts,
                            math.floor(
                                Distance
                            ) .. "m"
                        )

                    end

                end

                Data.Info.Text =
                    table.concat(
                        Parts,
                        "  |  "
                    )

            end

        end
    end
end

----------------------------------------------------
-- ESP TOGGLES
----------------------------------------------------

Hub.CreateToggle(
    VisualPage,
    "ESP",
    "Highlight other players.",
    "ESP",
    function()

        UpdateESP()

    end
)

Hub.CreateToggle(
    VisualPage,
    "Boxes",
    "Show player highlight boxes.",
    "BoxESP",
    function(Value)

        Settings.ESP =
            Value
            or Settings.ESP

        UpdateESP()

    end
)

Hub.CreateToggle(
    VisualPage,
    "Names",
    "Display player names.",
    "NameESP",
    function()

        UpdateESP()

    end
)

Hub.CreateToggle(
    VisualPage,
    "Health",
    "Display player health.",
    "HealthESP",
    function()

        UpdateESP()

    end
)

Hub.CreateToggle(
    VisualPage,
    "Distance",
    "Display player distance.",
    "DistanceESP",
    function()

        UpdateESP()

    end
)

Hub.CreateToggle(
    VisualPage,
    "Misc Visuals",
    "Additional visual player information.",
    "TracerESP",
    function()

        UpdateESP()

    end
)

----------------------------------------------------
-- FOV CHANGER
----------------------------------------------------

Hub.CreateSection(
    VisualPage,
    "CAMERA"
)

Hub.CreateToggle(
    VisualPage,
    "FOV Changer",
    "Change the camera field of view.",
    "FOVChanger",
    function(Value)

        local Camera =
            workspace.CurrentCamera

        if not Camera then
            return
        end

        if Value then
            Camera.FieldOfView =
                Settings.FOV
        else
            Camera.FieldOfView =
                Hub.DefaultFOV
        end

    end
)

Hub.CreateSlider(
    VisualPage,
    "FOV",
    "Camera field of view.",
    "FOV",
    60,
    120,
    1,
    function(Value)

        if Settings.FOVChanger then

            local Camera =
                workspace.CurrentCamera

            if Camera then
                Camera.FieldOfView =
                    Value
            end

        end

    end
)

----------------------------------------------------
-- SKYBOX
----------------------------------------------------

Hub.CreateToggle(
    VisualPage,
    "Skybox",
    "Enable custom skybox mode.",
    "Skybox",
    function(Value)

        if Value then

            if not Lighting:FindFirstChild(
                "RustedSky"
            ) then

                local Sky =
                    Instance.new("Sky")

                Sky.Name =
                    "RustedSky"

                Sky.Parent =
                    Lighting

                Sky.SkyboxBk =
                    "rbxassetid://159454299"

                Sky.SkyboxDn =
                    "rbxassetid://159454296"

                Sky.SkyboxFt =
                    "rbxassetid://159454293"

                Sky.SkyboxLf =
                    "rbxassetid://159454286"

                Sky.SkyboxRt =
                    "rbxassetid://159454300"

                Sky.SkyboxUp =
                    "rbxassetid://159454288"

            end

        else

            local Sky =
                Lighting:FindFirstChild(
                    "RustedSky"
                )

            if Sky then
                Sky:Destroy()
            end

        end

    end
)

----------------------------------------------------
-- CUSTOM HANDS
----------------------------------------------------

Hub.CreateSection(
    VisualPage,
    "HANDS"
)

Hub.CreateToggle(
    VisualPage,
    "Custom Hands",
    "Enable custom hand offsets.",
    "CustomHands",
    function()
        -- Applied in Part 6
    end
)

Hub.CreateSlider(
    VisualPage,
    "Hand X",
    "Horizontal hand offset.",
    "HandX",
    -5,
    5,
    0.1,
    function()
        -- Applied in Part 6
    end
)

Hub.CreateSlider(
    VisualPage,
    "Hand Y",
    "Vertical hand offset.",
    "HandY",
    -5,
    5,
    0.1,
    function()
        -- Applied in Part 6
    end
)

Hub.CreateSlider(
    VisualPage,
    "Hand Z",
    "Depth hand offset.",
    "HandZ",
    -5,
    5,
    0.1,
    function()
        -- Applied in Part 6
    end
)

----------------------------------------------------
-- COMBAT PAGE
----------------------------------------------------

Hub.CreateSection(
    CombatPage,
    "TARGETING"
)

Hub.CreateToggle(
    CombatPage,
    "Silent Aim",
    "Enable target selection assistance.",
    "SilentAim",
    function()
        -- Weapon integration in Part 6
    end
)

Hub.CreateToggle(
    CombatPage,
    "Team Check",
    "Ignore players on your team.",
    "TeamCheck",
    function()
        UpdateESP()
    end
)

Hub.CreateToggle(
    CombatPage,
    "Show FOV",
    "Display the targeting field of view.",
    "ShowFOV",
    function(Value)

        if Hub.FOVCircle then
            Hub.FOVCircle.Visible =
                Value
        end

    end
)

Hub.CreateToggle(
    CombatPage,
    "Snapline",
    "Draw a line toward the selected target.",
    "Snapline",
    function()
        -- Updated in Part 6
    end
)

----------------------------------------------------
-- FOV RADIUS
----------------------------------------------------

Hub.CreateSlider(
    CombatPage,
    "FOV Radius",
    "Targeting field of view radius.",
    "FOVRadius",
    50,
    500,
    1,
    function(Value)

        if Hub.FOVCircle then

            Hub.FOVCircle.Size =
                UDim2.fromOffset(
                    Value * 2,
                    Value * 2
                )

        end

    end
)

----------------------------------------------------
-- HIT PART
----------------------------------------------------

Hub.CreateDropdown(
    CombatPage,
    "Hit Part",
    "Preferred target body part.",
    "HitPart",
    {
        "Head",
        "HumanoidRootPart",
        "UpperTorso",
        "LowerTorso",
    },
    function()
        -- Used by combat integration
    end
)

----------------------------------------------------
-- BULLET TRACER
----------------------------------------------------

Hub.CreateSection(
    CombatPage,
    "BULLET TRACER"
)

Hub.CreateToggle(
    CombatPage,
    "Bullet Tracer",
    "Display a tracer when supported by the weapon system.",
    "BulletTracer",
    function()
        -- Weapon integration in Part 6
    end
)

Hub.CreateSlider(
    CombatPage,
    "Lifetime",
    "Tracer lifetime in seconds.",
    "TracerLifetime",
    0.1,
    5,
    0.1,
    function()
        -- Used by tracer system
    end
)

Hub.CreateDropdown(
    CombatPage,
    "Type",
    "Tracer rendering type.",
    "TracerType",
    {
        "Laser",
        "Beam",
        "Line",
    },
    function()
        -- Used by tracer system
    end
)

Hub.CreateDropdown(
    CombatPage,
    "Color",
    "Tracer color.",
    "TracerColor",
    {
        "Purple",
        "Red",
        "Blue",
        "Green",
        "Pink",
        "Orange",
    },
    function()
        -- Used by tracer system
    end
)

----------------------------------------------------
-- FOV CIRCLE
----------------------------------------------------

local FOVCircle =
    Instance.new("Frame")

FOVCircle.Name =
    "FOVCircle"

FOVCircle.Size =
    UDim2.fromOffset(
        Settings.FOVRadius * 2,
        Settings.FOVRadius * 2
    )

FOVCircle.AnchorPoint =
    Vector2.new(0.5, 0.5)

FOVCircle.Position =
    UDim2.fromScale(
        0.5,
        0.5
    )

FOVCircle.BackgroundTransparency =
    1

FOVCircle.BorderSizePixel =
    0

FOVCircle.Visible =
    Settings.ShowFOV

FOVCircle.ZIndex =
    10

FOVCircle.Parent =
    ScreenGui

Hub.FOVCircle =
    FOVCircle

local FOVStroke =
    Instance.new("UIStroke")

FOVStroke.Color =
    GetAccent()

FOVStroke.Thickness =
    1

FOVStroke.Transparency =
    0.15

FOVStroke.Parent =
    FOVCircle

local FOVCorner =
    Instance.new("UICorner")

FOVCorner.CornerRadius =
    UDim.new(1, 0)

FOVCorner.Parent =
    FOVCircle

----------------------------------------------------
-- UPDATE FOV POSITION
----------------------------------------------------

Hub.Connect(
    RunService.RenderStepped,
    function()

        if not Hub.FOVCircle then
            return
        end

        Hub.FOVCircle.Visible =
            Settings.ShowFOV

        Hub.FOVCircle.Size =
            UDim2.fromOffset(
                Settings.FOVRadius * 2,
                Settings.FOVRadius * 2
            )

        FOVStroke.Color =
            GetAccent()

    end
)

----------------------------------------------------
-- PLAYER CONNECTIONS
----------------------------------------------------

Hub.Connect(
    Players.PlayerAdded,
    function(Target)

        Hub.Connect(
            Target.CharacterAdded,
            function()

                task.wait(0.5)

                UpdateESP()

            end
        )

    end
)

Hub.Connect(
    Players.PlayerRemoving,
    function(Target)

        RemoveESP(Target)

    end
)

Hub.Connect(
    RunService.Heartbeat,
    function()

        if Settings.ESP then
            UpdateESP()
        end

    end
)

----------------------------------------------------
-- INITIAL ESP
----------------------------------------------------

task.spawn(function()

    task.wait(1)

    UpdateESP()

end)

print(
    "Rusted v"
    .. Hub.Version
    .. " | Part 4/6 loaded"
)
--[[
====================================================
                 RUSTED v3.0
                    PART 5/6
            MOVEMENT / MISC FUNCTIONS
====================================================
]]

----------------------------------------------------
-- MOVEMENT PAGE
----------------------------------------------------

Hub.CreateSection(
    MovementPage,
    "MOVEMENT"
)

----------------------------------------------------
-- SPEED HACK
----------------------------------------------------

Hub.CreateToggle(
    MovementPage,
    "Speed Hack",
    "Change your character movement speed.",
    "SpeedHack",
    function(Value)

        local Humanoid =
            Hub.GetHumanoid()

        if not Humanoid then
            return
        end

        if Value then

            Humanoid.WalkSpeed =
                Settings.Speed

        else

            Humanoid.WalkSpeed =
                16

        end

    end
)

----------------------------------------------------
-- SPEED VALUE
----------------------------------------------------

Hub.CreateSlider(
    MovementPage,
    "Speed Value",
    "Movement speed in studs per second.",
    "Speed",
    16,
    150,
    1,
    function(Value)

        if Settings.SpeedHack then

            local Humanoid =
                Hub.GetHumanoid()

            if Humanoid then

                Humanoid.WalkSpeed =
                    Value

            end

        end

    end
)

----------------------------------------------------
-- NOCLIP
----------------------------------------------------

Hub.CreateToggle(
    MovementPage,
    "Noclip",
    "Disable character collisions.",
    "Noclip",
    function()
        -- Handled by Heartbeat below.
    end
)

----------------------------------------------------
-- JUMP
----------------------------------------------------

Hub.CreateToggle(
    MovementPage,
    "Jump",
    "Enable custom jump power.",
    "Jump",
    function(Value)

        local Humanoid =
            Hub.GetHumanoid()

        if not Humanoid then
            return
        end

        pcall(function()
            Humanoid.UseJumpPower = true
        end)

        if Value then

            Humanoid.JumpPower =
                Settings.JumpPower

        else

            Humanoid.JumpPower =
                50

        end

    end
)

----------------------------------------------------
-- JUMP POWER
----------------------------------------------------

Hub.CreateSlider(
    MovementPage,
    "Jump Power",
    "Character jump power.",
    "JumpPower",
    20,
    150,
    1,
    function(Value)

        if Settings.Jump then

            local Humanoid =
                Hub.GetHumanoid()

            if Humanoid then

                pcall(function()
                    Humanoid.UseJumpPower = true
                end)

                Humanoid.JumpPower =
                    Value

            end

        end

    end
)

----------------------------------------------------
-- JUMP SHOT
----------------------------------------------------

Hub.CreateToggle(
    MovementPage,
    "Jump Shot",
    "Keep jump behavior enabled while moving.",
    "JumpShot",
    function()
        -- Applied by Heartbeat.
    end
)

----------------------------------------------------
-- MOVEMENT LOOP
----------------------------------------------------

Hub.Connect(
    RunService.Heartbeat,
    function()

        local Character =
            Player.Character

        local Humanoid =
            Character
            and Character:FindFirstChildOfClass(
                "Humanoid"
            )

        if not Character or not Humanoid then
            return
        end

        ------------------------------------------------
        -- SPEED
        ------------------------------------------------

        if Settings.SpeedHack then

            if Humanoid.WalkSpeed
                ~= Settings.Speed then

                Humanoid.WalkSpeed =
                    Settings.Speed

            end

        end

        ------------------------------------------------
        -- JUMP
        ------------------------------------------------

        if Settings.Jump then

            pcall(function()
                Humanoid.UseJumpPower = true
            end)

            if Humanoid.JumpPower
                ~= Settings.JumpPower then

                Humanoid.JumpPower =
                    Settings.JumpPower

            end

        end

        ------------------------------------------------
        -- NOCLIP
        ------------------------------------------------

        if Settings.Noclip then

            for _, Object in ipairs(
                Character:GetDescendants()
            ) do

                if Object:IsA("BasePart") then

                    Object.CanCollide = false

                end

            end

        end

        ------------------------------------------------
        -- JUMP SHOT
        ------------------------------------------------

        if Settings.JumpShot then

            if Humanoid.FloorMaterial
                ~= Enum.Material.Air then

                if UserInputService:IsKeyDown(
                    Enum.KeyCode.Space
                ) then

                    Humanoid.Jump = true

                end

            end

        end

    end
)

----------------------------------------------------
-- CHARACTER RESPAWN
----------------------------------------------------

Hub.Connect(
    Player.CharacterAdded,
    function(Character)

        task.wait(0.5)

        local Humanoid =
            Character:FindFirstChildOfClass(
                "Humanoid"
            )

        if not Humanoid then
            return
        end

        if Settings.SpeedHack then

            Humanoid.WalkSpeed =
                Settings.Speed

        end

        if Settings.Jump then

            pcall(function()
                Humanoid.UseJumpPower = true
            end)

            Humanoid.JumpPower =
                Settings.JumpPower

        end

    end
)

----------------------------------------------------
-- MISC PAGE
----------------------------------------------------

Hub.CreateSection(
    MiscPage,
    "LIGHTING"
)

----------------------------------------------------
-- FULLBRIGHT
----------------------------------------------------

local OriginalLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
}

Hub.CreateToggle(
    MiscPage,
    "Fullbright",
    "Remove dark lighting effects.",
    "Fullbright",
    function(Value)

        if Value then

            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false

            Lighting.Ambient =
                Color3.fromRGB(
                    255,
                    255,
                    255
                )

            Lighting.OutdoorAmbient =
                Color3.fromRGB(
                    255,
                    255,
                    255
                )

        else

            Lighting.Brightness =
                OriginalLighting.Brightness

            Lighting.ClockTime =
                OriginalLighting.ClockTime

            Lighting.FogEnd =
                OriginalLighting.FogEnd

            Lighting.GlobalShadows =
                OriginalLighting.GlobalShadows

            Lighting.Ambient =
                OriginalLighting.Ambient

            Lighting.OutdoorAmbient =
                OriginalLighting.OutdoorAmbient

        end

    end
)

----------------------------------------------------
-- NEON GUNS
----------------------------------------------------

Hub.CreateSection(
    MiscPage,
    "WEAPONS"
)

Hub.CreateToggle(
    MiscPage,
    "Neon Guns",
    "Apply a neon visual effect to weapon parts.",
    "NeonGuns",
    function()
        -- Applied by weapon scanner below.
    end
)

----------------------------------------------------
-- ORIGINAL MATERIAL STORAGE
----------------------------------------------------

local OriginalGunMaterials = {}

local function IsLikelyWeapon(Object)

    if not Object:IsA("Tool") then
        return false
    end

    local Name =
        string.lower(Object.Name)

    return
        string.find(Name, "gun")
        or string.find(Name, "weapon")
        or string.find(Name, "rifle")
        or string.find(Name, "pistol")
        or string.find(Name, "shotgun")
        or string.find(Name, "sniper")
end

----------------------------------------------------
-- APPLY NEON
----------------------------------------------------

local function UpdateNeonGuns()

    local Character =
        Player.Character

    if not Character then
        return
    end

    for _, Object in ipairs(
        Character:GetChildren()
    ) do

        if IsLikelyWeapon(Object) then

            for _, Part in ipairs(
                Object:GetDescendants()
            ) do

                if Part:IsA("BasePart") then

                    if not OriginalGunMaterials[Part] then

                        OriginalGunMaterials[Part] =
                            Part.Material

                    end

                    if Settings.NeonGuns then

                        Part.Material =
                            Enum.Material.Neon

                    else

                        Part.Material =
                            OriginalGunMaterials[Part]

                    end

                end

            end

        end

    end
end

----------------------------------------------------
-- WEAPON SCAN
----------------------------------------------------

Hub.Connect(
    RunService.Heartbeat,
    function()

        if Settings.NeonGuns then
            UpdateNeonGuns()
        end

    end
)

----------------------------------------------------
-- TOOL ADDED
----------------------------------------------------

Hub.Connect(
    Player.CharacterAdded,
    function(Character)

        Character.ChildAdded:Connect(
            function(Object)

                if Settings.NeonGuns then

                    task.wait()

                    UpdateNeonGuns()

                end

            end
        )

    end
)

----------------------------------------------------
-- MISC VISUAL UPDATE
----------------------------------------------------

Hub.Connect(
    RunService.RenderStepped,
    function()

        ------------------------------------------------
        -- FULLBRIGHT
        ------------------------------------------------

        if Settings.Fullbright then

            if Lighting.Brightness < 2 then
                Lighting.Brightness = 2
            end

            if Lighting.GlobalShadows then
                Lighting.GlobalShadows = false
            end

        end

        ------------------------------------------------
        -- SKYBOX
        ------------------------------------------------

        if Settings.Skybox then

            local Sky =
                Lighting:FindFirstChild(
                    "RustedSky"
                )

            if Sky then
                Sky.Parent = Lighting
            end

        end

    end
)

----------------------------------------------------
-- MOVEMENT BUTTON REFRESH
----------------------------------------------------

local function RefreshMovement()

    local Humanoid =
        Hub.GetHumanoid()

    if not Humanoid then
        return
    end

    if Settings.SpeedHack then

        Humanoid.WalkSpeed =
            Settings.Speed

    else

        Humanoid.WalkSpeed = 16

    end

    if Settings.Jump then

        pcall(function()
            Humanoid.UseJumpPower = true
        end)

        Humanoid.JumpPower =
            Settings.JumpPower

    else

        Humanoid.JumpPower = 50

    end
end

----------------------------------------------------
-- INITIAL MOVEMENT
----------------------------------------------------

task.spawn(function()

    task.wait(1)

    RefreshMovement()

end)

----------------------------------------------------
-- READY
----------------------------------------------------

print(
    "Rusted v"
    .. Hub.Version
    .. " | Part 5/6 loaded"
)
--[[
====================================================
                 RUSTED v3.0
                    PART 6/6
             SETTINGS / FINALIZER
====================================================
]]

----------------------------------------------------
-- SETTINGS PAGE
----------------------------------------------------

Hub.CreateSection(
    SettingsPage,
    "INTERFACE"
)

----------------------------------------------------
-- MENU COLOR
----------------------------------------------------

Hub.CreateDropdown(
    SettingsPage,
    "Menu Color",
    "Change the main Rusted accent color.",
    "MenuColor",
    {
        "Purple",
        "Red",
        "Blue",
        "Green",
        "Pink",
        "Orange",
    },
    function(Value)

        Settings.MenuColor = Value

        Hub.ApplyMenuColor()

        Hub.RefreshControlColors()

        ------------------------------------------------
        -- PAGE BUTTON COLORS
        ------------------------------------------------

        for PageName, Data in pairs(
            Hub.PageButtons
        ) do

            if PageName == Hub.CurrentPage then

                Data.Icon.TextColor3 =
                    Hub.GetMenuColor()

            end

        end

        ------------------------------------------------
        -- FOV
        ------------------------------------------------

        if Hub.FOVCircle then

            local Stroke =
                Hub.FOVCircle:FindFirstChildOfClass(
                    "UIStroke"
                )

            if Stroke then
                Stroke.Color =
                    Hub.GetMenuColor()
            end

        end

    end
)

----------------------------------------------------
-- AUTO UPDATE
----------------------------------------------------

Hub.CreateToggle(
    SettingsPage,
    "Auto Update",
    "Automatically refresh Rusted systems.",
    "AutoUpdate",
    function()
        -- Controlled by update loop.
    end
)

----------------------------------------------------
-- VERSION
----------------------------------------------------

local VersionSection =
    Hub.CreateSection(
        SettingsPage,
        "ABOUT"
    )

local VersionPanel =
    Hub.New(
        "Frame",
        {
            Size =
                UDim2.new(
                    1,
                    0,
                    0,
                    70
                ),

            BackgroundColor3 =
                Theme.Row,

            BorderSizePixel = 0,
        },
        SettingsPage
    )

Hub.Corner(
    VersionPanel,
    5
)

Hub.Stroke(
    VersionPanel,
    Theme.Border,
    1,
    0.55
)

local VersionTitle =
    Hub.New(
        "TextLabel",
        {
            Size =
                UDim2.new(
                    1,
                    -24,
                    0,
                    22
                ),

            Position =
                UDim2.fromOffset(
                    12,
                    8
                ),

            BackgroundTransparency = 1,

            Text =
                "RUSTED",

            TextColor3 =
                Theme.Text,

            Font =
                Enum.Font.GothamBlack,

            TextSize = 13,

            TextXAlignment =
                Enum.TextXAlignment.Left,
        },
        VersionPanel
    )

local VersionInfo =
    Hub.New(
        "TextLabel",
        {
            Size =
                UDim2.new(
                    1,
                    -24,
                    0,
                    18
                ),

            Position =
                UDim2.fromOffset(
                    12,
                    31
                ),

            BackgroundTransparency = 1,

            Text =
                "Version "
                .. Hub.Version
                .. "  •  Rusted Hub",

            TextColor3 =
                Theme.Text3,

            Font =
                Enum.Font.Gotham,

            TextSize = 9,

            TextXAlignment =
                Enum.TextXAlignment.Left,
        },
        VersionPanel
    )

local StatusText =
    Hub.New(
        "TextLabel",
        {
            Size =
                UDim2.new(
                    1,
                    -24,
                    0,
                    16
                ),

            Position =
                UDim2.fromOffset(
                    12,
                    49
                ),

            BackgroundTransparency = 1,

            Text =
                "Ready",

            TextColor3 =
                Theme.Green,

            Font =
                Enum.Font.GothamMedium,

            TextSize = 8,

            TextXAlignment =
                Enum.TextXAlignment.Left,
        },
        VersionPanel
    )

Hub.StatusText =
    StatusText

----------------------------------------------------
-- MENU CONTROLS
----------------------------------------------------

local MenuSection =
    Hub.CreateSection(
        SettingsPage,
        "MENU"
    )

----------------------------------------------------
-- RESET POSITION BUTTON
----------------------------------------------------

local ResetButton =
    Hub.New(
        "TextButton",
        {
            Size =
                UDim2.new(
                    1,
                    0,
                    0,
                    42
                ),

            BackgroundColor3 =
                Theme.Row,

            BorderSizePixel = 0,

            AutoButtonColor = false,

            Text =
                "Reset Menu Position",

            TextColor3 =
                Theme.Text2,

            Font =
                Enum.Font.GothamMedium,

            TextSize = 10,
        },
        SettingsPage
    )

Hub.Corner(
    ResetButton,
    5
)

Hub.Stroke(
    ResetButton,
    Theme.Border,
    1,
    0.55
)

ResetButton.MouseEnter:Connect(
    function()

        Hub.Tween(
            ResetButton,
            {
                BackgroundColor3 =
                    Theme.RowHover
            },
            0.1
        )

    end
)

ResetButton.MouseLeave:Connect(
    function()

        Hub.Tween(
            ResetButton,
            {
                BackgroundColor3 =
                    Theme.Row
            },
            0.1
        )

    end
)

----------------------------------------------------
-- MENU DRAGGING
----------------------------------------------------

local Dragging =
    false

local DragStart =
    nil

local StartPosition =
    nil

local DragInput =
    nil

local function UpdateMainPosition(
    Input
)

    if not Dragging then
        return
    end

    if not Input then
        return
    end

    local Delta =
        Input.Position
        - DragStart

    Main.Position =
        UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset
                + Delta.X,

            StartPosition.Y.Scale,
            StartPosition.Y.Offset
                + Delta.Y
        )
end

----------------------------------------------------
-- HEADER DRAG
----------------------------------------------------

Header.InputBegan:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging =
                true

            DragStart =
                Input.Position

            StartPosition =
                Main.Position

            if Input.UserInputType ==
                Enum.UserInputType.Touch then

                DragInput =
                    Input

            end

        end

    end
)

Header.InputChanged:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch then

            DragInput =
                Input

        end

    end
)

UserInputService.InputChanged:Connect(
    function(Input)

        if not Dragging then
            return
        end

        if Input ==
            DragInput then

            UpdateMainPosition(
                Input
            )

        end

    end
)

UserInputService.InputEnded:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging =
                false

        end

    end
)

----------------------------------------------------
-- RESET POSITION
----------------------------------------------------

local function ResetMenuPosition()

    Main.Position =
        UDim2.new(
            0.5,
            -380,
            0.5,
            -230
        )

end

ResetButton.Activated:Connect(
    function()

        ResetMenuPosition()

        StatusText.Text =
            "Menu position reset."

        StatusText.TextColor3 =
            GetAccent()

        task.delay(
            2,
            function()

                if StatusText then

                    StatusText.Text =
                        "Ready"

                    StatusText.TextColor3 =
                        Theme.Green

                end

            end
        )

    end
)

----------------------------------------------------
-- FLOATING BUTTON POSITION RESET
----------------------------------------------------

local FloatingResetButton =
    Hub.New(
        "TextButton",
        {
            Name =
                "FloatingReset",

            Size =
                UDim2.fromOffset(
                    20,
                    20
                ),

            Position =
                UDim2.new(
                    1,
                    -22,
                    1,
                    -22
                ),

            BackgroundTransparency =
                1,

            Text = "",

            Visible = false,
        },
        ScreenGui
    )

----------------------------------------------------
-- MENU COLOR REFRESH
----------------------------------------------------

local function RefreshAllColors()

    local Accent =
        Hub.GetMenuColor()

    ------------------------------------------------
    -- MAIN
    ------------------------------------------------

    if MainStroke then

        MainStroke.Color =
            Accent

    end

    ------------------------------------------------
    -- LOGO
    ------------------------------------------------

    if LogoAccent then

        LogoAccent.BackgroundColor3 =
            Accent

    end

    ------------------------------------------------
    -- SIDEBAR
    ------------------------------------------------

    for PageName, Data in pairs(
        Hub.PageButtons
    ) do

        if PageName ==
            Hub.CurrentPage then

            Data.Accent.BackgroundColor3 =
                Accent

            Data.Icon.TextColor3 =
                Accent

        end

    end

    ------------------------------------------------
    -- FOV
    ------------------------------------------------

    if Hub.FOVCircle then

        local Stroke =
            Hub.FOVCircle:FindFirstChildOfClass(
                "UIStroke"
            )

        if Stroke then

            Stroke.Color =
                Accent

        end

    end

    ------------------------------------------------
    -- FLOATING
    ------------------------------------------------

    if FloatingButton then

        FloatingButton.TextColor3 =
            Accent

    end

    if FloatingStroke then

        FloatingStroke.Color =
            Accent

    end

    if FloatingAccent then

        FloatingAccent.BackgroundColor3 =
            Accent

    end

end

----------------------------------------------------
-- UPDATE MENU COLOR LOOP
----------------------------------------------------

Hub.Connect(
    RunService.RenderStepped,
    function()

        if Settings.AutoUpdate then

            RefreshAllColors()

        end

    end
)

----------------------------------------------------
-- CAMERA FOV SAFETY
----------------------------------------------------

Hub.Connect(
    RunService.RenderStepped,
    function()

        if not Settings.FOVChanger then
            return
        end

        local Camera =
            workspace.CurrentCamera

        if not Camera then
            return
        end

        if math.abs(
            Camera.FieldOfView
            - Settings.FOV
        ) > 0.1 then

            Camera.FieldOfView =
                Settings.FOV

        end

    end
)

----------------------------------------------------
-- TEAM CHECK UPDATE
----------------------------------------------------

Hub.Connect(
    Players.PlayerAdded,
    function(Target)

        Target:GetPropertyChangedSignal(
            "Team"
        ):Connect(
            function()

                if Settings.ESP then

                    task.defer(
                        function()

                            if typeof(
                                UpdateESP
                            ) == "function" then

                                UpdateESP()

                            end

                        end
                    )

                end

            end
        )

    end
)

Hub.Connect(
    RunService.Heartbeat,
    function()

        if Settings.AutoUpdate then

            if Settings.ESP then

                if typeof(
                    UpdateESP
                ) == "function" then

                    UpdateESP()

                end

            end

        end

    end
)

----------------------------------------------------
-- CHARACTER RESET HANDLER
----------------------------------------------------

Hub.Connect(
    Player.CharacterAdded,
    function()

        task.wait(0.75)

        if Settings.SpeedHack then

            local Humanoid =
                Hub.GetHumanoid()

            if Humanoid then

                Humanoid.WalkSpeed =
                    Settings.Speed

            end

        end

        if Settings.Jump then

            local Humanoid =
                Hub.GetHumanoid()

            if Humanoid then

                pcall(
                    function()

                        Humanoid.UseJumpPower =
                            true

                    end
                )

                Humanoid.JumpPower =
                    Settings.JumpPower

            end

        end

        if Settings.Fullbright then

            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false

            Lighting.Ambient =
                Color3.fromRGB(
                    255,
                    255,
                    255
                )

            Lighting.OutdoorAmbient =
                Color3.fromRGB(
                    255,
                    255,
                    255
                )

        end

    end
)

----------------------------------------------------
-- SETTINGS DEFAULTS
----------------------------------------------------

Settings.MenuColor =
    Settings.MenuColor
    or "Purple"

Settings.AutoUpdate =
    Settings.AutoUpdate ~= false

----------------------------------------------------
-- FINAL COLOR APPLY
----------------------------------------------------

Hub.ApplyMenuColor()

Hub.RefreshControlColors()

RefreshAllColors()

----------------------------------------------------
-- FINAL PAGE
----------------------------------------------------

Hub.SwitchPage(
    Hub.CurrentPage
    or "Visual"
)

----------------------------------------------------
-- MAIN MENU VISIBLE
----------------------------------------------------

Main.Visible =
    true

FloatingButton.Visible =
    false

Settings.MenuOpen =
    true

----------------------------------------------------
-- FINAL STATUS
----------------------------------------------------

if StatusText then

    StatusText.Text =
        "Rusted v"
        .. Hub.Version
        .. " loaded."

    StatusText.TextColor3 =
        GetAccent()

end

----------------------------------------------------
-- LOADING EFFECT
----------------------------------------------------

Main.BackgroundTransparency =
    1

task.spawn(
    function()

        task.wait()

        Hub.Tween(
            Main,
            {
                BackgroundTransparency =
                    0
            },
            0.25
        )

    end
)

----------------------------------------------------
-- FINAL PRINT
----------------------------------------------------

print(
    "========================================"
)

print(
    "        RUSTED v"
        .. Hub.Version
        .. " READY"
)

print(
    "        PART 1/6 - OK"
)

print(
    "        PART 2/6 - OK"
)

print(
    "        PART 3/6 - OK"
)

print(
    "        PART 4/6 - OK"
)

print(
    "        PART 5/6 - OK"
)

print(
    "        PART 6/6 - OK"
)

print(
    "========================================"
)
