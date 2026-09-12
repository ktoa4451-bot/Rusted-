--==================================================
--                 RUSTED v3.2
--                  PART 1A/7
--             CORE + CONFIG + GUI
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- REMOVE OLD VERSION
--==================================================

pcall(function()

	for _, name in ipairs({
		"RustedV31",
		"RustedV32"
	}) do

		local old = PlayerGui:FindFirstChild(name)

		if old then
			old:Destroy()
		end

	end

end)

--==================================================
-- CONFIG
--==================================================

local S = {

	-- VISUAL
	ESP = false,
	BoxESP = false,
	Names = false,
	Health = false,
	Distance = false,
	Snapline = false,
	TeamCheck = true,

	-- AIM
	AimAssist = false,
	AimPlayers = true,
	AimNPC = true,
	AimVisibleOnly = true,
	AimFOV = 150,

	-- CAMERA
	FOVChanger = false,
	FOV = 90,

	-- MOVEMENT
	SpeedHack = false,
	Speed = 16,

	Jump = false,
	JumpPower = 50,

	Noclip = false,

	-- MISC
	Fullbright = false,
	NeonGuns = false,

	-- CUSTOM HANDS
	CustomHands = false,
	HandsX = 0,
	HandsY = 0,
	HandsZ = 0,

	-- MENU
	MenuAnimations = true,

	MenuColor = Color3.fromRGB(
		145,
		70,
		255
	)
}

--==================================================
-- COLORS
--==================================================

local COLORS = {

	BG = Color3.fromRGB(
		7,5,14
	),

	PANEL = Color3.fromRGB(
		12,9,22
	),

	ROW = Color3.fromRGB(
		20,15,34
	),

	HOVER = Color3.fromRGB(
		34,23,55
	),

	TEXT = Color3.fromRGB(
		245,242,255
	),

	SUB = Color3.fromRGB(
		145,137,165
	),

	DARK = Color3.fromRGB(
		80,70,100
	),

	PURPLE = S.MenuColor,

	WHITE = Color3.fromRGB(
		255,255,255
	),

	RED = Color3.fromRGB(
		255,65,85
	),

	GREEN = Color3.fromRGB(
		65,220,125
	),

	BLUE = Color3.fromRGB(
		70,135,255
	)
}

--==================================================
-- HELPERS
--==================================================

local function New(class, props, parent)

	local object = Instance.new(class)

	for property, value in pairs(
		props or {}
	) do

		object[property] = value

	end

	object.Parent = parent

	return object
end

local function Corner(object, radius)

	local corner =
		Instance.new("UICorner")

	corner.CornerRadius =
		UDim.new(
			0,
			radius or 8
		)

	corner.Parent = object

	return corner
end

local function Stroke(
	object,
	color,
	thickness,
	transparency
)

	local stroke =
		Instance.new("UIStroke")

	stroke.Color =
		color or COLORS.PURPLE

	stroke.Thickness =
		thickness or 1

	stroke.Transparency =
		transparency or 0

	stroke.ApplyStrokeMode =
		Enum.ApplyStrokeMode.Border

	stroke.Parent = object

	return stroke
end

local function Tween(
	object,
	time,
	style,
	direction,
	properties
)

	if not object
		or not object.Parent then

		return

	end

	local tween =
		TweenService:Create(

			object,

			TweenInfo.new(
				time,
				style or Enum.EasingStyle.Quart,
				direction or Enum.EasingDirection.Out
			),

			properties

		)

	tween:Play()

	return tween
end

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

local function GetRoot(character)

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

			Name =
				"RustedV32",

			ResetOnSpawn =
				false,

			IgnoreGuiInset =
				true,

			ZIndexBehavior =
				Enum.ZIndexBehavior.Sibling,

			DisplayOrder =
				999

		},
		PlayerGui
	)

--==================================================
-- MAIN WINDOW
--==================================================

local Main =
	New(
		"Frame",
		{

			Name =
				"Main",

			AnchorPoint =
				Vector2.new(
					.5,
					.5
				),

			Position =
				UDim2.fromScale(
					.5,
					.5
				),

			Size =
				UDim2.fromOffset(
					500,
					300
				),

			BackgroundColor3 =
				COLORS.BG,

			BackgroundTransparency =
				0,

			BorderSizePixel =
				0,

			ClipsDescendants =
				true,

			Active =
				true,

			ZIndex =
				10

		},
		Gui
	)

Corner(
	Main,
	14
)

local MainStroke =
	Stroke(
		Main,
		COLORS.PURPLE,
		1.5,
		.15
	)

--==================================================
-- SCALE
--==================================================

local MainScale =
	Instance.new(
		"UIScale"
	)

MainScale.Scale =
	1

MainScale.Parent =
	Main

local function UpdateScale()

	local camera =
		workspace.CurrentCamera

	if not camera then
		return
	end

	local width =
		camera.ViewportSize.X

	if width <= 360 then

		MainScale.Scale =
			.60

	elseif width <= 480 then

		MainScale.Scale =
			.72

	elseif width <= 650 then

		MainScale.Scale =
			.85

	else

		MainScale.Scale =
			1

	end

end

UpdateScale()

if workspace.CurrentCamera then

	workspace.CurrentCamera:
		GetPropertyChangedSignal(
			"ViewportSize"
		):
		Connect(
			UpdateScale
		)

end

--==================================================
-- TOP BAR
--==================================================

local Top =
	New(
		"Frame",
		{

			Name =
				"Top",

			Size =
				UDim2.new(
					1,
					0,
					0,
					48
				),

			BackgroundColor3 =
				COLORS.PANEL,

			BorderSizePixel =
				0,

			ClipsDescendants =
				true,

			ZIndex =
				20

		},
		Main
	)

Corner(
	Top,
	14
)

New(
	"Frame",
	{

		Size =
			UDim2.new(
				1,
				0,
				0,
				14
			),

		Position =
			UDim2.new(
				0,
				0,
				1,
				-14
			),

		BackgroundColor3 =
			COLORS.PANEL,

		BorderSizePixel =
			0,

		ZIndex =
			20

	},
	Top
)

--==================================================
-- LOGO
--==================================================

local LogoBox =
	New(
		"Frame",
		{

			Name =
				"LogoBox",

			Size =
				UDim2.fromOffset(
					30,
					30
				),

			Position =
				UDim2.fromOffset(
					9,
					9
				),

			BackgroundColor3 =
				COLORS.PURPLE,

			BorderSizePixel =
				0,

			ZIndex =
				25

		},
		Top
	)

Corner(
	LogoBox,
	9
)

local LogoStroke =
	Stroke(
		LogoBox,
		COLORS.WHITE,
		1,
		.6
	)

New(
	"TextLabel",
	{

		Size =
			UDim2.fromScale(
				1,
				1
			),

		BackgroundTransparency =
			1,

		Text =
			"R",

		TextColor3 =
			COLORS.WHITE,

		Font =
			Enum.Font.GothamBlack,

		TextSize =
			19,

		ZIndex =
			26

	},
	LogoBox
)

--==================================================
-- TITLE
--==================================================

local Title =
	New(
		"TextLabel",
		{

			Size =
				UDim2.fromOffset(
					160,
					20
				),

			Position =
				UDim2.fromOffset(
					47,
					5
				),

			BackgroundTransparency =
				1,

			Text =
				"RUSTED",

			TextColor3 =
				COLORS.TEXT,

			Font =
				Enum.Font.GothamBlack,

			TextSize =
				15,

			TextXAlignment =
				Enum.TextXAlignment.Left,

			ZIndex =
				23

		},
		Top
	)

local Version =
	New(
		"TextLabel",
		{

			Size =
				UDim2.fromOffset(
					100,
					13
				),

			Position =
				UDim2.fromOffset(
					48,
					25
				),

			BackgroundTransparency =
				1,

			Text =
				"v3.2",

			TextColor3 =
				COLORS.SUB,

			Font =
				Enum.Font.GothamMedium,

			TextSize =
				7,

			TextXAlignment =
				Enum.TextXAlignment.Left,

			ZIndex =
				23

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

			Name =
				"Minimize",

			Size =
				UDim2.fromOffset(
					28,
					28
				),

			Position =
				UDim2.new(
					1,
					-62,
					0,
					10
				),

			BackgroundColor3 =
				COLORS.ROW,

			BorderSizePixel =
				0,

			Text =
				"—",

			TextColor3 =
				COLORS.TEXT,

			Font =
				Enum.Font.GothamBold,

			TextSize =
				14,

			AutoButtonColor =
				false,

			ZIndex =
				30

		},
		Top
	)

Corner(
	Minimize,
	8
)

local MinStroke =
	Stroke(
		Minimize,
		COLORS.PURPLE,
		1,
		.4
	)

--==================================================
-- CLOSE
--==================================================

