--==================================================
--              RUSTED v3.1 PART 1/4
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Удаляем старую версию
pcall(function()
	local old = PlayerGui:FindFirstChild("RustedV31")
	if old then
		old:Destroy()
	end
end)

--==================================================
-- CONFIG
--==================================================

local S = {
	ESP = false,
	Names = false,
	Health = false,
	Distance = false,

	SilentAim = false,
	TeamCheck = true,
	ShowFOV = false,
	Snapline = false,
	FOVRadius = 150,

	FOVChanger = false,
	FOV = 90,

	SpeedHack = false,
	Speed = 16,

	Noclip = false,

	Jump = false,
	JumpPower = 50,

	Fullbright = false,
	NeonGuns = false,

	MenuColor = Color3.fromRGB(145,70,255)
}

local COLORS = {
	BG = Color3.fromRGB(7,5,14),
	PANEL = Color3.fromRGB(12,9,22),
	ROW = Color3.fromRGB(20,15,34),
	HOVER = Color3.fromRGB(34,23,55),

	TEXT = Color3.fromRGB(245,242,255),
	SUB = Color3.fromRGB(145,137,165),
	DARK = Color3.fromRGB(80,70,100),

	PURPLE = Color3.fromRGB(145,70,255),
	WHITE = Color3.fromRGB(255,255,255),
	RED = Color3.fromRGB(255,65,85),
	GREEN = Color3.fromRGB(65,220,125),
	BLUE = Color3.fromRGB(70,135,255)
}

--==================================================
-- HELPERS
--==================================================

local function New(class, props, parent)
	local obj = Instance.new(class)

	for property, value in pairs(props or {}) do
		obj[property] = value
	end

	obj.Parent = parent
	return obj
end

local function Corner(obj, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 8)
	corner.Parent = obj
	return corner
end

