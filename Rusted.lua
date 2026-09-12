--==================================================
-- RUSTED HUB
-- PART 1 / 5
--==================================================
-- UI CORE / SETTINGS / RESPONSIVE SCALE
--==================================================

--==================================================
-- SERVICES
--==================================================

local Players =
    game:GetService("Players")

local RunService =
    game:GetService("RunService")

local UserInputService =
    game:GetService("UserInputService")

local TweenService =
    game:GetService("TweenService")

local CoreGui =
    game:GetService("CoreGui")

--==================================================
-- PLAYER / CAMERA
--==================================================

local LocalPlayer =
    Players.LocalPlayer

local Camera =
    workspace.CurrentCamera

--==================================================
-- SETTINGS
--==================================================

local Settings = {

    -- GENERAL
    Enabled = true,

    -- VISUAL
    ESP = true,
    BoxESP = true,
    NameESP = true,
    DistanceESP = true,
    HealthESP = true,
    HealthBar = true,
    Tracer = false,

    -- VISUAL
    MaxDistance = 2500,
    BoxThickness = 2,
    TracerThickness = 2,

    -- COMBAT
    AimAssist = false,
    AimTarget = "Head",
    AimFOV = 120,
    AimSmoothness = 0.15,
    TeamCheck = true,
    WallCheck = true,

    -- MOVEMENT
    WalkSpeed = 16,
    JumpPower = 50,

    -- MISC
    Crosshair = false,

    -- MENU
    MenuVisible = true,
}

--==================================================
-- MENU SIZE
--==================================================

local MENU_WIDTH = 650
local MENU_HEIGHT = 510

local TOPBAR_HEIGHT = 62
local SIDEBAR_WIDTH = 145

--==================================================
-- COLORS
--==================================================

local Colors = {

    Background =
        Color3.fromRGB(
            10,
            9,
            16
        ),

    Main =
        Color3.fromRGB(
            16,
            14,
            25
        ),

    Sidebar =
        Color3.fromRGB(
            13,
            12,
            21
        ),

    Card =
        Color3.fromRGB(
            23,
            20,
            34
        ),

    CardHover =
        Color3.fromRGB(
            31,
            26,
            46
        ),

    Active =
        Color3.fromRGB(
            100,
            55,
            180
        ),

    Purple =
        Color3.fromRGB(
            145,
            75,
            255
        ),

    PurpleLight =
        Color3.fromRGB(
            185,
            125,
            255
        ),

    White =
        Color3.fromRGB(
            240,
            238,
            248
        ),

    Gray =
        Color3.fromRGB(
            155,
            150,
            170
        ),

    DarkGray =
        Color3.fromRGB(
            85,
            80,
            100
        ),

    Green =
        Color3.fromRGB(
            70,
            210,
            120
        ),

    Red =
        Color3.fromRGB(
            230,
            70,
            80
        ),

    Yellow =
        Color3.fromRGB(
            235,
            190,
            70
        ),
}

--==================================================
-- CLEAN OLD GUI
--==================================================

pcall(function()

    local Old =
        CoreGui:FindFirstChild(
            "RustedHub"
        )

    if Old then
        Old:Destroy()
    end

end)

pcall(function()

    local PlayerGui =
        LocalPlayer:FindFirstChildOfClass(
            "PlayerGui"
        )

    if PlayerGui then

        local Old =
            PlayerGui:FindFirstChild(
                "RustedHub"
            )

        if Old then
            Old:Destroy()
        end

    end

end)

--==================================================
-- GUI
--==================================================

local GUI =
    Instance.new(
        "ScreenGui"
    )

GUI.Name =
    "RustedHub"

GUI.ResetOnSpawn =
    false

GUI.IgnoreGuiInset =
    true

GUI.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

GUI.DisplayOrder =
    999

--==================================================
-- PARENT GUI
--==================================================

local GUIParent =
    nil

pcall(function()

    GUIParent =
        CoreGui

    GUI.Parent =
        CoreGui

end)

if not GUI.Parent then

    GUI.Parent =
        LocalPlayer:WaitForChild(
            "PlayerGui"
        )

end

--==================================================
-- HELPERS
--==================================================

local function MakeCorner(
    Object,
    Radius
)

    local Corner =
        Instance.new(
            "UICorner"
        )

    Corner.CornerRadius =
        UDim.new(
            0,
            Radius or 8
        )

    Corner.Parent =
        Object

    return Corner
end

--==================================================

local function MakeStroke(
    Object,
    Color,
    Thickness,
    Transparency
)

    local Stroke =
        Instance.new(
            "UIStroke"
        )

    Stroke.Color =
        Color or Colors.Purple

    Stroke.Thickness =
        Thickness or 1

    Stroke.Transparency =
        Transparency or 0

    Stroke.Parent =
        Object

    return Stroke
end

--==================================================