local Close =
	New(
		"TextButton",
		{

			Name =
				"Close",

			Size =
				UDim2.fromOffset(
					28,
					28
				),

			Position =
				UDim2.new(
					1,
					-31,
					0,
					10
				),

			BackgroundColor3 =
				COLORS.ROW,

			BorderSizePixel =
				0,

			Text =
				"×",

			TextColor3 =
				COLORS.TEXT,

			Font =
				Enum.Font.GothamBold,

			TextSize =
				17,

			AutoButtonColor =
				false,

			ZIndex =
				30

		},
		Top
	)

Corner(
	Close,
	8
)

local CloseStroke =
	Stroke(
		Close,
		COLORS.PURPLE,
		1,
		.4
	)

--==================================================
-- END PART 1A
--==================================================

--==================================================
--                 RUSTED v3.2
--                  PART 1B/7
--              GUI CONTENT + DRAG
--==================================================

--==================================================
-- BODY
--==================================================

local Body =
	New(
		"Frame",
		{

			Name =
				"Body",

			Position =
				UDim2.fromOffset(
					0,
					48
				),

			Size =
				UDim2.new(
					1,
					0,
					1,
					-48
				),

			BackgroundColor3 =
				COLORS.BG,

			BorderSizePixel =
				0,

			ClipsDescendants =
				true,

			ZIndex =
				11

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

			Name =
				"Sidebar",

			Size =
				UDim2.fromOffset(
					135,
					252
				),

			Position =
				UDim2.fromOffset(
					8,
					8
				),

			BackgroundColor3 =
				COLORS.PANEL,

			BorderSizePixel =
				0,

			ClipsDescendants =
				true,

			ZIndex =
				15

		},
		Body
	)

Corner(
	Sidebar,
	10
)

Stroke(
	Sidebar,
	COLORS.PURPLE,
	1,
	.75
)

--==================================================
-- CATEGORY TITLE
--==================================================

local CategoryTitle =
	New(
		"TextLabel",
		{

			Name =
				"CategoryTitle",

			Size =
				UDim2.new(
					1,
					-20,
					0,
					25
				),

			Position =
				UDim2.fromOffset(
					10,
					8
				),

			BackgroundTransparency =
				1,

			Text =
				"CATEGORIES",

			TextColor3 =
				COLORS.SUB,

			Font =
				Enum.Font.GothamBold,

			TextSize =
				9,

			TextXAlignment =
				Enum.TextXAlignment.Left,

			ZIndex =
				18

		},
		Sidebar
	)

--==================================================
-- CATEGORY LIST
--==================================================

local CategoryList =
	New(
		"Frame",
		{

			Name =
				"CategoryList",

			Size =
				UDim2.new(
					1,
					-12,
					1,
					-42
				),

			Position =
				UDim2.fromOffset(
					6,
					34
				),

			BackgroundTransparency =
				1,

			BorderSizePixel =
				0,

			ZIndex =
				18

		},
		Sidebar
	)

local CategoryLayout =
	New(
		"UIListLayout",
		{

			FillDirection =
				Enum.FillDirection.Vertical,

			HorizontalAlignment =
				Enum.HorizontalAlignment.Center,

			VerticalAlignment =
					Enum.VerticalAlignment.Top,

			Padding =
				UDim.new(
					0,
					5
				)

		},
		CategoryList
	)

--==================================================
-- CONTENT
--==================================================

local Content =
	New(
		"Frame",
		{

			Name =
				"Content",

			Size =
				UDim2.new(
					1,
					-151,
					1,
					-16
				),

			Position =
				UDim2.fromOffset(
					143,
					8
				),

			BackgroundColor3 =
				COLORS.PANEL,

			BorderSizePixel =
				0,

			ClipsDescendants =
				true,

			ZIndex =
				15

		},
		Body
	)

Corner(
	Content,
	10
)

Stroke(
	Content,
	COLORS.PURPLE,
	1,
	.75
)

--==================================================
-- CONTENT HEADER
--==================================================

local ContentTitle =
	New(
		"TextLabel",
		{

			Name =
				"ContentTitle",

			Size =
				UDim2.new(
					1,
					-20,
					0,
					28
				),

			Position =
				UDim2.fromOffset(
					10,
					7
				),

			BackgroundTransparency =
				1,

			Text =
				"COMBAT",

			TextColor3 =
				COLORS.TEXT,

			Font =
				Enum.Font.GothamBold,

			TextSize =
				12,

			TextXAlignment =
				Enum.TextXAlignment.Left,

			ZIndex =
				18

		},
		Content
	)

local ContentLine =
	New(
		"Frame",
		{

			Name =
				"ContentLine",

			Size =
				UDim2.new(
					1,
					-20,
					0,
					1
				),

			Position =
				UDim2.fromOffset(
					10,
					36
				),

			BackgroundColor3 =
				COLORS.PURPLE,

			BackgroundTransparency =
				.55,

			BorderSizePixel =
				0,

			ZIndex =
				18

		},
		Content
	)

--==================================================
-- PAGE CONTAINER
--==================================================

local Page =
	New(
		"ScrollingFrame",
		{

			Name =
				"Page",

			Size =
				UDim2.new(
					1,
					-16,
					1,
					-48
				),

			Position =
				UDim2.fromOffset(
					8,
					44
				),

			BackgroundTransparency =
				1,

			BorderSizePixel =
				0,

			ScrollBarThickness =
				3,

			ScrollBarImageColor3 =
				COLORS.PURPLE,

			ScrollBarImageTransparency =
				.25,

			CanvasSize =
				UDim2.new(
					0,
					0,
					0,
					0
				),

			AutomaticCanvasSize =
				Enum.AutomaticSize.Y,

			ClipsDescendants =
				true,

			ZIndex =
				17

		},
		Content
	)

local PagePadding =
	New(
		"UIPadding",
		{

			PaddingTop =
				UDim.new(
					0,
					2
				),

			PaddingBottom =
				UDim.new(
					0,
					8
				),

			PaddingLeft =
				UDim.new(
					0,
					2
				),

			PaddingRight =
				UDim.new(
					0,
					5
				)

		},
		Page
	)

local PageLayout =
	New(
		"UIListLayout",
		{

			FillDirection =
				Enum.FillDirection.Vertical,

			HorizontalAlignment =
				Enum.HorizontalAlignment.Center,

			VerticalAlignment =
				Enum.VerticalAlignment.Top,

			Padding =
				UDim.new(
					0,
					6
				)

		},
		Page
	)

--==================================================
-- CATEGORY BUTTON CREATOR
--==================================================

local Categories = {}

local function CreateCategory(
	name
)

	local Button =
		New(
			"TextButton",
			{

				Name =
					name,

				Size =
					UDim2.new(
						1,
						-4,
						0,
						34
					),

				BackgroundColor3 =
					COLORS.ROW,

				BorderSizePixel =
					0,

				AutoButtonColor =
					false,

				Text =
					name,

				TextColor3 =
					COLORS.SUB,

				Font =
					Enum.Font.GothamMedium,

				TextSize =
					10,

				TextXAlignment =
					Enum.TextXAlignment.Left,

				ZIndex =
					20

			},
			CategoryList
		)

	Corner(
		Button,
		8
	)

	local Padding =
		New(
			"UIPadding",
			{

				PaddingLeft =
					UDim.new(
						0,
						10
					)

			},
			Button
		)

	local ButtonStroke =
		Stroke(
			Button,
			COLORS.PURPLE,
			1,
			1
		)

	Categories[name] = {
		Button = Button,
		Stroke = ButtonStroke
	}

	return Button
end

--==================================================
-- CATEGORIES
--==================================================

local CombatButton =
	CreateCategory(
		"Combat"
	)

local VisualsButton =
	CreateCategory(
		"Visuals"
	)

local MovementButton =
	CreateCategory(
		"Movement"
	)

local MiscButton =
	CreateCategory(
		"Misc"
	)

local SettingsButton =
	CreateCategory(
		"Settings"
	)

--==================================================
-- PAGE FUNCTIONS
--==================================================

local Pages = {}

local function CreatePage(
	name
)

	local Frame =
		New(
			"Frame",
			{

				Name =
					name,

				Size =
					UDim2.new(
						1,
						0,
						0,
						0
					),

				AutomaticSize =
					Enum.AutomaticSize.Y,

				BackgroundTransparency =
					1,

				BorderSizePixel =
					0,

				Visible =
					false,

				ZIndex =
					18

			},
			Page
		)

	local Layout =
		New(
			"UIListLayout",
			{

				FillDirection =
					Enum.FillDirection.Vertical,

				HorizontalAlignment =
					Enum.HorizontalAlignment.Center,

				VerticalAlignment =
					Enum.VerticalAlignment.Top,

				Padding =
					UDim.new(
						0,
						6
					)

			},
			Frame
		)

	Pages[name] = Frame

	return Frame
end

--==================================================
-- PAGE CREATOR
--==================================================

local CombatPage =
	CreatePage(
		"CombatPage"
	)

local VisualsPage =
	CreatePage(
		"VisualsPage"
	)

local MovementPage =
	CreatePage(
		"MovementPage"
	)

local MiscPage =
	CreatePage(
		"MiscPage"
	)