local function Stroke(obj, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")

	stroke.Color = color or COLORS.PURPLE
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0

	stroke.Parent = obj

	return stroke
end

local function Tween(obj, time, style, direction, properties)
	local tween = TweenService:Create(
		obj,
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
	local character = GetCharacter()

	if not character then
		return nil
	end

	return character:FindFirstChildOfClass("Humanoid")
end

--==================================================
-- SCREEN GUI
--==================================================

local Gui = New("ScreenGui", {
	Name = "RustedV31",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

--==================================================
-- MAIN WINDOW
--==================================================

local Main = New("Frame", {
	Name = "Main",

	AnchorPoint = Vector2.new(.5,.5),
	Position = UDim2.fromScale(.5,.5),

	Size = UDim2.fromOffset(580,350),

	BackgroundColor3 = COLORS.BG,
	BackgroundTransparency = 0,

	BorderSizePixel = 0,

	ClipsDescendants = true,

	ZIndex = 10
}, Gui)

Corner(Main,16)

local MainStroke = Stroke(
	Main,
	COLORS.PURPLE,
	1.5,
	.15
)

--==================================================
-- MOBILE / PC SCALE
--==================================================

local Scale = Instance.new("UIScale")
Scale.Scale = 1
Scale.Parent = Main

local function UpdateScale()

	local camera = workspace.CurrentCamera

	if not camera then
		return
	end

	local width = camera.ViewportSize.X

	if width < 420 then
		Scale.Scale = .62
	elseif width < 600 then
		Scale.Scale = .76
	elseif width < 800 then
		Scale.Scale = .88
	else
		Scale.Scale = 1
	end
end

UpdateScale()

if workspace.CurrentCamera then
	workspace.CurrentCamera:GetPropertyChangedSignal(
		"ViewportSize"
	):Connect(UpdateScale)
end

--==================================================
-- TOP BAR
--==================================================

local Top = New("Frame", {
	Name = "Top",

	Size = UDim2.new(1,0,0,52),

	BackgroundColor3 = COLORS.PANEL,
	BorderSizePixel = 0,

	ZIndex = 11
}, Main)

Corner(Top,16)

-- закрываем нижнюю часть скругления
New("Frame", {
	Size = UDim2.new(1,0,0,14),
	Position = UDim2.new(0,0,1,-14),

	BackgroundColor3 = COLORS.PANEL,
	BorderSizePixel = 0,

	ZIndex = 11
}, Top)

--==================================================
-- LOGO
--==================================================

local LogoBox = New("Frame", {
	Name = "LogoBox",

	Size = UDim2.fromOffset(32,32),
	Position = UDim2.fromOffset(10,10),

	BackgroundColor3 = COLORS.PURPLE,
	BorderSizePixel = 0,

	ZIndex = 14
}, Top)

Corner(LogoBox,9)

local LogoStroke = Stroke(
	LogoBox,
	COLORS.WHITE,
	1,
	.65
)

local Logo = New("TextLabel", {
	Size = UDim2.fromScale(1,1),

	BackgroundTransparency = 1,

	Text = "R",
	TextColor3 = COLORS.WHITE,

	Font = Enum.Font.GothamBlack,
	TextSize = 20,

	ZIndex = 15
}, LogoBox)

--==================================================
-- TITLE
--==================================================

local Title = New("TextLabel", {
	Size = UDim2.fromOffset(180,22),
	Position = UDim2.fromOffset(52,6),

	BackgroundTransparency = 1,

	Text = "RUSTED",
	TextColor3 = COLORS.TEXT,

	Font = Enum.Font.GothamBlack,
	TextSize = 17,

	TextXAlignment = Enum.TextXAlignment.Left,

	ZIndex = 13
}, Top)

local Version = New("TextLabel", {
	Size = UDim2.fromOffset(100,15),
	Position = UDim2.fromOffset(53,28),

	BackgroundTransparency = 1,

	Text = "v3.1",

	TextColor3 = COLORS.SUB,

	Font = Enum.Font.GothamMedium,
	TextSize = 8,

	TextXAlignment = Enum.TextXAlignment.Left,

	ZIndex = 13
}, Top)

--==================================================
-- MINIMIZE
--==================================================

local Minimize = New("TextButton", {
	Name = "Minimize",

	Size = UDim2.fromOffset(30,30),
	Position = UDim2.new(1,-68,0,11),

	BackgroundColor3 = COLORS.ROW,
	BorderSizePixel = 0,

	Text = "—",
	TextColor3 = COLORS.TEXT,

	Font = Enum.Font.GothamBold,
	TextSize = 15,

	AutoButtonColor = false,

	ZIndex = 16
}, Top)

Corner(Minimize,9)

Stroke(
	Minimize,
	COLORS.PURPLE,
	1,
	.45
)

--==================================================
-- CLOSE
--==================================================

local Close = New("TextButton", {
	Name = "Close",

	Size = UDim2.fromOffset(30,30),
	Position = UDim2.new(1,-34,0,11),

	BackgroundColor3 = COLORS.ROW,
	BorderSizePixel = 0,

	Text = "×",
	TextColor3 = COLORS.TEXT,

	Font = Enum.Font.GothamBold,
	TextSize = 17,

	AutoButtonColor = false,

	ZIndex = 16
}, Top)

Corner(Close,9)

Stroke(
	Close,
	COLORS.PURPLE,
	1,
	.45
)

--==================================================
-- BODY
--==================================================

local Body = New("Frame", {
	Name = "Body",

	Size = UDim2.new(1,0,1,-52),
	Position = UDim2.fromOffset(0,52),

	BackgroundColor3 = COLORS.BG,
	BorderSizePixel = 0,

	ZIndex = 10
}, Main)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = New("Frame", {
	Name = "Sidebar",

	Size = UDim2.new(0,125,1,0),

	BackgroundColor3 = COLORS.PANEL,
	BorderSizePixel = 0,

	ZIndex = 11
}, Body)

local MenuLabel = New("TextLabel", {
	Size = UDim2.new(1,-20,0,18),
	Position = UDim2.fromOffset(10,10),

	BackgroundTransparency = 1,

	Text = "MENU",

	TextColor3 = COLORS.DARK,

	Font = Enum.Font.GothamBold,
	TextSize = 8,

	TextXAlignment = Enum.TextXAlignment.Left,

	ZIndex = 12
}, Sidebar)

--==================================================
-- NAV
--==================================================

local Nav = New("Frame", {
	Name = "Nav",

	Size = UDim2.new(1,-12,1,-38),
	Position = UDim2.fromOffset(6,34),

	BackgroundTransparency = 1,

	ZIndex = 12
}, Sidebar)

New("UIListLayout", {
	Padding = UDim.new(0,4),
	SortOrder = Enum.SortOrder.LayoutOrder
}, Nav)

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {
	Name = "Content",

	Size = UDim2.new(1,-125,1,0),
	Position = UDim2.fromOffset(125,0),

	BackgroundColor3 = COLORS.BG,
	BorderSizePixel = 0,

	ClipsDescendants = true,

	ZIndex = 11
}, Body)

--==================================================
-- HEADER
--==================================================

local Header = New("Frame", {
	Size = UDim2.new(1,-24,0,48),
	Position = UDim2.fromOffset(12,0),

	BackgroundTransparency = 1,

	ZIndex = 12
}, Content)

local PageTitle = New("TextLabel", {
	Size = UDim2.new(1,0,0,22),
	Position = UDim2.fromOffset(0,7),

	BackgroundTransparency = 1,

	Text = "Visual",

	TextColor3 = COLORS.TEXT,

	Font = Enum.Font.GothamBlack,
	TextSize = 16,

	TextXAlignment = Enum.TextXAlignment.Left,

	ZIndex = 13
}, Header)

local PageDesc = New("TextLabel", {
	Size = UDim2.new(1,0,0,14),
	Position = UDim2.fromOffset(0,29),

	BackgroundTransparency = 1,

	Text = "Player visuals and camera",

	TextColor3 = COLORS.SUB,

	Font = Enum.Font.Gotham,
	TextSize = 8,

	TextXAlignment = Enum.TextXAlignment.Left,

	ZIndex = 13
}, Header)

--==================================================
-- PAGES
--==================================================

local Pages = {}

local function MakePage(name)

	local page = New("ScrollingFrame", {
		Name = name,

		Size = UDim2.new(1,-24,1,-54),
		Position = UDim2.fromOffset(12,50),

		BackgroundTransparency = 1,
		BorderSizePixel = 0,

		ScrollBarThickness = 2,
		ScrollBarImageColor3 = COLORS.PURPLE,

		CanvasSize = UDim2.new(0,0,0,0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,

		Visible = false,

		ZIndex = 12
	}, Content)

	New("UIListLayout", {
		Padding = UDim.new(0,5),
		SortOrder = Enum.SortOrder.LayoutOrder
	}, page)

	New("UIPadding", {
		PaddingBottom = UDim.new(0,8)
	}, page)

	Pages[name] = page

	return page
end

local VisualPage = MakePage("Visual")
local CombatPage = MakePage("Combat")
local MovementPage = MakePage("Movement")
local MiscPage = MakePage("Misc")
local SettingsPage = MakePage("Settings")

--==================================================
-- NAV BUTTON
--==================================================

local NavButtons = {}

local function CreateNavButton(name, icon, order)

	local button = New("TextButton", {
		Size = UDim2.new(1,0,0,32),

		BackgroundColor3 = COLORS.PANEL,
		BorderSizePixel = 0,

		Text = "",
		AutoButtonColor = false,

		LayoutOrder = order,

		ZIndex = 13
	}, Nav)

	Corner(button,8)

	local accent = New("Frame", {
		Size = UDim2.new(0,3,0,18),
		Position = UDim2.new(0,0,.5,-9),

		BackgroundColor3 = COLORS.PURPLE,
		BorderSizePixel = 0,

		Visible = false,

		ZIndex = 15
	}, button)

	Corner(accent,3)

	local iconLabel = New("TextLabel", {
		Size = UDim2.fromOffset(25,32),
		Position = UDim2.fromOffset(7,0),

		BackgroundTransparency = 1,

		Text = icon,
		TextColor3 = COLORS.SUB,

		Font = Enum.Font.GothamBold,
		TextSize = 11,

		ZIndex = 14
	}, button)

	local textLabel = New("TextLabel", {
		Size = UDim2.new(1,-38,1,0),
		Position = UDim2.fromOffset(34,0),

		BackgroundTransparency = 1,

		Text = name,
		TextColor3 = COLORS.SUB,

		Font = Enum.Font.GothamMedium,
		TextSize = 9,

		TextXAlignment = Enum.TextXAlignment.Left,

		ZIndex = 14
	}, button)

	NavButtons[name] = {
		Button = button,
		Accent = accent,
		Icon = iconLabel,
		Text = textLabel
	}

	button.MouseEnter:Connect(function()

		if button:GetAttribute("Selected") then
			return
		end

		Tween(button,.12,Enum.EasingStyle.Quart,nil,{
			BackgroundColor3 = COLORS.HOVER
		})

	end)

	button.MouseLeave:Connect(function()

		if button:GetAttribute("Selected") then
			return
		end

		Tween(button,.12,Enum.EasingStyle.Quart,nil,{
			BackgroundColor3 = COLORS.PANEL
		})

	end)

	return button
end

CreateNavButton("Visual","◈",1)
CreateNavButton("Combat","⌁",2)
CreateNavButton("Movement","↗",3)
CreateNavButton("Misc","◆",4)
CreateNavButton("Settings","⚙",5)

--==================================================
-- PAGE SWITCHING
--==================================================

local Descriptions = {
	Visual = "Player visuals and camera",
	Combat = "Targeting and combat",
	Movement = "Movement controls",
	Misc = "Extra gameplay options",
	Settings = "Rusted configuration"
}

local CurrentPage

local function SwitchPage(name)

	local page = Pages[name]

	if not page then
		return
	end

	CurrentPage = name

	for pageName, pageObject in pairs(Pages) do
		pageObject.Visible = pageName == name
	end

	for buttonName, data in pairs(NavButtons) do

		local selected = buttonName == name

		data.Button:SetAttribute("Selected",selected)
		data.Accent.Visible = selected

		if selected then

			Tween(data.Button,.16,Enum.EasingStyle.Back,nil,{
				BackgroundColor3 = COLORS.HOVER
			})

			data.Icon.TextColor3 = COLORS.PURPLE
			data.Text.TextColor3 = COLORS.TEXT

		else

			Tween(data.Button,.12,Enum.EasingStyle.Quart,nil,{
				BackgroundColor3 = COLORS.PANEL
			})

			data.Icon.TextColor3 = COLORS.SUB
			data.Text.TextColor3 = COLORS.SUB

		end

	end

	PageTitle.Text = name
	PageDesc.Text = Descriptions[name] or ""

	PageTitle.Position = UDim2.fromOffset(-10,7)
	PageTitle.TextTransparency = 1

	Tween(PageTitle,.25,Enum.EasingStyle.Back,nil,{
		Position = UDim2.fromOffset(0,7),
		TextTransparency = 0
	})

end

for name,data in pairs(NavButtons) do

	data.Button.Activated:Connect(function()
		SwitchPage(name)
	end)

end

--==================================================
-- FLOATING LOGO
-- ONLY LOGO WHEN MINIMIZED
--==================================================

local Float = New("TextButton", {
	Name = "RustedLogo",

	AnchorPoint = Vector2.new(.5,.5),

	Position = UDim2.new(0,42,.5,0),

	Size = UDim2.fromOffset(46,46),

	BackgroundColor3 = COLORS.BG,
	BorderSizePixel = 0,

	Text = "R",

	TextColor3 = COLORS.WHITE,

	Font = Enum.Font.GothamBlack,
	TextSize = 21,

	AutoButtonColor = false,

	Visible = false,

	ZIndex = 100
}, Gui)

Corner(Float,14)

local FloatStroke = Stroke(
	Float,
	COLORS.PURPLE,
	2,
	.05
)

--==================================================
-- DRAG SYSTEM
--==================================================

local function MakeDraggable(handle, object)

	local dragging = false
	local dragStart
	local startPosition

	handle.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true

			dragStart = input.Position
			startPosition = object.Position

		end

	end)

	UIS.InputChanged:Connect(function(input)

		if not dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

			local delta = input.Position - dragStart

			object.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,

				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)

		end

	end)

	UIS.InputEnded:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

			dragging = false

		end

	end)

end

MakeDraggable(Top,Main)
MakeDraggable(Float,Float)

--==================================================
-- OPEN / CLOSE STATE
--==================================================

local Open = true

--==================================================
-- OPEN MENU
--==================================================

local function OpenMenu()

	if Open then
		return
	end

	Open = true

	Float.Visible = false
	Main.Visible = true

	Main.Size = UDim2.fromOffset(35,35)
	Main.Rotation = -15
	Main.BackgroundTransparency = 1

	Tween(
		Main,
		.5,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out,
		{
			Size = UDim2.fromOffset(580,350),
			Rotation = 0,
			BackgroundTransparency = 0
		}
	)

	LogoBox.Size = UDim2.fromOffset(4,4)
	LogoBox.Rotation = -90

	Tween(
		LogoBox,
		.55,
		Enum.EasingStyle.Elastic,
		Enum.EasingDirection.Out,
		{
			Size = UDim2.fromOffset(32,32),
			Rotation = 0
		}
	)

end

--==================================================
-- MINIMIZE
--==================================================

local function MinimizeMenu()

	if not Open then
		return
	end

	Open = false

	Tween(
		Main,
		.3,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.In,
		{
			Size = UDim2.fromOffset(35,35),
			Rotation = 18,
			BackgroundTransparency = 1
		}
	)

	task.delay(.25,function()

		if Open then
			return
		end

		Main.Visible = false

		Float.Visible = true

		Float.Size = UDim2.fromOffset(4,4)
		Float.Rotation = -90

		Tween(
			Float,
			.55,
			Enum.EasingStyle.Elastic,
			Enum.EasingDirection.Out,
			{
				Size = UDim2.fromOffset(46,46),
				Rotation = 0
			}
		)

	end)

end

--==================================================
-- BUTTON CONNECTIONS
--==================================================

Minimize.Activated:Connect(MinimizeMenu)

Float.Activated:Connect(OpenMenu)

Close.Activated:Connect(function()

	Open = false

	Tween(
		Main,
		.35,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.In,
		{
			Size = UDim2.fromOffset(20,20),
			Rotation = 25,
			BackgroundTransparency = 1
		}
	)

	task.delay(.35,function()

		if Gui then
			Gui:Destroy()
		end

	end)

end)

--==================================================
-- CRAZY BUTTON ANIMATION
--==================================================

local function ButtonHover(button, normalSize, hoverSize)

	button.MouseEnter:Connect(function()

		Tween(
			button,
			.15,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out,
			{
				Size = hoverSize,
				Rotation = -2
			}
		)

	end)

	button.MouseLeave:Connect(function()

		Tween(
			button,
			.15,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out,
			{
				Size = normalSize,
				Rotation = 0
			}
		)

	end)

end

ButtonHover(
	Minimize,
	UDim2.fromOffset(30,30),
	UDim2.fromOffset(33,33)
)

ButtonHover(
	Close,
	UDim2.fromOffset(30,30),
	UDim2.fromOffset(33,33)
)

ButtonHover(
	Float,
	UDim2.fromOffset(46,46),
	UDim2.fromOffset(52,52)
)

--==================================================
-- INITIAL ANIMATION
--==================================================

SwitchPage("Visual")

Main.BackgroundTransparency = 1
Main.Size = UDim2.fromOffset(25,25)
Main.Rotation = -12

task.delay(.05,function()

	Tween(
		Main,
		.6,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out,
		{
			Size = UDim2.fromOffset(580,350),
			Rotation = 0,
			BackgroundTransparency = 0
		}
	)

	Tween(
		LogoBox,
		.65,
		Enum.EasingStyle.Elastic,
		Enum.EasingDirection.Out,
		{
			Rotation = 360
		}
	)

end)

print("RUSTED v3.1 | PART 1/4")

--==================================================
--              RUSTED v3.1 PART 2/4
--              VISUAL + ESP
--==================================================

--==================================================
-- VISUAL HELPERS
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

	if data.Connection then
		data.Connection:Disconnect()
	end

	ESPObjects[player] = nil
end

local function IsEnemy(player)

	if player == Player then
		return false
	end

	if not S.TeamCheck then
		return true
	end

	if Player.Team and player.Team then
		return Player.Team ~= player.Team
	end

	return true
end

--==================================================
-- CREATE ESP
--==================================================

local function CreateESP(player)

	if player == Player then
		return
	end

	if not IsEnemy(player) then
		RemoveESP(player)
		return
	end

	local character = player.Character

	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")

	if not humanoid or not root then
		return
	end

	RemoveESP(player)

	local data = {}
	ESPObjects[player] = data

	--================================================
	-- HIGHLIGHT
	--================================================

	if S.ESP then

		local highlight = Instance.new("Highlight")

		highlight.Name = "RustedESP"
		highlight.Adornee = character

		highlight.FillColor = COLORS.PURPLE
		highlight.OutlineColor = COLORS.WHITE

		highlight.FillTransparency = .72
		highlight.OutlineTransparency = .05

		highlight.DepthMode =
			Enum.HighlightDepthMode.AlwaysOnTop

		highlight.Parent = character

		data.Highlight = highlight

	end

	--================================================
	-- BILLBOARD
	--================================================

	if S.Names or S.Health or S.Distance then

		local billboard = Instance.new("BillboardGui")

		billboard.Name = "RustedESPInfo"

		billboard.Adornee = root

		billboard.Size = UDim2.fromOffset(170,55)

		billboard.StudsOffset = Vector3.new(0,3.2,0)

		billboard.AlwaysOnTop = true

		billboard.MaxDistance = 250

		billboard.Parent = root

		Corner(billboard,6)

		local text = Instance.new("TextLabel")

		text.Name = "Info"

		text.Size = UDim2.fromScale(1,1)

		text.BackgroundTransparency = 1

		text.TextColor3 = COLORS.WHITE

		text.TextStrokeTransparency = .35

		text.Font = Enum.Font.GothamBold

		text.TextSize = 11

		text.TextWrapped = true

		text.Parent = billboard

		data.Billboard = billboard
		data.Text = text

		local function UpdateText()

			if not billboard.Parent then
				return
			end

			local lines = {}

			if S.Names then
				table.insert(lines,player.DisplayName)
			end

			if S.Health then
				table.insert(
					lines,
					"HP: "..math.floor(
						math.max(0,humanoid.Health)
					).."/"..math.floor(humanoid.MaxHealth)
				)
			end

			if S.Distance then

				local myCharacter = Player.Character
				local myRoot =
					myCharacter and
					myCharacter:FindFirstChild(
						"HumanoidRootPart"
					)

				if myRoot then

					local distance = math.floor(
						(myRoot.Position-root.Position).Magnitude
					)

					table.insert(
						lines,
						distance.."m"
					)

				end

			end

			text.Text = table.concat(lines,"\n")

		end

		data.Update = UpdateText

		UpdateText()

		data.Connection =
			RunService.RenderStepped:Connect(
				function()

					if not character.Parent then
						RemoveESP(player)
						return
					end

					UpdateText()

				end
			)

	end

end

--==================================================
-- REFRESH ESP
--==================================================

local function RefreshESP()

	for player in pairs(ESPObjects) do
		RemoveESP(player)
	end

	for _,player in ipairs(Players:GetPlayers()) do

		if player ~= Player then

			task.spawn(function()
				CreateESP(player)
			end)

		end

	end

end

--==================================================
-- VISUAL PAGE HELPERS
--==================================================

local function AddSection(parent,text)

	local label = New("TextLabel",{

		Size = UDim2.new(1,0,0,20),

		BackgroundTransparency = 1,

		Text = text,

		TextColor3 = COLORS.DARK,

		Font = Enum.Font.GothamBold,
		TextSize = 8,

		TextXAlignment = Enum.TextXAlignment.Left,

		ZIndex = 13

	},parent)

	return label
end

local function AddToggle(parent,title,description,key,callback)

	local row = New("TextButton",{

		Size = UDim2.new(1,0,0,46),

		BackgroundColor3 = COLORS.ROW,

		BorderSizePixel = 0,

		Text = "",

		AutoButtonColor = false,

		ZIndex = 13

	},parent)

	Corner(row,9)

	local titleLabel = New("TextLabel",{

		Size = UDim2.new(1,-70,0,19),

		Position = UDim2.fromOffset(11,4),

		BackgroundTransparency = 1,

		Text = title,

		TextColor3 = COLORS.TEXT,

		Font = Enum.Font.GothamBold,

		TextSize = 10,

		TextXAlignment = Enum.TextXAlignment.Left,

		ZIndex = 14

	},row)

	local descLabel = New("TextLabel",{

		Size = UDim2.new(1,-70,0,14),

		Position = UDim2.fromOffset(11,24),

		BackgroundTransparency = 1,

		Text = description or "",

		TextColor3 = COLORS.SUB,

		Font = Enum.Font.Gotham,

		TextSize = 7,

		TextXAlignment = Enum.TextXAlignment.Left,

		ZIndex = 14

	},row)

	local toggle = New("Frame",{

		Size = UDim2.fromOffset(36,19),

		Position = UDim2.new(1,-48,.5,-9),

		BackgroundColor3 = COLORS.DARK,

		BorderSizePixel = 0,

		ZIndex = 14

	},row)

	Corner(toggle,10)

	local knob = New("Frame",{

		Size = UDim2.fromOffset(13,13),

		Position = UDim2.fromOffset(3,3),

		BackgroundColor3 = COLORS.WHITE,

		BorderSizePixel = 0,

		ZIndex = 15

	},toggle)

	Corner(knob,7)

	local function Update(value)

		S[key] = value

		if value then

			Tween(toggle,.16,Enum.EasingStyle.Quart,nil,{
				BackgroundColor3 = COLORS.PURPLE
			})

			Tween(knob,.2,Enum.EasingStyle.Back,nil,{
				Position = UDim2.new(1,-16,.5,-6)
			})

		else

			Tween(toggle,.16,Enum.EasingStyle.Quart,nil,{
				BackgroundColor3 = COLORS.DARK
			})

			Tween(knob,.16,Enum.EasingStyle.Quart,nil,{
				Position = UDim2.fromOffset(3,3)
			})

		end

		if callback then
			task.spawn(callback,value)
		end

	end

	row.Activated:Connect(function()
		Update(not S[key])
	end)

	row.MouseEnter:Connect(function()

		Tween(row,.1,Enum.EasingStyle.Quart,nil,{
			BackgroundColor3 = COLORS.HOVER
		})

	end)

	row.MouseLeave:Connect(function()

		Tween(row,.1,Enum.EasingStyle.Quart,nil,{
			BackgroundColor3 = COLORS.ROW
		})

	end)

	Update(S[key])

	return row
end

--==================================================
-- VISUAL PAGE
--==================================================

AddSection(
	VisualPage,
	"PLAYER ESP"
)

AddToggle(
	VisualPage,
	"ESP",
	"Highlight enemy players",
	"ESP",
	function()
		RefreshESP()
	end
)

AddToggle(
	VisualPage,
	"Names",
	"Show player names",
	"Names",
	function()
		RefreshESP()
	end
)

AddToggle(
	VisualPage,
	"Health",
	"Show player health",
	"Health",
	function()
		RefreshESP()
	end
)

AddToggle(
	VisualPage,
	"Distance",
	"Show distance to players",
	"Distance",
	function()
		RefreshESP()
	end
)

AddSection(
	VisualPage,
	"ESP OPTIONS"
)

AddToggle(
	VisualPage,
	"Team Check",
	"Ignore players on your team",
	"TeamCheck",
	function()
		RefreshESP()
	end
)

--==================================================
-- PLAYER EVENTS
--==================================================

Players.PlayerAdded:Connect(function(player)

	player.CharacterAdded:Connect(function()

		task.wait(.5)

		if S.ESP or S.Names or S.Health or S.Distance then
			CreateESP(player)
		end

	end)

end)

Players.PlayerRemoving:Connect(function(player)
	RemoveESP(player)
end)

for _,player in ipairs(Players:GetPlayers()) do

	if player ~= Player then

		player.CharacterAdded:Connect(function()

			task.wait(.5)

			if S.ESP
				or S.Names
				or S.Health
				or S.Distance then

				CreateESP(player)

			end

		end)

	end

end

--==================================================
-- COMBAT PAGE
--==================================================

AddSection(
	CombatPage,
	"TARGETING"
)

AddToggle(
	CombatPage,
	"Silent Aim",
	"Target selection interface",
	"SilentAim",
	function(enabled)

		-- Actual weapon firing hook depends
		-- on Rusted's weapon/remotes.
		-- No fake RemoteEvent is created here.

		if enabled then
			print("RUSTED | Silent Aim enabled")
		else
			print("RUSTED | Silent Aim disabled")
		end

	end
)

AddToggle(
	CombatPage,
	"Team Check",
	"Ignore teammates",
	"TeamCheck",
	function()
		RefreshESP()
	end
)

AddToggle(
	CombatPage,
	"Show FOV",
	"Display targeting field of view",
	"ShowFOV",
	function()
	end
)

AddToggle(
	CombatPage,
	"Snapline",
	"Show target direction lines",
	"Snapline",
	function()
	end
)

--==================================================
-- FOV CIRCLE
--==================================================

local FOVCircle = New("Frame",{

	Name = "FOVCircle",

	AnchorPoint = Vector2.new(.5,.5),

	Position = UDim2.fromScale(.5,.5),

	Size = UDim2.fromOffset(
		S.FOVRadius*2,
		S.FOVRadius*2
	),

	BackgroundTransparency = 1,

	BorderSizePixel = 0,

	Visible = false,

	ZIndex = 5

},Gui)

Corner(FOVCircle,S.FOVRadius)

local FOVStroke = Stroke(
	FOVCircle,
	COLORS.PURPLE,
	1.5,
	.15
)

--==================================================
-- FOV UPDATE
--==================================================

RunService.RenderStepped:Connect(function()

	if not FOVCircle.Parent then
		return
	end

	FOVCircle.Visible = S.ShowFOV

	FOVCircle.Size = UDim2.fromOffset(
		S.FOVRadius*2,
		S.FOVRadius*2
	)

	local camera = workspace.CurrentCamera

	if camera then

		FOVCircle.Position = UDim2.fromOffset(
			camera.ViewportSize.X/2,
			camera.ViewportSize.Y/2
		)

	end

end)

--==================================================
-- FOV SLIDER
--==================================================

local function AddFOVSlider()

	local row = New("Frame",{

		Size = UDim2.new(1,0,0,60),

		BackgroundColor3 = COLORS.ROW,

		BorderSizePixel = 0,

		ZIndex = 13

	},CombatPage)

	Corner(row,9)

	New("TextLabel",{

		Size = UDim2.new(1,-60,0,18),

		Position = UDim2.fromOffset(11,5),

		BackgroundTransparency = 1,

		Text = "FOV Radius",

		TextColor3 = COLORS.TEXT,

		Font = Enum.Font.GothamBold,

		TextSize = 10,

		TextXAlignment = Enum.TextXAlignment.Left,

		ZIndex = 14

	},row)

	local value = New("TextLabel",{

		Size = UDim2.fromOffset(50,18),

		Position = UDim2.new(1,-61,0,5),

		BackgroundTransparency = 1,

		Text = tostring(S.FOVRadius),

		TextColor3 = COLORS.PURPLE,

		Font = Enum.Font.GothamBold,

		TextSize = 9,

		TextXAlignment = Enum.TextXAlignment.Right,

		ZIndex = 14

	},row)

	local bar = New("Frame",{

		Size = UDim2.new(1,-22,0,5),

		Position = UDim2.fromOffset(11,43),

		BackgroundColor3 = COLORS.DARK,

		BorderSizePixel = 0,

		ZIndex = 14

	},row)

	Corner(bar,3)

	local fill = New("Frame",{

		Size = UDim2.new(
			S.FOVRadius/300,
			0,1,0
		),

		BackgroundColor3 = COLORS.PURPLE,

		BorderSizePixel = 0,

		ZIndex = 15

	},bar)

	Corner(fill,3)

	local dragging = false

	local function SetFOV(input)

		local x = math.clamp(
			input.Position.X -
			bar.AbsolutePosition.X,
			0,
			bar.AbsoluteSize.X
		)

		local alpha = x/bar.AbsoluteSize.X

		S.FOVRadius = math.floor(
			50 + alpha*250
		)

		value.Text = tostring(S.FOVRadius)

		fill.Size = UDim2.new(
			(S.FOVRadius-50)/250,
			0,1,0
		)

	end

	bar.InputBegan:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or input.UserInputType ==
			Enum.UserInputType.Touch then

			dragging = true
			SetFOV(input)

		end

	end)

	UIS.InputChanged:Connect(function(input)

		if dragging and (
			input.UserInputType ==
			Enum.UserInputType.MouseMovement
			or input.UserInputType ==
			Enum.UserInputType.Touch
		) then

			SetFOV(input)

		end

	end)

	UIS.InputEnded:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or input.UserInputType ==
			Enum.UserInputType.Touch then

			dragging = false

		end

	end)

