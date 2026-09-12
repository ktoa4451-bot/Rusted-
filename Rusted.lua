--==================================================
-- RUSTED HUB
-- VERSION 1.0
-- PART 1 / 2
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Camera = workspace.CurrentCamera

--==================================================
-- SETTINGS
--==================================================

local Settings = {

    -- Visual
    ESP = true,
    Box = true,
    Name = false,
    Distance = false,
    Health = false,
    HealthBar = true,
    Tracer = false,

    -- Visual options
    BoxThickness = 2,
    TracerThickness = 2,
    MaxDistance = 2500,

    -- Menu
    MenuVisible = true,
}

--==================================================
-- COLORS
--==================================================

local Colors = {

    Background = Color3.fromRGB(9, 8, 20),

    Main = Color3.fromRGB(13, 11, 27),

    Top = Color3.fromRGB(18, 15, 36),

    Sidebar = Color3.fromRGB(12, 10, 25),

    Card = Color3.fromRGB(21, 18, 39),

    CardHover = Color3.fromRGB(31, 25, 54),

    Active = Color3.fromRGB(72, 35, 145),

    Active2 = Color3.fromRGB(110, 55, 220),

    Purple = Color3.fromRGB(155, 90, 255),

    PurpleLight = Color3.fromRGB(195, 155, 255),

    White = Color3.fromRGB(242, 238, 255),

    Gray = Color3.fromRGB(150, 140, 170),

    DarkGray = Color3.fromRGB(75, 68, 90),

    Red = Color3.fromRGB(255, 75, 85),

    Green = Color3.fromRGB(75, 230, 105),

    Yellow = Color3.fromRGB(255, 195, 65),
}

--==================================================
-- REMOVE OLD GUI
--==================================================

local OldGui = PlayerGui:FindFirstChild("RustedHub")

if OldGui then
    OldGui:Destroy()
end

local OldESP = PlayerGui:FindFirstChild("RustedESP")

if OldESP then
    OldESP:Destroy()
end

--==================================================
-- GUI
--==================================================

local GUI = Instance.new("ScreenGui")

GUI.Name = "RustedHub"

GUI.ResetOnSpawn = false

GUI.IgnoreGuiInset = true

GUI.DisplayOrder = 1000

GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

GUI.Parent = PlayerGui

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

--==================================================
-- HELPERS
--==================================================

local function MakeCorner(Object, Radius)

    local Corner = Instance.new("UICorner")

    Corner.CornerRadius = UDim.new(
        0,
        Radius or 10
    )

    Corner.Parent = Object

    return Corner
end

local function MakeStroke(
    Object,
    Color,
    Thickness,
    Transparency
)

    local Stroke = Instance.new("UIStroke")

    Stroke.Color = Color or Colors.Purple

    Stroke.Thickness = Thickness or 1

    Stroke.Transparency = Transparency or 0

    Stroke.Parent = Object

    return Stroke
end

local function MakeLabel(
    Parent,
    Text,
    Size,
    Color
)

    local Label = Instance.new("TextLabel")

    Label.BackgroundTransparency = 1

    Label.Text = Text or ""

    Label.TextSize = Size or 14

    Label.TextColor3 = Color or Colors.White

    Label.Font = Enum.Font.Gotham

    Label.TextXAlignment = Enum.TextXAlignment.Left

    Label.TextYAlignment = Enum.TextYAlignment.Center

    Label.Parent = Parent

    return Label
end

local function Tween(
    Object,
    Time,
    Properties
)

    local Info = TweenInfo.new(
        Time or 0.15,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )

    TweenService:Create(
        Object,
        Info,
        Properties
    ):Play()
end

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")

Main.Name = "Main"

Main.AnchorPoint = Vector2.new(0.5, 0.5)

Main.BackgroundColor3 = Colors.Main

Main.BorderSizePixel = 0

Main.ClipsDescendants = true

Main.Parent = GUI

MakeCorner(Main, 20)

MakeStroke(
    Main,
    Colors.Purple,
    2,
    0.05
)

--==================================================
-- TOP BAR
--==================================================

local TopBar = Instance.new("Frame")

TopBar.Name = "TopBar"

TopBar.BackgroundColor3 = Colors.Top

TopBar.BorderSizePixel = 0

TopBar.Size = UDim2.new(
    1,
    0,
    0,
    62
)

TopBar.Parent = Main

--==================================================
-- LOGO
--==================================================

local Logo = MakeLabel(
    TopBar,
    "◆",
    25,
    Colors.Purple
)

Logo.Position = UDim2.new(
    0,
    15,
    0,
    13
)

Logo.Size = UDim2.fromOffset(
    35,
    35
)

Logo.Font = Enum.Font.GothamBold

Logo.TextXAlignment =
    Enum.TextXAlignment.Center

--==================================================
-- TITLE
--==================================================

local Title = MakeLabel(
    TopBar,
    "RUSTED",
    18,
    Colors.White
)

Title.Position = UDim2.new(
    0,
    55,
    0,
    8
)