local SettingsPage =
	CreatePage(
		"SettingsPage"
	)

--==================================================
-- ROW CREATOR
--==================================================

local function CreateRow(
	parent,
	title,
	description
)

	local Row =
		New(
			"Frame",
			{

				Name =
					title .. "Row",

				Size =
					UDim2.new(
						1,
						-4,
						0,
						48
					),

				BackgroundColor3 =
					COLORS.ROW,

				BorderSizePixel =
					0,

				ZIndex =
					20

			},
			parent
		)

	Corner(
		Row,
		8
	)

	Stroke(
		Row,
		COLORS.PURPLE,
		1,
		.9
	)

	local TitleLabel =
		New(
			"TextLabel",
			{

				Size =
					UDim2.new(
						1,
						-75,
						0,
						20
					),

				Position =
					UDim2.fromOffset(
						10,
						6
					),

				BackgroundTransparency =
					1,

				Text =
					title,

				TextColor3 =
					COLORS.TEXT,

				Font =
					Enum.Font.GothamMedium,

				TextSize =
					10,

				TextXAlignment =
					Enum.TextXAlignment.Left,

				ZIndex =
					21

			},
			Row
		)

	local DescLabel =
		New(
			"TextLabel",
			{

				Size =
					UDim2.new(
						1,
						-75,
						0,
						15
					),

				Position =
					UDim2.fromOffset(
						10,
						25
					),

				BackgroundTransparency =
					1,

				Text =
					description or "",

				TextColor3 =
					COLORS.SUB,

				Font =
					Enum.Font.Gotham,

				TextSize =
					7,

				TextXAlignment =
					Enum.TextXAlignment.Left,

				TextTruncate =
					Enum.TextTruncate.AtEnd,

				ZIndex =
					21

			},
			Row
		)

	return Row
end

--==================================================
-- TOGGLE CREATOR
--==================================================

local function CreateToggle(
	parent,
	title,
	description,
	key
)

	local Row =
		CreateRow(
			parent,
			title,
			description
		)

	local Toggle =
		New(
			"TextButton",
			{

				Name =
					"Toggle",

				Size =
					UDim2.fromOffset(
						42,
						22
					),

				Position =
					UDim2.new(
						1,
						-52,
						.5,
						-11
					),

				BackgroundColor3 =
					COLORS.DARK,

				BorderSizePixel =
					0,

				AutoButtonColor =
					false,

				Text =
					"",

				ZIndex =
					23

			},
			Row
		)

	Corner(
		Toggle,
		11
	)

	local Circle =
		New(
			"Frame",
			{

				Name =
					"Circle",

				Size =
					UDim2.fromOffset(
						16,
						16
					),

				Position =
					UDim2.fromOffset(
						3,
						3
					),

				BackgroundColor3 =
					COLORS.WHITE,

				BorderSizePixel =
					0,

				ZIndex =
					24

			},
			Toggle
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
				Toggle,
				.15,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out,
				{
					BackgroundColor3 =
						COLORS.PURPLE
				}
			)

			Tween(
				Circle,
				.15,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out,
				{
					Position =
						UDim2.fromOffset(
							23,
							3
						)
				}
			)

		else

			Tween(
				Toggle,
				.15,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out,
				{
					BackgroundColor3 =
						COLORS.DARK
				}
			)

			Tween(
				Circle,
				.15,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out,
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

	Toggle.Activated:Connect(function()

		S[key] =
			not S[key]

		Update()

	end)

	Update()

	return Row
end

--==================================================
-- COMBAT PAGE
--==================================================

CreateToggle(
	CombatPage,
	"Aim Assist",
	"Selects the closest valid target",
	"AimAssist"
)

CreateToggle(
	CombatPage,
	"Players",
	"Allow player targets",
	"AimPlayers"
)

CreateToggle(
	CombatPage,
	"NPC",
	"Allow NPC targets",
	"AimNPC"
)

CreateToggle(
	CombatPage,
	"Visible Only",
	"Ignore targets behind walls",
	"AimVisibleOnly"
)

CreateToggle(
	CombatPage,
	"FOV",
	"Use screen distance",
	"FOVChanger"
)

--==================================================
-- VISUALS PAGE
--==================================================

CreateToggle(
	VisualsPage,
	"ESP",
	"Show valid targets",
	"ESP"
)

CreateToggle(
	VisualsPage,
	"Box ESP",
	"Display target boxes",
	"BoxESP"
)

CreateToggle(
	VisualsPage,
	"Names",
	"Display target names",
	"Names"
)

CreateToggle(
	VisualsPage,
	"Health",
	"Display target health",
	"Health"
)

CreateToggle(
	VisualsPage,
	"Distance",
	"Display target distance",
	"Distance"
)

CreateToggle(
	VisualsPage,
	"Snapline",
	"Line to selected target",
	"Snapline"
)

CreateToggle(
	VisualsPage,
	"Team Check",
	"Ignore teammates",
	"TeamCheck"
)

--==================================================
-- MOVEMENT PAGE
--==================================================

CreateToggle(
	MovementPage,
	"Speed",
	"Custom movement speed",
	"SpeedHack"
)

CreateToggle(
	MovementPage,
	"Jump",
	"Custom jump power",
	"Jump"
)

CreateToggle(
	MovementPage,
	"Noclip",
	"Disable character collisions",
	"Noclip"
)

--==================================================
-- MISC PAGE
--==================================================

CreateToggle(
	MiscPage,
	"Fullbright",
	"Remove dark lighting",
	"Fullbright"
)

CreateToggle(
	MiscPage,
	"Neon Gun",
	"Make equipped weapon neon",
	"NeonGuns"
)

CreateToggle(
	MiscPage,
	"Custom Hands",
	"Move the current viewmodel",
	"CustomHands"
)

CreateToggle(
	MiscPage,
	"Menu Animations",
	"Enable interface animations",
	"MenuAnimations"
)

--==================================================
-- SETTINGS PAGE
--==================================================

local SettingsInfo =
	CreateRow(
		SettingsPage,
		"RUSTED HUB",
		"v3.2"
	)

local InfoLabel =
	New(
		"TextLabel",
		{

			Size =
				UDim2.new(
					1,
					-20,
					0,
					60
				),

			Position =
				UDim2.fromOffset(
					10,
					58
				),

			BackgroundTransparency =
				1,

			Text =
				"Compact client interface\nCombat • Visuals • Movement • Misc",

			TextColor3 =
				COLORS.SUB,

			Font =
				Enum.Font.Gotham,

			TextSize =
				9,

			TextWrapped =
				true,

			TextXAlignment =
				Enum.TextXAlignment.Left,

			TextYAlignment =
				Enum.TextYAlignment.Top,

			ZIndex =
				21

		},
		SettingsPage
	)

--==================================================
-- PAGE SWITCH
--==================================================

local CurrentPage =
	"CombatPage"

local function ShowPage(
	name
)

	for pageName, frame in pairs(
		Pages
	) do

		frame.Visible =
			pageName == name

	end

	for categoryName, data in pairs(
		Categories
	) do

		local active =
			categoryName ==
			name:gsub(
				"Page",
				""
			)

		if active then

			data.Button.BackgroundColor3 =
				COLORS.PURPLE

			data.Button.TextColor3 =
				COLORS.WHITE

			data.Stroke.Transparency =
				.2

		else

			data.Button.BackgroundColor3 =
				COLORS.ROW

			data.Button.TextColor3 =
				COLORS.SUB

			data.Stroke.Transparency =
				1

		end

	end

	CurrentPage =
		name

end

CombatButton.Activated:Connect(function()
	ShowPage("CombatPage")
end)

VisualsButton.Activated:Connect(function()
	ShowPage("VisualsPage")
end)

MovementButton.Activated:Connect(function()
	ShowPage("MovementPage")
end)

MiscButton.Activated:Connect(function()
	ShowPage("MiscPage")
end)

SettingsButton.Activated:Connect(function()
	ShowPage("SettingsPage")
end)

ShowPage(
	"CombatPage"
)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging =
	false

local DragStart =
	nil

local StartPosition =
	nil

local function UpdateDrag(
	input
)

	if not Dragging
		or not DragStart
		or not StartPosition then

		return

	end

	local Delta =
		input.Position -
		DragStart

	Main.Position =
		UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset +
				Delta.X,

			StartPosition.Y.Scale,
			StartPosition.Y.Offset +
				Delta.Y
		)

end

Top.InputBegan:Connect(
	function(input)

		if
			input.UserInputType ==
				Enum.UserInputType.MouseButton1
			or
			input.UserInputType ==
				Enum.UserInputType.Touch
		then

			Dragging =
				true

			DragStart =
				input.Position

			StartPosition =
				Main.Position

		end

	end
)

Top.InputChanged:Connect(
	function(input)

		if
			input.UserInputType ==
				Enum.UserInputType.MouseMovement
			or
			input.UserInputType ==
				Enum.UserInputType.Touch
		then

			DragStart =
				DragStart or
				input.Position

		end

	end
)