end

AddFOVSlider()

--==================================================
-- INITIAL ESP
--==================================================

task.delay(.5,function()

	if S.ESP
		or S.Names
		or S.Health
		or S.Distance then

		RefreshESP()

	end

end)

print("RUSTED v3.1 | PART 2/4")

--==================================================
--              RUSTED v3.1 PART 3/4
--              MOVEMENT + MISC
--==================================================

--==================================================
-- TOGGLE
--==================================================

local function AddToggle(parent,title,description,key,callback)

	local row = New("TextButton",{
		Size = UDim2.new(1,0,0,46),

		BackgroundColor3 = COLORS.ROW,
		BorderSizePixel = 0,

		Text = "",
		AutoButtonColor = false,

		ZIndex = 13
	},parent)

	Corner(row,9)

	local titleLabel = New("TextLabel",{
		Size = UDim2.new(1,-65,0,19),
		Position = UDim2.fromOffset(11,4),

		BackgroundTransparency = 1,

		Text = title,
		TextColor3 = COLORS.TEXT,

		Font = Enum.Font.GothamBold,
		TextSize = 10,

		TextXAlignment = Enum.TextXAlignment.Left,

		ZIndex = 14
	},row)

	New("TextLabel",{
		Size = UDim2.new(1,-65,0,14),
		Position = UDim2.fromOffset(11,24),

		BackgroundTransparency = 1,

		Text = description or "",
		TextColor3 = COLORS.SUB,

		Font = Enum.Font.Gotham,
		TextSize = 7,

		TextXAlignment = Enum.TextXAlignment.Left,

		ZIndex = 14
	},row)

	local toggle = New("Frame",{
		Size = UDim2.fromOffset(36,19),
		Position = UDim2.new(1,-48,.5,-9),

		BackgroundColor3 = COLORS.DARK,
		BorderSizePixel = 0,

		ZIndex = 14
	},row)

	Corner(toggle,10)

	local knob = New("Frame",{
		Size = UDim2.fromOffset(13,13),
		Position = UDim2.fromOffset(3,3),

		BackgroundColor3 = COLORS.WHITE,
		BorderSizePixel = 0,

		ZIndex = 15
	},toggle)

	Corner(knob,7)

	local function Update(value)

		S[key] = value

		if value then

			Tween(toggle,.16,Enum.EasingStyle.Quart,nil,{
				BackgroundColor3 = COLORS.PURPLE
			})

			Tween(knob,.2,Enum.EasingStyle.Back,nil,{
				Position = UDim2.new(1,-16,.5,-6)
			})

		else

			Tween(toggle,.16,Enum.EasingStyle.Quart,nil,{
				BackgroundColor3 = COLORS.DARK
			})

			Tween(knob,.16,Enum.EasingStyle.Quart,nil,{
				Position = UDim2.fromOffset(3,3)
			})

		end

		if callback then
			task.spawn(callback,value)
		end

	end

	row.Activated:Connect(function()
		Update(not S[key])
	end)

	row.MouseEnter:Connect(function()

		Tween(row,.1,Enum.EasingStyle.Quart,nil,{
			BackgroundColor3 = COLORS.HOVER
		})

	end)

	row.MouseLeave:Connect(function()

		Tween(row,.1,Enum.EasingStyle.Quart,nil,{
			BackgroundColor3 = COLORS.ROW
		})

	end)

	Update(S[key])

	return row