Title.Size = UDim2.fromOffset(
    180,
    25
)

Title.Font = Enum.Font.GothamBold

--==================================================
-- SUBTITLE
--==================================================

local Subtitle = MakeLabel(
    TopBar,
    "PRIVATE  •  VISUAL",
    10,
    Colors.Gray
)

Subtitle.Position = UDim2.new(
    0,
    56,
    0,
    33
)

Subtitle.Size = UDim2.fromOffset(
    200,
    18
)

--==================================================
-- CLOSE BUTTON
--==================================================

local CloseButton = Instance.new("TextButton")

CloseButton.Name = "Close"

CloseButton.BackgroundTransparency = 1

CloseButton.Text = "×"

CloseButton.TextSize = 27

CloseButton.Font = Enum.Font.GothamBold

CloseButton.TextColor3 = Colors.White

CloseButton.Size = UDim2.fromOffset(
    42,
    42
)

CloseButton.Position = UDim2.new(
    1,
    -47,
    0,
    10
)

CloseButton.AutoButtonColor = false

CloseButton.Parent = TopBar

--==================================================
-- MINIMIZE BUTTON
--==================================================

local MinButton = Instance.new("TextButton")

MinButton.Name = "Minimize"

MinButton.BackgroundTransparency = 1

MinButton.Text = "−"

MinButton.TextSize = 25

MinButton.Font = Enum.Font.GothamBold

MinButton.TextColor3 = Colors.White

MinButton.Size = UDim2.fromOffset(
    42,
    42
)

MinButton.Position = UDim2.new(
    1,
    -90,
    0,
    10
)

MinButton.AutoButtonColor = false

MinButton.Parent = TopBar

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")

Sidebar.Name = "Sidebar"

Sidebar.BackgroundColor3 = Colors.Sidebar

Sidebar.BorderSizePixel = 0

Sidebar.Position = UDim2.new(
    0,
    0,
    0,
    62
)

Sidebar.Size = UDim2.new(
    0,
    150,
    1,
    -62
)

Sidebar.Parent = Main

--==================================================
-- SIDEBAR LIST
--==================================================

local SidebarLayout = Instance.new(
    "UIListLayout"
)

SidebarLayout.Padding =
    UDim.new(0, 8)

SidebarLayout.HorizontalAlignment =
    Enum.HorizontalAlignment.Center

SidebarLayout.SortOrder =
    Enum.SortOrder.LayoutOrder

SidebarLayout.Parent = Sidebar

local SidebarPadding = Instance.new(
    "UIPadding"
)

SidebarPadding.PaddingTop =
    UDim.new(0, 15)

SidebarPadding.PaddingLeft =
    UDim.new(0, 8)

SidebarPadding.PaddingRight =
    UDim.new(0, 8)

SidebarPadding.Parent = Sidebar

--==================================================
-- CATEGORY DATA
--==================================================

local CategoryData = {

    {
        Name = "Visual",
        Icon = "◉",
    },

    {
        Name = "Combat",
        Icon = "✥",
    },

    {
        Name = "Movement",
        Icon = "➤",
    },

    {
        Name = "Misc",
        Icon = "⚙",
    },

    {
        Name = "Settings",
        Icon = "☷",
    },
}

local CategoryButtons = {}

--==================================================
-- CREATE CATEGORIES
--==================================================

for Index, Data in ipairs(CategoryData) do

    local Button = Instance.new(
        "TextButton"
    )

    Button.Name = Data.Name

    Button.LayoutOrder = Index

    Button.Size = UDim2.new(
        1,
        0,
        0,
        46
    )

    Button.BackgroundColor3 =
        Index == 1
        and Colors.Active
        or Colors.Card

    Button.BorderSizePixel = 0

    Button.Text = ""

    Button.AutoButtonColor = false

    Button.Parent = Sidebar

    MakeCorner(Button, 11)

    local Icon = MakeLabel(
        Button,
        Data.Icon,
        18,
        Colors.PurpleLight
    )

    Icon.Position = UDim2.new(
        0,
        4,
        0,
        0
    )

    Icon.Size = UDim2.fromOffset(
        35,
        46
    )

    Icon.TextXAlignment =
        Enum.TextXAlignment.Center

    local Name = MakeLabel(
        Button,
        Data.Name,
        13,
        Colors.White
    )

    Name.Position = UDim2.new(
        0,
        42,
        0,
        0
    )

    Name.Size = UDim2.new(
        1,
        -45,
        1,
        0
    )

    Name.Font =
        Enum.Font.GothamMedium

    CategoryButtons[Data.Name] =
        Button
end

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")

Content.Name = "Content"

Content.BackgroundTransparency = 1

Content.Position = UDim2.new(
    0,
    150,
    0,
    62
)

Content.Size = UDim2.new(
    1,
    -150,
    1,
    -62
)

Content.Parent = Main

--==================================================
-- VISUAL PAGE
--==================================================

local VisualPage = Instance.new(
    "ScrollingFrame"
)

VisualPage.Name = "VisualPage"