local function MakeText(
    Parent,
    Text,
    Size,
    Color,
    Font
)

    local Label =
        Instance.new(
            "TextLabel"
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        Text or ""

    Label.TextColor3 =
        Color or Colors.White

    Label.TextSize =
        Size or 14

    Label.Font =
        Font or Enum.Font.Gotham

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.TextYAlignment =
        Enum.TextYAlignment.Center

    Label.Parent =
        Parent

    return Label
end

--==================================================

local function Tween(
    Object,
    Time,
    Properties
)

    local Info =
        TweenInfo.new(
            Time or 0.15,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )

    local Animation =
        TweenService:Create(
            Object,
            Info,
            Properties
        )

    Animation:Play()

    return Animation
end

--==================================================
-- MAIN WINDOW
--==================================================

local Main =
    Instance.new(
        "Frame"
    )

Main.Name =
    "Main"

Main.Size =
    UDim2.fromOffset(
        MENU_WIDTH,
        MENU_HEIGHT
    )

Main.Position =
    UDim2.new(
        0.5,
        -MENU_WIDTH / 2,
        0.5,
        -MENU_HEIGHT / 2
    )

Main.BackgroundColor3 =
    Colors.Main

Main.BorderSizePixel =
    0

Main.ClipsDescendants =
    true

Main.Parent =
    GUI

MakeCorner(
    Main,
    20
)

MakeStroke(
    Main,
    Colors.Purple,
    1.5,
    0.15
)

--==================================================
-- TOP BAR
--==================================================

local TopBar =
    Instance.new(
        "Frame"
    )

TopBar.Name =
    "TopBar"

TopBar.Size =
    UDim2.new(
        1,
        0,
        0,
        TOPBAR_HEIGHT
    )

TopBar.Position =
    UDim2.fromOffset(
        0,
        0
    )

TopBar.BackgroundColor3 =
    Colors.Background

TopBar.BorderSizePixel =
    0

TopBar.Parent =
    Main

--==================================================
-- LOGO
--==================================================

local Logo =
    MakeText(
        TopBar,
        "◈",
        25,
        Colors.Purple,
        Enum.Font.GothamBold
    )

Logo.Size =
    UDim2.fromOffset(
        42,
        TOPBAR_HEIGHT
    )

Logo.Position =
    UDim2.fromOffset(
        16,
        0
    )

Logo.TextXAlignment =
    Enum.TextXAlignment.Center

--==================================================
-- TITLE
--==================================================

local Title =
    MakeText(
        TopBar,
        "RUSTED",
        18,
        Colors.White,
        Enum.Font.GothamBold
    )

Title.Size =
    UDim2.fromOffset(
        110,
        28
    )

Title.Position =
    UDim2.fromOffset(
        58,
        9
    )

--==================================================
-- SUBTITLE
--==================================================

local Subtitle =
    MakeText(
        TopBar,
        "PRIVATE • HUB",
        10,
        Colors.Gray,
        Enum.Font.GothamMedium
    )

Subtitle.Size =
    UDim2.fromOffset(
        130,
        18
    )

Subtitle.Position =
    UDim2.fromOffset(
        59,
        32
    )

--==================================================
-- VERSION
--==================================================

local Version =
    MakeText(
        TopBar,
        "v2.0",
        10,
        Colors.PurpleLight,
        Enum.Font.GothamBold
    )

Version.Size =
    UDim2.fromOffset(
        45,
        20
    )

Version.Position =
    UDim2.fromOffset(
        180,
        21
    )

--==================================================
-- MINIMIZE
--==================================================

local MinButton =
    Instance.new(
        "TextButton"
    )

MinButton.Name =
    "Minimize"

MinButton.Size =
    UDim2.fromOffset(
        35,
        35
    )

MinButton.Position =
    UDim2.new(
        1,
        -78,
        0,
        13
    )

MinButton.BackgroundTransparency =
    1

MinButton.BorderSizePixel =
    0

MinButton.Text =
    "−"

MinButton.TextColor3 =
    Colors.White

MinButton.TextSize =
    22

MinButton.Font =
    Enum.Font.GothamBold

MinButton.AutoButtonColor =
    false

MinButton.Parent =
    TopBar

--==================================================
-- CLOSE
--==================================================

local CloseButton =
    Instance.new(
        "TextButton"
    )

CloseButton.Name =
    "Close"

CloseButton.Size =
    UDim2.fromOffset(
        35,
        35
    )

CloseButton.Position =
    UDim2.new(
        1,
        -42,
        0,
        13
    )

CloseButton.BackgroundTransparency =
    1

CloseButton.BorderSizePixel =
    0

CloseButton.Text =
    "×"

CloseButton.TextColor3 =
    Colors.White

CloseButton.TextSize =
    23

CloseButton.Font =
    Enum.Font.GothamBold

CloseButton.AutoButtonColor =
    false

CloseButton.Parent =
    TopBar

--==================================================
-- SIDEBAR
--==================================================

local Sidebar =
    Instance.new(
        "Frame"
    )

Sidebar.Name =
    "Sidebar"

Sidebar.Size =
    UDim2.new(
        0,
        SIDEBAR_WIDTH,
        1,
        -TOPBAR_HEIGHT
    )

Sidebar.Position =
    UDim2.fromOffset(
        0,
        TOPBAR_HEIGHT
    )

Sidebar.BackgroundColor3 =
    Colors.Sidebar

Sidebar.BorderSizePixel =
    0

Sidebar.Parent =
    Main

--==================================================
-- SIDEBAR TITLE
--==================================================

local SideTitle =
    MakeText(
        Sidebar,
        "CATEGORIES",
        10,
        Colors.DarkGray,
        Enum.Font.GothamBold
    )

SideTitle.Size =
    UDim2.new(
        1,
        -24,
        0,
        30
    )

SideTitle.Position =
    UDim2.fromOffset(
        12,
        10
    )

--==================================================
-- CATEGORY CONTAINER
--==================================================

local CategoryContainer =
    Instance.new(
        "Frame"
    )

CategoryContainer.Name =
    "CategoryContainer"

CategoryContainer.BackgroundTransparency =
    1

CategoryContainer.Size =
    UDim2.new(
        1,
        -16,
        1,
        -52
    )

CategoryContainer.Position =
    UDim2.fromOffset(
        8,
        45
    )

CategoryContainer.Parent =
    Sidebar

local CategoryLayout =
    Instance.new(
        "UIListLayout"
    )

CategoryLayout.Padding =
    UDim.new(
        0,
        5
    )

CategoryLayout.SortOrder =
    Enum.SortOrder.LayoutOrder

CategoryLayout.Parent =
    CategoryContainer

--==================================================
-- CATEGORY BUTTONS
--==================================================

local CategoryButtons = {}

local Categories = {

    {
        Name = "Visual",
        Icon = "◉",
        Order = 1,
    },

    {
        Name = "Combat",
        Icon = "◈",
        Order = 2,
    },

    {
        Name = "Movement",
        Icon = "➤",
        Order = 3,
    },

    {
        Name = "Misc",
        Icon = "◆",
        Order = 4,
    },

    {
        Name = "Settings",
        Icon = "⚙",
        Order = 5,
    },
}

--==================================================

for _, Category in ipairs(
    Categories
) do

    local Button =
        Instance.new(
            "TextButton"
        )

    Button.Name =
        Category.Name

    Button.Size =
        UDim2.new(
            1,
            0,
            0,
            42
        )

    Button.BackgroundColor3 =
        Colors.Card

    Button.BorderSizePixel =
        0

    Button.Text =
        ""

    Button.AutoButtonColor =
        false

    Button.LayoutOrder =
        Category.Order

    Button.Parent =
        CategoryContainer

    MakeCorner(
        Button,
        8
    )

    local Icon =
        MakeText(
            Button,
            Category.Icon,
            16,
            Colors.Gray,
            Enum.Font.GothamBold
        )

    Icon.Size =
        UDim2.fromOffset(
            34,
            42
        )

    Icon.Position =
        UDim2.fromOffset(
            5,
            0
        )

    Icon.TextXAlignment =
        Enum.TextXAlignment.Center

    local Label =
        MakeText(
            Button,
            Category.Name,
            12,
            Colors.Gray,
            Enum.Font.GothamMedium
        )

    Label.Size =
        UDim2.new(
            1,
            -45,
            1,
            0
        )

    Label.Position =
        UDim2.fromOffset(
            40,
            0
        )

    CategoryButtons[
        Category.Name
    ] = Button
end

--==================================================
-- CONTENT
--==================================================

local Content =
    Instance.new(
        "Frame"
    )

Content.Name =
    "Content"

Content.Position =
    UDim2.fromOffset(
        SIDEBAR_WIDTH,
        TOPBAR_HEIGHT
    )

Content.Size =
    UDim2.new(
        1,
        -SIDEBAR_WIDTH,
        1,
        -TOPBAR_HEIGHT
    )

Content.BackgroundColor3 =
    Colors.Background

Content.BorderSizePixel =
    0

Content.Parent =
    Main

--==================================================
-- PAGE HOLDER
--==================================================

local PageHolder =
    Instance.new(
        "Frame"
    )

PageHolder.Name =
    "PageHolder"

PageHolder.Size =
    UDim2.new(
        1,
        -24,
        1,
        -24
    )

PageHolder.Position =
    UDim2.fromOffset(
        12,
        12
    )

PageHolder.BackgroundTransparency =
    1

PageHolder.Parent =
    Content

--==================================================
-- PAGE TABLE
--==================================================

local Pages = {}

--==================================================
-- CREATE PAGE
--==================================================

local function CreatePage(
    Name
)

    local Page =
        Instance.new(
            "ScrollingFrame"
        )

    Page.Name =
        Name .. "Page"

    Page.Size =
        UDim2.fromScale(
            1,
            1
        )

    Page.BackgroundTransparency =
        1

    Page.BorderSizePixel =
        0

    Page.ScrollBarThickness =
        3

    Page.ScrollBarImageColor3 =
        Colors.Purple

    Page.CanvasSize =
        UDim2.fromOffset(
            0,
            0
        )

    Page.Visible =
        false

    Page.Parent =
        PageHolder

    local Padding =
        Instance.new(
            "UIPadding"
        )

    Padding.PaddingLeft =
        UDim.new(
            0,
            4
        )

    Padding.PaddingRight =
        UDim.new(
            0,
            4
        )

    Padding.PaddingTop =
        UDim.new(
            0,
            4
        )

    Padding.PaddingBottom =
        UDim.new(
            0,
            12
        )

    Padding.Parent =
        Page

    Pages[Name] =
        Page

    return Page
end

--==================================================
-- CREATE ALL PAGES
--==================================================

local VisualPage =
    CreatePage(
        "Visual"
    )

local CombatPage =
    CreatePage(
        "Combat"
    )

local MovementPage =
    CreatePage(
        "Movement"
    )

local MiscPage =
    CreatePage(
        "Misc"
    )

local SettingsPage =
    CreatePage(
        "Settings"
    )

--==================================================
-- PAGE SELECTION
--==================================================

local CurrentCategory =
    "Visual"

local function SelectCategory(
    Name
)

    CurrentCategory =
        Name

    for CategoryName, Button in pairs(
        CategoryButtons
    ) do

        local Active =
            CategoryName == Name

        Button.BackgroundColor3 =
            Active
            and Colors.Active
            or Colors.Card

        for _, Child in ipairs(
            Button:GetChildren()
        ) do

            if Child:IsA(
                "TextLabel"
            ) then

                Child.TextColor3 =
                    Active
                    and Colors.White
                    or Colors.Gray

            end

        end
    end

    for PageName, Page in pairs(
        Pages
    ) do

        Page.Visible =
            PageName == Name

    end
end

--==================================================
-- CATEGORY CONNECTIONS
--==================================================

for CategoryName, Button in pairs(
    CategoryButtons
) do

    Button.MouseButton1Click:Connect(
        function()

            SelectCategory(
                CategoryName
            )

        end
    )

end

--==================================================
-- MINIMIZE STATE
--==================================================

local Minimized =
    false

local SavedPosition =
    Main.Position

--==================================================
-- INITIAL STATE
--==================================================

SelectCategory(
    "Visual"
)

Main.Visible =
    true

GUI.Enabled =
    true

Settings.MenuVisible =
    true

--==================================================
-- PART 1 END
--==================================================

--==================================================
-- RUSTED HUB
-- PART 2 / 5
--==================================================
-- MENU CONTROLS / VISUAL / COMBAT / MOVEMENT / MISC
--==================================================

--==================================================
-- CURRENT PAGE HELPERS
--==================================================

local function ClearPage(Page)

    for _, Object in ipairs(Page:GetChildren()) do

        if not Object:IsA("UIPadding") then
            Object:Destroy()
        end

    end

end

--==================================================
-- SECTION TITLE
--==================================================

local function CreateSection(
    Page,
    Text,
    Order
)

    local Label =
        Instance.new("TextLabel")

    Label.Name =
        "Section_" .. Text

    Label.Size =
        UDim2.new(
            1,
            -8,
            0,
            30
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        Text

    Label.TextColor3 =
        Colors.PurpleLight

    Label.TextSize =
        13

    Label.Font =
        Enum.Font.GothamBold

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.LayoutOrder =
        Order or 0

    Label.Parent =
        Page

    return Label
end

--==================================================
-- TOGGLE CREATOR
--==================================================

local ToggleObjects = {}

local function CreateToggle(
    Page,
    Name,
    Description,
    SettingName,
    Order
)

    local Card =
        Instance.new("TextButton")

    Card.Name =
        Name .. "Toggle"

    Card.Size =
        UDim2.new(
            1,
            -8,
            0,
            54
        )

    Card.BackgroundColor3 =
        Colors.Card

    Card.BorderSizePixel =
        0

    Card.Text =
        ""

    Card.AutoButtonColor =
        false

    Card.LayoutOrder =
        Order or 0

    Card.Parent =
        Page

    MakeCorner(
        Card,
        9
    )

    -- NAME

    local Title =
        MakeText(
            Card,
            Name,
            13,
            Colors.White,
            Enum.Font.GothamBold
        )

    Title.Size =
        UDim2.new(
            1,
            -75,
            0,
            22
        )

    Title.Position =
        UDim2.fromOffset(
            13,
            5
        )

    -- DESCRIPTION

    local Desc =
        MakeText(
            Card,
            Description or "",
            10,
            Colors.Gray,
            Enum.Font.Gotham
        )

    Desc.Size =
        UDim2.new(
            1,
            -75,
            0,
            18
        )

    Desc.Position =
        UDim2.fromOffset(
            13,
            28
        )

    -- SWITCH BACKGROUND

    local Switch =
        Instance.new("Frame")

    Switch.Name =
        "Switch"

    Switch.Size =
        UDim2.fromOffset(
            40,
            21
        )

    Switch.Position =
        UDim2.new(
            1,
            -53,
            0.5,
            -10
        )

    Switch.BackgroundColor3 =
        Colors.DarkGray

    Switch.BorderSizePixel =
        0

    Switch.Parent =
        Card

    MakeCorner(
        Switch,
        11
    )

    -- SWITCH CIRCLE

    local Circle =
        Instance.new("Frame")

    Circle.Name =
        "Circle"

    Circle.Size =
        UDim2.fromOffset(
            15,
            15
        )

    Circle.Position =
        UDim2.fromOffset(
            3,
            3
        )

    Circle.BackgroundColor3 =
        Colors.White

    Circle.BorderSizePixel =
        0

    Circle.Parent =
        Switch

    MakeCorner(
        Circle,
        8
    )

    ToggleObjects[
        SettingName
    ] = {
        Card = Card,
        Switch = Switch,
        Circle = Circle,
    }

    local function Update()

        local Enabled =
            Settings[
                SettingName
            ]

        if Enabled then

            Tween(
                Switch,
                0.12,
                {
                    BackgroundColor3 =
                        Colors.Active
                }
            )

            Tween(
                Circle,
                0.12,
                {
                    Position =
                        UDim2.fromOffset(
                            22,
                            3
                        )
                }
            )

        else

            Tween(
                Switch,
                0.12,
                {
                    BackgroundColor3 =
                        Colors.DarkGray
                }
            )

            Tween(
                Circle,
                0.12,
                {
                    Position =
                        UDim2.fromOffset(
                            3,
                            3
                        )
                }
            )

        end
    end

    Card.MouseButton1Click:Connect(
        function()

            Settings[
                SettingName
            ] =
                not Settings[
                    SettingName
                ]

            Update()

        end
    )

    Card.MouseEnter:Connect(
        function()

            Tween(
                Card,
                0.12,
                {
                    BackgroundColor3 =
                        Colors.CardHover
                }
            )

        end
    )

    Card.MouseLeave:Connect(
        function()

            Tween(
                Card,
                0.12,
                {
                    BackgroundColor3 =
                        Colors.Card
                }
            )

        end
    )

    Update()

    return Card
end

--==================================================
-- SLIDER CREATOR
--==================================================

local SliderObjects = {}

local function CreateSlider(
    Page,
    Name,
    Description,
    SettingName,
    Minimum,
    Maximum,
    Order
)

    local Card =
        Instance.new("Frame")

    Card.Name =
        Name .. "Slider"

    Card.Size =
        UDim2.new(
            1,
            -8,
            0,
            70
        )

    Card.BackgroundColor3 =
        Colors.Card

    Card.BorderSizePixel =
        0

    Card.LayoutOrder =
        Order or 0

    Card.Parent =
        Page

    MakeCorner(
        Card,
        9
    )

    local Title =
        MakeText(
            Card,
            Name,
            13,
            Colors.White,
            Enum.Font.GothamBold
        )

    Title.Size =
        UDim2.new(
            1,
            -90,
            0,
            23
        )

    Title.Position =
        UDim2.fromOffset(
            13,
            5
        )

    local Value =
        MakeText(
            Card,
            tostring(
                Settings[
                    SettingName
                ]
            ),
            11,
            Colors.PurpleLight,
            Enum.Font.GothamBold
        )

    Value.Size =
        UDim2.fromOffset(
            65,
            23
        )

    Value.Position =
        UDim2.new(
            1,
            -78,
            0,
            5
        )

    Value.TextXAlignment =
        Enum.TextXAlignment.Right

    local Desc =
        MakeText(
            Card,
            Description or "",
            10,
            Colors.Gray,
            Enum.Font.Gotham
        )

    Desc.Size =
        UDim2.new(
            1,
            -26,
            0,
            18
        )

    Desc.Position =
        UDim2.fromOffset(
            13,
            27
        )

    -- BAR

    local Bar =
        Instance.new("Frame")

    Bar.Size =
        UDim2.new(
            1,
            -26,
            0,
            5
        )

    Bar.Position =
        UDim2.fromOffset(
            13,
            56
        )

    Bar.BackgroundColor3 =
        Colors.DarkGray

    Bar.BorderSizePixel =
        0

    Bar.Parent =
        Card

    MakeCorner(
        Bar,
        4
    )

    local Fill =
        Instance.new("Frame")

    Fill.Size =
        UDim2.fromScale(
            0,
            1
        )

    Fill.BackgroundColor3 =
        Colors.Purple

    Fill.BorderSizePixel =
        0

    Fill.Parent =
        Bar

    MakeCorner(
        Fill,
        4
    )

    local Drag =
        Instance.new("TextButton")

    Drag.Size =
        UDim2.fromScale(
            1,
            3
        )

    Drag.Position =
        UDim2.new(
            0,
            0,
            -1,
            0
        )

    Drag.BackgroundTransparency =
        1

    Drag.Text =
        ""

    Drag.Parent =
        Bar

    local function SetValue(
        ValueNumber
    )

        ValueNumber =
            math.clamp(
                ValueNumber,
                Minimum,
                Maximum
            )

        Settings[
            SettingName
        ] =
            ValueNumber

        local Percent =
            (
                ValueNumber - Minimum
            )
            /
            (
                Maximum - Minimum
            )

        Fill.Size =
            UDim2.new(
                Percent,
                0,
                1,
                0
            )

        Value.Text =
            tostring(
                math.floor(
                    ValueNumber
                )
            )
    end

    local function FromInput(
        Input
    )

        local X =
            Input.Position.X

        local StartX =
            Bar.AbsolutePosition.X

        local Width =
            Bar.AbsoluteSize.X

        local Percent =
            math.clamp(
                (X - StartX)
                /
                Width,
                0,
                1
            )

        local NewValue =
            Minimum
            +
            (
                Maximum - Minimum
            )
            *
            Percent

        SetValue(
            NewValue
        )
    end

    Drag.InputBegan:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1
                or
                Input.UserInputType ==
                Enum.UserInputType.Touch then

                FromInput(Input)

            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseMovement
                or
                Input.UserInputType ==
                Enum.UserInputType.Touch then

                if Drag:GetAttribute(
                    "Dragging"
                ) then

                    FromInput(Input)

                end

            end
        end
    )

    Drag.InputBegan:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1
                or
                Input.UserInputType ==
                Enum.UserInputType.Touch then

                Drag:SetAttribute(
                    "Dragging",
                    true
                )

            end

        end
    )

    Drag.InputEnded:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1
                or
                Input.UserInputType ==
                Enum.UserInputType.Touch then

                Drag:SetAttribute(
                    "Dragging",
                    false
                )

            end

        end
    )

    SliderObjects[
        SettingName
    ] = {
        Set = SetValue
    }

    SetValue(
        Settings[
            SettingName
        ]
    )

    return Card