end

--==================================================
-- SLIDER
--==================================================

local function AddSlider(
	parent,
	title,
	description,
	key,
	minValue,
	maxValue,
	callback
)

	local row = New("Frame",{

		Size = UDim2.new(1,0,0,60),

		BackgroundColor3 = COLORS.ROW,
		BorderSizePixel = 0,

		ZIndex = 13

	},parent)

	Corner(row,9)

	New("TextLabel",{

		Size = UDim2.new(1,-70,0,18),
		Position = UDim2.fromOffset(11,5),

		BackgroundTransparency = 1,

		Text = title,
		TextColor3 = COLORS.TEXT,

		Font = Enum.Font.GothamBold,
		TextSize = 10,

		TextXAlignment = Enum.TextXAlignment.Left,

		ZIndex = 14

	},row)

	local valueLabel = New("TextLabel",{

		Size = UDim2.fromOffset(55,18),
		Position = UDim2.new(1,-65,0,5),

		BackgroundTransparency = 1,

		TextColor3 = COLORS.PURPLE,

		Font = Enum.Font.GothamBold,
		TextSize = 9,

		TextXAlignment = Enum.TextXAlignment.Right,

		ZIndex = 14

	},row)

	New("TextLabel",{

		Size = UDim2.new(1,-22,0,14),
		Position = UDim2.fromOffset(11,23),

		BackgroundTransparency = 1,

		Text = description or "",
		TextColor3 = COLORS.SUB,

		Font = Enum.Font.Gotham,
		TextSize = 7,

		TextXAlignment = Enum.TextXAlignment.Left,

		ZIndex = 14

	},row)

	local bar = New("Frame",{

		Size = UDim2.new(1,-22,0,5),
		Position = UDim2.fromOffset(11,44),

		BackgroundColor3 = COLORS.DARK,
		BorderSizePixel = 0,

		ZIndex = 14

	},row)

	Corner(bar,3)

	local fill = New("Frame",{

		Size = UDim2.new(0,0,1,0),

		BackgroundColor3 = COLORS.PURPLE,
		BorderSizePixel = 0,

		ZIndex = 15

	},bar)

	Corner(fill,3)

	local dragging = false

	local function SetValue(value)

		value = math.clamp(
			math.floor(value),
			minValue,
			maxValue
		)

		S[key] = value

		local alpha =
			(value-minValue) /
			(maxValue-minValue)

		valueLabel.Text = tostring(value)

		Tween(fill,.1,Enum.EasingStyle.Quart,nil,{
			Size = UDim2.new(alpha,0,1,0)
		})

		if callback then
			task.spawn(callback,value)
		end

	end

	local function FromInput(input)

		local width = bar.AbsoluteSize.X

		if width <= 0 then
			return
		end

		local x = math.clamp(
			input.Position.X -
			bar.AbsolutePosition.X,
			0,
			width
		)

		local alpha = x/width

		SetValue(
			minValue +
			(maxValue-minValue)*alpha
		)

	end

	bar.InputBegan:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or input.UserInputType ==
			Enum.UserInputType.Touch then

			dragging = true

			FromInput(input)

		end

	end)

	UIS.InputChanged:Connect(function(input)

		if not dragging then
			return
		end

		if input.UserInputType ==
			Enum.UserInputType.MouseMovement
			or input.UserInputType ==
			Enum.UserInputType.Touch then

			FromInput(input)

		end

	end)

	UIS.InputEnded:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or input.UserInputType ==
			Enum.UserInputType.Touch then

			dragging = false

		end

	end)

	SetValue(S[key])

	return row