UIS.InputChanged:Connect(
	function(input)

		if
			input.UserInputType ==
				Enum.UserInputType.MouseMovement
			or
			input.UserInputType ==
				Enum.UserInputType.Touch
		then

			UpdateDrag(
				input
			)

		end

	end
)

UIS.InputEnded:Connect(
	function(input)

		if
			input.UserInputType ==
				Enum.UserInputType.MouseButton1
			or
			input.UserInputType ==
				Enum.UserInputType.Touch
		then

			Dragging =
				false

		end

	end
)

--==================================================
-- MINIMIZE STATE
--==================================================

local Minimized =
	false

local FullSize =
	UDim2.fromOffset(
		500,
		300
	)

local MinSize =
	UDim2.fromOffset(
		500,
		48
	)

local function SetMinimized(
	state
)

	Minimized =
		state

	if Minimized then

		Minimize.Text =
			"+"

		if S.MenuAnimations then

			Tween(
				Main,
				.2,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.Out,
				{
					Size =
						MinSize
				}
			)

		else

			Main.Size =
				MinSize

		end

	else

		Minimize.Text =
			"—"

		if S.MenuAnimations then

			Tween(
				Main,
				.2,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.Out,
				{
					Size =
						FullSize
				}
			)

		else

			Main.Size =
				FullSize

		end

	end

end

Minimize.Activated:Connect(
	function()

		SetMinimized(
			not Minimized
		)

	end
)

--==================================================
-- CLOSE
--==================================================

Close.Activated:Connect(
	function()

		Gui.Enabled =
			false

	end
)

--==================================================
-- END PART 1B
--==================================================

--==================================================
--                 RUSTED v3.2
--                  PART 2A/7
--                  ESP CORE
--==================================================

--==================================================
-- ESP FOLDER
--==================================================

local ESPFolder =
	New(
		"Folder",
		{
			Name = "RustedESP"
		},
		Gui
	)

--==================================================
-- ESP OBJECT STORAGE
--==================================================

local ESPObjects = {}

--==================================================
-- TARGET CHARACTER
--==================================================

local function GetTargetCharacter(
	player
)

	if not player then
		return nil
	end

	local character =
		player.Character

	if not character then
		return nil
	end

	local humanoid =
		character:
			FindFirstChildOfClass(
				"Humanoid"
			)

	local root =
		GetRoot(
			character
		)

	if not humanoid
		or not root then

		return nil

	end

	if humanoid.Health <= 0 then
		return nil
	end

	return character
end

--==================================================
-- TEAM CHECK
--==================================================

local function IsEnemy(
	player
)

	if player == Player then
		return false
	end

	if not S.TeamCheck then
		return true
	end

	if Player.Team
		and player.Team
		and Player.Team ==
			player.Team then

		return false

	end

	return true
end

--==================================================
-- PLAYER TARGET CHECK
--==================================================

local function IsValidPlayer(
	player
)

	if not player then
		return false
	end

	if player == Player then
		return false
	end

	if not IsEnemy(player) then
		return false
	end

	return
		GetTargetCharacter(
			player
		) ~= nil

end

--==================================================
-- NPC CHECK
--==================================================