end

--==================================================
-- DROPDOWN CREATOR
--==================================================

local DropdownObjects = {}

local function CreateDropdown(
    Page,
    Name,
    Description,
    SettingName,
    Options,
    Order
)

    local Card =
        Instance.new("TextButton")

    Card.Name =
        Name .. "Dropdown"

    Card.Size =
        UDim2.new(
            1,
            -8,
            0,
            58
        )

    Card.BackgroundColor3 =
        Colors.Card

    Card.BorderSizePixel =
        0

    Card.Text =
        ""

    Card.AutoButtonColor =
        false

    Card.LayoutOrder =
        Order or 0

    Card.Parent =
        Page

    MakeCorner(
        Card,
        9
    )

    local Title =
        MakeText(
            Card,
            Name,
            13,
            Colors.White,
            Enum.Font.GothamBold
        )

    Title.Size =
        UDim2.new(
            1,
            -150,
            0,
            23
        )

    Title.Position =
        UDim2.fromOffset(
            13,
            5
        )

    local Desc =
        MakeText(
            Card,
            Description or "",
            10,
            Colors.Gray,
            Enum.Font.Gotham
        )

    Desc.Size =
        UDim2.new(
            1,
            -150,
            0,
            18
        )

    Desc.Position =
        UDim2.fromOffset(
            13,
            29
        )

    local Value =
        MakeText(
            Card,
            tostring(
                Settings[
                    SettingName
                ]
            ),
            11,
            Colors.PurpleLight,
            Enum.Font.GothamBold
        )

    Value.Size =
        UDim2.fromOffset(
            115,
            30
        )

    Value.Position =
        UDim2.new(
            1,
            -125,
            0.5,
            -15
        )

    Value.TextXAlignment =
        Enum.TextXAlignment.Right

    local Index = 1

    for I, Option in ipairs(
        Options
    ) do

        if Option ==
            Settings[
                SettingName
            ] then

            Index = I
            break

        end
    end

    local function Update()

        Settings[
            SettingName
        ] =
            Options[Index]

        Value.Text =
            tostring(
                Options[Index]
            )
    end

    Card.MouseButton1Click:Connect(
        function()

            Index =
                Index + 1

            if Index >
                #Options then

                Index = 1

            end

            Update()

        end
    )

    Card.MouseEnter:Connect(
        function()

            Tween(
                Card,
                0.12,
                {
                    BackgroundColor3 =
                        Colors.CardHover
                }
            )

        end
    )

    Card.MouseLeave:Connect(
        function()

            Tween(
                Card,
                0.12,
                {
                    BackgroundColor3 =
                        Colors.Card
                }
            )

        end
    )

    DropdownObjects[
        SettingName
    ] = {
        Update = Update
    }

    Update()

    return Card