end

--==================================================
-- MOVEMENT
--==================================================

AddSection(
	MovementPage,
	"MOVEMENT"
)

AddToggle(
	MovementPage,
	"Speed Hack",
	"Change walking speed",
	"SpeedHack",
	function(enabled)

		local humanoid = GetHumanoid()

		if humanoid then

			humanoid.WalkSpeed =
				enabled and S.Speed or 16

		end

	end
)

AddSlider(
	MovementPage,
	"Speed",
	"Walking speed",
	"Speed",
	16,
	100,
	function(value)

		if not S.SpeedHack then
			return
		end

		local humanoid = GetHumanoid()

		if humanoid then
			humanoid.WalkSpeed = value
		end

	end
)

AddToggle(
	MovementPage,
	"Jump Power",
	"Change jump power",
	"Jump",
	function(enabled)

		local humanoid = GetHumanoid()

		if not humanoid then
			return
		end

		if humanoid.UseJumpPower then

			humanoid.JumpPower =
				enabled and S.JumpPower or 50

		else

			humanoid.JumpHeight =
				enabled and 12 or 7.2

		end

	end
)

AddSlider(
	MovementPage,
	"Jump Power",
	"Jump strength",
	"JumpPower",
	50,
	150,
	function(value)

		if not S.Jump then
			return
		end

		local humanoid = GetHumanoid()

		if humanoid and humanoid.UseJumpPower then
			humanoid.JumpPower = value
		end

	end
)