VisualPage.BackgroundTransparency = 1

VisualPage.BorderSizePixel = 0

VisualPage.Size = UDim2.new(
    1,
    0,
    1,
    0
)

VisualPage.CanvasSize =
    UDim2.new(0,0,0,0)

VisualPage.AutomaticCanvasSize =
    Enum.AutomaticSize.Y

VisualPage.ScrollBarThickness = 3

VisualPage.ScrollBarImageColor3 =
    Colors.Purple

VisualPage.Parent = Content

local VisualPadding = Instance.new(
    "UIPadding"
)

VisualPadding.PaddingTop =
    UDim.new(0, 16)

VisualPadding.PaddingBottom =
    UDim.new(0, 16)

VisualPadding.PaddingLeft =
    UDim.new(0, 16)

VisualPadding.PaddingRight =
    UDim.new(0, 16)

VisualPadding.Parent =
    VisualPage

local VisualLayout = Instance.new(
    "UIListLayout"
)

VisualLayout.Padding =
    UDim.new(0, 8)

VisualLayout.SortOrder =
    Enum.SortOrder.LayoutOrder

VisualLayout.Parent =
    VisualPage

--==================================================
-- VISUAL HEADER
--==================================================

local VisualHeader = MakeLabel(
    VisualPage,
    "Visual",
    20,
    Colors.White
)

VisualHeader.LayoutOrder = 1

VisualHeader.Size =
    UDim2.new(1,0,0,30)

VisualHeader.Font =
    Enum.Font.GothamBold

local VisualDescription = MakeLabel(
    VisualPage,
    "Настройки отображения игроков",
    11,
    Colors.Gray
)

VisualDescription.LayoutOrder = 2

VisualDescription.Size =
    UDim2.new(1,0,0,23)

--==================================================
-- TOGGLE SYSTEM
--==================================================

local ToggleRefresh = {}

local function CreateToggle(
    Name,
    Description,
    Key,
    Order
)

    local Button = Instance.new(
        "TextButton"
    )

    Button.Name = Key

    Button.LayoutOrder = Order

    Button.Size = UDim2.new(
        1,
        0,
        0,
        62
    )

    Button.BackgroundColor3 =
        Colors.Card

    Button.BorderSizePixel = 0

    Button.Text = ""

    Button.AutoButtonColor = false

    Button.Parent = VisualPage

    MakeCorner(Button, 11)

    local NameLabel = MakeLabel(
        Button,
        Name,
        14,
        Colors.White
    )

    NameLabel.Position = UDim2.new(
        0,
        15,
        0,
        7
    )

    NameLabel.Size = UDim2.new(
        1,
        -85,
        0,
        22
    )

    NameLabel.Font =
        Enum.Font.GothamMedium

    local DescLabel = MakeLabel(
        Button,
        Description,
        10,
        Colors.Gray
    )

    DescLabel.Position = UDim2.new(
        0,
        15,
        0,
        32
    )

    DescLabel.Size = UDim2.new(
        1,
        -85,
        0,
        18
    )

    -- Switch

    local Switch = Instance.new(
        "Frame"
    )

    Switch.Size =
        UDim2.fromOffset(44,24)

    Switch.Position =
        UDim2.new(
            1,
            -59,
            0.5,
            -12
        )

    Switch.BorderSizePixel = 0

    Switch.Parent = Button

    MakeCorner(Switch,12)

    local Circle = Instance.new(
        "Frame"
    )

    Circle.Size =
        UDim2.fromOffset(18,18)

    Circle.BorderSizePixel = 0

    Circle.Parent = Switch

    MakeCorner(Circle,10)

    local function Refresh()

        if Settings[Key] then

            Switch.BackgroundColor3 =
                Colors.Active2

            Circle.BackgroundColor3 =
                Colors.White

            Circle.Position =
                UDim2.new(
                    1,
                    -21,
                    0.5,
                    -9
                )

        else

            Switch.BackgroundColor3 =
                Color3.fromRGB(
                    50,
                    44,
                    62
                )

            Circle.BackgroundColor3 =
                Colors.DarkGray

            Circle.Position =
                UDim2.new(
                    0,
                    3,
                    0.5,
                    -9
                )
        end
    end

    ToggleRefresh[Key] = Refresh

    Button.MouseButton1Click:Connect(
        function()

            Settings[Key] =
                not Settings[Key]

            Refresh()
        end
    )

    Button.MouseEnter:Connect(
        function()

            Tween(
                Button,
                0.12,
                {
                    BackgroundColor3 =
                        Colors.CardHover
                }
            )
        end
    )

    Button.MouseLeave:Connect(
        function()

            Tween(
                Button,
                0.12,
                {
                    BackgroundColor3 =
                        Colors.Card
                }
            )
        end
    )

    Refresh()

    return Button
end

--==================================================
-- VISUAL TOGGLES
--==================================================

CreateToggle(
    "ESP",
    "Включить отображение игроков",
    "ESP",
    3
)

CreateToggle(
    "Box ESP",
    "Рамка вокруг игрока",
    "Box",
    4
)