end

--==================================================
-- PAGE LAYOUT
--==================================================

local function SetupLayout(
    Page
)

    local Layout =
        Instance.new(
            "UIListLayout"
        )

    Layout.Padding =
        UDim.new(
            0,
            7
        )

    Layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    Layout.Parent =
        Page

    Layout:GetPropertyChangedSignal(
        "AbsoluteContentSize"
    ):Connect(
        function()

            Page.CanvasSize =
                UDim2.fromOffset(
                    0,
                    Layout.AbsoluteContentSize.Y
                    + 25
                )

        end
    )
end

--==================================================
-- VISUAL PAGE
--==================================================

ClearPage(
    VisualPage
)

SetupLayout(
    VisualPage
)

CreateSection(
    VisualPage,
    "PLAYER ESP",
    1
)

CreateToggle(
    VisualPage,
    "ESP",
    "Enable player ESP",
    "ESP",
    2
)

CreateToggle(
    VisualPage,
    "Box ESP",
    "Draw a 2D box around players",
    "BoxESP",
    3
)

CreateToggle(
    VisualPage,
    "Name ESP",
    "Display player names",
    "NameESP",
    4
)

CreateToggle(
    VisualPage,
    "Distance",
    "Display distance to players",
    "DistanceESP",
    5
)