AddToggle(
	MovementPage,
	"Noclip",
	"Walk through objects",
	"Noclip",
	function()
	end
)

--==================================================
-- NOCLIP
--==================================================

RunService.Stepped:Connect(function()

	if not S.Noclip then
		return
	end

	local character = GetCharacter()

	if not character then
		return
	end

	for _,object in ipairs(
		character:GetDescendants()
	) do

		if object:IsA("BasePart") then
			object.CanCollide = false
		end

	end

end)

--==================================================
-- CHARACTER UPDATE
--==================================================

Player.CharacterAdded:Connect(function(character)

	local humanoid =
		character:WaitForChild(
			"Humanoid",
			5
		)

	if not humanoid then
		return
	end

	task.wait(.15)

	if S.SpeedHack then
		humanoid.WalkSpeed = S.Speed
	end

	if S.Jump and humanoid.UseJumpPower then
		humanoid.JumpPower = S.JumpPower
	end

end)

--==================================================
-- MISC
--==================================================

AddSection(
	MiscPage,
	"CAMERA"
)

AddToggle(
	MiscPage,
	"FOV Changer",
	"Change camera field of view",
	"FOVChanger",
	function(enabled)

		local camera =
			workspace.CurrentCamera

		if camera then

			camera.FieldOfView =
				enabled and S.FOV or 70

		end

	end
)