CreateToggle(
    "Name ESP",
    "Имя игрока над рамкой",
    "Name",
    5
)

CreateToggle(
    "Distance ESP",
    "Расстояние до игрока",
    "Distance",
    6
)

CreateToggle(
    "Health ESP",
    "Показывать HP игрока",
    "Health",
    7
)

CreateToggle(
    "Health Bar",
    "Полоска здоровья возле рамки",
    "HealthBar",
    8
)

CreateToggle(
    "Tracer ESP",
    "Линия от нижней части экрана",
    "Tracer",
    9
)

--==================================================
-- OTHER PAGES
--==================================================

local OtherPages = {}

local function CreateOtherPage(
    CategoryName,
    Description
)

    local Page = Instance.new(
        "Frame"
    )

    Page.Name =
        CategoryName .. "Page"

    Page.BackgroundTransparency = 1

    Page.Size =
        UDim2.new(1,0,1,0)

    Page.Visible = false

    Page.Parent = Content

    local Header = MakeLabel(
        Page,
        CategoryName,
        21,
        Colors.White
    )

    Header.Position =
        UDim2.new(0,20,0,20)

    Header.Size =
        UDim2.new(1,-40,0,32)

    Header.Font =
        Enum.Font.GothamBold

    local Desc = MakeLabel(
        Page,
        Description,
        12,
        Colors.Gray
    )

    Desc.Position =
        UDim2.new(0,20,0,55)

    Desc.Size =
        UDim2.new(1,-40,0,30)

    local Info = Instance.new(
        "Frame"
    )

    Info.Position =
        UDim2.new(0,20,0,100)

    Info.Size =
        UDim2.new(1,-40,0,80)

    Info.BackgroundColor3 =
        Colors.Card

    Info.BorderSizePixel = 0

    Info.Parent = Page

    MakeCorner(Info,12)

    local InfoText = MakeLabel(
        Info,
        "Функции этой категории\nбудут добавлены позже.",
        13,
        Colors.Gray
    )

    InfoText.Position =
        UDim2.new(0,15,0,10)

    InfoText.Size =
        UDim2.new(1,-30,1,-20)

    OtherPages[CategoryName] =
        Page
end

CreateOtherPage(
    "Combat",
    "Настройки боевых функций"
)

CreateOtherPage(
    "Movement",
    "Настройки движения"
)

CreateOtherPage(
    "Misc",
    "Дополнительные функции"
)

CreateOtherPage(
    "Settings",
    "Настройки меню"
)

--==================================================
-- CATEGORY SWITCH
--==================================================

local function SelectCategory(
    Category
)

    for Name, Button in pairs(
        CategoryButtons
    ) do

        if Name == Category then

            Button.BackgroundColor3 =
                Colors.Active

        else

            Button.BackgroundColor3 =
                Colors.Card
        end
    end

    VisualPage.Visible =
        Category == "Visual"

    for Name, Page in pairs(
        OtherPages
    ) do

        Page.Visible =
            Name == Category
    end
end

for Category, Button in pairs(
    CategoryButtons
) do

    Button.MouseButton1Click:Connect(
        function()

            SelectCategory(Category)
        end
    )
end

--==================================================
-- END PART 1
--==================================================
--==================================================
-- RUSTED HUB
-- PART 2 / 2
--==================================================

--==================================================
-- ESP OBJECTS
--==================================================

local ESPObjects = {}

--==================================================
-- CREATE ESP LINE
--==================================================

local function CreateESPLine()

    local Line = Instance.new(
        "Frame"
    )

    Line.BackgroundColor3 =
        Colors.Purple

    Line.BorderSizePixel = 0

    Line.AnchorPoint =
        Vector2.new(0.5,0.5)

    Line.Visible = false

    Line.ZIndex = 2

    Line.Parent = ESPGui

    return Line
end

--==================================================
-- CREATE ESP TEXT
--==================================================

local function CreateESPText()

    local Text = Instance.new(
        "TextLabel"
    )

    Text.BackgroundTransparency = 1

    Text.TextColor3 =
        Colors.White

    Text.TextStrokeTransparency =
        0.25

    Text.Font =
        Enum.Font.GothamBold

    Text.TextSize = 13

    Text.TextXAlignment =
        Enum.TextXAlignment.Center

    Text.TextYAlignment =
        Enum.TextYAlignment.Center

    Text.Visible = false

    Text.ZIndex = 3

    Text.Parent = ESPGui

    return Text
end

--==================================================
-- CREATE PLAYER ESP
--==================================================