CreateToggle(
    VisualPage,
    "Health",
    "Display current and maximum HP",
    "HealthESP",
    6
)

CreateToggle(
    VisualPage,
    "Health Bar",
    "Display a vertical health bar",
    "HealthBar",
    7
)

CreateToggle(
    VisualPage,
    "Tracer",
    "Draw lines toward players",
    "Tracer",
    8
)

CreateSlider(
    VisualPage,
    "Max Distance",
    "Maximum ESP render distance",
    "MaxDistance",
    100,
    5000,
    9
)

--==================================================
-- COMBAT PAGE
--==================================================

ClearPage(
    CombatPage
)

SetupLayout(
    CombatPage
)

CreateSection(
    CombatPage,
    "AIM ASSIST",
    1
)

CreateToggle(
    CombatPage,
    "Aim Assist",
    "Assist aiming toward a selected target",
    "AimAssist",
    2
)

CreateDropdown(
    CombatPage,
    "Target",
    "Select the preferred target body part",
    "AimTarget",
    {
        "Head",
        "Torso"
    },
    3
)

CreateSlider(
    CombatPage,
    "FOV",
    "Aim assist field of view",
    "AimFOV",
    30,
    500,
    4
)

CreateSlider(
    CombatPage,
    "Smoothness",
    "Aim movement smoothing",
    "AimSmoothness",
    0.01,
    1,
    5
)

CreateToggle(
    CombatPage,
    "Team Check",
    "Ignore teammates when targeting",
    "TeamCheck",
    6
)

CreateToggle(
    CombatPage,
    "Wall Check",
    "Require a visible target",
    "WallCheck",
    7
)

--==================================================
-- MOVEMENT PAGE
--==================================================

ClearPage(
    MovementPage
)

SetupLayout(
    MovementPage
)

CreateSection(
    MovementPage,
    "MOVEMENT",
    1
)

CreateSlider(
    MovementPage,
    "Walk Speed",
    "Player movement speed",
    "WalkSpeed",
    8,
    100,
    2
)

CreateSlider(
    MovementPage,
    "Jump Power",
    "Player jump power",
    "JumpPower",
    20,
    150,
    3
)

--==================================================
-- MISC PAGE
--==================================================

ClearPage(
    MiscPage
)

SetupLayout(
    MiscPage
)

CreateSection(
    MiscPage,
    "MISCELLANEOUS",
    1
)

CreateToggle(
    MiscPage,
    "Crosshair",
    "Display a simple screen crosshair",
    "Crosshair",
    2
)

--==================================================
-- SETTINGS PAGE
--==================================================

ClearPage(
    SettingsPage
)

SetupLayout(
    SettingsPage
)

CreateSection(
    SettingsPage,
    "GENERAL",
    1
)

CreateToggle(
    SettingsPage,
    "Hub Enabled",
    "Enable the hub interface",
    "Enabled",
    2
)

--==================================================
-- INITIAL PAGE
--==================================================

SelectCategory(
    "Visual"
)

--==================================================
-- PART 2 END
--==================================================

--==================================================
-- RUSTED HUB
-- PART 3 / 5
--==================================================
-- ESP SYSTEM
--==================================================

--==================================================
-- ESP GUI
--==================================================

local ESPGui =
    Instance.new("ScreenGui")

ESPGui.Name =
    "RustedESP"

ESPGui.ResetOnSpawn =
    false

ESPGui.IgnoreGuiInset =
    true

ESPGui.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

ESPGui.DisplayOrder =
    998

ESPGui.Parent =
    GUIParent or CoreGui

--==================================================
-- ESP OBJECTS
--==================================================

local ESPObjects = {}

--==================================================
-- CREATE LINE
--==================================================

local function CreateESPLine()

    local Line =
        Instance.new("Frame")

    Line.BackgroundColor3 =
        Colors.Purple

    Line.BorderSizePixel =
        0

    Line.AnchorPoint =
        Vector2.new(
            0.5,
            0.5
        )

    Line.Visible =
        false

    Line.ZIndex =
        2

    Line.Parent =
        ESPGui

    return Line
end

--==================================================
-- CREATE TEXT
--==================================================

local function CreateESPText()

    local Text =
        Instance.new("TextLabel")

    Text.BackgroundTransparency =
        1

    Text.TextColor3 =
        Colors.White

    Text.TextStrokeTransparency =
        0.25

    Text.Font =
        Enum.Font.GothamBold

    Text.TextSize =
        13

    Text.TextXAlignment =
        Enum.TextXAlignment.Center

    Text.TextYAlignment =
        Enum.TextYAlignment.Center

    Text.Visible =
        false

    Text.ZIndex =
        3

    Text.Parent =
        ESPGui

    return Text
end

--==================================================
-- CREATE PLAYER ESP
--==================================================

