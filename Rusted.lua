--// Rusted ESP
--// Lunar style - Base ESP

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local ESP_ENABLED = true
local SHOW_NAME = true
local SHOW_DISTANCE = true

local ESP_FOLDER = Instance.new("Folder")
ESP_FOLDER.Name = "RustedESP"
ESP_FOLDER.Parent = game:GetService("CoreGui")

local Objects = {}

local function RemoveESP(player)
    if Objects[player] then
        Objects[player]:Destroy()
        Objects[player] = nil
    end
end

local function CreateESP(player)
    if player == LocalPlayer then
        return
    end

    if Objects[player] then
        return
    end

    local character = player.Character
    if not character then
        return
    end

    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then
        return
    end

    local highlight = Instance.new("Highlight")
    highlight.Name = "PlayerESP"
    highlight.Adornee = character
    highlight.FillTransparency = 0.75
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = ESP_FOLDER

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "Info"
    billboard.Adornee = root
    billboard.Size = UDim2.new(0, 180, 0, 45)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = ESP_FOLDER

    local text = Instance.new("TextLabel")
    text.BackgroundTransparency = 1
    text.Size = UDim2.new(1, 0, 1, 0)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 13
    text.TextColor3 = Color3.fromRGB(220, 190, 255)
    text.TextStrokeTransparency = 0.25
    text.Text = player.DisplayName
    text.Parent = billboard

    Objects[player] = highlight

    local connection

    connection = RunService.RenderStepped:Connect(function()
        if not ESP_ENABLED then
            highlight.Enabled = false
            billboard.Enabled = false
            return
        end

        if not player.Parent
            or not player.Character
            or not player.Character:FindFirstChild("HumanoidRootPart") then

            highlight.Enabled = false
            billboard.Enabled = false
            return
        end

        highlight.Enabled = true
        billboard.Enabled = true

        local myCharacter = LocalPlayer.Character
        local myRoot = myCharacter
            and myCharacter:FindFirstChild("HumanoidRootPart")

        local playerRoot =
            player.Character:FindFirstChild("HumanoidRootPart")

        local distanceText = ""

        if SHOW_DISTANCE and myRoot and playerRoot then
            local distance =
                math.floor((myRoot.Position - playerRoot.Position).Magnitude)

            distanceText = "\n[" .. distance .. " studs]"
        end

        if SHOW_NAME then
            text.Text = player.DisplayName .. distanceText
        elseif SHOW_DISTANCE then
            text.Text = distanceText
        else
            text.Text = ""
        end
    end)

    player.CharacterRemoving:Connect(function()
        highlight.Enabled = false
        billboard.Enabled = false
    end)
end

local function SetupPlayer(player)
    if player == LocalPlayer then
        return
    end

    player.CharacterAdded:Connect(function()
        task.wait(1)

        RemoveESP(player)
        CreateESP(player)
    end)

    if player.Character then
        task.wait(0.5)
        CreateESP(player)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    SetupPlayer(player)
end

Players.PlayerAdded:Connect(function(player)
    SetupPlayer(player)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

print("🌙 Rusted ESP loaded")