local function CreatePlayerESP(Player)

    if Player == LocalPlayer then
        return
    end

    if ESPObjects[Player] then
        return
    end

    local Data = {}

    Data.Top =
        CreateESPLine()

    Data.Bottom =
        CreateESPLine()

    Data.Left =
        CreateESPLine()

    Data.Right =
        CreateESPLine()

    Data.Tracer =
        CreateESPLine()

    Data.Name =
        CreateESPText()

    Data.Distance =
        CreateESPText()

    Data.Health =
        CreateESPText()

    -- Health bar background

    Data.HealthBack =
        Instance.new("Frame")

    Data.HealthBack.BackgroundColor3 =
        Color3.fromRGB(
            25,
            25,
            30
        )

    Data.HealthBack.BorderSizePixel = 0

    Data.HealthBack.Visible = false

    Data.HealthBack.ZIndex = 2

    Data.HealthBack.Parent =
        ESPGui

    MakeCorner(
        Data.HealthBack,
        2
    )

    -- Health bar

    Data.HealthFill =
        Instance.new("Frame")

    Data.HealthFill.BackgroundColor3 =
        Colors.Green

    Data.HealthFill.BorderSizePixel = 0

    Data.HealthFill.Size =
        UDim2.new(
            1,
            0,
            1,
            0
        )

    Data.HealthFill.Parent =
        Data.HealthBack

    MakeCorner(
        Data.HealthFill,
        2
    )

    ESPObjects[Player] =
        Data
end

--==================================================
-- HIDE ESP
--==================================================

local function HideESP(Data)

    if not Data then
        return
    end

    Data.Top.Visible = false

    Data.Bottom.Visible = false

    Data.Left.Visible = false

    Data.Right.Visible = false

    Data.Tracer.Visible = false

    Data.Name.Visible = false

    Data.Distance.Visible = false

    Data.Health.Visible = false

    Data.HealthBack.Visible = false
end

--==================================================
-- REMOVE ESP
--==================================================

local function RemovePlayerESP(Player)

    local Data =
        ESPObjects[Player]

    if not Data then
        return
    end

    for _, Object in pairs(Data) do

        if typeof(Object) == "Instance" then

            Object:Destroy()
        end
    end

    ESPObjects[Player] = nil
end

--==================================================
-- LINE POSITION
--==================================================

local function SetLine(
    Line,
    PointA,
    PointB,
    Thickness
)

    local DX =
        PointB.X - PointA.X

    local DY =
        PointB.Y - PointA.Y

    local Length =
        math.sqrt(
            DX * DX +
            DY * DY
        )

    Line.Size =
        UDim2.fromOffset(
            math.max(Length,1),
            Thickness or 2
        )

    Line.Position =
        UDim2.fromOffset(
            (PointA.X + PointB.X) / 2,
            (PointA.Y + PointB.Y) / 2
        )

    Line.Rotation =
        math.deg(
            math.atan2(DY,DX)
        )

    Line.Visible = true
end

--==================================================
-- CHARACTER BOUNDS
--==================================================

local function GetScreenBounds(
    Character
)

    local Success, CF, Size =
        pcall(
            function()

                local CFrameValue,
                    SizeValue =
                    Character:GetBoundingBox()

                return true,
                    CFrameValue,
                    SizeValue
            end
        )

    if not Success then
        return nil
    end

    local Corners = {

        Vector3.new(
            -Size.X/2,
            -Size.Y/2,
            -Size.Z/2
        ),

        Vector3.new(
            -Size.X/2,
            -Size.Y/2,
            Size.Z/2
        ),

        Vector3.new(
            -Size.X/2,
            Size.Y/2,
            -Size.Z/2
        ),

        Vector3.new(
            -Size.X/2,
            Size.Y/2,
            Size.Z/2
        ),

        Vector3.new(
            Size.X/2,
            -Size.Y/2,
            -Size.Z/2
        ),

        Vector3.new(
            Size.X/2,
            -Size.Y/2,
            Size.Z/2
        ),

        Vector3.new(
            Size.X/2,
            Size.Y/2,
            -Size.Z/2
        ),

        Vector3.new(
            Size.X/2,
            Size.Y/2,
            Size.Z/2
        ),
    }

    local MinX = math.huge

    local MinY = math.huge

    local MaxX = -math.huge

    local MaxY = -math.huge

    local Visible =
        false

    for _, Corner in ipairs(
        Corners
    ) do

        local WorldPosition =
            CF:PointToWorldSpace(
                Corner
            )

        local ScreenPosition,
            OnScreen =
            Camera:WorldToViewportPoint(
                WorldPosition
            )

        if ScreenPosition.Z > 0 then

            Visible = true

            MinX =
                math.min(
                    MinX,
                    ScreenPosition.X
                )

            MinY =
                math.min(
                    MinY,
                    ScreenPosition.Y
                )

            MaxX =
                math.max(
                    MaxX,
                    ScreenPosition.X
                )

            MaxY =
                math.max(
                    MaxY,
                    ScreenPosition.Y
                )
        end
    end

    if not Visible then
        return nil
    end

    return MinX,
        MinY,
        MaxX,
        MaxY
end

--==================================================
-- UPDATE ESP
--==================================================