local function CreatePlayerESP(
    Player
)

    if Player ==
        LocalPlayer then
        return
    end

    if ESPObjects[Player] then
        return
    end

    local Data = {}

    -- BOX

    Data.Top =
        CreateESPLine()

    Data.Bottom =
        CreateESPLine()

    Data.Left =
        CreateESPLine()

    Data.Right =
        CreateESPLine()

    -- TRACER

    Data.Tracer =
        CreateESPLine()

    -- TEXT

    Data.Name =
        CreateESPText()

    Data.Distance =
        CreateESPText()

    Data.Health =
        CreateESPText()

    --==================================================
    -- HEALTH BAR BACKGROUND
    --==================================================

    Data.HealthBack =
        Instance.new("Frame")

    Data.HealthBack.BackgroundColor3 =
        Color3.fromRGB(
            25,
            23,
            30
        )

    Data.HealthBack.BorderSizePixel =
        0

    Data.HealthBack.Visible =
        false

    Data.HealthBack.ZIndex =
        2

    Data.HealthBack.Parent =
        ESPGui

    MakeCorner(
        Data.HealthBack,
        2
    )

    --==================================================
    -- HEALTH BAR
    --==================================================

    Data.HealthFill =
        Instance.new("Frame")

    Data.HealthFill.BackgroundColor3 =
        Colors.Green

    Data.HealthFill.BorderSizePixel =
        0

    Data.HealthFill.Size =
        UDim2.fromScale(
            1,
            1
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

local function HideESP(
    Data
)

    if not Data then
        return
    end

    Data.Top.Visible =
        false

    Data.Bottom.Visible =
        false

    Data.Left.Visible =
        false

    Data.Right.Visible =
        false

    Data.Tracer.Visible =
        false

    Data.Name.Visible =
        false

    Data.Distance.Visible =
        false

    Data.Health.Visible =
        false

    Data.HealthBack.Visible =
        false
end

--==================================================
-- REMOVE ESP
--==================================================

local function RemovePlayerESP(
    Player
)

    local Data =
        ESPObjects[Player]

    if not Data then
        return
    end

    for _, Object in pairs(
        Data
    ) do

        if typeof(Object) ==
            "Instance" then

            Object:Destroy()

        end

    end

    ESPObjects[Player] =
        nil
end

--==================================================
-- SET LINE
--==================================================

local function SetLine(
    Line,
    PointA,
    PointB,
    Thickness
)

    local DX =
        PointB.X -
        PointA.X

    local DY =
        PointB.Y -
        PointA.Y

    local Length =
        math.sqrt(
            DX * DX +
            DY * DY
        )

    if Length < 1 then
        Length = 1
    end

    Line.Size =
        UDim2.fromOffset(
            Length,
            Thickness or 2
        )

    Line.Position =
        UDim2.fromOffset(
            (
                PointA.X +
                PointB.X
            ) / 2,

            (
                PointA.Y +
                PointB.Y
            ) / 2
        )

    Line.Rotation =
        math.deg(
            math.atan2(
                DY,
                DX
            )
        )

    Line.Visible =
        true
end

--==================================================
-- GET 2D PLAYER BOUNDS
--==================================================

local function GetScreenBounds(
    Character
)

    local Success,
        BoxCFrame,
        BoxSize =
        pcall(
            function()

                local CF,
                    Size =
                    Character:GetBoundingBox()

                return true,
                    CF,
                    Size
            end
        )

    if not Success then
        return nil
    end

    local Corners = {

        Vector3.new(
            -BoxSize.X / 2,
            -BoxSize.Y / 2,
            -BoxSize.Z / 2
        ),

        Vector3.new(
            -BoxSize.X / 2,
            -BoxSize.Y / 2,
            BoxSize.Z / 2
        ),

        Vector3.new(
            -BoxSize.X / 2,
            BoxSize.Y / 2,
            -BoxSize.Z / 2
        ),

        Vector3.new(
            -BoxSize.X / 2,
            BoxSize.Y / 2,
            BoxSize.Z / 2
        ),

        Vector3.new(
            BoxSize.X / 2,
            -BoxSize.Y / 2,
            -BoxSize.Z / 2
        ),

        Vector3.new(
            BoxSize.X / 2,
            -BoxSize.Y / 2,
            BoxSize.Z / 2
        ),

        Vector3.new(
            BoxSize.X / 2,
            BoxSize.Y / 2,
            -BoxSize.Z / 2
        ),

        Vector3.new(
            BoxSize.X / 2,
            BoxSize.Y / 2,
            BoxSize.Z / 2
        ),
    }

    local MinX =
        math.huge

    local MinY =
        math.huge

    local MaxX =
        -math.huge

    local MaxY =
        -math.huge

    local HasPoint =
        false

    for _, Corner in ipairs(
        Corners
    ) do

        local WorldPosition =
            BoxCFrame:PointToWorldSpace(
                Corner
            )

        local ScreenPosition,
            OnScreen =
            Camera:WorldToViewportPoint(
                WorldPosition
            )

        if ScreenPosition.Z > 0 then

            HasPoint =
                true

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

    if not HasPoint then
        return nil
    end

    return
        MinX,
        MinY,
        MaxX,
        MaxY
end

--==================================================
-- UPDATE PLAYER ESP
--==================================================

local function UpdatePlayerESP(
    Player,
    Data
)

    if not Settings.Enabled
        or not Settings.ESP then

        HideESP(
            Data
        )

        return
    end

    if Player ==
        LocalPlayer then

        HideESP(
            Data
        )

        return
    end

    local Character =
        Player.Character

    if not Character then

        HideESP(
            Data
        )

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

    if not Humanoid
        or not Root then

        HideESP(
            Data
        )

        return
    end

    if Humanoid.Health <= 0 then

        HideESP(
            Data
        )

        return
    end

    --==================================================
    -- DISTANCE
    --==================================================

    local Distance =
        (
            Camera.CFrame.Position -
            Root.Position
        ).Magnitude

    if Distance >
        Settings.MaxDistance then

        HideESP(
            Data
        )

        return
    end

    --==================================================
    -- SCREEN BOUNDS
    --==================================================

    local MinX,
        MinY,
        MaxX,
        MaxY =
        GetScreenBounds(
            Character
        )

    if not MinX then

        HideESP(
            Data
        )

        return
    end

    local Width =
        MaxX - MinX

    local Height =
        MaxY - MinY

    if Width <= 1
        or Height <= 1 then

        HideESP(
            Data
        )

        return
    end

    local CenterX =
        (
            MinX +
            MaxX
        ) / 2

    local CenterY =
        (
            MinY +
            MaxY
        ) / 2

    --==================================================
    -- BOX
    --==================================================

    if Settings.BoxESP then

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

        Data.Top.Visible =
            false

        Data.Bottom.Visible =
            false

        Data.Left.Visible =
            false

        Data.Right.Visible =
            false
    end

    --==================================================
    -- NAME
    --==================================================

    if Settings.NameESP then

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

        Data.Name.Visible =
            true

    else

        Data.Name.Visible =
            false
    end

    --==================================================
    -- DISTANCE
    --==================================================

    if Settings.DistanceESP then

        Data.Distance.Text =
            tostring(
                math.floor(
                    Distance
                )
            ) ..
            " studs"

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

        Data.Distance.Visible =
            true

    else

        Data.Distance.Visible =
            false
    end

    --==================================================
    -- HEALTH TEXT
    --==================================================

    if Settings.HealthESP then

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
            )
            ..
            " / "
            ..
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

        Data.Health.Visible =
            true

    else

        Data.Health.Visible =
            false
    end

    --==================================================
    -- HEALTH BAR
    --==================================================

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
                CurrentHP /
                MaxHP,

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

        if Percent >
            0.60 then

            Data.HealthFill.BackgroundColor3 =
                Colors.Green

        elseif Percent >
            0.30 then

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

    --==================================================
    -- TRACER
    --==================================================

    if Settings.Tracer then

        local Viewport =
            Camera.ViewportSize

        SetLine(
            Data.Tracer,

            Vector2.new(
                Viewport.X / 2,
                Viewport.Y
            ),

            Vector2.new(
                CenterX,
                MaxY
            ),

            Settings.TracerThickness
        )

    else

        Data.Tracer.Visible =
            false
    end
end

--==================================================
-- PLAYER CHARACTER CONNECTIONS
--==================================================

local CharacterConnections = {}

local function TrackPlayer(
    Player
)

    if Player ==
        LocalPlayer then
        return
    end

    CreatePlayerESP(
        Player
    )

    if CharacterConnections[Player] then
        return
    end

    CharacterConnections[Player] =
        Player.CharacterAdded:Connect(
            function()

                task.wait(
                    0.15
                )

                CreatePlayerESP(
                    Player
                )

            end
        )
end

--==================================================
-- INITIAL PLAYERS
--==================================================

for _, Player in ipairs(
    Players:GetPlayers()
) do

    TrackPlayer(
        Player
    )
end

--==================================================
-- NEW PLAYERS
--==================================================

Players.PlayerAdded:Connect(
    function(Player)

        TrackPlayer(
            Player
        )

    end
)

--==================================================
-- PLAYER REMOVING
--==================================================

Players.PlayerRemoving:Connect(
    function(Player)

        if CharacterConnections[Player] then

            CharacterConnections[
                Player
            ]:Disconnect()

            CharacterConnections[
                Player
            ] = nil
        end

        RemovePlayerESP(
            Player
        )

    end
)

