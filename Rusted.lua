--==================================================
--                 RUSTED HUB v4.0
--                    PART 1A/5
--==================================================

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- REMOVE OLD GUI
--==================================================

pcall(function()

	local old = PlayerGui:FindFirstChild("RustedHub")

	if old then
		old:Destroy()
	end

end)

--==================================================
-- CONFIG
--==================================================

local S = {

	-- AIM
	AimAssist = false,
	AimPlayers = true,
	AimNPC = true,
	AimVisibleOnly = true,
	AimFOV = 150,

	-- ESP
	ESP = false,
	BoxESP = false,
	Names = false,
	Health = false,
	Distance = false,
	Snapline = false,
	ChestESP = false,

	-- MOVEMENT
	SpeedHack = false,
	Speed = 16,

	Jump = false,
	JumpPower = 50,

	Noclip = false,

	-- CAMERA
	FOVChanger = false,
	FOV = 90,

	-- MISC
	Fullbright = false,

	-- MENU
	MenuAnimations = true,

	-- SEPARATE COLORS
	MenuColor = Color3.fromRGB(145,70,255),
	ESPColor = Color3.fromRGB(145,70,255),
	BoxColor = Color3.fromRGB(145,70,255),
	NameColor = Color3.fromRGB(255,255,255),
	HealthColor = Color3.fromRGB(80,255,100),
	DistanceColor = Color3.fromRGB(200,200,200),
	SnaplineColor = Color3.fromRGB(255,255,255),
	FOVColor = Color3.fromRGB(145,70,255),
	ChestColor = Color3.fromRGB(255,180,50),
}

--==================================================
-- UI COLORS
--==================================================

local COLORS = {

	BG = Color3.fromRGB(
		16,16,20
	),

	PANEL = Color3.fromRGB(
		22,22,28
	),

	ROW = Color3.fromRGB(
		28,28,35
	),

	HOVER = Color3.fromRGB(
		38,38,48
	),

	TEXT = Color3.fromRGB(
		245,245,250
	),

	SUB = Color3.fromRGB(
		150,150,160
	),

	DARK = Color3.fromRGB(
		10,10,13
	),

	PURPLE = S.MenuColor,

	WHITE = Color3.fromRGB(
		255,255,255
	),

	GREEN = Color3.fromRGB(
		80,255,100
	),

	RED = Color3.fromRGB(
		255,80,80
	),
}

--==================================================
-- HELPER: CREATE
--==================================================

local function New(
	class,
	properties,
	parent
)

	local object =
		Instance.new(class)

	for property,value in pairs(
		properties or {}
	) do

		object[property] =
			value

	end

	if parent then
		object.Parent =
			parent
	end

	return object
end

--==================================================
-- HELPER: CORNER
--==================================================

local function Corner(
	object,
	radius
)

	local corner =
		Instance.new(
			"UICorner"
		)

	corner.CornerRadius =
		UDim.new(
			0,
			radius or 6
		)

	corner.Parent =
		object

	return corner
end

--==================================================
-- HELPER: STROKE
--==================================================

local function Stroke(
	object,
	color,
	thickness
)

	local stroke =
		Instance.new(
			"UIStroke"
		)

	stroke.Color =
		color or COLORS.PURPLE

	stroke.Thickness =
		thickness or 1

	stroke.Parent =
		object

	return stroke
end

--==================================================
-- HELPER: TWEEN
--==================================================

local function Tween(
	object,
	properties,
	time
)

	if not S.MenuAnimations then

		for property,value in pairs(
			properties
		) do

			object[property] =
				value

		end

		return

	end

	local info =
		TweenInfo.new(
			time or 0.18,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out
		)

	local tween =
		TweenService:Create(
			object,
			info,
			properties
		)

	tween:Play()

	return tween
end

--==================================================
-- CHARACTER HELPERS
--==================================================

local function GetCharacter()

	return Player.Character

end


local function GetHumanoid()

	local character =
		GetCharacter()

	if not character then
		return nil
	end

	return character:
		FindFirstChildOfClass(
			"Humanoid"
		)
end


local function GetRoot()

	local character =
		GetCharacter()

	if not character then
		return nil
	end

	return character:
		FindFirstChild(
			"HumanoidRootPart"
		)
end

--==================================================
-- SCREEN GUI
--==================================================

local Gui =
	New(
		"ScreenGui",
		{
			Name = "RustedHub",

			ResetOnSpawn = false,

			IgnoreGuiInset = true,

			DisplayOrder = 999,
		},
		PlayerGui
	)

--==================================================
-- MAIN
--==================================================

local Main =
	New(
		"Frame",
		{
			Name = "Main",

			Size =
				UDim2.fromOffset(
					500,
					300
				),

			Position =
				UDim2.new(
					0.5,
					-250,
					0.5,
					-150
				),

			BackgroundColor3 =
				COLORS.BG,

			BorderSizePixel = 0,

			ClipsDescendants = true,
		},
		Gui
	)

Corner(
	Main,
	10
)

Stroke(
	Main,
	COLORS.PURPLE,
	1
)

--==================================================
-- UI SCALE
--==================================================

local Scale =
	New(
		"UIScale",
		{
			Scale = 1,
		},
		Main
	)


local function UpdateScale()

	local camera =
		workspace.CurrentCamera

	if not camera then
		return
	end

	local viewport =
		camera.ViewportSize

	local scale =
		math.min(
			viewport.X / 900,
			viewport.Y / 600
		)

	Scale.Scale =
		math.clamp(
			scale,
			0.72,
			1.15
		)

end


UpdateScale()


workspace:GetPropertyChangedSignal(
	"CurrentCamera"
):Connect(
	function()

		task.wait()

		UpdateScale()

	end
)

--==================================================
-- TOP BAR
--==================================================

local Top =
	New(
		"Frame",
		{
			Name = "Top",

			Size =
				UDim2.new(
					1,
					0,
					0,
					48
				),

			BackgroundColor3 =
				COLORS.PANEL,

			BorderSizePixel = 0,
		},
		Main
	)

--==================================================
-- LOGO
--==================================================

local LogoBox =
	New(
		"Frame",
		{
			Size =
				UDim2.fromOffset(
					32,
					32
				),

			Position =
				UDim2.fromOffset(
					9,
					8
				),

			BackgroundColor3 =
				COLORS.PURPLE,

			BorderSizePixel = 0,
		},
		Top
	)

Corner(
	LogoBox,
	8
)


New(
	"TextLabel",
	{
		Size =
			UDim2.fromScale(
				1,
				1
			),

		BackgroundTransparency = 1,

		Text = "R",

		TextColor3 =
			COLORS.WHITE,

		TextSize = 19,

		Font =
			Enum.Font.GothamBold,
	},
	LogoBox
)

--==================================================
-- TITLE
--==================================================

New(
	"TextLabel",
	{
		Size =
			UDim2.fromOffset(
				180,
				28
			),

		Position =
			UDim2.fromOffset(
				50,
				5
			),

		BackgroundTransparency = 1,

		Text = "RUSTED",

		TextColor3 =
			COLORS.TEXT,

		TextSize = 16,

		TextXAlignment =
			Enum.TextXAlignment.Left,

		Font =
			Enum.Font.GothamBold,
	},
	Top
)


New(
	"TextLabel",
	{
		Size =
			UDim2.fromOffset(
				180,
				18
			),

		Position =
			UDim2.fromOffset(
				50,
				25
			),

		BackgroundTransparency = 1,

		Text = "RUSTED HUB",

		TextColor3 =
			COLORS.SUB,

		TextSize = 9,

		TextXAlignment =
			Enum.TextXAlignment.Left,

		Font =
			Enum.Font.Gotham,
	},
	Top
)

--==================================================
-- MINIMIZE
--==================================================

local Minimize =
	New(
		"TextButton",
		{
			Name = "Minimize",

			Size =
				UDim2.fromOffset(
					34,
					34
				),

			Position =
				UDim2.new(
					1,
					-76,
					0,
					7
				),

			BackgroundColor3 =
				COLORS.ROW,

			BorderSizePixel = 0,

			Text = "—",

			TextColor3 =
				COLORS.TEXT,

			TextSize = 18,

			Font =
				Enum.Font.GothamBold,

			AutoButtonColor = false,
		},
		Top
	)

Corner(
	Minimize,
	7
)

--==================================================
-- CLOSE
--==================================================

local Close =
	New(
		"TextButton",
		{
			Name = "Close",

			Size =
				UDim2.fromOffset(
					34,
					34
				),

			Position =
				UDim2.new(
					1,
					-38,
					0,
					7
				),

			BackgroundColor3 =
				COLORS.ROW,

			BorderSizePixel = 0,

			Text = "×",

			TextColor3 =
				COLORS.TEXT,

			TextSize = 20,

			Font =
				Enum.Font.GothamBold,

			AutoButtonColor = false,
		},
		Top
	)

Corner(
	Close,
	7
)

--==================================================
-- BODY
--==================================================

local Body =
	New(
		"Frame",
		{
			Name = "Body",

			Size =
				UDim2.new(
					1,
					0,
					1,
					-48
				),

			Position =
				UDim2.fromOffset(
					0,
					48
				),

			BackgroundTransparency = 1,

			ClipsDescendants = true,
		},
		Main
	)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar =
	New(
		"Frame",
		{
			Name = "Sidebar",

			Size =
				UDim2.fromOffset(
					125,
					252
				),

			BackgroundColor3 =
				COLORS.PANEL,

			BorderSizePixel = 0,
		},
		Body
	)

New(
	"UIPadding",
	{
		PaddingTop =
			UDim.new(
				0,
				10
			),

		PaddingLeft =
			UDim.new(
				0,
				8
			),

		PaddingRight =
			UDim.new(
				0,
				8
			),
	},
	Sidebar
)


New(
	"UIListLayout",
	{
		Padding =
			UDim.new(
				0,
				5
			),

		SortOrder =
			Enum.SortOrder.LayoutOrder,
	},
	Sidebar
)

--==================================================
-- CONTENT
--==================================================

local Content =
	New(
		"Frame",
		{
			Name = "Content",

			Size =
				UDim2.new(
					1,
					-125,
					1,
					0
				),

			Position =
				UDim2.fromOffset(
					125,
					0
				),

			BackgroundColor3 =
				COLORS.BG,

			BorderSizePixel = 0,

			ClipsDescendants = true,
		},
		Body
	)

--==================================================
-- PAGE HOLDER
--==================================================

local PageHolder =
	New(
		"Frame",
		{
			Name = "PageHolder",

			Size =
				UDim2.new(
					1,
					-20,
					1,
					-20
				),

			Position =
				UDim2.fromOffset(
					10,
					10
				),

			BackgroundTransparency = 1,

			ClipsDescendants = true,
		},
		Content
	)

--==================================================
-- PAGES TABLE
--==================================================

local Pages = {}

--==================================================
-- PART 1A END
--==================================================

--==================================================
--                 RUSTED HUB v4.0
--                    PART 1B/5
--==================================================

--==================================================
-- PAGE CREATOR
--==================================================

local CurrentPage = nil
local CategoryButtons = {}