local function UpdateESP(
    Player,
    Data
)

    if not Settings.ESP then

        HideESP(Data)

        return
    end

    local Character =
        Player.Character

    if not Character then

        HideESP(Data)

        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    local Root =
        Character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not Humanoid or not Root then

        HideESP(Data)

        return
    end

    if Humanoid.Health <= 0 then

        HideESP(Data)

        return
    end

    local Distance =
        (
            Camera.CFrame.Position
            - Root.Position
        ).Magnitude

    if Distance >
        Settings.MaxDistance then

        HideESP(Data)

        return
    end

    local MinX,
        MinY,
        MaxX,
        MaxY =
        GetScreenBounds(
            Character
        )

    if not MinX then

        HideESP(Data)

        return
    end

    local Width =
        MaxX - MinX

    local Height =
        MaxY - MinY

    local CenterX =
        (MinX + MaxX) / 2

    --================================================
    -- BOX
    --================================================

    if Settings.Box then

        SetLine(
            Data.Top,
            Vector2.new(
                MinX,
                MinY
            ),
            Vector2.new(
                MaxX,
                MinY
            ),
            Settings.BoxThickness
        )

        SetLine(
            Data.Bottom,
            Vector2.new(
                MinX,
                MaxY
            ),
            Vector2.new(
                MaxX,
                MaxY
            ),
            Settings.BoxThickness
        )

        SetLine(
            Data.Left,
            Vector2.new(
                MinX,
                MinY
            ),
            Vector2.new(
                MinX,
                MaxY
            ),
            Settings.BoxThickness
        )

        SetLine(
            Data.Right,
            Vector2.new(
                MaxX,
                MinY
            ),
            Vector2.new(
                MaxX,
                MaxY
            ),
            Settings.BoxThickness
        )

    else

        Data.Top.Visible = false

        Data.Bottom.Visible = false

        Data.Left.Visible = false

        Data.Right.Visible = false
    end

    --================================================
    -- NAME
    --================================================

    if Settings.Name then

        Data.Name.Text =
            Player.DisplayName

        local NameWidth =
            math.max(
                Width,
                90
            )

        Data.Name.Size =
            UDim2.fromOffset(
                NameWidth,
                20
            )

        Data.Name.Position =
            UDim2.fromOffset(
                CenterX -
                    NameWidth / 2,
                MinY - 23
            )

        Data.Name.Visible = true

    else

        Data.Name.Visible = false
    end

    --================================================
    -- DISTANCE
    --================================================

    if Settings.Distance then

        Data.Distance.Text =
            tostring(
                math.floor(
                    Distance
                )
            ) .. " studs"

        local DistanceWidth =
            math.max(
                Width,
                90
            )

        Data.Distance.Size =
            UDim2.fromOffset(
                DistanceWidth,
                18
            )

        Data.Distance.Position =
            UDim2.fromOffset(
                CenterX -
                    DistanceWidth / 2,
                MaxY + 2
            )

        Data.Distance.Visible = true

    else

        Data.Distance.Visible = false
    end

    --================================================
    -- HEALTH TEXT
    --================================================

    if Settings.Health then

        local CurrentHP =
            math.max(
                0,
                Humanoid.Health
            )

        local MaxHP =
            math.max(
                1,
                Humanoid.MaxHealth
            )

        Data.Health.Text =
            math.floor(
                CurrentHP
            ) ..
            " / " ..
            math.floor(
                MaxHP
            )

        Data.Health.Size =
            UDim2.fromOffset(
                85,
                20
            )

        Data.Health.Position =
            UDim2.fromOffset(
                MinX - 90,
                MinY
            )

        Data.Health.Visible = true

    else

        Data.Health.Visible = false
    end

    --================================================
    -- HEALTH BAR
    --================================================

    if Settings.HealthBar then

        local CurrentHP =
            math.max(
                0,
                Humanoid.Health
            )

        local MaxHP =
            math.max(
                1,
                Humanoid.MaxHealth
            )

        local Percent =
            math.clamp(
                CurrentHP / MaxHP,
                0,
                1
            )

        Data.HealthBack.Size =
            UDim2.fromOffset(
                5,
                math.max(
                    Height,
                    5
                )
            )

        Data.HealthBack.Position =
            UDim2.fromOffset(
                MinX - 8,
                MinY
            )

        Data.HealthBack.Visible =
            true

        Data.HealthFill.Size =
            UDim2.new(
                1,
                0,
                Percent,
                0
            )

        Data.HealthFill.Position =
            UDim2.new(
                0,
                0,
                1 - Percent,
                0
            )

        if Percent > 0.60 then

            Data.HealthFill.BackgroundColor3 =
                Colors.Green

        elseif Percent > 0.30 then

            Data.HealthFill.BackgroundColor3 =
                Colors.Yellow

        else

            Data.HealthFill.BackgroundColor3 =
                Colors.Red
        end

    else

        Data.HealthBack.Visible =
            false
    end

    --================================================
    -- TRACER
    --================================================

    if Settings.Tracer then

        local Viewport =
            Camera.ViewportSize

        local StartPoint =
            Vector2.new(
                Viewport.X / 2,
                Viewport.Y
            )

        local EndPoint =
            Vector2.new(
                CenterX,
                MaxY
            )

        SetLine(
            Data.Tracer,
            StartPoint,
            EndPoint,
            Settings.TracerThickness
        )

    else

        Data.Tracer.Visible = false
    end