--==================================================
-- ESP RENDER LOOP
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

                UpdatePlayerESP(
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
-- PART 3 END
--==================================================

--==================================================
-- RUSTED HUB
-- PART 4 / 5
--==================================================
-- AIM ASSIST
--==================================================

--==================================================
-- AIM STATE
--==================================================

local AimTargetPlayer = nil
local AimTargetPart = nil

--==================================================
-- FOV CIRCLE
--==================================================

local FOVCircle =
    Instance.new("Frame")

FOVCircle.Name =
    "AimFOV"

FOVCircle.BackgroundTransparency =
    1

FOVCircle.BorderSizePixel =
    0

FOVCircle.AnchorPoint =
    Vector2.new(
        0.5,
        0.5
    )

FOVCircle.Visible =
    false

FOVCircle.ZIndex =
    10

FOVCircle.Parent =
    ESPGui

MakeCorner(
    FOVCircle,
    500
)

local FOVStroke =
    MakeStroke(
        FOVCircle,
        Colors.Purple,
        1,
        0.25
    )

--==================================================
-- UPDATE FOV
--==================================================

local function UpdateFOVCircle()

    if not Settings.AimAssist
        or not Settings.Enabled then

        FOVCircle.Visible =
            false

        return
    end

    local Viewport =
        Camera.ViewportSize

    local Center =
        Vector2.new(
            Viewport.X / 2,
            Viewport.Y / 2
        )

    FOVCircle.Size =
        UDim2.fromOffset(
            Settings.AimFOV * 2,
            Settings.AimFOV * 2
        )

    FOVCircle.Position =
        UDim2.fromOffset(
            Center.X,
            Center.Y
        )

    FOVCircle.Visible =
        true
end

--==================================================
-- GET AIM PART
--==================================================

local function GetAimPart(
    Character
)

    if Settings.AimTarget ==
        "Head" then

        return Character:FindFirstChild(
            "Head"
        )

    end

    return Character:FindFirstChild(
        "HumanoidRootPart"
    )
end

--==================================================
-- TEAM CHECK
--==================================================

local function IsEnemy(
    Player
)

    if Player ==
        LocalPlayer then

        return false
    end

    if not Settings.TeamCheck then
        return true
    end

    if LocalPlayer.Team ==
        nil then

        return true
    end

    if Player.Team ==
        nil then

        return true
    end

    return Player.Team ~=
        LocalPlayer.Team
end

--==================================================
-- WALL CHECK
--==================================================

local function HasLineOfSight(
    Part
)

    if not Settings.WallCheck then
        return true
    end

    if not Part then
        return false
    end

    local Origin =
        Camera.CFrame.Position

    local Direction =
        Part.Position -
        Origin

    local Params =
        RaycastParams.new()

    Params.FilterType =
        Enum.RaycastFilterType.Exclude

    Params.FilterDescendantsInstances = {
        LocalPlayer.Character,
        Camera
    }

    Params.IgnoreWater =
        true

    local Result =
        workspace:Raycast(
            Origin,
            Direction,
            Params
        )

    if not Result then
        return true
    end

    return Result.Instance:IsDescendantOf(
        Part.Parent
    )
end

--==================================================
-- GET CLOSEST TARGET
--==================================================

local function GetClosestTarget()

    local Viewport =
        Camera.ViewportSize

    local ScreenCenter =
        Vector2.new(
            Viewport.X / 2,
            Viewport.Y / 2
        )

    local BestPlayer =
        nil

    local BestPart =
        nil

    local BestDistance =
        Settings.AimFOV

    for _, Player in ipairs(
        Players:GetPlayers()
    ) do

        if Player ~= LocalPlayer
            and IsEnemy(Player) then

            local Character =
                Player.Character

            if Character then

                local Humanoid =
                    Character:FindFirstChildOfClass(
                        "Humanoid"
                    )

                if Humanoid
                    and Humanoid.Health > 0 then

                    local Part =
                        GetAimPart(
                            Character
                        )

                    if Part then

                        local ScreenPosition,
                            OnScreen =
                            Camera:WorldToViewportPoint(
                                Part.Position
                            )

                        if OnScreen
                            and ScreenPosition.Z > 0 then

                            local ScreenPoint =
                                Vector2.new(
                                    ScreenPosition.X,
                                    ScreenPosition.Y
                                )

                            local Distance =
                                (
                                    ScreenPoint -
                                    ScreenCenter
                                ).Magnitude

                            if Distance <=
                                BestDistance then

                                if HasLineOfSight(
                                    Part
                                ) then

                                    BestDistance =
                                        Distance

                                    BestPlayer =
                                        Player

                                    BestPart =
                                        Part

                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return BestPlayer,
        BestPart
end

--==================================================
-- AIM CAMERA
--==================================================

local function AimAt(
    Part
)

    if not Part then
        return
    end

    local CameraPosition =
        Camera.CFrame.Position

    local Direction =
        Part.Position -
        CameraPosition

    if Direction.Magnitude <= 0.001 then
        return
    end

    local TargetCFrame =
        CFrame.lookAt(
            CameraPosition,
            Part.Position
        )

    local Smooth =
        math.clamp(
            Settings.AimSmoothness,
            0.01,
            1
        )

    Camera.CFrame =
        Camera.CFrame:Lerp(
            TargetCFrame,
            Smooth
        )
end

--==================================================
-- AIM UPDATE
--==================================================

local function UpdateAim()

    if not Settings.Enabled
        or not Settings.AimAssist then

        AimTargetPlayer =
            nil

        AimTargetPart =
            nil

        return
    end

    local Player,
        Part =
        GetClosestTarget()

    AimTargetPlayer =
        Player

    AimTargetPart =
        Part

    if Part then

        AimAt(
            Part
        )

    end
end

--==================================================
-- AIM RENDER LOOP
--==================================================

RunService.RenderStepped:Connect(
    function()

        Camera =
            workspace.CurrentCamera
            or Camera

        UpdateFOVCircle()

        UpdateAim()

    end
)

--==================================================
-- FOV COLOR
--==================================================

local function UpdateFOVColor()

    if AimTargetPlayer then

        FOVStroke.Color =
            Colors.Green

    else

        FOVStroke.Color =
            Colors.Purple

    end
end

RunService.RenderStepped:Connect(
    function()

        UpdateFOVColor()

    end
)

--==================================================
-- AIM TARGET RESET
--==================================================

Players.PlayerRemoving:Connect(
    function(Player)

        if AimTargetPlayer ==
            Player then

            AimTargetPlayer =
                nil

            AimTargetPart =
                nil

        end

    end
)

--==================================================
-- CAMERA UPDATE
--==================================================

workspace:GetPropertyChangedSignal(
    "CurrentCamera"
):Connect(
    function()

        Camera =
            workspace.CurrentCamera
            or Camera

        task.defer(
            UpdateFOVCircle
        )

    end
)

--==================================================
-- PART 4 END
--==================================================

--==================================================
-- RUSTED HUB
-- PART 5 / 5
--==================================================
-- FINAL CONTROLS / DRAG / MINIMIZE / CROSSHAIR
-- MOVEMENT / INITIALIZATION
--==================================================

--==================================================
-- MENU SCALE
--==================================================

local MenuScale = Instance.new("UIScale")
MenuScale.Name = "MenuScale"
MenuScale.Scale = 1
MenuScale.Parent = Main

local function UpdateMenuScale()
    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize

    local ScaleX = (Viewport.X - 20) / MENU_WIDTH
    local ScaleY = (Viewport.Y - 20) / MENU_HEIGHT

    local Scale = math.min(1, ScaleX, ScaleY)

    -- Не даём меню стать слишком маленьким
    Scale = math.max(0.55, Scale)

    MenuScale.Scale = Scale
end

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateMenuScale)

--==================================================
-- OPEN BUTTON
--==================================================

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.fromOffset(52, 52)
OpenButton.Position = UDim2.new(0, 15, 0.5, -26)
OpenButton.BackgroundColor3 = Colors.Card
OpenButton.Text = "◈"
OpenButton.TextColor3 = Colors.PurpleLight
OpenButton.TextSize = 25
OpenButton.Font = Enum.Font.GothamBold
OpenButton.AutoButtonColor = false
OpenButton.Visible = false
OpenButton.Parent = GUI

MakeCorner(OpenButton, 14)
MakeStroke(OpenButton, Colors.Purple, 1.5)

OpenButton.MouseEnter:Connect(function()
    Tween(OpenButton, {
        BackgroundColor3 = Colors.CardHover,
        TextColor3 = Colors.White
    }, 0.12)
end)