local function CreatePage(name)

	local Page =
		New(
			"ScrollingFrame",
			{
				Name = name,

				Size =
					UDim2.fromScale(
						1,
						1
					),

				BackgroundTransparency = 1,

				BorderSizePixel = 0,

				CanvasSize =
					UDim2.new(
						0,
						0,
						0,
						0
					),

				AutomaticCanvasSize =
					Enum.AutomaticSize.Y,

				ScrollBarThickness = 3,

				ScrollBarImageColor3 =
					COLORS.PURPLE,

				Visible = false,
			},
			PageHolder
		)

	New(
		"UIPadding",
		{
			PaddingTop =
				UDim.new(
					0,
					4
				),

			PaddingBottom =
				UDim.new(
					0,
					10
				),

			PaddingLeft =
				UDim.new(
					0,
					4
				),

			PaddingRight =
				UDim.new(
					0,
					4
				),
		},
		Page
	)

	New(
		"UIListLayout",
		{
			Padding =
				UDim.new(
					0,
					7
				),

			SortOrder =
				Enum.SortOrder.LayoutOrder,
		},
		Page
	)

	Pages[name] = Page

	return Page
end

--==================================================
-- CREATE PAGES
--==================================================

local CombatPage =
	CreatePage(
		"Combat"
	)