end

--==================================================
-- CREATE EXISTING ESP
--==================================================

for _, Player in ipairs(
    Players:GetPlayers()
) do

    CreatePlayerESP(Player)
end

--==================================================
-- NEW PLAYER
--==================================================

Players.PlayerAdded:Connect(
    function(Player)

        CreatePlayerESP(Player)
    end
)

--==================================================
-- PLAYER REMOVED
--==================================================

Players.PlayerRemoving:Connect(
    function(Player)

        RemovePlayerESP(Player)
    end
)

--==================================================
-- RENDER LOOP
--==================================================

RunService.RenderStepped:Connect(
    function()

        Camera =
            workspace.CurrentCamera
            or Camera

        for Player, Data in pairs(
            ESPObjects
        ) do

            if Player.Parent ==
                Players then

                UpdateESP(
                    Player,
                    Data
                )

            else

                RemovePlayerESP(
                    Player
                )
            end
        end
    end
)

--==================================================
-- RESPONSIVE MENU
--==================================================

local function UpdateMenuSize()

    local Viewport =
        Camera.ViewportSize

    local Width =
        Viewport.X

    local Height =
        Viewport.Y

    local MenuWidth

    local MenuHeight

    -- PHONE

    if Width < 500 then

        MenuWidth =
            math.floor(
                Width * 0.90
            )

        MenuHeight =
            math.floor(
                Height * 0.76
            )

    -- TABLET

    elseif Width < 900 then

        MenuWidth =
            math.floor(
                Width * 0.75
            )

        MenuHeight =
            math.floor(
                Height * 0.72
            )

    -- PC

    else

        MenuWidth =
            math.min(
                700,
                math.floor(
                    Width * 0.55
                )
            )

        MenuHeight =
            math.min(
                530,
                math.floor(
                    Height * 0.72
                )
            )
    end

    MenuWidth =
        math.max(
            MenuWidth,
            310
        )

    MenuHeight =
        math.max(
            MenuHeight,
            320
        )

    Main.Size =
        UDim2.fromOffset(
            MenuWidth,
            MenuHeight
        )

    Main.Position =
        UDim2.new(
            0.5,
            0,
            0.5,
            0
        )

    local SidebarWidth =
        math.clamp(
            MenuWidth * 0.235,
            88,
            155
        )

    Sidebar.Size =
        UDim2.new(
            0,
            SidebarWidth,
            1,
            -62
        )

    Content.Position =
        UDim2.new(
            0,
            SidebarWidth,
            0,
            62
        )

    Content.Size =
        UDim2.new(
            1,
            -SidebarWidth,
            1,
            -62
        )
end

--==================================================
-- VIEWPORT CHANGE
--==================================================

Camera:GetPropertyChangedSignal(
    "ViewportSize"
):Connect(
    function()

        task.defer(
            UpdateMenuSize
        )
    end
)

--==================================================
-- MINIMIZE
--==================================================

local Minimized = false

local SavedSize

local SavedPosition

MinButton.MouseButton1Click:Connect(
    function()

        if not Minimized then

            SavedSize =
                Main.Size

            SavedPosition =
                Main.Position

            Minimized = true

            Sidebar.Visible = false

            Content.Visible = false

            Main.Size =
                UDim2.fromOffset(
                    math.min(
                        300,
                        Camera.ViewportSize.X
                        * 0.70
                    ),
                    62
                )

            Main.Position =
                UDim2.new(
                    0.5,
                    0,
                    0,
                    10
                )

        else

            Minimized = false

            Sidebar.Visible = true

            Content.Visible = true

            UpdateMenuSize()
        end
    end
)

--==================================================
-- CLOSE / OPEN BUTTON
--==================================================

local OpenButton =
    Instance.new("TextButton")

OpenButton.Name =
    "OpenButton"

OpenButton.Size =
    UDim2.fromOffset(
        48,
        48
    )

OpenButton.Position =
    UDim2.new(
        0,
        15,
        0.5,
        -24
    )

OpenButton.BackgroundColor3 =
    Colors.Main

OpenButton.BorderSizePixel = 0

OpenButton.Text = "◆"

OpenButton.TextSize = 20

OpenButton.TextColor3 =
    Colors.Purple

OpenButton.Font =
    Enum.Font.GothamBold

OpenButton.Visible = false

OpenButton.AutoButtonColor = false

OpenButton.Parent = GUI

MakeCorner(
    OpenButton,
    13
)

MakeStroke(
    OpenButton,
    Colors.Purple,
    1,
    0.1
)

CloseButton.MouseButton1Click:Connect(
    function()

        GUI.Enabled = true

        Main.Visible = false

        OpenButton.Visible = true
    end
)

OpenButton.MouseButton1Click:Connect(
    function()

        Main.Visible = true

        OpenButton.Visible = false

        UpdateMenuSize()
    end
)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart = nil
local StartPosition = nil