AddSlider(
	MiscPage,
	"Field Of View",
	"Camera FOV",
	"FOV",
	50,
	120,
	function(value)

		if not S.FOVChanger then
			return
		end

		local camera =
			workspace.CurrentCamera

		if camera then
			camera.FieldOfView = value
		end

	end
)

--==================================================
-- FULLBRIGHT
--==================================================

AddSection(
	MiscPage,
	"LIGHTING"
)

AddToggle(
	MiscPage,
	"Fullbright",
	"Improve visibility",
	"Fullbright",
	function(enabled)

		if enabled then

			Lighting.Brightness = 2
			Lighting.ClockTime = 14
			Lighting.FogEnd = 100000
			Lighting.GlobalShadows = false

		else

			Lighting.Brightness = 1
			Lighting.GlobalShadows = true

		end

	end
)

--==================================================
-- NEON GUNS
--==================================================

AddToggle(
	MiscPage,
	"Neon Guns",
	"Highlight weapon tools",
	"NeonGuns",
	function(enabled)

		local function UpdateTool(tool)

			if not tool:IsA("Tool") then
				return
			end

			local old =
				tool:FindFirstChild(
					"RustedNeon"
				)

			if enabled then

				if old then
					return
				end

				local highlight =
					Instance.new("Highlight")

				highlight.Name =
					"RustedNeon"

				highlight.FillColor =
					COLORS.PURPLE

				highlight.OutlineColor =
					COLORS.WHITE

				highlight.FillTransparency =
					.35

				highlight.OutlineTransparency =
					0

				highlight.DepthMode =
					Enum.HighlightDepthMode.AlwaysOnTop

				highlight.Parent = tool

			else

				if old then
					old:Destroy()
				end

			end

		end

		local character = GetCharacter()

		if character then

			for _,object in ipairs(
				character:GetChildren()
			) do

				UpdateTool(object)

			end

		end

		for _,object in ipairs(
			Player.Backpack:GetChildren()
		) do

			UpdateTool(object)

		end

	end
)

--==================================================
-- NEW WEAPONS
--==================================================

Player.Backpack.ChildAdded:Connect(function(tool)

	if not S.NeonGuns then
		return
	end

	if not tool:IsA("Tool") then
		return
	end

	task.wait(.05)

	if tool:FindFirstChild("RustedNeon") then
		return
	end

	local highlight =
		Instance.new("Highlight")

	highlight.Name = "RustedNeon"

	highlight.FillColor =
		COLORS.PURPLE

	highlight.OutlineColor =
		COLORS.WHITE

	highlight.FillTransparency = .35
	highlight.OutlineTransparency = 0

	highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	highlight.Parent = tool

end)

--==================================================
-- FOV LOOP
--==================================================

RunService.RenderStepped:Connect(function()

	if not S.FOVChanger then
		return
	end

	local camera =
		workspace.CurrentCamera

	if camera then

		if math.abs(
			camera.FieldOfView-S.FOV
		) > .1 then

			camera.FieldOfView = S.FOV

		end

	end

end)

--==================================================
-- FULLBRIGHT LOOP
--==================================================

RunService.RenderStepped:Connect(function()

	if not S.Fullbright then
		return
	end

	Lighting.Brightness = 2
	Lighting.ClockTime = 14
	Lighting.FogEnd = 100000
	Lighting.GlobalShadows = false

end)

--==================================================
-- PAGE ANIMATION
--==================================================

for _,page in pairs(Pages) do

	page:GetPropertyChangedSignal(
		"Visible"
	):Connect(function()

		if not page.Visible then
			return
		end

		page.Position =
			UDim2.fromOffset(20,50)

		page.CanvasPosition =
			Vector2.zero

		Tween(
			page,
			.25,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out,
			{
				Position =
					UDim2.fromOffset(12,50)
			}
		)

	end)

end

print("RUSTED v3.1 | PART 3/4")

--==================================================
--              RUSTED v3.1 PART 4/4
--              SETTINGS + FINAL
--==================================================

--==================================================
-- SETTINGS PAGE
--==================================================

AddSection(
	SettingsPage,
	"RUSTED"
)

--==================================================
-- MENU COLOR
--==================================================

local ColorPresets = {
	{
		Name = "Purple",
		Color = Color3.fromRGB(145,70,255)
	},
	{
		Name = "Blue",
		Color = Color3.fromRGB(70,135,255)
	},
	{
		Name = "Red",
		Color = Color3.fromRGB(255,65,85)
	},
	{
		Name = "Green",
		Color = Color3.fromRGB(65,220,125)
	}
}

local function ApplyColor(color)

	S.MenuColor = color
	COLORS.PURPLE = color

	-- Main outline
	if MainStroke then
		MainStroke.Color = color
	end

	-- Logo
	LogoBox.BackgroundColor3 = color

	if LogoStroke then
		LogoStroke.Color = COLORS.WHITE
	end

	-- Floating button
	if FloatStroke then
		FloatStroke.Color = color
	end

	-- Navigation
	for _,data in pairs(NavButtons) do

		data.Accent.BackgroundColor3 = color

		if data.Button:GetAttribute("Selected") then
			data.Icon.TextColor3 = color
		end

	end

	-- FOV
	if FOVStroke then
		FOVStroke.Color = color
	end

	-- Scrollbars
	for _,page in pairs(Pages) do
		page.ScrollBarImageColor3 = color
	end

	-- Existing ESP
	for _,data in pairs(ESPObjects) do

		if data.Highlight then

			data.Highlight.FillColor = color

		end

	end

	-- Existing neon weapons
	local function UpdateNeon(container)

		for _,object in ipairs(container:GetDescendants()) do

			if object:IsA("Highlight")
				and object.Name == "RustedNeon" then

				object.FillColor = color

			end

		end

	end

	local character = GetCharacter()

	if character then
		UpdateNeon(character)
	end

	UpdateNeon(Player.Backpack)

end

--==================================================
-- COLOR BUTTONS
--==================================================