local function IsNPC(
	model
)

	if not model
		or not model:IsA("Model") then

		return false

	end

	if Players:GetPlayerFromCharacter(
		model
	) then

		return false

	end

	local humanoid =
		model:
			FindFirstChildOfClass(
				"Humanoid"
			)

	local root =
		GetRoot(
			model
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
-- CREATE ESP
--==================================================

local function CreateESP(
	key,
	character,
	displayName
)

	if ESPObjects[key] then
		return ESPObjects[key]
	end

	local root =
		GetRoot(
			character
		)

	if not root then
		return nil
	end

	--==============================================
	-- BILLBOARD
	--==============================================

	local Billboard =
		New(
			"BillboardGui",
			{

				Name =
					"ESP_" ..
					tostring(key),

				Adornee =
					root,

				Size =
					UDim2.fromOffset(
						150,
						70
					),

				StudsOffset =
					Vector3.new(
						0,
						3,
						0
					),

				AlwaysOnTop =
					true,

				LightInfluence =
					0,

				Enabled =
					true,

				ZIndexBehavior =
					Enum.ZIndexBehavior.Sibling

			},
			ESPFolder
		)

	--==============================================
	-- NAME
	--==============================================

	local NameLabel =
		New(
			"TextLabel",
			{

				Name =
					"Name",

				Size =
					UDim2.new(
						1,
						0,
						0,
						18
					),

				Position =
					UDim2.fromOffset(
						0,
						0
					),

				BackgroundTransparency =
					1,

				Text =
					displayName
					or "Target",

				TextColor3 =
					COLORS.WHITE,

				TextStrokeTransparency =
					.25,

				Font =
					Enum.Font.GothamBold,

				TextSize =
					11,

				TextXAlignment =
					Enum.TextXAlignment.Center,

				Visible =
					S.Names,

				ZIndex =
					5

			},
			Billboard
		)

	--==============================================
	-- HEALTH
	--==============================================

	local HealthLabel =
		New(
			"TextLabel",
			{

				Name =
					"Health",

				Size =
					UDim2.new(
						1,
						0,
						0,
						15
					),

				Position =
					UDim2.fromOffset(
						0,
						18
					),

				BackgroundTransparency =
					1,

				TextColor3 =
					COLORS.GREEN,

				TextStrokeTransparency =
					.35,

				Font =
					Enum.Font.GothamMedium,

				TextSize =
					9,

				TextXAlignment =
					Enum.TextXAlignment.Center,

				Visible =
					S.Health,

				ZIndex =
					5

			},
			Billboard
		)

	--==============================================
	-- DISTANCE
	--==============================================

	local DistanceLabel =
		New(
			"TextLabel",
			{

				Name =
					"Distance",

				Size =
					UDim2.new(
						1,
						0,
						0,
						15
					),

				Position =
					UDim2.fromOffset(
						0,
						33
					),

				BackgroundTransparency =
					1,

				TextColor3 =
					COLORS.SUB,

				TextStrokeTransparency =
					.4,

				Font =
					Enum.Font.Gotham,

				TextSize =
					8,

				TextXAlignment =
					Enum.TextXAlignment.Center,

				Visible =
					S.Distance,

				ZIndex =
					5

			},
			Billboard
		)

	--==============================================
	-- BOX
	--==============================================

	local Box =
		New(
			"Frame",
			{

				Name =
					"Box",

				Size =
					UDim2.fromOffset(
						55,
						75
					),

				Position =
					UDim2.new(
						.5,
						-27,
						.5,
						-37
					),

				BackgroundTransparency =
					1,

				Visible =
					S.BoxESP,

				ZIndex =
					3

			},
			Billboard
		)

	local BoxStroke =
		Stroke(
			Box,
			COLORS.PURPLE,
			1.5,
			0
		)

	--==============================================
	-- STORE
	--==============================================

	local Data = {

		Billboard =
			Billboard,

		Name =
			NameLabel,

		Health =
			HealthLabel,

		Distance =
			DistanceLabel,

		Box =
			Box,

		BoxStroke =
			BoxStroke,

		Character =
			character,

		Root =
			root

	}

	ESPObjects[key] =
		Data

	return Data
end

--==================================================
-- REMOVE ESP
--==================================================

local function RemoveESP(
	key
)

	local data =
		ESPObjects[key]

	if not data then
		return
	end

	if data.Billboard then

		pcall(function()

			data.Billboard:
				Destroy()

		end)

	end

	ESPObjects[key] =
		nil

end

--==================================================
-- CLEAR ESP
--==================================================

local function ClearESP()

	for key in pairs(
		ESPObjects
	) do

		RemoveESP(
			key
		)

	end

end

--==================================================
-- UPDATE ESP DATA
--==================================================

local function UpdateESPObject(
	data
)

	if not data then
		return
	end

	local character =
		data.Character

	if not character
		or not character.Parent then

		return

	end

	local humanoid =
		character:
			FindFirstChildOfClass(
				"Humanoid"
			)

	local root =
		GetRoot(
			character
		)

	if not humanoid
		or not root then

		return

	end

	data.Root =
		root

	--==============================================
	-- HEALTH TEXT
	--==============================================

	local health =
		math.max(
			0,
			math.floor(
				humanoid.Health
			)
		)

	local maxHealth =
		math.max(
			1,
			math.floor(
				humanoid.MaxHealth
			)
		)

	data.Health.Text =
		"HP: " ..
		tostring(health) ..
		"/" ..
		tostring(maxHealth)

	--==============================================
	-- DISTANCE
	--==============================================

	local myCharacter =
		GetCharacter()

	local myRoot =
		GetRoot(
			myCharacter
		)

	if myRoot then

		local distance =
			(
				myRoot.Position -
				root.Position
			).Magnitude

		data.Distance.Text =
			string.format(
				"%.0f studs",
				distance
			)

	end

	--==============================================
	-- VISIBILITY
	--==============================================

	data.Name.Visible =
		S.Names

	data.Health.Visible =
		S.Health

	data.Distance.Visible =
		S.Distance

	data.Box.Visible =
		S.BoxESP

	data.Billboard.Enabled =
		S.ESP

end

--==================================================
-- END PART 2A/7
--==================================================

--==================================================
--                 RUSTED v3.2
--                  PART 2B/7
--          ESP SCANNER + REALTIME UPDATE
--==================================================

--==================================================
-- NPC STORAGE
--==================================================

local NPCObjects = {}

--==================================================
-- ADD PLAYER ESP
--==================================================

local function AddPlayerESP(
	player
)

	if not S.ESP then
		return
	end

	if not IsValidPlayer(player) then
		return
	end

	local character =
		GetTargetCharacter(
			player
		)

	if not character then
		return
	end

	local key =
		"PLAYER_" ..
		player.UserId

	local data =
		CreateESP(
			key,
			character,
			player.DisplayName
		)

	if data then

		data.Player =
			player

		data.IsNPC =
			false

	end

end

--==================================================
-- REMOVE PLAYER ESP
--==================================================

local function RemovePlayerESP(
	player
)

	if not player then
		return
	end

	local key =
		"PLAYER_" ..
		player.UserId

	RemoveESP(
		key
	)

end

--==================================================
-- ADD NPC ESP
--==================================================

local function AddNPCESP(
	model
)

	if not S.ESP
		or not S.AimNPC then

		return

	end

	if not IsNPC(model) then
		return
	end

	local key =
		"NPC_" ..
		model:GetDebugId()

	local data =
		CreateESP(
			key,
			model,
			model.Name
		)

	if data then

		data.NPC =
			model

		data.IsNPC =
			true

		NPCObjects[model] =
			key

	end

end

--==================================================
-- REMOVE NPC ESP
--==================================================

local function RemoveNPCESP(
	model
)

	local key =
		NPCObjects[model]

	if key then

		RemoveESP(
			key
		)

		NPCObjects[model] =
			nil

	end

end

--==================================================
-- SCAN PLAYERS
--==================================================

local function ScanPlayers()

	if not S.ESP then

		for key in pairs(
			ESPObjects
		) do

			if string.sub(
				key,
				1,
				7
			) == "PLAYER_" then

				RemoveESP(
					key
				)

			end

		end

		return
	end

	for _, player in ipairs(
		Players:GetPlayers()
	) do

		if player ~= Player then

			AddPlayerESP(
				player
			)

		end

	end

end

--==================================================
-- SCAN NPCS
--==================================================

local function ScanNPCs()

	if not S.ESP
		or not S.AimNPC then

		for model in pairs(
			NPCObjects
		) do

			RemoveNPCESP(
				model
			)

		end

		return
	end

	for _, object in ipairs(
		workspace:GetDescendants()
	) do

		if object:IsA("Model")
			and IsNPC(object) then

			AddNPCESP(
				object
			)

		end

	end

end

--==================================================
-- UPDATE ALL ESP
--==================================================

local function UpdateAllESP()

	if not S.ESP then
		return
	end

	for key, data in pairs(
		ESPObjects
	) do

		local valid =
			false

		--==========================================
		-- PLAYER
		--==========================================

		if not data.IsNPC
			and data.Player then

			local player =
				data.Player

			if IsValidPlayer(
				player
			) then

				local character =
					GetTargetCharacter(
						player
					)

				if character then

					data.Character =
						character

					valid =
						true

				end

			end

		--==========================================
		-- NPC
		--==========================================

		elseif data.IsNPC
			and data.NPC then

			local npc =
				data.NPC

			if IsNPC(npc) then

				data.Character =
					npc

				valid =
					true

			end

		end

		if valid then

			UpdateESPObject(
				data
			)

		else

			RemoveESP(
				key
			)

		end

	end

end

--==================================================
-- PLAYER EVENTS
--==================================================

Players.PlayerAdded:Connect(
	function(player)

		player.CharacterAdded:Connect(
			function()

				task.wait(
					0.5
				)

				AddPlayerESP(
					player
				)

			end
		)

	end
)

Players.PlayerRemoving:Connect(
	function(player)

		RemovePlayerESP(
			player
		)

	end
)

--==================================================
-- EXISTING PLAYER CHARACTER EVENTS
--==================================================

for _, player in ipairs(
	Players:GetPlayers()
) do

	if player ~= Player then

		player.CharacterAdded:Connect(
			function()

				task.wait(
					0.5
				)

				AddPlayerESP(
					player
				)

			end
		)

		player.CharacterRemoving:Connect(
			function()

				RemovePlayerESP(
					player
				)

			end
		)

	end

end

--==================================================
-- NPC DESCENDANT MONITOR
--==================================================

workspace.DescendantAdded:Connect(
	function(object)

		if not S.ESP
			or not S.AimNPC then

			return

		end

		if object:IsA("Model") then

			task.defer(
				function()

					if IsNPC(object) then

						AddNPCESP(
							object
						)

					end

				end
			)

		end

	end
)

workspace.DescendantRemoving:Connect(
	function(object)

		if object:IsA("Model") then

			RemoveNPCESP(
				object
			)

		end

	end
)

--==================================================
-- ESP UPDATE LOOP
--==================================================

local ESPTimer =
	0

RunService.Heartbeat:Connect(
	function(deltaTime)

		ESPTimer +=
			deltaTime

		-- Scan periodically instead of
		-- scanning the entire workspace
		-- every frame.

		if ESPTimer >= 0.5 then

			ESPTimer =
				0

			ScanPlayers()
			ScanNPCs()

		end

		UpdateAllESP()

	end
)

--==================================================
-- INITIAL SCAN
--==================================================

task.defer(
	function()

		task.wait(
			0.5
		)

		ScanPlayers()
		ScanNPCs()

	end
)

--==================================================
-- END PART 2B/7
--==================================================

--==================================================
--                 RUSTED v3.2
--                  PART 3A/7
--             TARGET SELECTOR + FOV
--==================================================

--==================================================
-- CAMERA
--==================================================

local Camera =
	workspace.CurrentCamera

--==================================================
-- TARGET STATE
--==================================================

local CurrentTarget =
	nil

local CurrentTargetRoot =
	nil

local CurrentTargetPart =
	nil

--==================================================
-- FOV GUI
--==================================================

local FOVGui =
	New(
		"ScreenGui",
		{

			Name =
				"RustedFOV",

			ResetOnSpawn =
				false,

			IgnoreGuiInset =
				true,

			DisplayOrder =
				998,

			ZIndexBehavior =
				Enum.ZIndexBehavior.Sibling

		},
		PlayerGui
	)

local FOVCircle =
	New(
		"Frame",
		{

			Name =
				"FOVCircle",

			AnchorPoint =
				Vector2.new(
					.5,
					.5
				),

			Position =
				UDim2.fromScale(
					.5,
					.5
				),

			Size =
				UDim2.fromOffset(
					S.AimFOV * 2,
					S.AimFOV * 2
				),

			BackgroundTransparency =
				1,

			BorderSizePixel =
				0,

			Visible =
				false,

			ZIndex =
				2

		},
		FOVGui
	)

local FOVCorner =
	Corner(
		FOVCircle,
		S.AimFOV
	)

local FOVStroke =
	Stroke(
		FOVCircle,
		COLORS.PURPLE,
		1.5,
		.25
	)

--==================================================
-- UPDATE FOV
--==================================================

local function UpdateFOVCircle()

	local size =
		math.clamp(
			S.AimFOV,
			20,
			600
		)

	FOVCircle.Size =
		UDim2.fromOffset(
			size * 2,
			size * 2
		)

	FOVCorner.CornerRadius =
		UDim.new(
			0,
			size
		)

	FOVCircle.Visible =
		S.AimAssist

end

UpdateFOVCircle()

--==================================================
-- CHARACTER TARGET PART
--==================================================

local function GetAimPart(
	character
)

	if not character then
		return nil
	end

	-- Prefer Head for more accurate
	-- visual target selection.

	local head =
		character:
			FindFirstChild(
				"Head"
			)

	if head
		and head:IsA("BasePart") then

		return head

	end

	local root =
		GetRoot(
			character
		)

	if root then
		return root
	end

	return character:
		FindFirstChildWhichIsA(
			"BasePart"
		)

end

--==================================================
-- VISIBILITY CHECK
--==================================================

local function IsVisible(
	part,
	character
)

	if not S.AimVisibleOnly then
		return true
	end

	if not part
		or not character then

		return false

	end

	Camera =
		workspace.CurrentCamera

	if not Camera then
		return false
	end

	local origin =
		Camera.CFrame.Position

	local direction =
		part.Position -
		origin

	local params =
		RaycastParams.new()

	params.FilterType =
		Enum.RaycastFilterType.Exclude

	local ignoreList = {
		Player.Character
	}

	-- Ignore the target's own
	-- character only after the
	-- ray reaches it.

	for _, object in ipairs(
		character:GetDescendants()
	) do

		if object:IsA("BasePart") then

			table.insert(
				ignoreList,
				object
			)

		end

	end

	params.FilterDescendantsInstances =
		ignoreList

	local result =
		workspace:Raycast(
			origin,
			direction,
			params
		)

	-- Nothing blocked the ray.

	if not result then
		return true
	end

	-- Some games have transparent
	-- helper parts. Continue through
	-- fully transparent parts.

	local hit =
		result.Instance

	if hit
		and hit:IsA("BasePart")
		and hit.Transparency >= 1 then

		return true
	end

	return false
end

--==================================================
-- SCREEN POSITION
--==================================================

local function GetScreenPosition(
	part
)

	Camera =
		workspace.CurrentCamera

	if not Camera
		or not part then

		return nil, false
	end

	local position,
		onScreen =
		Camera:WorldToViewportPoint(
			part.Position
		)

	return
		Vector2.new(
			position.X,
			position.Y
		),
		onScreen
end

--==================================================
-- TARGET VALIDATION
--==================================================

local function IsTargetValid(
	character
)

	if not character
		or not character.Parent then

		return false
	end

	local humanoid =
		character:
			FindFirstChildOfClass(
				"Humanoid"
			)

	local root =
		GetRoot(
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
-- PLAYER TARGETS
--==================================================

local function GetPlayerTargets()

	local targets = {}

	if not S.AimPlayers then
		return targets
	end

	for _, player in ipairs(
		Players:GetPlayers()
	) do

		if IsValidPlayer(player) then

			local character =
				GetTargetCharacter(
					player
				)

			if character
				and IsTargetValid(
					character
				) then

				table.insert(
					targets,
					{
						Character =
							character,

						Player =
							player,

						IsNPC =
							false
					}
				)

			end

		end

	end

	return targets
end

--==================================================
-- NPC TARGETS
--==================================================

local function GetNPCTargets()

	local targets = {}

	if not S.AimNPC then
		return targets
	end

	for model in pairs(
		NPCObjects
	) do

		if IsNPC(model)
			and IsTargetValid(model) then

			table.insert(
				targets,
				{
					Character =
						model,

					Player =
						nil,

					IsNPC =
						true
				}
			)

		end

	end

	return targets
end

--==================================================
-- COLLECT TARGETS
--==================================================

local function GetAllTargets()

	local targets =
		GetPlayerTargets()

	local npcs =
		GetNPCTargets()

	for _, target in ipairs(
		npcs
	) do

		table.insert(
			targets,
			target
		)

	end

	return targets
end

--==================================================
-- FIND CLOSEST TARGET
--==================================================

local function FindClosestTarget()

	Camera =
		workspace.CurrentCamera

	if not Camera then
		return nil
	end

	local viewport =
		Camera.ViewportSize

	local screenCenter =
		Vector2.new(
			viewport.X / 2,
			viewport.Y / 2
		)

	local maxDistance =
		math.clamp(
			S.AimFOV,
			20,
			600
		)

	local closest =
		nil

	local closestDistance =
		math.huge

	for _, target in ipairs(
		GetAllTargets()
	) do

		local character =
			target.Character

		local part =
			GetAimPart(
				character
			)

		if part then

			local screenPosition,
				onScreen =
				GetScreenPosition(
					part
				)

			if onScreen then

				local distance =
					(
						screenPosition -
						screenCenter
					).Magnitude

				if distance <=
					maxDistance then

					if IsVisible(
						part,
						character
					) then

						if distance <
							closestDistance then

							closestDistance =
								distance

							closest =
								target

							closest.AimPart =
								part

						end

					end

				end

			end

		end

	end

	return closest
end

--==================================================
-- TARGET UPDATE
--==================================================

local function UpdateTarget()

	if not S.AimAssist then

		CurrentTarget =
			nil

		CurrentTargetRoot =
			nil

		CurrentTargetPart =
			nil

		return

	end

	local target =
		FindClosestTarget()

	if target then

		CurrentTarget =
			target

		CurrentTargetRoot =
			GetRoot(
				target.Character
			)

		CurrentTargetPart =
			target.AimPart

	else

		CurrentTarget =
			nil

		CurrentTargetRoot =
			nil

		CurrentTargetPart =
			nil

	end

end

--==================================================
-- TARGET UPDATE LOOP
--==================================================

RunService.RenderStepped:Connect(
	function()

		UpdateFOVCircle()

		UpdateTarget()

	end
)

--==================================================
-- END PART 3A/7
--==================================================

--==================================================
--                 RUSTED v3.2
--                  PART 3B/7
--                SNAPLINE SYSTEM
--==================================================

--==================================================
-- SNAPLINE GUI
--==================================================

local SnapGui =
	New(
		"ScreenGui",
		{

			Name =
				"RustedSnapline",

			ResetOnSpawn =
				false,

			IgnoreGuiInset =
				true,

			DisplayOrder =
				997,

			ZIndexBehavior =
				Enum.ZIndexBehavior.Sibling

		},
		PlayerGui
	)

--==================================================
-- LINE
--==================================================

local SnapLine =
	New(
		"Frame",
		{

			Name =
				"SnapLine",

			AnchorPoint =
				Vector2.new(
					0,
					0.5
				),

			Position =
				UDim2.fromOffset(
					0,
					0
				),

			Size =
				UDim2.fromOffset(
					0,
					2
				),

			BackgroundColor3 =
				COLORS.PURPLE,

			BorderSizePixel =
				0,

			Visible =
				false,

			ZIndex =
				5

		},
		SnapGui
	)

Corner(
	SnapLine,
	2
)

--==================================================
-- TARGET DOT
--==================================================

local TargetDot =
	New(
		"Frame",
		{

			Name =
				"TargetDot",

			AnchorPoint =
				Vector2.new(
					.5,
					.5
				),

			Size =
				UDim2.fromOffset(
					7,
					7
				),

			BackgroundColor3 =
				COLORS.WHITE,

			BorderSizePixel =
				0,

			Visible =
				false,

			ZIndex =
				6

		},
		SnapGui
	)

Corner(
	TargetDot,
	5
)

Stroke(
	TargetDot,
	COLORS.PURPLE,
	1,
	.1
)

--==================================================
-- LINE UPDATE
--==================================================

local function UpdateSnapline()

	if not S.Snapline
		or not S.AimAssist then

		SnapLine.Visible =
			false

		TargetDot.Visible =
			false

		return

	end

	if not CurrentTarget
		or not CurrentTargetPart then

		SnapLine.Visible =
			false

		TargetDot.Visible =
			false

		return

	end

	Camera =
		workspace.CurrentCamera

	if not Camera then

		SnapLine.Visible =
			false

		TargetDot.Visible =
			false

		return

	end

	local viewport =
		Camera.ViewportSize

	local center =
		Vector2.new(
			viewport.X / 2,
			viewport.Y / 2
		)

	local targetPosition,
		onScreen =
		Camera:WorldToViewportPoint(
			CurrentTargetPart.Position
		)

	if not onScreen
		or targetPosition.Z <= 0 then

		SnapLine.Visible =
			false

		TargetDot.Visible =
			false

		return

	end

	local target =
		Vector2.new(
			targetPosition.X,
			targetPosition.Y
		)

	local difference =
		target -
		center

	local length =
		difference.Magnitude

	if length < 1 then

		SnapLine.Visible =
			false

		TargetDot.Visible =
			true

		TargetDot.Position =
			UDim2.fromOffset(
				target.X,
				target.Y
			)

		return

	end

	local angle =
		math.deg(
			math.atan2(
				difference.Y,
				difference.X
			)
		)

	--==============================================
	-- DRAW FROM SCREEN CENTER
	--==============================================

	SnapLine.AnchorPoint =
		Vector2.new(
			0,
			0.5
		)

	SnapLine.Position =
		UDim2.fromOffset(
			center.X,
			center.Y
		)

	SnapLine.Size =
		UDim2.fromOffset(
			length,
			2
		)

	SnapLine.Rotation =
		angle

	SnapLine.Visible =
		true

	--==============================================
	-- TARGET DOT
	--==============================================

	TargetDot.Position =
		UDim2.fromOffset(
			target.X,
			target.Y
		)

	TargetDot.Visible =
		true

end

--==================================================
-- SNAPLINE LOOP
--==================================================

RunService.RenderStepped:Connect(
	function()

		UpdateSnapline()

	end
)

--==================================================
-- SNAPLINE COLOR UPDATE
--==================================================

local function UpdateSnaplineColor()

	SnapLine.BackgroundColor3 =
		COLORS.PURPLE

end

UpdateSnaplineColor()

--==================================================
-- END PART 3B/7
--==================================================

--==================================================
--                 RUSTED v3.2
--                  PART 4/7
--                 AIM ASSIST
--==================================================

--==================================================
-- AIM SETTINGS
--==================================================

local AimConnection =
	nil

local LastAimTarget =
	nil

--==================================================
-- GET AIM POSITION
--==================================================

local function GetAimPosition()

	if not CurrentTarget then
		return nil
	end

	if not CurrentTarget.Character then
		return nil
	end

	local character =
		CurrentTarget.Character

	if not IsTargetValid(
		character
	) then

		return nil

	end

	local part =
		CurrentTargetPart

	if not part
		or not part.Parent then

		part =
			GetAimPart(
				character
			)

	end

	if not part then
		return nil
	end

	-- Re-check visibility so Aim Assist
	-- does not keep tracking a target
	-- that became hidden.

	if S.AimVisibleOnly then

		if not IsVisible(
			part,
			character
		) then

			return nil

		end

	end

	return part.Position
end

--==================================================
-- AIM CAMERA
--==================================================

local function UpdateAim()

	if not S.AimAssist then

		LastAimTarget =
			nil

		return

	end

	local position =
		GetAimPosition()

	if not position then

		LastAimTarget =
			nil

		return

	end

	Camera =
		workspace.CurrentCamera

	if not Camera then
		return
	end

	-- Keep the player's current camera
	-- orientation while gently pointing
	-- toward the selected target.

	local cameraPosition =
		Camera.CFrame.Position

	local direction =
		position -
		cameraPosition

	if direction.Magnitude <= 0.01 then
		return
	end

	local targetCFrame =
		CFrame.lookAt(
			cameraPosition,
			position
		)

	-- Small smoothing value prevents
	-- an excessively abrupt camera jump.

	local smooth =
		0.18

	Camera.CFrame =
		Camera.CFrame:Lerp(
			targetCFrame,
			smooth
		)

	LastAimTarget =
		CurrentTarget

end

--==================================================
-- START AIM
--==================================================

local function StartAim()

	if AimConnection then
		return
	end

	AimConnection =
		RunService.RenderStepped:Connect(
			function()

				UpdateAim()

			end
		)

end

--==================================================
-- STOP AIM
--==================================================

local function StopAim()

	if AimConnection then

		AimConnection:Disconnect()

		AimConnection =
			nil

	end

	LastAimTarget =
		nil

end

--==================================================
-- AIM STATE
--==================================================

local function UpdateAimState()

	if S.AimAssist then

		StartAim()

	else

		StopAim()

	end

end

--==================================================
-- MONITOR AIM TOGGLE
--==================================================

task.spawn(
	function()

		local previous =
			S.AimAssist

		while Gui.Parent do

			if previous ~=
				S.AimAssist then

				previous =
					S.AimAssist

				UpdateAimState()

			end

			task.wait(
				0.05
			)

		end

		StopAim()

	end
)

--==================================================
-- CAMERA CHANGE SUPPORT
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
-- CHARACTER RESPAWN SUPPORT
--==================================================

Player.CharacterAdded:Connect(
	function()

		CurrentTarget =
			nil

		CurrentTargetRoot =
			nil

		CurrentTargetPart =
			nil

		LastAimTarget =
			nil

	end
)

--==================================================
-- TARGET INVALIDATION
--==================================================

RunService.Heartbeat:Connect(
	function()

		if not S.AimAssist then
			return
		end

		if not CurrentTarget then
			return
		end

		local character =
			CurrentTarget.Character

		if not character
			or not IsTargetValid(
				character
			) then

			CurrentTarget =
				nil

			CurrentTargetRoot =
				nil

			CurrentTargetPart =
				nil

			LastAimTarget =
				nil

		end

	end
)

--==================================================
-- INITIALIZE
--==================================================

UpdateAimState()

--==================================================
-- END PART 4/7
--==================================================

--==================================================
--                 RUSTED v3.2
--                  PART 5/7
--          MOVEMENT + CAMERA SYSTEM
--==================================================

--==================================================
-- ORIGINAL VALUES
--==================================================

local OriginalWalkSpeed =
	16

local OriginalJumpPower =
	50

local OriginalUseJumpPower =
	true

local OriginalCameraFOV =
	70

--==================================================
-- CHARACTER VALUES
--==================================================

local function SaveCharacterValues()

	local humanoid =
		GetHumanoid()

	if not humanoid then
		return
	end

	OriginalWalkSpeed =
		humanoid.WalkSpeed

	OriginalJumpPower =
		humanoid.JumpPower

	OriginalUseJumpPower =
		humanoid.UseJumpPower

end

SaveCharacterValues()

--==================================================
-- FOV
--==================================================

local function SaveCameraFOV()

	Camera =
		workspace.CurrentCamera

	if Camera then

		OriginalCameraFOV =
			Camera.FieldOfView

	end

end

SaveCameraFOV()

--==================================================
-- APPLY SPEED
--==================================================

local function UpdateSpeed()

	local humanoid =
		GetHumanoid()

	if not humanoid then
		return
	end

	if S.SpeedHack then

		humanoid.WalkSpeed =
			math.clamp(
				S.Speed,
				0,
				250
			)

	else

		humanoid.WalkSpeed =
			OriginalWalkSpeed

	end

end

--==================================================
-- APPLY JUMP
--==================================================

local function UpdateJump()

	local humanoid =
		GetHumanoid()

	if not humanoid then
		return
	end

	if S.Jump then

		humanoid.UseJumpPower =
			true

		humanoid.JumpPower =
			math.clamp(
				S.JumpPower,
				0,
				1000
			)

	else

		humanoid.UseJumpPower =
			OriginalUseJumpPower

		humanoid.JumpPower =
			OriginalJumpPower

	end

end

--==================================================
-- NOCLIP
--==================================================

local NoclipConnection =
	nil

local function SetNoclip(
	state
)

	local character =
		GetCharacter()

	if not character then
		return
	end

	for _, object in ipairs(
		character:GetDescendants()
	) do

		if object:IsA(
			"BasePart"
		) then

			object.CanCollide =
				not state

		end

	end

end

local function StartNoclip()

	if NoclipConnection then
		return
	end

	NoclipConnection =
		RunService.Stepped:Connect(
			function()

				if not S.Noclip then

					SetNoclip(
						false
					)

					return

				end

				SetNoclip(
					true
				)

			end
		)

end

local function StopNoclip()

	if NoclipConnection then

		NoclipConnection:Disconnect()

		NoclipConnection =
			nil

	end

	SetNoclip(
		false
	)

end

local function UpdateNoclip()

	if S.Noclip then

		StartNoclip()

	else

		StopNoclip()

	end

end

--==================================================
-- CAMERA FOV
--==================================================

local function UpdateCameraFOV()

	Camera =
		workspace.CurrentCamera

	if not Camera then
		return
	end

	if S.FOVChanger then

		Camera.FieldOfView =
			math.clamp(
				S.FOV,
				40,
				120
			)

	else

		Camera.FieldOfView =
			OriginalCameraFOV

	end

end

--==================================================
-- CHARACTER RESPAWN
--==================================================

Player.CharacterAdded:Connect(
	function(character)

		task.wait(
			0.5
		)

		local humanoid =
			character:
				FindFirstChildOfClass(
					"Humanoid"
				)

		if humanoid then

			OriginalWalkSpeed =
				humanoid.WalkSpeed

			OriginalJumpPower =
				humanoid.JumpPower

			OriginalUseJumpPower =
				humanoid.UseJumpPower

		end

		UpdateSpeed()
		UpdateJump()
		UpdateNoclip()

	end
)

--==================================================
-- MOVEMENT LOOP
--==================================================

local MovementTimer =
	0

RunService.Heartbeat:Connect(
	function(deltaTime)

		MovementTimer +=
			deltaTime

		if MovementTimer <
			0.05 then

			return

		end

		MovementTimer =
			0

		UpdateSpeed()
		UpdateJump()
		UpdateNoclip()

	end
)

--==================================================
-- CAMERA LOOP
--==================================================

RunService.RenderStepped:Connect(
	function()

		UpdateCameraFOV()

	end
)

--==================================================
-- INITIAL STATE
--==================================================

UpdateSpeed()
UpdateJump()
UpdateNoclip()
UpdateCameraFOV()

--==================================================
-- END PART 5/7
--==================================================

--==================================================
--                 RUSTED v3.2
--                  PART 6/7
--              MISC SYSTEM
--==================================================

--==================================================
-- FULLBRIGHT
--==================================================

local OriginalLighting = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogEnd = Lighting.FogEnd,
	GlobalShadows = Lighting.GlobalShadows,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
}

local function UpdateFullbright()

	if S.Fullbright then

		Lighting.Brightness =
			2

		Lighting.ClockTime =
			14

		Lighting.FogEnd =
			100000

		Lighting.GlobalShadows =
			false

		Lighting.Ambient =
			Color3.new(
				1,
				1,
				1
			)

		Lighting.OutdoorAmbient =
			Color3.new(
				1,
				1,
				1
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


--==================================================
-- NEON GUN
--==================================================

local NeonParts = {}

local function GetEquippedTool()

	local character =
		GetCharacter()

	if not character then
		return nil
	end

	for _, object in ipairs(
		character:GetChildren()
	) do

		if object:IsA("Tool") then
			return object
		end

	end

	return nil

end


local function SaveNeonPart(
	part
)

	if NeonParts[part] then
		return
	end

	NeonParts[part] = {
		Material = part.Material,
		Color = part.Color,
		Reflectance = part.Reflectance,
	}

end


local function ApplyNeonToTool(
	tool
)

	if not tool then
		return
	end

	for _, object in ipairs(
		tool:GetDescendants()
	) do

		if object:IsA(
			"BasePart"
		) then

			SaveNeonPart(
				object
			)

			object.Material =
				Enum.Material.Neon

			object.Color =
				COLORS.PURPLE

			object.Reflectance =
				0.05

		end

	end

end


local function RestoreNeon()

	for part, data in pairs(
		NeonParts
	) do

		if part and
			part.Parent then

			part.Material =
				data.Material

			part.Color =
				data.Color

			part.Reflectance =
				data.Reflectance

		end

	end

	table.clear(
		NeonParts
	)

end


local LastNeonTool =
	nil


local function UpdateNeonGun()

	if not S.NeonGuns then

		RestoreNeon()

		LastNeonTool =
			nil

		return

	end

	local tool =
		GetEquippedTool()

	if tool ~= LastNeonTool then

		RestoreNeon()

		LastNeonTool =
			tool

	end

	if tool then

		ApplyNeonToTool(
			tool
		)

	end

end


--==================================================
-- CUSTOM HANDS
--==================================================

local HandsModel =
	nil

local OriginalHandsPivot =
	nil

local function FindHandsModel()

	local camera =
		workspace.CurrentCamera

	if not camera then
		return nil
	end

	local preferredNames = {
		"ViewModel",
		"Viewmodel",
		"Arms",
		"Hands",
		"Hand",
	}

	for _, name in ipairs(
		preferredNames
	) do

		local object =
			camera:FindFirstChild(
				name,
				true
			)

		if object and
			object:IsA("Model") then

			return object

		end

	end

	for _, object in ipairs(
		camera:GetChildren()
	) do

		if object:IsA("Model") then

			if object:FindFirstChildWhichIsA(
				"Humanoid"
			) == nil then

				local hasPart =
					object:FindFirstChildWhichIsA(
						"BasePart",
						true
					)

				if hasPart then
					return object
				end

			end

		end

	end

	return nil

end


local function ResetHands()

	if HandsModel and
		HandsModel.Parent and
		OriginalHandsPivot then

		HandsModel:PivotTo(
			OriginalHandsPivot
		)

	end

	HandsModel =
		nil

	OriginalHandsPivot =
		nil

end


local function UpdateCustomHands()

	if not S.CustomHands then

		ResetHands()

		return

	end

	local model =
		FindHandsModel()

	if not model then
		return
	end

	if model ~= HandsModel then

		ResetHands()

		HandsModel =
			model

		OriginalHandsPivot =
			model:GetPivot()

	end

	if not OriginalHandsPivot then
		return
	end

	local offset =
		CFrame.new(
			S.HandsX,
			S.HandsY,
			S.HandsZ
		)

	model:PivotTo(
		OriginalHandsPivot *
		offset
	)

end


--==================================================
-- MISC LOOP
--==================================================

local MiscTimer =
	0

RunService.RenderStepped:Connect(
	function(deltaTime)

		MiscTimer +=
			deltaTime

		if MiscTimer <
			0.03 then

			return

		end

		MiscTimer =
			0

		UpdateFullbright()
		UpdateNeonGun()
		UpdateCustomHands()

	end
)


--==================================================
-- TOOL EVENTS
--==================================================

Player.CharacterAdded:Connect(
	function(character)

		task.wait(
			0.5
		)

		LastNeonTool =
			nil

		RestoreNeon()

		HandsModel =
			nil

		OriginalHandsPivot =
			nil

	end
)


--==================================================
-- INITIAL STATE
--==================================================

UpdateFullbright()
UpdateNeonGun()
UpdateCustomHands()


--==================================================
-- END PART 6/7
--==================================================

--==================================================
--                 RUSTED v3.2
--                  PART 7/7
--              FINAL SYSTEM
--==================================================

--==================================================
-- THEME
--==================================================

local function ApplyTheme()

	if not Main or not Main.Parent then
		return
	end

	for _, object in ipairs(
		Main:GetDescendants()
	) do

		if object:IsA("UIStroke") then

			if object:GetAttribute(
				"RustedPurple"
			) then

				object.Color =
					S.MenuColor

			end

		elseif object:IsA("TextButton") then

			if object:GetAttribute(
				"RustedPurple"
			) then

				object.TextColor3 =
					S.MenuColor

			end

		end

	end

end


--==================================================
-- MENU COLOR UPDATE
--==================================================

local function SetMenuColor(
	color
)

	if typeof(color) ~= "Color3" then
		return
	end

	S.MenuColor =
		color

	COLORS.PURPLE =
		color

	ApplyTheme()

end


--==================================================
-- ANIMATION HELPERS
--==================================================

local function AnimateObject(
	object,
	properties,
	duration
)

	if not S.MenuAnimations then
		for property, value in pairs(
			properties
		) do
			object[property] =
				value
		end

		return
	end

	local tween =
		TweenService:Create(
			object,
			TweenInfo.new(
				duration or 0.15,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			),
			properties
		)

	tween:Play()

	return tween

end


--==================================================
-- MENU STATE
--==================================================

local MenuEnabled =
	true


local function SetMenuEnabled(
	state
)

	MenuEnabled =
		state

	if not Main then
		return
	end

	Main.Visible =
		state

end


--==================================================
-- SAFE CLEANUP
--==================================================

local Connections = {}


local function AddConnection(
	connection
)

	if connection then
		table.insert(
			Connections,
			connection
		)

	end

end


local function Cleanup()

	for _, connection in ipairs(
		Connections
	) do

		pcall(
			function()
				connection:Disconnect()
			end
		)

	end

	table.clear(
		Connections
	)

	StopNoclip()
	RestoreNeon()

	-- Restore camera

	if Camera then

		Camera.FieldOfView =
			OriginalCameraFOV

	end

	-- Restore lighting

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

	-- Restore character

	local humanoid =
		GetHumanoid()

	if humanoid then

		humanoid.WalkSpeed =
			OriginalWalkSpeed

		humanoid.UseJumpPower =
			OriginalUseJumpPower

		humanoid.JumpPower =
			OriginalJumpPower

	end

end


--==================================================
-- CLOSE BUTTON
--==================================================

if Close then

	Close.MouseButton1Click:Connect(
		function()

			Cleanup()

			if Gui then
				Gui.Enabled =
					false
			end

		end
	)

end


--==================================================
-- RIGHT SHIFT MENU TOGGLE
--==================================================

AddConnection(
	UIS.InputBegan:Connect(
		function(
			input,
			gameProcessed
		)

			if gameProcessed then
				return
			end

			if input.KeyCode ==
				Enum.KeyCode.RightShift then

				if Gui then

					Gui.Enabled =
						not Gui.Enabled

				end

			end

		end
	)
)


--==================================================
-- CHARACTER SAFETY
--==================================================

AddConnection(
	Player.CharacterAdded:Connect(
		function()

			task.wait(
				1
			)

			if S.SpeedHack then
				UpdateSpeed()
			end

			if S.Jump then
				UpdateJump()
			end

			if S.Noclip then
				UpdateNoclip()
			end

			if S.CustomHands then
				UpdateCustomHands()
			end

		end
	)
)


--==================================================
-- CAMERA SAFETY
--==================================================

AddConnection(
	workspace:GetPropertyChangedSignal(
		"CurrentCamera"
	):Connect(
		function()

			Camera =
				workspace.CurrentCamera

			if Camera and
				not S.FOVChanger then

				Camera.FieldOfView =
					OriginalCameraFOV

			end

		end
	)
)


--==================================================
-- APPLY INITIAL THEME
--==================================================

ApplyTheme()


--==================================================
-- FINAL GUI SETTINGS
--==================================================

if Gui then

	Gui.ResetOnSpawn =
		false

	Gui.IgnoreGuiInset =
		true

	DisplayOrder =
		100

end


--==================================================
-- FINAL MENU STATE
--==================================================

if Main then

	Main.Visible =
		true

	Main.ClipsDescendants =
		true

end


--==================================================
-- FINAL CONFIG
--==================================================

S.MenuAnimations =
	true

S.AimAssist =
	false

S.ESP =
	false

S.BoxESP =
	false

S.Names =
	false

S.Health =
	false

S.Distance =
	false

S.Snapline =
	false

S.SpeedHack =
	false

S.Jump =
	false

S.Noclip =
	false

S.Fullbright =
	false

S.NeonGuns =
	false

S.CustomHands =
	false


--==================================================
-- RUSTED v3.2 READY
--==================================================

print(
	"RUSTED v3.2 loaded successfully"
)

--==================================================
-- END PART 7/7
--==================================================