local function BeginDrag(Input)

    if Input.UserInputType ~= Enum.UserInputType.MouseButton1
        and Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    Dragging = true
    DragStart = Input.Position
    StartPosition = Main.Position

    Input.Changed:Connect(function()

        if Input.UserInputState == Enum.UserInputState.End then
            Dragging = false
        end

    end)
end

TopBar.InputBegan:Connect(BeginDrag)

UserInputService.InputChanged:Connect(function(Input)

    if not Dragging then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
        and Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = Input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end)

--==================================================
-- CLOSE BUTTON HOVER
--==================================================

CloseButton.MouseEnter:Connect(function()

    Tween(
        CloseButton,
        0.12,
        {
            TextColor3 = Colors.Red
        }
    )

end)

CloseButton.MouseLeave:Connect(function()

    Tween(
        CloseButton,
        0.12,
        {
            TextColor3 = Colors.White
        }
    )

end)

--==================================================
-- MINIMIZE BUTTON HOVER
--==================================================

MinButton.MouseEnter:Connect(function()

    Tween(
        MinButton,
        0.12,
        {
            TextColor3 = Colors.PurpleLight
        }
    )

end)

MinButton.MouseLeave:Connect(function()

    Tween(
        MinButton,
        0.12,
        {
            TextColor3 = Colors.White
        }
    )

end)

--==================================================
-- CATEGORY HOVER
--==================================================

for Category, Button in pairs(CategoryButtons) do

    Button.MouseEnter:Connect(function()

        if Button.BackgroundColor3 ~= Colors.Active then

            Tween(
                Button,
                0.12,
                {
                    BackgroundColor3 = Colors.CardHover
                }
            )

        end

    end)

    Button.MouseLeave:Connect(function()

        if Button.BackgroundColor3 ~= Colors.Active then

            Tween(
                Button,
                0.12,
                {
                    BackgroundColor3 = Colors.Card
                }
            )

        end

    end)

end

--==================================================
-- OPEN BUTTON
--==================================================

local OpenButton = Instance.new("TextButton")

OpenButton.Name = "OpenButton"

OpenButton.Size = UDim2.fromOffset(
    48,
    48
)

OpenButton.Position = UDim2.new(
    0,
    15,
    0.5,
    -24
)

OpenButton.BackgroundColor3 =
    Colors.Main

OpenButton.BorderSizePixel = 0

OpenButton.Text = "◆"

OpenButton.TextSize = 20

OpenButton.TextColor3 =
    Colors.Purple

OpenButton.Font =
    Enum.Font.GothamBold

OpenButton.AutoButtonColor = false

OpenButton.Visible = false

OpenButton.Parent = GUI

MakeCorner(
    OpenButton,
    13
)

MakeStroke(
    OpenButton,
    Colors.Purple,
    1,
    0.1
)

--==================================================
-- CLOSE
--==================================================

CloseButton.MouseButton1Click:Connect(function()

    Main.Visible = false

    OpenButton.Visible = true

end)

--==================================================
-- REOPEN
--==================================================

OpenButton.MouseButton1Click:Connect(function()

    Main.Visible = true

    OpenButton.Visible = false

    UpdateMenuSize()

end)

--==================================================
-- OPEN BUTTON HOVER
--==================================================

OpenButton.MouseEnter:Connect(function()

    Tween(
        OpenButton,
        0.12,
        {
            BackgroundColor3 =
                Colors.CardHover
        }
    )

end)

OpenButton.MouseLeave:Connect(function()

    Tween(
        OpenButton,
        0.12,
        {
            BackgroundColor3 =
                Colors.Main
        }
    )

end)

--==================================================
-- RESPONSIVE OPEN BUTTON
--==================================================

local function UpdateOpenButton()

    local Viewport =
        Camera.ViewportSize

    if Viewport.X < 500 then

        OpenButton.Size =
            UDim2.fromOffset(
                44,
                44
            )

        OpenButton.Position =
            UDim2.new(
                0,
                10,
                0.5,
                -22
            )

    else

        OpenButton.Size =
            UDim2.fromOffset(
                48,
                48
            )

        OpenButton.Position =
            UDim2.new(
                0,
                15,
                0.5,
                -24
            )

    end
end

Camera:GetPropertyChangedSignal(
    "ViewportSize"
):Connect(function()

    task.defer(function()

        UpdateMenuSize()
        UpdateOpenButton()

    end)

end)

--==================================================
-- INITIALIZE
--==================================================

SelectCategory("Visual")

UpdateMenuSize()

UpdateOpenButton()

Main.Visible = true

OpenButton.Visible = false

GUI.Enabled = true

--==================================================
-- STATUS
--==================================================

print(
    "[Rusted Hub] Loaded successfully"
)

print(
    "[Rusted Hub] Menu: ON"
)

print(
    "[Rusted Hub] Visual ESP: ON"
)

print(
    "[Rusted Hub] Box ESP: ON"
)

--==================================================
-- END OF RUSTED HUB
--==================================================