for index,preset in ipairs(ColorPresets) do

	local button = New("TextButton",{

		Size = UDim2.new(1,0,0,42),

		BackgroundColor3 = COLORS.ROW,

		BorderSizePixel = 0,

		Text = "",

		AutoButtonColor = false,

		LayoutOrder = index,

		ZIndex = 13

	},SettingsPage)

	Corner(button,9)

	local colorPreview = New("Frame",{

		Size = UDim2.fromOffset(25,25),

		Position = UDim2.fromOffset(10,8),

		BackgroundColor3 = preset.Color,

		BorderSizePixel = 0,

		ZIndex = 14

	},button)

	Corner(colorPreview,8)

	New("TextLabel",{

		Size = UDim2.new(1,-50,1,0),

		Position = UDim2.fromOffset(45,0),

		BackgroundTransparency = 1,

		Text = preset.Name,

		TextColor3 = COLORS.TEXT,

		Font = Enum.Font.GothamBold,

		TextSize = 9,

		TextXAlignment = Enum.TextXAlignment.Left,

		ZIndex = 14

	},button)

	button.Activated:Connect(function()

		ApplyColor(preset.Color)

		Tween(
			colorPreview,
			.2,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out,
			{
				Size = UDim2.fromOffset(30,30)
			}
		)

		task.delay(.2,function()

			if colorPreview.Parent then

				Tween(
					colorPreview,
					.2,
					Enum.EasingStyle.Back,
					Enum.EasingDirection.Out,
					{
						Size = UDim2.fromOffset(25,25)
					}
				)

			end

		end)

	end)

	button.MouseEnter:Connect(function()

		Tween(button,.12,Enum.EasingStyle.Quart,nil,{
			BackgroundColor3 = COLORS.HOVER
		})

	end)

	button.MouseLeave:Connect(function()

		Tween(button,.12,Enum.EasingStyle.Quart,nil,{
			BackgroundColor3 = COLORS.ROW
		})

	end)

end

--==================================================
-- UI SETTINGS
--==================================================

AddSection(
	SettingsPage,
	"INTERFACE"
)

AddToggle(
	SettingsPage,
	"Menu Animations",
	"Animated opening and closing",
	"MenuAnimations",
	function()
	end
)

--==================================================
-- VERSION INFO
--==================================================

local Info = New("Frame",{

	Size = UDim2.new(1,0,0,54),

	BackgroundColor3 = COLORS.ROW,

	BorderSizePixel = 0,

	ZIndex = 13

},SettingsPage)

Corner(Info,9)

New("TextLabel",{

	Size = UDim2.new(1,-20,0,20),

	Position = UDim2.fromOffset(10,6),

	BackgroundTransparency = 1,

	Text = "RUSTED",

	TextColor3 = COLORS.TEXT,

	Font = Enum.Font.GothamBlack,

	TextSize = 11,

	TextXAlignment = Enum.TextXAlignment.Left,

	ZIndex = 14

},Info)

New("TextLabel",{

	Size = UDim2.new(1,-20,0,16),

	Position = UDim2.fromOffset(10,27),

	BackgroundTransparency = 1,

	Text = "v3.1  •  Compact UI",

	TextColor3 = COLORS.SUB,

	Font = Enum.Font.Gotham,

	TextSize = 8,

	TextXAlignment = Enum.TextXAlignment.Left,

	ZIndex = 14

},Info)

--==================================================
-- MENU ANIMATION
--==================================================

local function CrazyPulse()

	if not Main.Visible then
		return
	end

	Tween(
		MainStroke,
		.18,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.InOut,
		{
			Transparency = 0
		}
	)

	task.delay(.18,function()

		if MainStroke and MainStroke.Parent then

			Tween(
				MainStroke,
				.35,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut,
				{
					Transparency = .15
				}
			)

		end

	end)

end

--==================================================
-- LOGO ANIMATION
--==================================================

task.spawn(function()

	while Gui and Gui.Parent do

		if Main.Visible then

			Tween(
				LogoBox,
				1.5,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut,
				{
					Rotation = 5
				}
			)

			task.wait(1.5)

			if not Gui or not Gui.Parent then
				break
			end

			Tween(
				LogoBox,
				1.5,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut,
				{
					Rotation = -5
				}
			)

			task.wait(1.5)

		else

			task.wait(.5)

		end

	end

end)

--==================================================
-- TOP BAR HOVER
--==================================================

for _,button in ipairs({
	Minimize,
	Close
}) do

	button.MouseEnter:Connect(function()

		Tween(
			button,
			.15,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out,
			{
				Rotation = -8
			}
		)

	end)

	button.MouseLeave:Connect(function()

		Tween(
			button,
			.15,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out,
			{
				Rotation = 0
			}
		)

	end)

end

--==================================================
-- FLOAT BUTTON CRAZY EFFECT
--==================================================

task.spawn(function()

	while Gui and Gui.Parent do

		if Float.Visible then

			Tween(
				FloatStroke,
				.5,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut,
				{
					Transparency = .7
				}
			)

			task.wait(.5)

			if not Float.Visible then
				continue
			end

			Tween(
				FloatStroke,
				.5,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut,
				{
					Transparency = .05
				}
			)

			task.wait(.5)

		else

			task.wait(.5)

		end

	end

end)

--==================================================
-- FLOAT BUTTON CLICK EFFECT
--==================================================

Float.Activated:Connect(function()

	Float.Rotation = -25

	Tween(
		Float,
		.45,
		Enum.EasingStyle.Elastic,
		Enum.EasingDirection.Out,
		{
			Rotation = 0
		}
	)

end)

--==================================================
-- MINIMIZE CLICK EFFECT
--==================================================

Minimize.Activated:Connect(function()

	CrazyPulse()

end)

--==================================================
-- CLOSE CLICK EFFECT
--==================================================

Close.Activated:Connect(function()

	Tween(
		Close,
		.18,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out,
		{
			Rotation = 15
		}
	)

end)

--==================================================
-- PAGE CLICK EFFECT
--==================================================

for _,data in pairs(NavButtons) do

	data.Button.Activated:Connect(function()

		Tween(
			data.Icon,
			.18,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out,
			{
				Rotation = 15
			}
		)

		task.delay(.18,function()

			if data.Icon.Parent then

				Tween(
					data.Icon,
					.25,
					Enum.EasingStyle.Back,
					Enum.EasingDirection.Out,
					{
						Rotation = 0
					}
				)

			end

		end)

	end)

end

--==================================================
-- RESET CAMERA WHEN GUI CLOSES
--==================================================

local function Cleanup()

	for player in pairs(ESPObjects) do
		RemoveESP(player)
	end

	local camera = workspace.CurrentCamera

	if camera then
		camera.FieldOfView = 70
	end

	local character = GetCharacter()

	if character then

		for _,object in ipairs(
			character:GetDescendants()
		) do

			if object:IsA("BasePart") then

				if object.Name ~= "HumanoidRootPart" then
					-- Do not force collision state here.
				end

			end

		end

	end

end

--==================================================
-- CHARACTER RESPAWN CLEANUP
--==================================================

Player.CharacterRemoving:Connect(function()

	for player in pairs(ESPObjects) do
		RemoveESP(player)
	end

end)

--==================================================
-- FINAL GUI SETTINGS
--==================================================

Gui.DisplayOrder = 999

--==================================================
-- FINAL COLOR
--==================================================

ApplyColor(S.MenuColor)

--==================================================
-- FINAL PAGE
--==================================================

SwitchPage("Visual")

--==================================================
-- FINAL START EFFECT
--==================================================

task.delay(.7,function()

	if not Gui or not Gui.Parent then
		return
	end

	-- small logo bounce
	Tween(
		LogoBox,
		.25,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out,
		{
			Size = UDim2.fromOffset(36,36)
		}
	)

	task.wait(.25)

	if LogoBox.Parent then

		Tween(
			LogoBox,
			.25,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out,
			{
				Size = UDim2.fromOffset(32,32)
			}
		)

	end

end)

print("====================================")
print("        RUSTED v3.1 LOADED")
print("        ALL 4 PARTS READY")
print("====================================")