OpenButton.MouseLeave:Connect(function()
    Tween(OpenButton, {
        BackgroundColor3 = Colors.Card,
        TextColor3 = Colors.PurpleLight
    }, 0.12)
end)

OpenButton.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenButton.Visible = false
    Settings.MenuVisible = true

    UpdateMenuScale()
end)

--==================================================
-- CLOSE
--==================================================

CloseButton.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenButton.Visible = true
    Settings.MenuVisible = false
end)

--==================================================
-- MINIMIZE
--==================================================

local IsMinimized = false

local SavedMainSize = UDim2.fromOffset(
    MENU_WIDTH,
    MENU_HEIGHT
)

local function SetMinimized(State)
    IsMinimized = State

    if State then
        SavedMainSize = Main.Size

        Sidebar.Visible = false
        Content.Visible = false

        Main.Size = UDim2.fromOffset(
            MENU_WIDTH,
            TOPBAR_HEIGHT
        )

        MinButton.Text = "+"
    else
        Main.Size = SavedMainSize

        Sidebar.Visible = true
        Content.Visible = true

        MinButton.Text = "−"

        UpdateMenuScale()
    end
end

MinButton.MouseButton1Click:Connect(function()
    SetMinimized(not IsMinimized)
end)

--==================================================
-- BUTTON HOVER
--==================================================

CloseButton.MouseEnter:Connect(function()
    Tween(CloseButton, {
        BackgroundColor3 = Colors.Red,
        TextColor3 = Colors.White
    }, 0.12)
end)

CloseButton.MouseLeave:Connect(function()
    Tween(CloseButton, {
        BackgroundColor3 = Colors.Card,
        TextColor3 = Colors.White
    }, 0.12)
end)

MinButton.MouseEnter:Connect(function()
    Tween(MinButton, {
        BackgroundColor3 = Colors.CardHover
    }, 0.12)
end)

MinButton.MouseLeave:Connect(function()
    Tween(MinButton, {
        BackgroundColor3 = Colors.Card
    }, 0.12)
end)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart = nil
local StartPosition = nil

local function IsOverButton(Position, Button)
    local Objects = GUI:GetGuiObjectsAtPosition(
        Position.X,
        Position.Y
    )

    for _, Object in ipairs(Objects) do
        if Object == Button or Object:IsDescendantOf(Button) then
            return true
        end
    end

    return false
end

TopBar.InputBegan:Connect(function(Input)
    if Input.UserInputType ~= Enum.UserInputType.MouseButton1
        and Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    if IsOverButton(Input.Position, MinButton)
        or IsOverButton(Input.Position, CloseButton) then
        return
    end

    Dragging = true
    DragStart = Input.Position
    StartPosition = Main.Position
end)

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

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

--==================================================
-- CROSSHAIR
--==================================================

local CrosshairGui = Instance.new("ScreenGui")
CrosshairGui.Name = "RustedCrosshair"
CrosshairGui.ResetOnSpawn = false
CrosshairGui.IgnoreGuiInset = true
CrosshairGui.DisplayOrder = 997

pcall(function()
    CrosshairGui.Parent = CoreGui
end)

if not CrosshairGui.Parent then
    CrosshairGui.Parent = GUIParent
end

local CrosshairContainer = Instance.new("Frame")
CrosshairContainer.Name = "Crosshair"
CrosshairContainer.Size = UDim2.fromOffset(24, 24)
CrosshairContainer.AnchorPoint = Vector2.new(0.5, 0.5)
CrosshairContainer.Position = UDim2.fromScale(0.5, 0.5)
CrosshairContainer.BackgroundTransparency = 1
CrosshairContainer.Visible = false
CrosshairContainer.Parent = CrosshairGui

local CrosshairTop = Instance.new("Frame")
CrosshairTop.Size = UDim2.fromOffset(2, 7)
CrosshairTop.Position = UDim2.new(0.5, -1, 0, 0)
CrosshairTop.BorderSizePixel = 0
CrosshairTop.BackgroundColor3 = Colors.White
CrosshairTop.Parent = CrosshairContainer

local CrosshairBottom = Instance.new("Frame")
CrosshairBottom.Size = UDim2.fromOffset(2, 7)
CrosshairBottom.Position = UDim2.new(0.5, -1, 1, -7)
CrosshairBottom.BorderSizePixel = 0
CrosshairBottom.BackgroundColor3 = Colors.White
CrosshairBottom.Parent = CrosshairContainer

local CrosshairLeft = Instance.new("Frame")
CrosshairLeft.Size = UDim2.fromOffset(7, 2)
CrosshairLeft.Position = UDim2.new(0, 0, 0.5, -1)
CrosshairLeft.BorderSizePixel = 0
CrosshairLeft.BackgroundColor3 = Colors.White
CrosshairLeft.Parent = CrosshairContainer

local CrosshairRight = Instance.new("Frame")
CrosshairRight.Size = UDim2.fromOffset(7, 2)
CrosshairRight.Position = UDim2.new(1, -7, 0.5, -1)
CrosshairRight.BorderSizePixel = 0
CrosshairRight.BackgroundColor3 = Colors.White
CrosshairRight.Parent = CrosshairContainer

local function UpdateCrosshair()
    CrosshairContainer.Visible =
        Settings.Enabled
        and Settings.Crosshair
end

--==================================================
-- MOVEMENT
--==================================================

local function ApplyMovement()
    if not Settings.Enabled then
        return
    end

    local Character = LocalPlayer.Character

    if not Character then
        return
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        return
    end

    Humanoid.WalkSpeed = Settings.WalkSpeed

    pcall(function()
        Humanoid.JumpPower = Settings.JumpPower
    end)

    pcall(function()
        Humanoid.UseJumpPower = true
    end)
end

LocalPlayer.CharacterAdded:Connect(function(Character)
    task.wait(0.5)

    ApplyMovement()
end)

--==================================================
-- MAIN UPDATE
--==================================================

RunService.RenderStepped:Connect(function()
    if Settings.Enabled then
        ApplyMovement()
    end

    UpdateCrosshair()
end)

--==================================================
-- HUB ENABLE/DISABLE
--==================================================

local HubToggle = ToggleObjects["Enabled"]

if HubToggle then
    HubToggle.MouseButton1Click:Connect(function()
        Settings.Enabled = not Settings.Enabled

        Main.Visible = Settings.MenuVisible
    end)
end

--==================================================
-- CATEGORY BUTTONS
--==================================================

for Name, Button in pairs(CategoryButtons) do
    Button.MouseButton1Click:Connect(function()
        SelectCategory(Name)
    end)
end

--==================================================
-- SETTINGS SAFETY
--==================================================

Settings.Enabled = true
Settings.MenuVisible = true

Main.Visible = true
GUI.Enabled = true
OpenButton.Visible = false

--==================================================
-- FINAL SCALE
--==================================================

task.defer(function()
    task.wait()

    UpdateMenuScale()

    Main.Position = UDim2.new(
        0.5,
        0,
        0.5,
        0
    )

    Main.AnchorPoint = Vector2.new(0.5, 0.5)
end)

--==================================================
-- INITIAL STATE
--==================================================

SelectCategory("Visual")

UpdateCrosshair()

--==================================================
-- FINAL
--==================================================

print("[Rusted Hub] Loaded successfully.")
print("[Rusted Hub] Menu: 650x510 base size")
print("[Rusted Hub] ESP: Ready")
print("[Rusted Hub] Aim Assist: Ready")
print("[Rusted Hub] All parts loaded.")

--==================================================
-- RUSTED HUB
-- PART 5 / 5 END
--==================================================