local VisualsPage =
	CreatePage(
		"Visuals"
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
-- CATEGORY BUTTON
--==================================================

local function CreateCategory(
	name,
	order
)

	local Button =
		New(
			"TextButton",
			{
				Name = name,

				Size =
					UDim2.new(
						1,
						0,
						0,
						34
					),

				BackgroundColor3 =
					COLORS.ROW,

				BackgroundTransparency =
					0.25,

				BorderSizePixel = 0,

				Text = name,

				TextColor3 =
					COLORS.SUB,

				TextSize = 11,

				TextXAlignment =
					Enum.TextXAlignment.Left,

				Font =
					Enum.Font.GothamSemibold,

				AutoButtonColor = false,

				LayoutOrder =
					order,

				ClipsDescendants = true,
			},
			Sidebar
		)

	Corner(
		Button,
		7
	)

	New(
		"UIPadding",
		{
			PaddingLeft =
				UDim.new(
					0,
					12
				),
		},
		Button
	)

	local Indicator =
		New(
			"Frame",
			{
				Name = "Indicator",

				Size =
					UDim2.fromOffset(
						3,
						18
					),

				Position =
					UDim2.new(
						0,
						0,
						0.5,
						-9
					),

				BackgroundColor3 =
					COLORS.PURPLE,

				BackgroundTransparency = 1,

				BorderSizePixel = 0,
			},
			Button
		)

	Corner(
		Indicator,
		3
	)

	CategoryButtons[name] =
		Button

	Button.MouseEnter:Connect(
		function()

			if CurrentPage ~= name then

				Tween(
					Button,
					{
						BackgroundColor3 =
							COLORS.HOVER,
					},
					0.12
				)

			end

		end
	)

	Button.MouseLeave:Connect(
		function()

			if CurrentPage ~= name then

				Tween(
					Button,
					{
						BackgroundColor3 =
							COLORS.ROW,
					},
					0.12
				)

			end

		end
	)

	return Button
end

--==================================================
-- SWITCH PAGE
--==================================================

local function SwitchPage(
	name
)

	local page =
		Pages[name]

	if not page then
		return
	end

	for pageName,frame in pairs(
		Pages
	) do

		frame.Visible =
			(pageName == name)

	end

	for categoryName,button in pairs(
		CategoryButtons
	) do

		local active =
			categoryName == name

		if active then

			Tween(
				button,
				{
					BackgroundColor3 =
						COLORS.PURPLE,

					BackgroundTransparency =
						0.15,

					TextColor3 =
						COLORS.WHITE,
				},
				0.16
			)

			local indicator =
				button:FindFirstChild(
					"Indicator"
				)

			if indicator then

				Tween(
					indicator,
					{
						BackgroundTransparency = 0,
					},
					0.16
				)

			end

		else

			Tween(
				button,
				{
					BackgroundColor3 =
						COLORS.ROW,

					BackgroundTransparency =
						0.25,

					TextColor3 =
						COLORS.SUB,
				},
				0.16
			)

			local indicator =
				button:FindFirstChild(
					"Indicator"
				)

			if indicator then

				Tween(
					indicator,
					{
						BackgroundTransparency = 1,
					},
					0.16
				)

			end

		end

	end

	CurrentPage = name

end

--==================================================
-- CATEGORIES
--==================================================

local CombatButton =
	CreateCategory(
		"Combat",
		1
	)

local VisualsButton =
	CreateCategory(
		"Visuals",
		2
	)

local MovementButton =
	CreateCategory(
		"Movement",
		3
	)

local MiscButton =
	CreateCategory(
		"Misc",
		4
	)

local SettingsButton =
	CreateCategory(
		"Settings",
		5
	)

CombatButton.MouseButton1Click:Connect(
	function()
		SwitchPage("Combat")
	end
)

VisualsButton.MouseButton1Click:Connect(
	function()
		SwitchPage("Visuals")
	end
)

MovementButton.MouseButton1Click:Connect(
	function()
		SwitchPage("Movement")
	end
)

MiscButton.MouseButton1Click:Connect(
	function()
		SwitchPage("Misc")
	end
)

SettingsButton.MouseButton1Click:Connect(
	function()
		SwitchPage("Settings")
	end
)

--==================================================
-- TOGGLE CREATOR
--==================================================

local function CreateToggle(
	parent,
	name,
	key,
	description
)

	local Holder =
		New(
			"Frame",
			{
				Size =
					UDim2.new(
						1,
						-4,
						0,
						46
					),

				BackgroundColor3 =
					COLORS.ROW,

				BorderSizePixel = 0,
			},
			parent
		)

	Corner(
		Holder,
		7
	)

	local Text =
		New(
			"TextLabel",
			{
				Size =
					UDim2.new(
						1,
						-65,
						0,
						20
					),

				Position =
					UDim2.fromOffset(
						12,
						5
					),

				BackgroundTransparency = 1,

				Text = name,

				TextColor3 =
					COLORS.TEXT,

				TextSize = 11,

				TextXAlignment =
					Enum.TextXAlignment.Left,

				Font =
					Enum.Font.GothamSemibold,
			},
			Holder
		)

	if description then

		New(
			"TextLabel",
			{
				Size =
					UDim2.new(
						1,
						-65,
						0,
						14
					),

				Position =
					UDim2.fromOffset(
						12,
						25
					),

				BackgroundTransparency = 1,

				Text = description,

				TextColor3 =
					COLORS.SUB,

				TextSize = 8,

				TextXAlignment =
					Enum.TextXAlignment.Left,

				Font =
					Enum.Font.Gotham,
			},
			Holder
		)

	end

	local Switch =
		New(
			"TextButton",
			{
				Size =
					UDim2.fromOffset(
						38,
						20
					),

				Position =
					UDim2.new(
						1,
						-50,
						0.5,
						-10
					),

				BackgroundColor3 =
					COLORS.DARK,

				BorderSizePixel = 0,

				Text = "",

				AutoButtonColor = false,
			},
			Holder
		)

	Corner(
		Switch,
		10
	)

	local Circle =
		New(
			"Frame",
			{
				Size =
					UDim2.fromOffset(
						16,
						16
					),

				Position =
					UDim2.fromOffset(
						2,
						2
					),

				BackgroundColor3 =
					COLORS.SUB,

				BorderSizePixel = 0,
			},
			Switch
		)

	Corner(
		Circle,
		8
	)

	local function Update()

		local enabled =
			S[key] == true

		if enabled then

			Tween(
				Switch,
				{
					BackgroundColor3 =
						COLORS.PURPLE,
				},
				0.15
			)

			Tween(
				Circle,
				{
					Position =
						UDim2.fromOffset(
							20,
							2
						),

					BackgroundColor3 =
						COLORS.WHITE,
				},
				0.15
			)

		else

			Tween(
				Switch,
				{
					BackgroundColor3 =
						COLORS.DARK,
				},
				0.15
			)

			Tween(
				Circle,
				{
					Position =
						UDim2.fromOffset(
							2,
							2
						),

					BackgroundColor3 =
						COLORS.SUB,
				},
				0.15
			)

		end

	end

	Switch.MouseButton1Click:Connect(
		function()

			S[key] =
				not S[key]

			Update()

		end
	)

	Holder.MouseEnter:Connect(
		function()

			Tween(
				Holder,
				{
					BackgroundColor3 =
						COLORS.HOVER,
				},
				0.12
			)

		end
	)

	Holder.MouseLeave:Connect(
		function()

			Tween(
				Holder,
				{
					BackgroundColor3 =
						COLORS.ROW,
				},
				0.12
			)

		end
	)

	Update()

	return Holder
end

--==================================================
-- VALUE BOX
--==================================================

local function CreateValue(
	parent,
	name,
	key,
	default,
	minimum,
	maximum
)

	S[key] =
		tonumber(S[key])
		or default

	local Holder =
		New(
			"Frame",
			{
				Size =
					UDim2.new(
						1,
						-4,
						0,
						42
					),

				BackgroundColor3 =
					COLORS.ROW,

				BorderSizePixel = 0,
			},
			parent
		)

	Corner(
		Holder,
		7
	)

	New(
		"TextLabel",
		{
			Size =
				UDim2.new(
					1,
					-90,
					1,
					0
				),

			Position =
				UDim2.fromOffset(
					12,
					0
				),

			BackgroundTransparency = 1,

			Text = name,

			TextColor3 =
				COLORS.TEXT,

			TextSize = 10,

			TextXAlignment =
				Enum.TextXAlignment.Left,

			Font =
				Enum.Font.GothamSemibold,
		},
		Holder
	)

	local Box =
		New(
			"TextBox",
			{
				Size =
					UDim2.fromOffset(
						65,
						26
					),

				Position =
					UDim2.new(
						1,
						-75,
						0.5,
						-13
					),

				BackgroundColor3 =
					COLORS.DARK,

				BorderSizePixel = 0,

				Text =
					tostring(
						S[key]
					),

				TextColor3 =
					COLORS.WHITE,

				TextSize = 10,

				Font =
					Enum.Font.GothamBold,

				ClearTextOnFocus = false,
			},
			Holder
		)

	Corner(
		Box,
		6
	)

	Stroke(
		Box,
		COLORS.PURPLE,
		1,
		0.55
	)

	Box.FocusLost:Connect(
		function()

			local value =
				tonumber(
					Box.Text
				)

			if value == nil then

				value =
					S[key]

			end

			value =
				math.clamp(
					value,
					minimum,
					maximum
				)

			S[key] =
				value

			Box.Text =
				tostring(value)

		end
	)

	return Holder
end

--==================================================
-- COMBAT PAGE
--==================================================

CreateToggle(
	CombatPage,
	"Aim Assist",
	"AimAssist",
	"Selects the nearest valid target"
)

CreateToggle(
	CombatPage,
	"Players",
	"AimPlayers",
	"Allow player targets"
)

CreateToggle(
	CombatPage,
	"NPC",
	"AimNPC",
	"Allow NPC targets"
)

CreateToggle(
	CombatPage,
	"Visible Only",
	"AimVisibleOnly",
	"Ignore targets behind walls"
)

CreateValue(
	CombatPage,
	"Aim FOV",
	"AimFOV",
	150,
	10,
	1000
)

--==================================================
-- VISUALS PAGE
--==================================================

CreateToggle(
	VisualsPage,
	"Players ESP",
	"ESP",
	"Show players through the world"
)

CreateToggle(
	VisualsPage,
	"Box ESP",
	"BoxESP",
	"Draw a box around the character"
)

CreateToggle(
	VisualsPage,
	"Names",
	"Names",
	"Show player names"
)

CreateToggle(
	VisualsPage,
	"Health",
	"Health",
	"Show current health"
)

CreateToggle(
	VisualsPage,
	"Distance",
	"Distance",
	"Show distance to target"
)

CreateToggle(
	VisualsPage,
	"Snapline",
	"Snapline",
	"Draw a line toward targets"
)

CreateToggle(
	VisualsPage,
	"Chest ESP",
	"ChestESP",
	"Highlight the character chest"
)

--==================================================
-- MOVEMENT PAGE
--==================================================

CreateToggle(
	MovementPage,
	"Speed",
	"SpeedHack",
	"Change your movement speed"
)

CreateValue(
	MovementPage,
	"Speed Value",
	"Speed",
	16,
	1,
	500
)

CreateToggle(
	MovementPage,
	"Jump",
	"Jump",
	"Enable custom jump power"
)

CreateValue(
	MovementPage,
	"JumpPower",
	"JumpPower",
	50,
	1,
	500
)

CreateToggle(
	MovementPage,
	"Noclip",
	"Noclip",
	"Walk through solid objects"
)

CreateToggle(
	MovementPage,
	"FOV Changer",
	"FOVChanger",
	"Change camera field of view"
)

CreateValue(
	MovementPage,
	"FOV",
	"FOV",
	90,
	40,
	160
)

--==================================================
-- MISC PAGE
--==================================================

CreateToggle(
	MiscPage,
	"Fullbright",
	"Fullbright",
	"Make the game brighter"
)

CreateToggle(
	MiscPage,
	"Menu Animations",
	"MenuAnimations",
	"Enable menu animations"
)

--==================================================
-- SETTINGS PAGE
--==================================================

CreateToggle(
	SettingsPage,
	"Menu Animations",
	"MenuAnimations",
	"Enable animated menu transitions"
)

--==================================================
-- DEFAULT PAGE
--==================================================

SwitchPage(
	"Combat"
)

--==================================================
-- DRAG SYSTEM
--==================================================

local function MakeDraggable(
	object,
	handle
)

	handle =
		handle
		or object

	local dragging = false
	local dragStart
	local startPosition

	handle.InputBegan:Connect(
		function(input)

			if input.UserInputType ==
				Enum.UserInputType.MouseButton1
				or input.UserInputType ==
				Enum.UserInputType.Touch then

				dragging = true

				dragStart =
					input.Position

				startPosition =
					object.Position

				input.Changed:Connect(
					function()

						if input.UserInputState ==
							Enum.UserInputState.End then

							dragging = false

						end

					end
				)

			end

		end
	)

	UIS.InputChanged:Connect(
		function(input)

			if not dragging then
				return
			end

			if input.UserInputType ~=
				Enum.UserInputType.MouseMovement
				and input.UserInputType ~=
				Enum.UserInputType.Touch then

				return

			end

			local delta =
				input.Position -
				dragStart

			object.Position =
				UDim2.new(
					startPosition.X.Scale,
					startPosition.X.Offset + delta.X,
					startPosition.Y.Scale,
					startPosition.Y.Offset + delta.Y
				)

		end
	)

end

MakeDraggable(
	Main,
	Top
)

--==================================================
-- FLOATING REOPEN BUTTON
--==================================================

local Float =
	New(
		"TextButton",
		{
			Name = "RustedLogo",

			Size =
				UDim2.fromOffset(
					42,
					42
				),

			Position =
				UDim2.new(
					0,
					18,
					0.5,
					-21
				),

			BackgroundColor3 =
				COLORS.PURPLE,

			BorderSizePixel = 0,

			Text = "R",

			TextColor3 =
				COLORS.WHITE,

			TextSize = 19,

			Font =
				Enum.Font.GothamBlack,

			Visible = false,

			AutoButtonColor = false,

			ZIndex = 100,
		},
		Gui
	)

Corner(
	Float,
	12
)

Stroke(
	Float,
	COLORS.WHITE,
	1,
	0.55
)

MakeDraggable(
	Float,
	Float
)

--==================================================
-- MENU STATE
--==================================================

local MenuOpen = true

local NormalSize =
	UDim2.fromOffset(
		500,
		300
	)

local function OpenMenu()

	if MenuOpen then
		return
	end

	MenuOpen = true

	Float.Visible = false

	Main.Visible = true

	Main.Size =
		UDim2.fromOffset(
			42,
			42
		)

	Main.Rotation = -12

	Main.BackgroundTransparency = 1

	Tween(
		Main,
		{
			Size = NormalSize,

			Rotation = 0,

			BackgroundTransparency = 0,
		},
		0.35
	)

end

local function MinimizeMenu()

	if not MenuOpen then
		return
	end

	MenuOpen = false

	Tween(
		Main,
		{
			Size =
				UDim2.fromOffset(
					42,
					42
				),

			Rotation = 12,

			BackgroundTransparency = 1,
		},
		0.28
	)

	task.delay(
		0.25,
		function()

			if MenuOpen then
				return
			end

			Main.Visible = false

			Float.Visible = true

			Float.Size =
				UDim2.fromOffset(
					10,
					10
				)

			Float.BackgroundTransparency = 1

			Tween(
				Float,
				{
					Size =
						UDim2.fromOffset(
							42,
							42
						),

					BackgroundTransparency = 0,
				},
				0.3
			)

		end
	)

end

--==================================================
-- MINIMIZE BUTTON
--==================================================

Minimize.MouseEnter:Connect(
	function()

		Tween(
			Minimize,
			{
				BackgroundColor3 =
					COLORS.HOVER,
			},
			0.12
		)

	end
)

Minimize.MouseLeave:Connect(
	function()

		Tween(
			Minimize,
			{
				BackgroundColor3 =
					COLORS.ROW,
			},
			0.12
		)

	end
)

Minimize.MouseButton1Click:Connect(
	function()

		MinimizeMenu()

	end
)

--==================================================
-- CLOSE BUTTON
--==================================================

Close.MouseEnter:Connect(
	function()

		Tween(
			Close,
			{
				BackgroundColor3 =
					COLORS.RED,
			},
			0.12
		)

	end
)

Close.MouseLeave:Connect(
	function()

		Tween(
			Close,
			{
				BackgroundColor3 =
					COLORS.ROW,
			},
			0.12
		)

	end
)

Close.MouseButton1Click:Connect(
	function()

		Gui.Enabled = false

	end
)

--==================================================
-- FLOAT OPEN
--==================================================

Float.MouseEnter:Connect(
	function()

		Tween(
			Float,
			{
				Size =
					UDim2.fromOffset(
						48,
						48
					),

				BackgroundColor3 =
					COLORS.HOVER,
			},
			0.12
		)

	end
)

Float.MouseLeave:Connect(
	function()

		Tween(
			Float,
			{
				Size =
					UDim2.fromOffset(
						42,
						42
					),

				BackgroundColor3 =
					COLORS.PURPLE,
			},
			0.12
		)

	end
)

Float.MouseButton1Click:Connect(
	function()

		OpenMenu()

	end
)

--==================================================
-- TOP BAR DRAG HOVER
--==================================================

Top.MouseEnter:Connect(
	function()

		if not MenuOpen then
			return
		end

		Tween(
			LogoBox,
			{
				Rotation = 8,
			},
			0.15
		)

	end
)

Top.MouseLeave:Connect(
	function()

		Tween(
			LogoBox,
			{
				Rotation = 0,
			},
			0.15
		)

	end
)

--==================================================
-- LOGO ANIMATION
--==================================================

task.spawn(
	function()

		while Gui.Parent do

			if MenuOpen
				and S.MenuAnimations then

				Tween(
					LogoBox,
					{
						Rotation = 5,
					},
					0.6
				)

				task.wait(0.6)

				Tween(
					LogoBox,
					{
						Rotation = -5,
					},
					0.6
				)

				task.wait(0.6)

			else

				task.wait(0.5)

			end

		end

	end
)

--==================================================
-- PART 1B END
--==================================================

--==================================================
--                 RUSTED HUB v4.0
--                    PART 2A/5
--              TARGET + ESP CORE
--==================================================

--==================================================
-- TARGET / ESP STORAGE
--==================================================

local CurrentTarget = nil

local ESPObjects = {}

local ESPConnections = {}

local Camera = workspace.CurrentCamera

--==================================================
-- CAMERA UPDATE
--==================================================

workspace:GetPropertyChangedSignal(
	"CurrentCamera"
):Connect(
	function()

		Camera =
			workspace.CurrentCamera

	end
)

--==================================================
-- CHARACTER ROOT
--==================================================

local function GetRootOf(
	character
)

	if not character then
		return nil
	end

	return character:
		FindFirstChild(
			"HumanoidRootPart"
		)

end

--==================================================
-- HUMANOID
--==================================================

local function GetHumanoidOf(
	character
)

	if not character then
		return nil
	end

	return character:
		FindFirstChildOfClass(
			"Humanoid"
		)

end

--==================================================
-- VALID CHARACTER
--==================================================

local function IsValidCharacter(
	character
)

	if not character then
		return false
	end

	if not character:IsA(
		"Model"
	) then

		return false

	end

	local humanoid =
		GetHumanoidOf(
			character
		)

	local root =
		GetRootOf(
			character
		)

	if not humanoid
		or not root then

		return false

	end

	if humanoid.Health <= 0 then
		return false
	end

	return true

end

--==================================================
-- PLAYER FROM CHARACTER
--==================================================

local function GetPlayerFromCharacter(
	character
)

	if not character then
		return nil
	end

	return Players:
		GetPlayerFromCharacter(
			character
		)

end

--==================================================
-- TEAM CHECK
--==================================================

local function IsEnemyPlayer(
	player
)

	if not player then
		return false
	end

	if player == Player then
		return false
	end

	-- Team Check remains available for combat.
	-- It is NOT an ESP toggle.

	if S.TeamCheck
		and Player.Team ~= nil
		and player.Team ~= nil
		and Player.Team == player.Team then

		return false

	end

	return true

end

--==================================================
-- VISIBILITY CHECK
--==================================================

local function IsVisible(
	character
)

	if not Camera
		or not character then

		return false

	end

	local root =
		GetRootOf(
			character
		)

	if not root then
		return false
	end

	local origin =
		Camera.CFrame.Position

	local direction =
		root.Position -
		origin

	local params =
		RaycastParams.new()

	params.FilterType =
		Enum.RaycastFilterType.Exclude

	params.FilterDescendantsInstances = {
		Player.Character
	}

	params.IgnoreWater = true

	local result =
		workspace:Raycast(
			origin,
			direction,
			params
		)

	if not result then
		return true
	end

	return result.Instance:
		IsDescendantOf(
			character
		)

end

--==================================================
-- SCREEN POSITION
--==================================================

local function GetScreenPosition(
	position
)

	if not Camera then
		return nil, false
	end

	local screen,
		visible =
		Camera:WorldToViewportPoint(
			position
		)

	return Vector2.new(
		screen.X,
		screen.Y
	),
	visible
end

--==================================================
-- MOUSE / CENTER
--==================================================

local function GetScreenCenter()

	if not Camera then
		return Vector2.zero
	end

	local viewport =
		Camera.ViewportSize

	return Vector2.new(
		viewport.X / 2,
		viewport.Y / 2
	)

end

--==================================================
-- FOV CHECK
--==================================================

local function IsInsideFOV(
	character
)

	local root =
		GetRootOf(
			character
		)

	if not root then
		return false
	end

	local screen,
		visible =
		GetScreenPosition(
			root.Position
		)

	if not visible then
		return false
	end

	local center =
		GetScreenCenter()

	local distance =
		(screen - center).Magnitude

	return distance <= S.AimFOV

end

--==================================================
-- FIND CLOSEST PLAYER
--==================================================

local function GetClosestPlayer()

	if not Camera then
		return nil
	end

	local closest = nil

	local closestDistance =
		math.huge

	for _,player in ipairs(
		Players:GetPlayers()
	) do

		if player ~= Player
			and IsEnemyPlayer(
				player
			) then

			local character =
				player.Character

			if IsValidCharacter(
				character
			) then

				local root =
					GetRootOf(
						character
					)

				if root then

					local screen,
						visible =
						GetScreenPosition(
							root.Position
						)

					if visible then

						local distance =
							(
								screen -
								GetScreenCenter()
							).Magnitude

						if distance <=
							S.AimFOV then

							if not S.AimVisibleOnly
								or IsVisible(
									character
								) then

								if distance <
									closestDistance then

									closestDistance =
										distance

									closest =
										player

								end

							end

						end

					end

				end

			end

		end

	end

	return closest

end

--==================================================
-- FIND CLOSEST NPC
--==================================================

local function GetClosestNPC()

	if not Camera then
		return nil
	end

	local closest = nil

	local closestDistance =
		math.huge

	local center =
		GetScreenCenter()

	for _,object in ipairs(
		workspace:GetDescendants()
	) do

		if object:IsA(
			"Model"
		)
		and not Players:
			GetPlayerFromCharacter(
				object
			)
		then

			if IsValidCharacter(
				object
			) then

				local root =
					GetRootOf(
						object
					)

				if root then

					local screen,
						visible =
						GetScreenPosition(
							root.Position
						)

					if visible then

						local distance =
							(
								screen -
								center
							).Magnitude

						if distance <=
							S.AimFOV then

							if not S.AimVisibleOnly
								or IsVisible(
									object
								) then

								if distance <
									closestDistance then

									closestDistance =
										distance

									closest =
										object

								end

							end

						end

					end

				end

			end

		end

	end

	return closest

end

--==================================================
-- UNIVERSAL TARGET
--==================================================

local function FindTarget()

	local playerTarget = nil
	local npcTarget = nil

	if S.AimPlayers then

		playerTarget =
			GetClosestPlayer()

	end

	if S.AimNPC then

		npcTarget =
			GetClosestNPC()

	end

	if not playerTarget
		and not npcTarget then

		return nil

	end

	if playerTarget
		and not npcTarget then

		return playerTarget.Character

	end

	if npcTarget
		and not playerTarget then

		return npcTarget

	end

	local playerCharacter =
		playerTarget.Character

	local playerRoot =
		GetRootOf(
			playerCharacter
		)

	local npcRoot =
		GetRootOf(
			npcTarget
		)

	if not playerRoot
		or not npcRoot then

		return playerCharacter
			or npcTarget

	end

	local center =
		GetScreenCenter()

	local playerScreen =
		Camera:
			WorldToViewportPoint(
				playerRoot.Position
			)

	local npcScreen =
		Camera:
			WorldToViewportPoint(
				npcRoot.Position
			)

	local playerDistance =
		(
			Vector2.new(
				playerScreen.X,
				playerScreen.Y
			) -
			center
		).Magnitude

	local npcDistance =
		(
			Vector2.new(
				npcScreen.X,
				npcScreen.Y
			) -
			center
		).Magnitude

	if playerDistance <=
		npcDistance then

		return playerCharacter

	end

	return npcTarget

end

--==================================================
-- UPDATE TARGET
--==================================================

local function UpdateTarget()

	if not S.AimAssist then

		CurrentTarget = nil

		return nil

	end

	CurrentTarget =
		FindTarget()

	return CurrentTarget

end

--==================================================
-- ESP ROOT
--==================================================

local ESPFolder =
	New(
		"Folder",
		{
			Name = "RustedESP",
		},
		Gui
	)

--==================================================
-- ESP COLOR
--==================================================

local function GetESPColor()

	return S.ESPColor

end

--==================================================
-- REMOVE ESP
--==================================================

local function RemoveESP(
	character
)

	local data =
		ESPObjects[
			character
		]

	if not data then
		return
	end

	for _,object in pairs(
		data
	) do

		if typeof(object) ==
			"Instance" then

			pcall(
				function()

					object:Destroy()

				end
			)

		end

	end

	ESPObjects[
		character
	] = nil

end

--==================================================
-- MODEL BOUNDS
--==================================================

local function GetCharacterBounds(
	character
)

	if not Camera
		or not character then

		return nil
	end

	local cf, size

	local success =
		pcall(
			function()

				cf, size =
					character:
						GetBoundingBox()

			end
		)

	if not success
		or not cf
		or not size then

		return nil

	end

	local half =
		size / 2

	local corners = {

		cf * Vector3.new(
			-half.X,
			-half.Y,
			-half.Z
		),

		cf * Vector3.new(
			-half.X,
			-half.Y,
			half.Z
		),

		cf * Vector3.new(
			-half.X,
			half.Y,
			-half.Z
		),

		cf * Vector3.new(
			-half.X,
			half.Y,
			half.Z
		),

		cf * Vector3.new(
			half.X,
			-half.Y,
			-half.Z
		),

		cf * Vector3.new(
			half.X,
			-half.Y,
			half.Z
		),

		cf * Vector3.new(
			half.X,
			half.Y,
			-half.Z
		),

		cf * Vector3.new(
			half.X,
			half.Y,
			half.Z
		),
	}

	local minX =
		math.huge

	local minY =
		math.huge

	local maxX =
		-math.huge

	local maxY =
		-math.huge

	local anyVisible =
		false

	for _,corner in ipairs(
		corners
	) do

		local screen,
			visible =
			GetScreenPosition(
				corner.Position
			)

		if screen then

			minX =
				math.min(
					minX,
					screen.X
				)

			minY =
				math.min(
					minY,
					screen.Y
				)

			maxX =
				math.max(
					maxX,
					screen.X
				)

			maxY =
				math.max(
					maxY,
					screen.Y
				)

			if visible then
				anyVisible = true
			end

		end

	end

	if minX == math.huge then
		return nil
	end

	return {
		Position = Vector2.new(
			minX,
			minY
		),

		Size = Vector2.new(
			maxX - minX,
			maxY - minY
		),

		Visible = anyVisible,
	}

end

--==================================================
-- CREATE ESP DATA
--==================================================

local function CreateESP(
	character
)

	if not IsValidCharacter(
		character
	) then

		return nil

	end

	if ESPObjects[
		character
	] then

		return ESPObjects[
			character
		]

	end

	local data = {}

	ESPObjects[
		character
	] = data

	return data

end

--==================================================
-- FIND ESP CHARACTERS
--==================================================

local function GetESPCharacters()

	local result = {}

	if not S.ESP then
		return result
	end

	for _,player in ipairs(
		Players:GetPlayers()
	) do

		if player ~= Player then

			local character =
				player.Character

			if IsValidCharacter(
				character
			) then

				table.insert(
					result,
					character
				)

			end

		end

	end

	return result

end

--==================================================
-- ESP CLEANUP
--==================================================

local function CleanupESP()

	for character,_ in pairs(
		ESPObjects
	) do

		if not character
			or not character.Parent
			or not IsValidCharacter(
				character
			) then

			RemoveESP(
				character
			)

		end

	end

end

--==================================================
-- TARGET LOOP
--==================================================

ESPConnections.TargetLoop =
	RunService.RenderStepped:Connect(
		function()

			UpdateTarget()

		end
	)

--==================================================
-- ESP CLEANUP LOOP
--==================================================

ESPConnections.CleanupLoop =
	RunService.RenderStepped:Connect(
		function()

			CleanupESP()

		end
	)

--==================================================
-- PLAYER REMOVAL
--==================================================

Players.PlayerRemoving:Connect(
	function(player)

		if player.Character then

			RemoveESP(
				player.Character
			)

		end

	end
)

--==================================================
-- PART 2A END
--==================================================

--==================================================
--                 RUSTED HUB v4.0
--                    PART 2B/5
--                 ESP RENDER SYSTEM
--==================================================

--==================================================
-- ESP UI HELPERS
--==================================================

local function CreateESPFrame(
	parent,
	name
)

	local frame =
		New(
			"Frame",
			{
				Name = name,

				BackgroundTransparency = 1,

				BorderSizePixel = 0,

				Visible = false,

				ZIndex = 50,
			},
			parent
		)

	return frame
end

--==================================================
-- CREATE PLAYER ESP
--==================================================

local function BuildESP(
	character
)

	if not character then
		return nil
	end

	if ESPObjects[
		character
	] then

		return ESPObjects[
			character
	]

	end

	local container =
		New(
			"Frame",
			{
				Name =
					"ESP_" ..
					character.Name,

				Size =
					UDim2.fromScale(
						1,
						1
					),

				Position =
					UDim2.fromScale(
						0,
						0
					),

				BackgroundTransparency = 1,

				BorderSizePixel = 0,

				Visible = true,

				ZIndex = 50,
			},
			ESPFolder
		)

	local box =
		CreateESPFrame(
			container,
			"Box"
		)

	local boxStroke =
		Instance.new(
			"UIStroke"
		)

	boxStroke.Thickness = 1.5

	boxStroke.Color =
		S.BoxColor

	boxStroke.Transparency = 0

	boxStroke.Parent =
		box

	-- NAME

	local nameLabel =
		New(
			"TextLabel",
			{
				Name = "Name",

				AnchorPoint =
					Vector2.new(
						0.5,
						1
					),

				BackgroundTransparency = 1,

				Text = character.Name,

				TextColor3 =
					S.NameColor,

				TextSize = 11,

				Font =
					Enum.Font.GothamBold,

				TextStrokeTransparency = 0.35,

				TextStrokeColor3 =
					Color3.new(
						0,
						0,
						0
					),

				Visible = false,

				ZIndex = 52,
			},
			container
		)

	-- HEALTH

	local healthBackground =
		New(
			"Frame",
			{
				Name =
					"HealthBackground",

				BackgroundColor3 =
					Color3.fromRGB(
						20,
						20,
						20
					),

				BorderSizePixel = 0,

				Visible = false,

				ZIndex = 51,
			},
			container
		)

	local healthFill =
		New(
			"Frame",
			{
				Name =
					"HealthFill",

				BackgroundColor3 =
					S.HealthColor,

				BorderSizePixel = 0,

				AnchorPoint =
					Vector2.new(
						0,
						1
					),

				Position =
					UDim2.fromScale(
						0,
						1
					),

				Size =
					UDim2.fromScale(
						1,
						1
					),

				ZIndex = 52,
			},
			healthBackground
		)

	-- DISTANCE

	local distanceLabel =
		New(
			"TextLabel",
			{
				Name =
					"Distance",

				AnchorPoint =
					Vector2.new(
						0.5,
						0
					),

				BackgroundTransparency = 1,

				Text = "",

				TextColor3 =
					S.DistanceColor,

				TextSize = 9,

				Font =
					Enum.Font.Gotham,

				TextStrokeTransparency = 0.4,

				TextStrokeColor3 =
					Color3.new(
						0,
						0,
						0
					),

				Visible = false,

				ZIndex = 52,
			},
			container
		)

	-- SNAPLINE

	local snapline =
		New(
			"Frame",
			{
				Name =
					"Snapline",

				AnchorPoint =
					Vector2.new(
						0.5,
						0
					),

				BackgroundColor3 =
					S.SnaplineColor,

				BorderSizePixel = 0,

				Visible = false,

				ZIndex = 49,
			},
			container
		)

	-- CHEST

	local chest =
		New(
			"Frame",
			{
				Name =
					"Chest",

				AnchorPoint =
					Vector2.new(
						0.5,
						0.5
					),

				Size =
					UDim2.fromOffset(
						8,
						8
					),

				BackgroundColor3 =
					S.ChestColor,

				BorderSizePixel = 0,

				Visible = false,

				ZIndex = 53,
			},
			container
		)

	Corner(
		chest,
		4
	)

	local data = {

		Container = container,

		Box = box,

		BoxStroke = boxStroke,

		NameLabel = nameLabel,

		HealthBackground =
			healthBackground,

		HealthFill =
			healthFill,

		DistanceLabel =
			distanceLabel,

		Snapline =
			snapline,

		Chest = chest,
	}

	ESPObjects[
		character
	] = data

	return data
end

--==================================================
-- REMOVE INVALID ESP
--==================================================

local function RemoveInvalidESP()

	for character,data in pairs(
		ESPObjects
	) do

		if not character
			or not character.Parent then

			RemoveESP(
				character
			)

		elseif not IsValidCharacter(
			character
		) then

			RemoveESP(
				character
			)

		end

	end

end

--==================================================
-- UPDATE BOX
--==================================================

local function UpdateBox(
	data,
	bounds
)

	if not data
		or not data.Box then

		return

	end

	if not S.BoxESP
		or not bounds
		or not bounds.Visible then

		data.Box.Visible = false

		return

	end

	-- Real character screen bounds.
	-- No fixed 55x75 box.

	data.Box.Visible = true

	data.Box.Position =
		UDim2.fromOffset(
			bounds.Position.X,
			bounds.Position.Y
		)

	data.Box.Size =
		UDim2.fromOffset(
			math.max(
				2,
				bounds.Size.X
			),

			math.max(
				2,
				bounds.Size.Y
			)
		)

	data.BoxStroke.Color =
		S.BoxColor

end

--==================================================
-- UPDATE NAME
--==================================================

local function UpdateName(
	data,
	bounds
)

	if not data
		or not data.NameLabel then

		return

	end

	if not S.Names
		or not bounds
		or not bounds.Visible then

		data.NameLabel.Visible = false

		return

	end

	data.NameLabel.Visible = true

	data.NameLabel.Position =
		UDim2.fromOffset(
			bounds.Position.X +
				bounds.Size.X / 2,

			bounds.Position.Y - 3
		)

	data.NameLabel.TextColor3 =
		S.NameColor

end

--==================================================
-- UPDATE HEALTH
--==================================================

local function UpdateHealth(
	data,
	character,
	bounds
)

	if not data
		or not data.HealthBackground then

		return

	end

	if not S.Health
		or not bounds
		or not bounds.Visible then

		data.HealthBackground.Visible =
			false

		return

	end

	local humanoid =
		GetHumanoidOf(
			character
		)

	if not humanoid then

		data.HealthBackground.Visible =
			false

		return

	end

	data.HealthBackground.Visible =
		true

	local width = 3

	local x =
		bounds.Position.X - 6

	local y =
		bounds.Position.Y

	local height =
		math.max(
			2,
			bounds.Size.Y
		)

	data.HealthBackground.Position =
		UDim2.fromOffset(
			x,
			y
		)

	data.HealthBackground.Size =
		UDim2.fromOffset(
			width,
			height
		)

	local health =
		math.clamp(
			humanoid.Health /
				math.max(
					humanoid.MaxHealth,
					1
				),

			0,
			1
		)

	data.HealthFill.Size =
		UDim2.new(
			1,
			0,
			health,
			0
		)

	data.HealthFill.BackgroundColor3 =
		S.HealthColor

end

--==================================================
-- UPDATE DISTANCE
--==================================================

local function UpdateDistance(
	data,
	character,
	bounds
)

	if not data
		or not data.DistanceLabel then

		return

	end

	if not S.Distance
		or not bounds
		or not bounds.Visible then

		data.DistanceLabel.Visible =
			false

		return

	end

	local root =
		GetRootOf(
			character
		)

	local localRoot =
		GetRoot()

	if not root
		or not localRoot then

		data.DistanceLabel.Visible =
			false

		return

	end

	local distance =
		(
			root.Position -
			localRoot.Position
		).Magnitude

	data.DistanceLabel.Visible =
		true

	data.DistanceLabel.Text =
		string.format(
			"%dm",
			math.floor(
				distance
			)
		)

	data.DistanceLabel.Position =
		UDim2.fromOffset(
			bounds.Position.X +
				bounds.Size.X / 2,

			bounds.Position.Y +
				bounds.Size.Y +
				3
		)

	data.DistanceLabel.TextColor3 =
		S.DistanceColor

end

--==================================================
-- UPDATE SNAPLINE
--==================================================

local function UpdateSnapline(
	data,
	bounds
)

	if not data
		or not data.Snapline then

		return

	end

	if not S.Snapline
		or not bounds
		or not bounds.Visible then

		data.Snapline.Visible =
			false

		return

	end

	local center =
		GetScreenCenter()

	local target =
		Vector2.new(
			bounds.Position.X +
				bounds.Size.X / 2,

			bounds.Position.Y +
				bounds.Size.Y
		)

	local difference =
		target - center

	local length =
		difference.Magnitude

	if length < 1 then

		data.Snapline.Visible =
			false

		return

	end

	local angle =
		math.deg(
			math.atan2(
				difference.Y,
				difference.X
			)
		)

	data.Snapline.Visible =
		true

	data.Snapline.Position =
		UDim2.fromOffset(
			center.X,
			center.Y
		)

	data.Snapline.Size =
		UDim2.fromOffset(
			length,
			1
		)

	data.Snapline.Rotation =
		angle

	data.Snapline.BackgroundColor3 =
		S.SnaplineColor

end

--==================================================
-- UPDATE CHEST ESP
--==================================================

local function UpdateChest(
	data,
	character
)

	if not data
		or not data.Chest then

		return

	end

	if not S.ChestESP then

		data.Chest.Visible =
			false

		return

	end

	local chestPart =
		character:
			FindFirstChild(
				"UpperTorso"
			)
			or character:
			FindFirstChild(
				"Torso"
			)
			or character:
			FindFirstChild(
				"HumanoidRootPart"
			)

	if not chestPart then

		data.Chest.Visible =
			false

		return

	end

	local screen,
		visible =
		GetScreenPosition(
			chestPart.Position
		)

	if not screen
		or not visible then

		data.Chest.Visible =
			false

		return

	end

	data.Chest.Visible =
		true

	data.Chest.Position =
		UDim2.fromOffset(
			screen.X,
			screen.Y
		)

	data.Chest.BackgroundColor3 =
		S.ChestColor

end

--==================================================
-- UPDATE SINGLE ESP
--==================================================

local function UpdateESP(
	character
)

	if not S.ESP then

		local data =
			ESPObjects[
				character
			]

		if data then

			data.Container.Visible =
				false

		end

		return

	end

	if not IsValidCharacter(
		character
	) then

		RemoveESP(
			character
		)

		return

	end

	local data =
		BuildESP(
			character
		)

	if not data then
		return
	end

	data.Container.Visible =
		true

	local bounds =
		GetCharacterBounds(
			character
		)

	if not bounds then

		data.Container.Visible =
			false

		return

	end

	UpdateBox(
		data,
		bounds
	)

	UpdateName(
		data,
		bounds
	)

	UpdateHealth(
		data,
		character,
		bounds
	)

	UpdateDistance(
		data,
		character,
		bounds
	)

	UpdateSnapline(
		data,
		bounds
	)

	UpdateChest(
		data,
		character
	)

end

--==================================================
-- ESP RENDER LOOP
--==================================================

local ESPRenderConnection

ESPRenderConnection =
	RunService.RenderStepped:Connect(
		function()

			if not Gui
				or not Gui.Parent then

				return

			end

			if not Camera then

				Camera =
					workspace.CurrentCamera

			end

			if not S.ESP then

				for _,data in pairs(
					ESPObjects
				) do

					if data.Container then

						data.Container.Visible =
							false

					end

				end

				return

			end

			local characters =
				GetESPCharacters()

			local active =
				{}

			for _,character in ipairs(
				characters
			) do

				active[
					character
				] = true

				UpdateESP(
					character
				)

			end

			for character,data in pairs(
				ESPObjects
			) do

				if not active[
					character
				] then

					if data.Container then

						data.Container.Visible =
							false

					end

				end

			end

			RemoveInvalidESP()

		end
	)

--==================================================
-- PLAYER CHARACTER UPDATE
--==================================================

local function TrackPlayer(
	player
)

	if player == Player then
		return
	end

	player.CharacterAdded:Connect(
		function(character)

			task.wait(
				0.25
			)

			if S.ESP then

				BuildESP(
					character
				)

			end

		end
	)

	player.CharacterRemoving:Connect(
		function(character)

			RemoveESP(
				character
			)

		end
	)

end

for _,player in ipairs(
	Players:GetPlayers()
) do

	TrackPlayer(
		player
	)

end

Players.PlayerAdded:Connect(
	function(player)

		TrackPlayer(
			player
		)

	end
)

--==================================================
-- COLOR REFRESH
--==================================================

RunService.RenderStepped:Connect(
	function()

		for _,data in pairs(
			ESPObjects
		) do

			if data.BoxStroke then

				data.BoxStroke.Color =
					S.BoxColor

			end

			if data.NameLabel then

				data.NameLabel.TextColor3 =
					S.NameColor

			end

			if data.HealthFill then

				data.HealthFill.BackgroundColor3 =
					S.HealthColor

			end

			if data.DistanceLabel then

				data.DistanceLabel.TextColor3 =
					S.DistanceColor

			end

			if data.Snapline then

				data.Snapline.BackgroundColor3 =
					S.SnaplineColor

			end

			if data.Chest then

				data.Chest.BackgroundColor3 =
					S.ChestColor

			end

		end

	end
)

--==================================================
-- PART 2B END
--==================================================

--==================================================
--                 RUSTED HUB v4.0
--                    PART 3A/5
--                 MOVEMENT SYSTEM
--==================================================

--==================================================
-- MOVEMENT STATE
--==================================================

local OriginalWalkSpeed = 16
local OriginalJumpPower = 50

--==================================================
-- GET HUMANOID
--==================================================

local function GetCurrentHumanoid()

	local character =
		Player.Character

	if not character then
		return nil
	end

	return character:
		FindFirstChildOfClass(
			"Humanoid"
		)

end

--==================================================
-- SAVE DEFAULT VALUES
--==================================================

local function SaveCharacterDefaults()

	local humanoid =
		GetCurrentHumanoid()

	if not humanoid then
		return
	end

	OriginalWalkSpeed =
		humanoid.WalkSpeed

	if humanoid.UseJumpPower then

		OriginalJumpPower =
			humanoid.JumpPower

	end

end

SaveCharacterDefaults()

--==================================================
-- APPLY SPEED
--==================================================

local function ApplySpeed()

	local humanoid =
		GetCurrentHumanoid()

	if not humanoid then
		return
	end

	if S.SpeedHack then

		local value =
			tonumber(
				S.Speed
			)

		if value then

			humanoid.WalkSpeed =
				math.clamp(
					value,
					1,
					500
				)

		end

	else

		humanoid.WalkSpeed =
			OriginalWalkSpeed

	end

end

--==================================================
-- APPLY JUMP POWER
--==================================================

local function ApplyJump()

	local humanoid =
		GetCurrentHumanoid()

	if not humanoid then
		return
	end

	if S.Jump then

		humanoid.UseJumpPower =
			true

		local value =
			tonumber(
				S.JumpPower
			)

		if value then

			humanoid.JumpPower =
				math.clamp(
					value,
					1,
					500
				)

		end

	else

		if humanoid.UseJumpPower then

			humanoid.JumpPower =
				OriginalJumpPower

		end

	end

end

--==================================================
-- MOVEMENT LOOP
--==================================================

local MovementConnection

MovementConnection =
	RunService.Heartbeat:Connect(
		function()

			local humanoid =
				GetCurrentHumanoid()

			if not humanoid then
				return
			end

			-- SPEED

			if S.SpeedHack then

				local speed =
					tonumber(
						S.Speed
					)

				if speed then

					humanoid.WalkSpeed =
						math.clamp(
							speed,
							1,
							500
						)

				end

			elseif humanoid.WalkSpeed ~=
				OriginalWalkSpeed then

				humanoid.WalkSpeed =
					OriginalWalkSpeed

			end

			-- JUMP POWER

			if S.Jump then

				humanoid.UseJumpPower =
					true

				local jumpPower =
					tonumber(
						S.JumpPower
					)

				if jumpPower then

					humanoid.JumpPower =
						math.clamp(
							jumpPower,
							1,
							500
						)

				end

			end

		end
	)

--==================================================
-- NOCLIP
--==================================================

local NoclipConnection

NoclipConnection =
	RunService.Stepped:Connect(
		function()

			if not S.Noclip then
				return
			end

			local character =
				Player.Character

			if not character then
				return
			end

			for _,object in ipairs(
				character:GetDescendants()
			) do

				if object:IsA(
					"BasePart"
				) then

					object.CanCollide =
						false

				end

			end

		end
	)

--==================================================
-- RESTORE COLLISION
--==================================================

local function RestoreCollision()

	local character =
		Player.Character

	if not character then
		return
	end

	for _,object in ipairs(
		character:GetDescendants()
	) do

		if object:IsA(
			"BasePart"
		) then

			object.CanCollide =
				true

		end

	end

end

--==================================================
-- NOCLIP STATE MONITOR
--==================================================

local PreviousNoclip =
	false

local NoclipStateConnection

NoclipStateConnection =
	RunService.Heartbeat:Connect(
		function()

			if PreviousNoclip
				and not S.Noclip then

				RestoreCollision()

			end

			PreviousNoclip =
				S.Noclip

		end
	)

--==================================================
-- CHARACTER SETUP
--==================================================

local function SetupMovementCharacter(
	character
)

	if not character then
		return
	end

	local humanoid =
		character:
			WaitForChild(
				"Humanoid",
				5
			)

	if not humanoid then
		return
	end

	task.wait(
		0.15
	)

	OriginalWalkSpeed =
		humanoid.WalkSpeed

	if humanoid.UseJumpPower then

		OriginalJumpPower =
			humanoid.JumpPower

	end

	ApplySpeed()

	ApplyJump()

end

--==================================================
-- CHARACTER ADDED
--==================================================

if Player.Character then

	task.spawn(
		function()

			SetupMovementCharacter(
				Player.Character
			)

		end
	)

end

local MovementCharacterConnection

MovementCharacterConnection =
	Player.CharacterAdded:Connect(
		function(character)

			task.spawn(
				function()

					SetupMovementCharacter(
						character
					)

				end
			)

		end
	)

--==================================================
-- MOVEMENT VALUE MONITOR
--==================================================

local MovementValueConnection

MovementValueConnection =
	RunService.Heartbeat:Connect(
		function()

			if not Player.Character then
				return
			end

			if S.SpeedHack then

				ApplySpeed()

			end

			if S.Jump then

				ApplyJump()

			end

		end
	)

--==================================================
-- CLEANUP MOVEMENT
--==================================================

local function CleanupMovement()

	local humanoid =
		GetCurrentHumanoid()

	if humanoid then

		humanoid.WalkSpeed =
			OriginalWalkSpeed

		if humanoid.UseJumpPower then

			humanoid.JumpPower =
				OriginalJumpPower

		end

	end

	RestoreCollision()

	if MovementConnection then

		MovementConnection:
			Disconnect()

	end

	if NoclipConnection then

		NoclipConnection:
			Disconnect()

	end

	if NoclipStateConnection then

		NoclipStateConnection:
			Disconnect()

	end

	if MovementValueConnection then

		MovementValueConnection:
			Disconnect()

	end

	if MovementCharacterConnection then

		MovementCharacterConnection:
			Disconnect()

	end

end

--==================================================
-- PART 3A END
--==================================================

--==================================================
--                 RUSTED HUB v4.0
--                    PART 3B/5
--              FOV + FULLBRIGHT + AIM
--==================================================

--==================================================
-- CAMERA / FOV
--==================================================

local OriginalFOV = 70

if Camera then
	OriginalFOV = Camera.FieldOfView
end

local FOVConnection

local function ApplyFOV()

	if not Camera then
		return
	end

	if S.FOVChanger then

		local value =
			tonumber(S.FOV)

		if value then

			Camera.FieldOfView =
				math.clamp(
					value,
					1,
					120
				)

		end

	else

		Camera.FieldOfView =
			OriginalFOV

	end

end

FOVConnection =
	RunService.RenderStepped:Connect(
		function()

			if not Camera then
				Camera = workspace.CurrentCamera
			end

			if not Camera then
				return
			end

			if S.FOVChanger then

				local value =
					tonumber(S.FOV)

				if value then

					Camera.FieldOfView =
						math.clamp(
							value,
							1,
							120
						)

				end

			end

		end
	)

--==================================================
-- FULLBRIGHT
--==================================================

local OriginalLighting = {

	Brightness =
		Lighting.Brightness,

	Ambient =
		Lighting.Ambient,

	OutdoorAmbient =
		Lighting.OutdoorAmbient,

	ColorShiftTop =
		Lighting.ColorShift_Top,

	ColorShiftBottom =
		Lighting.ColorShift_Bottom,

	GlobalShadows =
		Lighting.GlobalShadows,

	ExposureCompensation =
		Lighting.ExposureCompensation
}

local function ApplyFullbright()

	if S.Fullbright then

		Lighting.Brightness = 2

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

		Lighting.ColorShift_Top =
			Color3.fromRGB(
				0,
				0,
				0
			)

		Lighting.ColorShift_Bottom =
			Color3.fromRGB(
				0,
				0,
				0
			)

		Lighting.GlobalShadows =
			false

		Lighting.ExposureCompensation =
			1

	else

		Lighting.Brightness =
			OriginalLighting.Brightness

		Lighting.Ambient =
			OriginalLighting.Ambient

		Lighting.OutdoorAmbient =
			OriginalLighting.OutdoorAmbient

		Lighting.ColorShift_Top =
			OriginalLighting.ColorShiftTop

		Lighting.ColorShift_Bottom =
			OriginalLighting.ColorShiftBottom

		Lighting.GlobalShadows =
			OriginalLighting.GlobalShadows

		Lighting.ExposureCompensation =
			OriginalLighting.ExposureCompensation

	end

end

local FullbrightConnection

FullbrightConnection =
	RunService.RenderStepped:Connect(
		function()

			ApplyFullbright()

		end
	)

--==================================================
-- AIM TARGET
--==================================================

CurrentTarget = nil

local AimTargetConnection

AimTargetConnection =
	RunService.RenderStepped:Connect(
		function()

			if not S.AimAssist then

				CurrentTarget =
					nil

				return

			end

			CurrentTarget =
				FindTarget()

		end
	)

--==================================================
-- AIM TARGET HELPERS
--==================================================

local function GetAimTarget()

	if not S.AimAssist then
		return nil
	end

	if not CurrentTarget then
		return nil
	end

	if not IsValidCharacter(
		CurrentTarget
	) then

		CurrentTarget =
			nil

		return nil

	end

	return CurrentTarget

end

local function GetAimTargetPosition()

	local target =
		GetAimTarget()

	if not target then
		return nil
	end

	local root =
		GetRootOf(target)

	if not root then
		return nil
	end

	local head =
		target:FindFirstChild(
			"Head"
		)

	if head and head:IsA(
		"BasePart"
	) then

		return head.Position

	end

	return root.Position

end

local function HasAimTarget()

	return
		GetAimTarget() ~= nil

end

--==================================================
-- IMPORTANT:
-- CAMERA НЕ ПОВОРАЧИВАЕМ
--==================================================

-- Здесь намеренно НЕТ:
--
-- Camera.CFrame = ...
-- Camera.CFrame:Lerp(...)
-- CFrame.lookAt(...)
--
-- Aim Assist только выбирает цель.
-- Перенаправление пули будет добавляться
-- отдельно после определения реальной
-- системы стрельбы Rusted.

--==================================================
-- AIM STATE RESET
--==================================================

local AimCharacterConnection

AimCharacterConnection =
	Player.CharacterAdded:Connect(
		function()

			CurrentTarget =
				nil

		end
	)

--==================================================
-- VALUE UPDATE
--==================================================

local ValueUpdateConnection

ValueUpdateConnection =
	RunService.Heartbeat:Connect(
		function()

			if S.FOVChanger then

				ApplyFOV()

			end

		end
	)

--==================================================
-- CLEANUP 3B
--==================================================

local function CleanupPart3B()

	if FOVConnection then

		FOVConnection:
			Disconnect()

		FOVConnection =
			nil

	end

	if FullbrightConnection then

		FullbrightConnection:
			Disconnect()

		FullbrightConnection =
			nil

	end

	if AimTargetConnection then

		AimTargetConnection:
			Disconnect()

		AimTargetConnection =
			nil

	end

	if AimCharacterConnection then

		AimCharacterConnection:
			Disconnect()

		AimCharacterConnection =
			nil

	end

	if ValueUpdateConnection then

		ValueUpdateConnection:
			Disconnect()

		ValueUpdateConnection =
			nil

	end

	-- Restore FOV

	if Camera then

		Camera.FieldOfView =
			OriginalFOV

	end

	-- Restore lighting

	Lighting.Brightness =
		OriginalLighting.Brightness

	Lighting.Ambient =
		OriginalLighting.Ambient

	Lighting.OutdoorAmbient =
		OriginalLighting.OutdoorAmbient

	Lighting.ColorShift_Top =
		OriginalLighting.ColorShiftTop

	Lighting.ColorShift_Bottom =
		OriginalLighting.ColorShiftBottom

	Lighting.GlobalShadows =
		OriginalLighting.GlobalShadows

	Lighting.ExposureCompensation =
		OriginalLighting.ExposureCompensation

	CurrentTarget =
		nil

end

--==================================================
-- PART 3B END
--==================================================

--==================================================
--                 RUSTED HUB v4.0
--                    PART 4A/5
--              AIM + FOV UI SYSTEM
--==================================================

--==================================================
-- COMBAT TEAM CHECK
--==================================================

-- Team Check используется ТОЛЬКО для Aim.
-- В ESP Team Check отсутствует.

if S.TeamCheck == nil then
	S.TeamCheck = true
end

--==================================================
-- AIM TARGET VALIDATION
--==================================================

local function IsAimTargetValid(character)

	if not character then
		return false
	end

	if not IsValidCharacter(character) then
		return false
	end

	-- Team Check только для Aim

	if S.TeamCheck then

		local targetPlayer =
			GetPlayerFromCharacter(
				character
			)

		if targetPlayer
			and targetPlayer ~= Player then

			if Player.Team
				and targetPlayer.Team
				and Player.Team ==
					targetPlayer.Team then

				return false

			end

		end

	end

	-- Visible Only

	if S.AimVisibleOnly then

		if not IsVisible(character) then
			return false
		end

	end

	return true

end

--==================================================
-- FIND AIM TARGET
--==================================================

local function FindAimTarget()

	if not S.AimAssist then
		return nil
	end

	local bestTarget = nil
	local bestDistance = math.huge

	-- PLAYERS

	if S.AimPlayers then

		for _,player in ipairs(
			Players:GetPlayers()
		) do

			if player ~= Player then

				local character =
					player.Character

				if character
					and IsAimTargetValid(
						character
					) then

					local root =
						GetRootOf(
							character
						)

					if root then

						local screenPos,
							onScreen =
							Camera:WorldToViewportPoint(
								root.Position
							)

						if onScreen then

							local center =
								GetScreenCenter()

							local distance =
								(
									Vector2.new(
										screenPos.X,
										screenPos.Y
									)
									-
									center
								).Magnitude

							if distance <=
								S.AimFOV
								and distance <
								bestDistance then

								bestDistance =
									distance

								bestTarget =
									character

							end

						end

					end

				end

			end

		end

	end

	-- NPC

	if S.AimNPC then

		for _,object in ipairs(
			workspace:GetDescendants()
		) do

			if object:IsA("Model")
				and not Players:GetPlayerFromCharacter(
					object
				) then

				if IsAimTargetValid(
					object
				) then

					local root =
						GetRootOf(
							object
						)

					if root then

						local screenPos,
							onScreen =
							Camera:WorldToViewportPoint(
								root.Position
							)

						if onScreen then

							local center =
								GetScreenCenter()

							local distance =
								(
									Vector2.new(
										screenPos.X,
										screenPos.Y
									)
									-
									center
								).Magnitude

							if distance <=
								S.AimFOV
								and distance <
								bestDistance then

								bestDistance =
									distance

								bestTarget =
									object

							end

						end

					end

				end

			end

		end

	end

	return bestTarget

end

--==================================================
-- UPDATE AIM TARGET
--==================================================

local AimUpdateConnection

AimUpdateConnection =
	RunService.RenderStepped:Connect(
		function()

			if not S.AimAssist then

				CurrentTarget =
					nil

				return

			end

			local target =
				FindAimTarget()

			if target then

				CurrentTarget =
					target

			else

				CurrentTarget =
					nil

			end

		end
	)

--==================================================
-- AIM TARGET POSITION
--==================================================

local function GetAimPosition()

	local target =
		CurrentTarget

	if not target then
		return nil
	end

	if not IsAimTargetValid(
		target
	) then

		CurrentTarget =
			nil

		return nil

	end

	-- Сначала Head

	local head =
		target:FindFirstChild(
			"Head"
		)

	if head
		and head:IsA("BasePart") then

		return head.Position

	end

	-- Потом HumanoidRootPart

	local root =
		GetRootOf(target)

	if root then

		return root.Position

	end

	return nil

end

--==================================================
-- FOV CIRCLE
--==================================================

local FOVCircle =
	New(
		"Frame",
		{
			Name =
				"FOVCircle",

			BackgroundTransparency =
				1,

			BorderSizePixel =
				0,

			Visible =
				false,

			AnchorPoint =
				Vector2.new(
					0.5,
					0.5
				),

			Position =
				UDim2.fromOffset(
					0,
					0
				),

			Size =
				UDim2.fromOffset(
					S.AimFOV * 2,
					S.AimFOV * 2
				),

			ZIndex =
				50
		},
		Gui
	)

local FOVCorner =
	New(
		"UICorner",
		{
			CornerRadius =
				UDim.new(
					1,
					0
				)
		},
		FOVCircle
	)

local FOVStroke =
	New(
		"UIStroke",
		{
			Thickness =
				1.5,

			Transparency =
				0.1,

			Color =
				S.FOVColor
		},
		FOVCircle
	)

--==================================================
-- UPDATE FOV CIRCLE
--==================================================

local function UpdateFOVCircle()

	if not Camera then
		Camera =
			workspace.CurrentCamera
	end

	if not Camera then
		return
	end

	if not S.AimAssist then

		FOVCircle.Visible =
			false

		return

	end

	FOVCircle.Visible =
		true

	local viewport =
		Camera.ViewportSize

	FOVCircle.Position =
		UDim2.fromOffset(
			viewport.X / 2,
			viewport.Y / 2
		)

	local radius =
		math.clamp(
			tonumber(
				S.AimFOV
			) or 100,
			10,
			1000
		)

	FOVCircle.Size =
		UDim2.fromOffset(
			radius * 2,
			radius * 2
		)

	FOVStroke.Color =
		S.FOVColor

end

local FOVCircleConnection

FOVCircleConnection =
	RunService.RenderStepped:Connect(
		function()

			UpdateFOVCircle()

		end
	)

--==================================================
-- TEAM CHECK TOGGLE
--==================================================

local TeamCheckToggle

TeamCheckToggle =
	CreateToggle(
		CombatPage,
		"Team Check",
		"Ignore teammates when aiming",
		"TeamCheck"
	)

--==================================================
-- AIM FOV VALUE
--==================================================

CreateValue(
	CombatPage,
	"Aim FOV",
	"FOV radius",
	"AimFOV",
	10,
	1000
)

--==================================================
-- AIM STATE REFRESH
--==================================================

local AimStateConnection

AimStateConnection =
	RunService.Heartbeat:Connect(
		function()

			if not S.AimAssist then

				CurrentTarget =
					nil

			end

		end
	)

--==================================================
-- PART 4A CLEANUP
--==================================================

local function CleanupPart4A()

	if AimUpdateConnection then

		AimUpdateConnection:
			Disconnect()

		AimUpdateConnection =
			nil

	end

	if FOVCircleConnection then

		FOVCircleConnection:
			Disconnect()

		FOVCircleConnection =
			nil

	end

	if AimStateConnection then

		AimStateConnection:
			Disconnect()

		AimStateConnection =
			nil

	end

	CurrentTarget =
		nil

	if FOVCircle then

		FOVCircle.Visible =
			false

	end

end

--==================================================
-- PART 4A END
--==================================================

--==================================================
--                 RUSTED HUB v4.0
--                    PART 4B/5
--                 COLOR SETTINGS
--==================================================

--==================================================
-- COLOR EDITOR
--==================================================

local ColorEditors = {}

local ColorDefinitions = {

	{
		Name = "Menu Color",
		Key = "MenuColor"
	},

	{
		Name = "ESP Color",
		Key = "ESPColor"
	},

	{
		Name = "Box Color",
		Key = "BoxColor"
	},

	{
		Name = "Name Color",
		Key = "NameColor"
	},

	{
		Name = "Health Color",
		Key = "HealthColor"
	},

	{
		Name = "Distance Color",
		Key = "DistanceColor"
	},

	{
		Name = "Snapline Color",
		Key = "SnaplineColor"
	},

	{
		Name = "FOV Color",
		Key = "FOVColor"
	},

	{
		Name = "Chest Color",
		Key = "ChestColor"
	}

}

--==================================================
-- COLOR CONVERTER
--==================================================

local function ColorToRGB(color)

	return
		math.floor(
			color.R * 255 + 0.5
		),
		math.floor(
			color.G * 255 + 0.5
		),
		math.floor(
			color.B * 255 + 0.5
		)

end

local function RGBToColor(r, g, b)

	r =
		math.clamp(
			tonumber(r) or 255,
			0,
			255
		)

	g =
		math.clamp(
			tonumber(g) or 255,
			0,
			255
		)

	b =
		math.clamp(
			tonumber(b) or 255,
			0,
			255
		)

	return Color3.fromRGB(
		r,
		g,
		b
	)

end

--==================================================
-- UPDATE MENU COLORS
--==================================================

local function RefreshAllColors()

	-- Main menu

	if MainStroke then

		MainStroke.Color =
			S.MenuColor

	end

	if MinStroke then

		MinStroke.Color =
			S.MenuColor

	end

	if CloseStroke then

		CloseStroke.Color =
			S.MenuColor

	end

	if LogoBox then

		LogoBox.BackgroundColor3 =
			S.MenuColor

	end

	-- FOV

	if FOVStroke then

		FOVStroke.Color =
			S.FOVColor

	end

	-- ESP

	for character,data in pairs(
		ESPObjects
	) do

		if data then

			if data.Box
				and data.Box:FindFirstChild(
					"UIStroke"
				) then

				data.Box.UIStroke.Color =
					S.BoxColor

			end

			if data.Name
				and data.Name:FindFirstChild(
					"UIStroke"
				) then

				data.Name.UIStroke.Color =
					S.NameColor

			end

		end

	end

end

--==================================================
-- CREATE COLOR INPUT
--==================================================

local function CreateColorEditor(
	parent,
	title,
	key,
	order
)

	local holder =
		New(
			"Frame",
			{
				Name =
					key .. "_Editor",

				BackgroundColor3 =
					Color3.fromRGB(
						24,
						24,
						30
					),

				BackgroundTransparency =
					0,

				BorderSizePixel =
					0,

				Size =
					UDim2.new(
						1,
						-10,
						0,
						54
					),

				LayoutOrder =
					order
			},
			parent
		)

	New(
		"UICorner",
		{
			CornerRadius =
				UDim.new(
					0,
					6
				)
		},
		holder
	)

	local titleLabel =
		New(
			"TextLabel",
			{
				Name =
					"Title",

				BackgroundTransparency =
					1,

				Position =
					UDim2.new(
						0,
						10,
						0,
						4
					),

				Size =
					UDim2.new(
						0,
						125,
						0,
						20
					),

				Font =
					Enum.Font.GothamMedium,

				Text =
					title,

				TextColor3 =
					Color3.fromRGB(
						235,
						235,
						240
					),

				TextSize =
					13,

				TextXAlignment =
					Enum.TextXAlignment.Left
			},
			holder
		)

	local rBox =
		New(
			"TextBox",
			{
				Name =
					"R",

				BackgroundColor3 =
					Color3.fromRGB(
						35,
						35,
						42
					),

				BorderSizePixel =
					0,

				Position =
					UDim2.new(
						0,
						140,
						0,
						8
					),

				Size =
					UDim2.new(
						0,
						45,
						0,
						34
					),

				Font =
					Enum.Font.Gotham,

				TextSize =
					12,

				TextColor3 =
					Color3.fromRGB(
						255,
						255,
						255
					),

				TextXAlignment =
					Enum.TextXAlignment.Center,

				ClearTextOnFocus =
					false
			},
			holder
		)

	local gBox =
		New(
			"TextBox",
			{
				Name =
					"G",

				BackgroundColor3 =
					Color3.fromRGB(
						35,
						35,
						42
					),

				BorderSizePixel =
					0,

				Position =
					UDim2.new(
						0,
						190,
						0,
						8
					),

				Size =
					UDim2.new(
						0,
						45,
						0,
						34
					),

				Font =
					Enum.Font.Gotham,

				TextSize =
					12,

				TextColor3 =
					Color3.fromRGB(
						255,
						255,
						255
					),

				TextXAlignment =
					Enum.TextXAlignment.Center,

				ClearTextOnFocus =
					false
			},
			holder
		)

	local bBox =
		New(
			"TextBox",
			{
				Name =
					"B",

				BackgroundColor3 =
					Color3.fromRGB(
						35,
						35,
						42
					),

				BorderSizePixel =
					0,

				Position =
					UDim2.new(
						0,
						240,
						0,
						8
					),

				Size =
					UDim2.new(
						0,
						45,
						0,
						34
					),

				Font =
					Enum.Font.Gotham,

				TextSize =
					12,

				TextColor3 =
					Color3.fromRGB(
						255,
						255,
						255
					),

				TextXAlignment =
					Enum.TextXAlignment.Center,

				ClearTextOnFocus =
					false
			},
			holder
		)

	local preview =
		New(
			"Frame",
			{
				Name =
					"Preview",

				BackgroundColor3 =
					S[key],

				BorderSizePixel =
					0,

				Position =
					UDim2.new(
						1,
						-48,
						0,
						10
					),

				Size =
					UDim2.fromOffset(
						34,
						34
					)
			},
			holder
		)

	New(
		"UICorner",
		{
			CornerRadius =
				UDim.new(
					0,
					6
				)
		},
		preview
	)

	local r,g,b =
		ColorToRGB(
			S[key]
		)

	rBox.Text =
		tostring(r)

	gBox.Text =
		tostring(g)

	bBox.Text =
		tostring(b)

	local function UpdateColor()

		local color =
			RGBToColor(
				rBox.Text,
				gBox.Text,
				bBox.Text
			)

		S[key] =
			color

		preview.BackgroundColor3 =
			color

		RefreshAllColors()

	end

	rBox.FocusLost:Connect(
		UpdateColor
	)

	gBox.FocusLost:Connect(
		UpdateColor
	)

	bBox.FocusLost:Connect(
		UpdateColor
	)

	ColorEditors[key] = {

		Holder =
			holder,

		R =
			rBox,

		G =
			gBox,

		B =
			bBox,

		Preview =
			preview

	}

	return holder

end

--==================================================
-- SETTINGS PAGE
--==================================================

local SettingsScroll =
	New(
		"ScrollingFrame",
		{
			Name =
				"ColorSettings",

			BackgroundTransparency =
				1,

			BorderSizePixel =
				0,

			Size =
				UDim2.new(
					1,
					0,
					1,
					0
				),

			CanvasSize =
				UDim2.new(
					0,
					0,
					0,
					0
				),

			ScrollBarThickness =
				3,

			ScrollBarImageColor3 =
				S.MenuColor,

			AutomaticCanvasSize =
				Enum.AutomaticSize.Y
		},
		SettingsPage
	)

local SettingsLayout =
	New(
		"UIListLayout",
		{
			Padding =
				UDim.new(
					0,
					7
				),

			SortOrder =
				Enum.SortOrder.LayoutOrder
		},
		SettingsScroll
	)

New(
	"UIPadding",
	{
		PaddingTop =
			UDim.new(
				0,
				5
			),

		PaddingBottom =
			UDim.new(
				0,
				10
			),

		PaddingLeft =
			UDim.new(
				0,
				5
			),

		PaddingRight =
			UDim.new(
				0,
				5
			)
	},
	SettingsScroll
)

--==================================================
-- COLOR SETTINGS TITLE
--==================================================

New(
	"TextLabel",
	{
		Name =
			"ColorTitle",

		BackgroundTransparency =
			1,

		Size =
			UDim2.new(
				1,
				-10,
				0,
				30
			),

		Font =
			Enum.Font.GothamBold,

		Text =
			"COLOR SETTINGS",

		TextColor3 =
			S.MenuColor,

		TextSize =
			14,

		TextXAlignment =
			Enum.TextXAlignment.Left,

		LayoutOrder =
			1
	},
	SettingsScroll
)

--==================================================
-- CREATE ALL COLOR EDITORS
--==================================================

for index,definition in ipairs(
	ColorDefinitions
) do

	CreateColorEditor(
		SettingsScroll,

		definition.Name,

		definition.Key,

		index + 1
	)

end

--==================================================
-- COLOR UPDATE LOOP
--==================================================

local ColorRefreshConnection

ColorRefreshConnection =
	RunService.Heartbeat:Connect(
		function()

			if FOVStroke then

				FOVStroke.Color =
					S.FOVColor

			end

			if FOVCircle then

				FOVCircle.Visible =
					S.AimAssist

			end

		end
	)

--==================================================
-- CLEANUP 4B
--==================================================

local function CleanupPart4B()

	if ColorRefreshConnection then

		ColorRefreshConnection:
			Disconnect()

		ColorRefreshConnection =
			nil

	end

	table.clear(
		ColorEditors
	)

end

--==================================================
-- PART 4B END
--==================================================

--==================================================
--                 RUSTED HUB v4.0
--                    PART 5A/5
--             FINAL CONNECT + CLEANUP
--==================================================

--==================================================
-- SETTINGS REFRESH
--==================================================

local FinalSettingsConnection

FinalSettingsConnection =
	RunService.Heartbeat:Connect(
		function()

			-- Menu color

			if MainStroke then
				MainStroke.Color =
					S.MenuColor
			end

			if MinStroke then
				MinStroke.Color =
					S.MenuColor
			end

			if CloseStroke then
				CloseStroke.Color =
					S.MenuColor
			end

			-- FOV color

			if FOVStroke then
				FOVStroke.Color =
					S.FOVColor
			end

			-- FOV visibility

			if FOVCircle then

				FOVCircle.Visible =
					S.AimAssist

			end

		end
	)

--==================================================
-- CHARACTER RESPAWN REFRESH
--==================================================

local FinalCharacterConnection

FinalCharacterConnection =
	Player.CharacterAdded:Connect(
		function(character)

			CurrentTarget =
				nil

			task.wait(0.25)

			if character then

				local humanoid =
					character:
						FindFirstChildOfClass(
							"Humanoid"
						)

				if humanoid then

					OriginalWalkSpeed =
						humanoid.WalkSpeed

					if humanoid.UseJumpPower then

						OriginalJumpPower =
							humanoid.JumpPower

					end

					ApplySpeed()
					ApplyJump()

				end

			end

		end
	)

--==================================================
-- JUMP RE-APPLY
--==================================================

local JumpInputConnection

JumpInputConnection =
	UserInputService.InputBegan:Connect(
		function(input, processed)

			if processed then
				return
			end

			if input.KeyCode ==
				Enum.KeyCode.Space then

				if S.Jump then

					ApplyJump()

				end

			end

		end
	)

--==================================================
-- VALUE CHANGE REFRESH
--==================================================

local function RefreshMovementValues()

	if S.SpeedHack then
		ApplySpeed()
	end

	if S.Jump then
		ApplyJump()
	end

	if S.FOVChanger then
		ApplyFOV()
	end

end

local ValueRefreshConnection

ValueRefreshConnection =
	RunService.Heartbeat:Connect(
		function()

			RefreshMovementValues()

		end
	)

--==================================================
-- MENU ANIMATION STATE
--==================================================

local MenuOpen =
	true

local MenuBusy =
	false

--==================================================
-- OPEN MENU
--==================================================

local function OpenMenu()

	if MenuBusy then
		return
	end

	if MenuOpen then
		return
	end

	MenuBusy =
		true

	Gui.Enabled =
		true

	if Main then

		Main.Visible =
			true

		if S.MenuAnimations then

			local oldSize =
				Main.Size

			Main.Size =
				UDim2.fromOffset(
					20,
					20
				)

			Main.BackgroundTransparency =
				1

			Tween(
				Main,
				{
					Size =
						oldSize,

					BackgroundTransparency =
						0
				},
				0.25
			)

		else

			Main.Size =
				UDim2.fromOffset(
					500,
					300
				)

			Main.BackgroundTransparency =
				0

		end

	end

	MenuOpen =
		true

	task.delay(
		0.26,
		function()

			MenuBusy =
				false

		end
	)

end

--==================================================
-- CLOSE / MINIMIZE MENU
--==================================================

local function MinimizeMenu()

	if MenuBusy then
		return
	end

	if not MenuOpen then
		return
	end

	MenuBusy =
		true

	if S.MenuAnimations then

		Tween(
			Main,
			{
				Size =
					UDim2.fromOffset(
						20,
						20
					),

				BackgroundTransparency =
					1
			},
			0.22
		)

		task.delay(
			0.23,
			function()

				Main.Visible =
					false

				Main.Size =
					UDim2.fromOffset(
						500,
						300
					)

				Main.BackgroundTransparency =
					0

			end
		)

	else

		Main.Visible =
			false

	end

	MenuOpen =
		false

	task.delay(
		0.26,
		function()

			MenuBusy =
				false

		end
	)

end

--==================================================
-- MINIMIZE BUTTON
--==================================================

if Minimize then

	Minimize.MouseButton1Click:Connect(
		function()

			MinimizeMenu()

		end
	)

end

--==================================================
-- CLOSE BUTTON
--==================================================

if Close then

	Close.MouseButton1Click:Connect(
		function()

			MinimizeMenu()

		end
	)

end

--==================================================
-- FLOATING REOPEN BUTTON
--==================================================

if Float then

	Float.Visible =
		false

	Float.MouseButton1Click:Connect(
		function()

			OpenMenu()

		end
	)

end

--==================================================
-- FLOAT VISIBILITY
--==================================================

local FloatConnection

FloatConnection =
	RunService.RenderStepped:Connect(
		function()

			if Float then

				Float.Visible =
					not MenuOpen

			end

		end
	)

--==================================================
-- FLOAT HOVER
--==================================================

if Float then

	Float.MouseEnter:Connect(
		function()

			if S.MenuAnimations then

				Tween(
					Float,
					{
						Size =
							UDim2.fromOffset(
								52,
								52
							)
					},
					0.12
				)

			end

		end
	)

	Float.MouseLeave:Connect(
		function()

			if S.MenuAnimations then

				Tween(
					Float,
					{
						Size =
							UDim2.fromOffset(
								46,
								46
							)
					},
					0.12
				)

			end

		end
	)

end

--==================================================
-- FINAL MENU COLOR
--==================================================

if Float then

	Float.BackgroundColor3 =
		S.MenuColor

end

--==================================================
-- FINAL STATE
--==================================================

S.AimAssist =
	S.AimAssist or false

S.AimPlayers =
	S.AimPlayers or true

S.AimNPC =
	S.AimNPC or false

S.AimVisibleOnly =
	S.AimVisibleOnly or false

S.TeamCheck =
	S.TeamCheck == nil
		and true
		or S.TeamCheck

S.AimFOV =
	tonumber(
		S.AimFOV
	) or 150

S.Speed =
	tonumber(
		S.Speed
	) or 16

S.JumpPower =
	tonumber(
		S.JumpPower
	) or 50

S.FOV =
	tonumber(
		S.FOV
	) or 70

--==================================================
-- INITIAL APPLY
--==================================================

task.defer(
	function()

		task.wait(
			0.2
		)

		ApplySpeed()
		ApplyJump()
		ApplyFOV()
		ApplyFullbright()
		UpdateFOVCircle()

	end
)

--==================================================
-- FINAL CLEANUP
--==================================================

local FinalCleanupDone =
	false

local function FinalCleanup()

	if FinalCleanupDone then
		return
	end

	FinalCleanupDone =
		true

	-- Connections

	if FinalSettingsConnection then
		FinalSettingsConnection:
			Disconnect()
	end

	if FinalCharacterConnection then
		FinalCharacterConnection:
			Disconnect()
	end

	if JumpInputConnection then
		JumpInputConnection:
			Disconnect()
	end

	if ValueRefreshConnection then
		ValueRefreshConnection:
			Disconnect()
	end

	if FloatConnection then
		FloatConnection:
			Disconnect()
	end

	-- Part 4

	if CleanupPart4B then
		CleanupPart4B()
	end

	if CleanupPart4A then
		CleanupPart4A()
	end

	-- Part 3

	if CleanupPart3B then
		CleanupPart3B()
	end

	if CleanupMovement then
		CleanupMovement()
	end

	-- ESP

	if CleanupESP then
		CleanupESP()
	end

	-- Restore target

	CurrentTarget =
		nil

	-- Hide FOV

	if FOVCircle then
		FOVCircle.Visible =
			false
	end

	-- Hide floating button

	if Float then
		Float.Visible =
			false
	end

end

--==================================================
-- GUI REMOVED
--==================================================

Gui.AncestryChanged:Connect(
	function(_, parent)

		if not parent then

			FinalCleanup()

		end

	end
)

--==================================================
-- FINAL READY
--==================================================

print(
	"[Rusted Hub] Loaded successfully."
)

print(
	"[Rusted Hub] Version 4.0"
)

print(
	"[Rusted Hub] 5-part build complete."
)

--==================================================
--                 END OF SCRIPT
--==================================================
