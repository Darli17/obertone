--[[
░████████   ░██     ░██    ░██████████░██     ░██ ░██████████    ░███████      ░███    ░█████████  ░██         ░██████
░██    ░██   ░██   ░██         ░██    ░██     ░██ ░██            ░██   ░██    ░██░██   ░██     ░██ ░██           ░██  
░██    ░██    ░██ ░██          ░██    ░██     ░██ ░██            ░██    ░██  ░██  ░██  ░██     ░██ ░██           ░██  
░████████      ░████           ░██    ░██████████ ░█████████     ░██    ░██ ░█████████ ░█████████  ░██           ░██  
░██     ░██     ░██            ░██    ░██     ░██ ░██            ░██    ░██ ░██    ░██ ░██   ░██   ░██           ░██  
░██     ░██     ░██            ░██    ░██     ░██ ░██            ░██   ░██  ░██    ░██ ░██    ░██  ░██           ░██  
░█████████      ░██            ░██    ░██     ░██ ░██████████    ░███████   ░██    ░██ ░██     ░██ ░██████████ ░██████
                                                                                                                      
                                                                                                                      
                                                                                                                      
░██████████ ░███    ░██     ░█████   ░██████   ░██     ░██ ░██                                                        
░██         ░████   ░██       ░██   ░██   ░██   ░██   ░██  ░██                                                        
░██         ░██░██  ░██       ░██  ░██     ░██   ░██ ░██   ░██                                                        
░█████████  ░██ ░██ ░██       ░██  ░██     ░██    ░████    ░██                                                        
░██         ░██  ░██░██ ░██   ░██  ░██     ░██     ░██     ░██                                                        
░██         ░██   ░████ ░██   ░██   ░██   ░██      ░██                                                                
░██████████ ░██    ░███  ░██████     ░██████       ░██     ░██                                                        
                                                                                                                      
                                                                                                                      
]]

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false 
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = false

local version = "1.0"

local Window = Library:CreateWindow({
	Title = " ",
	Footer = "Obertone "..version.." [RELEASE]",
	Icon = 107765095938421,
  Animations = {
      ToggleWindow = true,
      TabSwitch = true,
      Groupbox = true,
      Dropdown = true,
      KeyPicker = true
  },
    
  TabTransitionTime = 0.22,
  TabSwipeOffset = 26,
  TabSwipeFrom = "bottom",
	NotifySide = "Right",
	ShowCustomCursor = false,
  CornerRadius = 13,
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("Obertone")
SaveManager:SetFolder("Obertone/babft")
SaveManager:SetSubFolder("babft") -- if the game has multiple places inside of it (for example: DOORS)

ThemeManager:SetDefaultTheme({
    FontColor = Color3.fromRGB(255, 255, 255),
    MainColor = Color3.fromRGB(21, 21, 21),
    AccentColor = Color3.fromRGB(255, 245, 0),
    BackgroundColor = Color3.fromRGB(13, 13, 13),
    OutlineColor = Color3.fromRGB(0, 0, 0),
    FontFace =  Enum.Font.Gotham,
    BackgroundImage = ""
})

local Tabs = {
  Home = Window:AddTab("Home", "house"),
	Modifiers = Window:AddTab("Modifiers", "percent"),
	Shop = Window:AddTab("Shop", "shopping-cart"),
  AutoFarm = Window:AddTab("Farm", "trophy"),
  Inventory = Window:AddTab("Data", "save"),
  Quests = Window:AddTab("Rewards", "flame"),
  Teleportation = Window:AddTab("Teleportation", "user-group"),
	["UI Settings"] = Window:AddTab("Settings", "settings"),
}

SaveManager:BuildConfigSection(Tabs["UI Settings"])

ThemeManager:ApplyToTab(Tabs["UI Settings"])
ThemeManager:LoadDefault()

local function notification(title, desc, time)

Library:Notify({
    Title = title,
    TitleColor = Color3.fromRGB(255, 245, 0),
    Description = desc,
    SoundId = "rbxassetid://131390520971848",
    Icon = "rbxassetid://107765095938421", -- Lucide icon Name
    Time = time,
})

end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character.HumanoidRootPart
local tag = nil

local function updateCharacter(newCharacter)
    character = newCharacter or player.Character

    root = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
    task.wait(0.3)
    local groupLabel = root:FindFirstChild("GroupLabel")

    if groupLabel then
        local textLabel = groupLabel:FindFirstChild("TextLabel")

        if textLabel then
            tag = textLabel
        end
    end
end

updateCharacter(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(function(character)
    updateCharacter(character)
end)


local zones = {
    white = "WhiteZone",
    black = "BlackZone",
    blue = "Really blueZone",
    green = "CamoZone",
    magenta = "MagentaZone",
    yellow = "New YellerZone",
    red = "Really redZone"
}

local teamName = player.Team.Name
local zoneName = zones[teamName:lower()]

local team = workspace:WaitForChild(zoneName)
task.spawn(function()

teamName = player.Team.Name
zoneName = zones[teamName:lower()]
team = workspace:WaitForChild(zoneName)

end)

do -- Greetings scope: prevents exhausting top-level local registers
local status_great = "🟢"
local status_normal = "🟡"
local status_down = "🟠"
local status_be = "⚫"

local GreetingsGroup = Tabs.Home:AddGroupbox({
    Side = "Left",
    Name = "Greetings!",
    IconName = "user-check",
})

local isUsernameEnabled = false
local isDisplaynameEnabled = false

local WelcomeLabel = GreetingsGroup:AddLabel("Welcome!", true)

local UserNameLabel = GreetingsGroup:AddLabel(
    '<font color="rgb(73, 230, 133)">@' .. player.Name .. '</font> ' ..
    '<font color="rgb(180, 180, 180)">(' .. player.DisplayName .. ')</font>',
    true
)

local function UpdateUsername()
    local username = player.Name
    local displayName = player.DisplayName

    local shownUsername = isUsernameEnabled and "Hidden" or username
    local shownDisplayName = isDisplaynameEnabled and "Hidden" or displayName

    UserNameLabel:SetText(
        '<font color="rgb(73, 230, 133)">@' .. shownUsername .. '</font> ' ..
        '<font color="rgb(180, 180, 180)">(' .. shownDisplayName .. ')</font>'
    )
end

GreetingsGroup:AddToggle("UsernameEnabled", {
    Text = "Hide Username",
    Default = false,

    Callback = function(Value)
        isUsernameEnabled = Value
        UpdateUsername()
    end
})

GreetingsGroup:AddToggle("DisplaynameEnabled", {
    Text = "Hide Display Name",
    Default = false,

    Callback = function(Value)
        isDisplaynameEnabled = Value
        UpdateUsername()
    end
})
local userId = player.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

GreetingsGroup:AddImage("MyImage", {
    Image = content,
    Height = 200,
})

GreetingsGroup:AddDivider("")

local StatusLabel = GreetingsGroup:AddLabel("Is latest: ["..status_great.."] | Version: ["..version.."]", true)
local ChangeLogLabel = GreetingsGroup:AddLabel(
  "Change Log [📃]:"
)
local ChangeLogText = GreetingsGroup:AddLabel(
  "[1] - Script has been released! version 1.0!",
  true
)
local ChangeLogText2 = GreetingsGroup:AddLabel(
  "[2] - Fixed names from poopy to normal ones.",
  true
)

end -- Greetings scope


local ClientGroup = Tabs.Home:AddGroupbox({
    Side = "Right",
    Name = "Client",
    Description = "View ping, fps and more.",
    IconName = "smartphone-user-round",
})

do

    local status_great = "🟢"
    local status_normal = "🟡"
    local status_down = "🟠"
    local status_be = "⚫"

    local Stats = game:GetService("Stats")
    local RunService = game:GetService("RunService")

    local PingLabel = ClientGroup:AddLabel("PING: 0 ms", true)
    local FPSLabel = ClientGroup:AddLabel("FPS: 0", true)
    local PingStatusLabel = ClientGroup:AddLabel("PING Status: " .. status_great, true)
    local FPSStatusLabel = ClientGroup:AddLabel("FPS Status: " .. status_great, true)

    local fps = 0
    local frames = 0
    local lastUpdate = os.clock()

    RunService.RenderStepped:Connect(function()
        frames += 1

        local now = os.clock()
        if now - lastUpdate >= 1 then
            fps = math.floor(frames / (now - lastUpdate))
            frames = 0
            lastUpdate = now
        end
    end)

    task.spawn(function()
        while true do
            -- PING
            local ping = 0

            pcall(function()
                ping = math.floor(
                    Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
                )
            end)

            PingLabel:SetText("Ping: " .. ping .. " ms")

            if ping > 1000 then
                PingStatusLabel:SetText("Ping Status: " .. status_be)
            elseif ping > 300 then
                PingStatusLabel:SetText("Ping Status: " .. status_down)
            elseif ping > 180 then
                PingStatusLabel:SetText("Ping Status: " .. status_normal)
            else
                PingStatusLabel:SetText("Ping Status: " .. status_great)
            end

            -- FPS
            FPSLabel:SetText("FPS: " .. fps)

            if fps < 10 then
                FPSStatusLabel:SetText("FPS Status: " .. status_be)
            elseif fps < 30 then
                FPSStatusLabel:SetText("FPS Status: " .. status_down)
            elseif fps < 70 then
                FPSStatusLabel:SetText("FPS Status: " .. status_normal)
            else
                FPSStatusLabel:SetText("FPS Status: " .. status_great)
            end

            task.wait(1)
        end
    end)
end

ClientGroup:AddDivider("")

do
    local StartTime = os.clock()

    local UptimeLabel = ClientGroup:AddLabel("Uptime: 00:00:00", true)

    task.spawn(function()
        while true do
            local elapsed = math.floor(os.clock() - StartTime)

            local hours = math.floor(elapsed / 3600)
            local minutes = math.floor((elapsed % 3600) / 60)
            local seconds = elapsed % 60

            UptimeLabel:SetText(string.format(
                "Uptime: %02d:%02d:%02d",
                hours,
                minutes,
                seconds
            ))

            task.wait(1)
        end
    end)
end

local ExecutorLabel = ClientGroup:AddLabel("Executor: ", true)
local ExecutorStatus = ClientGroup:AddLabel("Status: ", true)

local executor = identifyexecutor() or getexecutorname() or "Unknown"
local badExecutors = {"Xeno", "Solara", "JJsploit", "bunni", "Krnl", "Velocity"}
local isBadExecutor = false
for _, bad in ipairs(badExecutors) do
    if executor:lower():find(bad:lower()) then
        isBadExecutor = true
        break
    end
end

    local status_great = "🟢"
    local status_normal = "🟡"
    local status_down = "🟠"
    local status_be = "⚫"

      ExecutorLabel:SetText(
        executor
      )
      ExecutorStatus:SetText(
        "Status: "..status_great.." (Great executor)"
      )

if isBadExecutor == true then
    local player = game.Players.LocalPlayer
    if executor == "Xeno" then
      ExecutorLabel:SetText(
        executor
      )
      ExecutorStatus:SetText(
        "Status: "..status_be.." (Delete malware bro...)"
      )
    else
      ExecutorLabel:SetText(
        executor
      )
      ExecutorStatus:SetText(
        "Status: "..status_down.." (Bad executor)"
      )
    end
end

ClientGroup:AddDivider("")
ClientGroup:AddLabel("Game: Build A Boat For Treasure")

local ServerGroup = Tabs.Home:AddGroupbox({
    Side = "Right",
    Name = "Server",
    Description = "",
    IconName = "server",
})

do

local PlayerBox = ServerGroup:AddTabbox({
    Side = "Left", -- case-insensitive
    Name = "Players",
    -- MaxHeight = 300,
    -- PopOut = true,
    -- MaxPopOutHeight = 200,
    -- PopOutWidth = 280,
})

local InfoBox = ServerGroup:AddTabbox({
    Side = "Right", -- case-insensitive
    Name = "Info",
    -- MaxHeight = 300,
    -- PopOut = true,
    -- MaxPopOutHeight = 200,
    -- PopOutWidth = 280,
})

local PlayersInfo = PlayerBox:AddTab("Players", "user-round")
local InfoInfo = InfoBox:AddTab("Info", "message-square")

local maxPlayers = Players.MaxPlayers

local function updateCounter()
    local currentPlayers = #Players:GetPlayers()

    ServerGroup:SetDescription("Players: "..currentPlayers .. "/" .. maxPlayers)
end

local PlayerElements = {}

local function AddPlayer(Player)
    if PlayerElements[Player] then return end

    local PlayerDivider = PlayersInfo:AddDivider("")

    local PlayerUsername = PlayersInfo:AddLabel(
        Player.Name .. " (@" .. Player.DisplayName .. ")"
    )

    local userIdX = Player.UserId
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local content, isReady = Players:GetUserThumbnailAsync(userIdX, thumbType, thumbSize)

    local PlayerImage = PlayersInfo:AddImage("PlayerImage", {
        Image = content,
        Height = 200,
    })

    PlayerElements[Player] = {
        Label = PlayerUsername,
        Image = PlayerImage,
        Divider = PlayerDivider
    }
end

local function RemovePlayer(Player)
    local Elements = PlayerElements[Player]
    if not Elements then return end

    Elements.Label:Destroy()
    Elements.Image:Destroy()
    Elements.Divider:Destroy()

    PlayerElements[Player] = nil
end

for _, Player in ipairs(Players:GetPlayers()) do
    AddPlayer(Player)
end


local SelectedItem = "WoodBlock"

local PlayerLabels = {}
local ValueConnections = {}

local ValuesX = {}

for _, v in ipairs(player.Data:GetChildren()) do
    if v:IsA("IntValue")
        and not v.Name:match("XY$")
        and not v.Name:match("XZ$")
        and not v.Name:match("YZ$")
        and not v.Name:match("[XYZ]$") then

        table.insert(ValuesX, v.Name)
    end
end

local function ClearLabels()
    for plr, label in pairs(PlayerLabels) do
        label:Destroy()
        PlayerLabels[plr] = nil
    end

    for plr, connection in pairs(ValueConnections) do
        connection:Disconnect()
        ValueConnections[plr] = nil
    end
end

local function AddPlayerLabel(plr)
    if PlayerLabels[plr] then
        PlayerLabels[plr]:Destroy()
        PlayerLabels[plr] = nil
    end

    if ValueConnections[plr] then
        ValueConnections[plr]:Disconnect()
        ValueConnections[plr] = nil
    end

    local Data = plr:FindFirstChild("Data")
    if not Data then return end

    local Value = Data:FindFirstChild(SelectedItem)
    if not Value or not Value:IsA("IntValue") then return end

    local Label = ServerGroup:AddLabel(
        plr.Name .. ": " .. tostring(Value.Value)
    )

    PlayerLabels[plr] = Label

    ValueConnections[plr] = Value:GetPropertyChangedSignal("Value"):Connect(function()
        if PlayerLabels[plr] then
            Label:SetText(plr.Name .. ": " .. tostring(Value.Value))
        end
    end)
end

local PlayerInfo = InfoInfo:AddDropdown("PlayerInfos", {
    Text = "Select Block to view:",
    Values = ValuesX,
    Default = "WoodBlock",
    Searchable = true,
    Multi = false,

    Callback = function(Value)
        SelectedItem = Value

        ClearLabels()

        for _, plr in ipairs(Players:GetPlayers()) do
            AddPlayerLabel(plr)
        end
    end
})

for _, plr in ipairs(Players:GetPlayers()) do
    AddPlayerLabel(plr)
end

Players.PlayerAdded:Connect(function(plr)

    updateCounter()

    AddPlayer(plr)

    task.wait(1)

    AddPlayerLabel(plr)

end)

Players.PlayerRemoving:Connect(function(plr)

    updateCounter()

    RemovePlayer(plr)

    if PlayerLabels[plr] then
        PlayerLabels[plr]:Destroy()
        PlayerLabels[plr] = nil
    end

    if ValueConnections[plr] then
        ValueConnections[plr]:Disconnect()
        ValueConnections[plr] = nil
    end

end)

updateCounter()

end


-- Modifiers

local PlayerGroup = Tabs.Modifiers:AddGroupbox({
    Side = "Left",
    Name = "Player",
    Description = "Adjust character speed, jump height and much more.",
    IconName = "user-round",
})

local WalkSpeed = PlayerGroup:AddSlider("WalkSpeed", {
    Text = "WalkSpeed:",
    Default = humanoid.WalkSpeed,
    Min = 16,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)

humanoid.WalkSpeed = Value

    end
})
local JumpPower = PlayerGroup:AddSlider("JumpPower", {
    Text = "JumpPower:",
    Default = humanoid.JumpPower,
    Min = 50,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)

humanoid.JumpPower = Value

    end
})
local FOV = PlayerGroup:AddSlider("FOV", {
    Text = "Field Of View:",
    Default = workspace.CurrentCamera.FieldOfView,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Callback = function(Value)

workspace.CurrentCamera.FieldOfView = Value

    end
})

local speeds = 1
local nowe = nil

local Fly = PlayerGroup:AddToggle("Fly", {
    Text = "Fly",
    Default = false,
    Callback = function(Value)

local speaker = game:GetService("Players").LocalPlayer

local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = not Value

	if nowe == true then
		nowe = false

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	else 
		nowe = true



		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i,v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end




	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then



		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Torso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		local bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			game:GetService("RunService").RenderStepped:Wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end
			--	game.Players.LocalPlayer.Character.Animate.Disabled = true
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false




	else
		local plr = game.Players.LocalPlayer
		local UpperTorso = plr.Character.UpperTorso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end

			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false



	end


game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
	wait(0.7)
	game.Players.LocalPlayer.Character:WaitForChild("Humanoid").PlatformStand = false
	game.Players.LocalPlayer.Character:WaitForChild("Animate").Disabled = false

end)

    end
})


local FlySpeed = PlayerGroup:AddSlider("FlySpeed", {
    Text = "Fly Speed:",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(Value)

speeds = Value
	if nowe == true then


		tpwalking = false
		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
  end


    end
})
Fly:AddKeyPicker("FlyKeybind", {
    Text = "Fly",
    Default = "F",
    Mode = "Toggle",
    SyncToggleState = true
})

local RunService = game:GetService("RunService")

local noclip = false
local NoclipConnection

local Noclip = PlayerGroup:AddToggle("Noclip", {
    Text = "Noclip",
    Default = false,

    Callback = function(Value)
        noclip = Value

        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end

        if noclip then
            NoclipConnection = RunService.Stepped:Connect(function()
                if not character or not character.Parent then
                    return
                end

                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        end
    end
})
Noclip:AddKeyPicker("NoclipKeybind", {
    Text = "Noclip",
    Default = "N",
    Mode = "Toggle",
    SyncToggleState = true
})

local infjump = false

local InfiniteJump = PlayerGroup:AddToggle("InfiniteJump", {
    Text = "Infinite Jump",
    Default = false,
    Callback = function(Value)

infjump = Value

while infjump == true and task.wait(0.) do

if humanoid.Jump then
     humanoid:ChangeState("Jumping")
end

end

    end
})

local cashfolder = player.OtherData

local WaterGodMode = PlayerGroup:AddToggle("WaterGodMode", {
    Text = "Water Godmode",
    Default = false,
    Risky = true,
    Tooltip = "This could affect the gameplay/game process. are you sure?",
    Callback = function(Value)

if Value == true then

for i2,v2 in ipairs(workspace:GetDescendants()) do

if v2.Name == "Water" then
v2.Parent = cashfolder
end

end

end

if Value == false then

for i3,v3 in ipairs(cashfolder:GetDescendants()) do

if v3.Name == "Water" then

v3.Parent = workspace

end

end

end

    end
})

    if tag then

local TagGroup = Tabs.Modifiers:AddGroupbox({
    Side = "Left",
    Name = "Tag",
    Description = "Change Group Tag text, color.",
    IconName = "tag",
})

local oldtagtext = tag.Text
local oldtagcolor = tag.TextColor3

local tagtext = "Co-Owner"
local tagcolor = Color3.fromRGB(255,0,0)

local TagText = TagGroup:AddInput("TagText", {
	Default = tagtext,
	Numeric = false, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Tag Text",

	Callback = function(Value)

tagtext = Value

	end,
})
local enabletag = false

local EnableTag = TagGroup:AddToggle("EnableTag", {
    Text = "Enable Custom Tag",
    Default = false,
    Callback = function(Value)

enabletag = Value

while enabletag == true and task.wait(0.1) do
tag.Text = tagtext
tag.TextColor3 = tagcolor
if enabletag == false then
tag.Text = oldtagtext
tag.TextColor3 = oldtagcolor
end
end

    end
})

local TagColor = EnableTag:AddColorPicker("TagColor", {
    Default = tagcolor,
    Title = "",
    Resizable = true,
    Callback = function(Value)

tagcolor = Value

    end
})

if player.Name == "ValerikRobJR" and player.UserId == 9015172057 then

local TagPresets = TagGroup:AddDropdown("TagPresets", {
    Text = "Tag Presets",
    Values = { "Master Builder", "Contributor", "Obertone Creator" },
    Multi = false,
    Callback = function(Value)

if Value == "Master Builder" then

tagtext = "Master Builder"
tagcolor = Color3.fromRGB(248,67,253)

end
if Value == "Contributor" then

tagtext = "Contributor"
tagcolor = Color3.new(0, 64005, 65025)

end
if Value == "Obertone Creator" then

tagtext = "Obertone Creator"
tagcolor = Color3.fromRGB(255, 245, 0)

end

    end
})

else

local TagPresets = TagGroup:AddDropdown("TagPresets", {
    Text = "Tag Presets",
    Values = { "Master Builder", "Contributor" },
    Multi = false,
    Callback = function(Value)

if Value == "Master Builder" then

tagtext = "Master Builder"
tagcolor = Color3.fromRGB(248,67,253)

end
if Value == "Contributor" then

tagtext = "Contributor"
tagcolor = Color3.new(0, 64005, 65025)

end

    end
})

end

    end

local WorldGroup = Tabs.Modifiers:AddGroupbox({
    Side = "Right",
    Name = "World",
    Description = "Change the sky, the fog. Whatever you’d like!",
    IconName = "earth",
})

WorldGroup:AddDivider("World")

local SkyId = nil
local OriginalSky = nil
local CustomSky = nil

WorldGroup:AddInput("SkyID", {
    Default = "",
    Numeric = true,
    Finished = true,
    ClearTextOnFocus = false,
    Text = "Sky ID:",
    Placeholder = "rbxassetid://123456789",

    Callback = function(Value)
        SkyId = Value
    end,
})

WorldGroup:AddToggle("EnableSky", {
    Text = "Enable Custom Sky",
    Default = false,

    Callback = function(Value)
        local lighting = game:GetService("Lighting")

        if Value then
            if not SkyId or SkyId == "" then

                return
            end

            OriginalSky = lighting:FindFirstChildOfClass("Sky")

            if OriginalSky then
                OriginalSky.Parent = nil
            end

            local success, result = pcall(function()
                return game:GetObjects(SkyId)[1]
            end)

            if not success or not result then

                if OriginalSky then
                    OriginalSky.Parent = lighting
                end

                return
            end

            CustomSky = result
            CustomSky.Name = "NewDaySky"
            CustomSky.Parent = lighting

        else

            if CustomSky and CustomSky.Parent then
                CustomSky:Destroy()
            end

            CustomSky = nil
            if OriginalSky then
                OriginalSky.Parent = lighting
            end
        end
    end
})

local daylight = 14
local nightlight = 23.1
local ambient = Color3.fromRGB(255,255,255)

local Lighting = game:GetService("Lighting")

local originalSettings = {}

WorldGroup:AddToggle("Fullbright", {
    Text = "Fullbright",
    Default = false,

    Callback = function(Value)
        if Value then
            originalSettings.ClockTime = Lighting.ClockTime
            originalSettings.Ambient = Lighting.Ambient
            originalSettings.OutdoorAmbient = Lighting.OutdoorAmbient
            originalSettings.Brightness = Lighting.Brightness
            originalSettings.GlobalShadows = Lighting.GlobalShadows

            Lighting.ClockTime = daylight
            Lighting.Ambient = ambient
            Lighting.OutdoorAmbient = ambient
            Lighting.Brightness = 3
            Lighting.GlobalShadows = false

        else
            -- Возвращаем настройки
            Lighting.ClockTime = originalSettings.ClockTime
            Lighting.Ambient = originalSettings.Ambient
            Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
            Lighting.Brightness = originalSettings.Brightness
            Lighting.GlobalShadows = originalSettings.GlobalShadows
        end
    end
})

local fogcolor = Color3.fromRGB(191, 191, 191)
local fogstart = 500
local fogend = 200

local lighting = game:GetService("Lighting")

local originalFogStart = lighting.FogStart
local originalFogEnd = lighting.FogEnd
local originalFogColor = lighting.FogColor

local CustomFog = WorldGroup:AddToggle("CustomFog", {
    Text = "Custom Fog",
    Default = false,

    Callback = function(Value)
        if Value then
            lighting.FogStart = fogstart
            lighting.FogEnd = fogend
            lighting.FogColor = fogcolor
        else
            lighting.FogStart = originalFogStart
            lighting.FogEnd = originalFogEnd
            lighting.FogColor = originalFogColor
        end
    end
})
CustomFog:AddColorPicker("FogColor", {
    Default = game.Lighting.FogColor,
    Title = "Pick some beautiful color for fog!",
    Resizable = true,
    Callback = function(Value)

fogcolor = Value

    end
})

WorldGroup:AddInput("FogStart", {
	Default = "",
	Numeric = true, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Fog Start",

	Placeholder = "500", 

	Callback = function(Value)

fogstart = Value

	end,
})
WorldGroup:AddInput("FogEnd", {
	Default = "",
	Numeric = true, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Fog End",

	Placeholder = "200", 

	Callback = function(Value)

fogend = Value

	end,
})

local IsolationDisable = WorldGroup:AddToggle("BypassIsolationMode", {
    Text = "Bypass Isolation Mode",
    Default = false,

    Callback = function(Value)
        for color, zoneName in pairs(zones) do
            for _, zone in ipairs(workspace:GetDescendants()) do
                if zone.Name == zoneName then
                    local beams = zone:FindFirstChild("IsolationBeams", true)
                    local modeBeams = beams and beams:FindFirstChild("IsolationModeBeams", true)
                    local part = modeBeams and modeBeams:FindFirstChild("PPart", true)

                    if part and part:IsA("BasePart") then
                        part.CanCollide = not Value
                    end
                end
            end
        end
    end
})

local BlocksGroup = Tabs.Modifiers:AddGroupbox({
    Side = "Right",
    Name = "Blocks",
    Description = "Adjust the jet turbine speed, thruster fuel, and much more.",
    IconName = "cog",
})

local category = "Thrusters"
local plot = workspace.Blocks[player.Name]

local Category
local Sliders = {}

local CategoryValues = {
    ["Thrusters"] = {"Fuel", "MassMuiltiplier"},
    ["Jet Turbines"] = {
        "MaxSpeed", "MaxForce", "MaxStageSpeed", "Fuel"
    },
    ["Boat Motors"] = {"TurningSpeed", "MaxSpeed"},
    ["Wheels"] = {"MaxSpeed"}
}

local CategoryModels = {
    ["Thrusters"] = {
        "MegaThruster", "Thruster", "UltraThruster",
        "WinterThruster", "HalloweenThruster"
    },
    ["Jet Turbines"] = {
        "JetTurbine", "JetTurbineWinter", "SonicJetTurbine"
    },
    ["Boat Motors"] = {
        "BoatMotor", "BoatMotorUltra", "BoatMotorWinter"
    },
    ["Wheels"] = {
        "BackWheel", "FrontWheel",
        "BackWheelCookie", "FrontWheelCookie",
        "BackWheelMint", "FrontWheelMint",
        "HugeBackWheel", "HugeFrontWheel",
        "HugeMotor", "Motor"
    }
}

local function ClearSliders()
    for _, Slider in pairs(Sliders) do
        Slider:Destroy()
    end

    table.clear(Sliders)
end
local function CreateSliders()
    ClearSliders()

    for _, valueName in ipairs(CategoryValues[category]) do
        local Slider

        Slider = BlocksGroup:AddSlider(valueName, {
            Text = valueName,
            Default = 0,
            Min = 0,
            Max = 10000,
            Rounding = 1,
Callback = function(Value)
    local models = CategoryModels[category]

    if not models then
        return
    end

    for _, modelName in ipairs(models) do
        for _, obj in ipairs(plot:GetDescendants()) do
            if obj.Name == modelName and obj:IsA("Model") then

                -- Ищем Value внутри модели
                local setting = obj:FindFirstChild(valueName, true)

                if setting and setting:IsA("ValueBase") then
                    setting.Value = Value
                end

                -- Если значение хранится в Attribute
                if obj:GetAttribute(valueName) ~= nil then
                    obj:SetAttribute(valueName, Value)
                end
            end
        end
    end
end
        })

        table.insert(Sliders, Slider)
    end
end
Category = BlocksGroup:AddDropdown("Category", {
    Text = "Select Category:",
    Values = {
        "Thrusters", "Jet Turbines",
        "Boat Motors", "Wheels"
    },
    Default = "Thrusters",
    Multi = false,

    Callback = function(Value)
        category = Value
        CreateSliders()
    end
})

CreateSliders()

-- Shop

local ShopGroup = Tabs.Shop:AddGroupbox({
    Side = "Left",
    Name = "Shop",
    Description = "Enable event items.",
    IconName = "shopping-cart",
})

local SelectedItems = "Halloween"
local IncludeGoldItems = false
local EnabledEvent = false

local EnableEventItems = ShopGroup:AddToggle("EventItems", {
    Text = "Enable Event Blocks",
    Default = false,
    Callback = function(Value)

EnabledEvent = Value

local scrollingeventitems = player.PlayerGui.ShopGui.MainFrame.TabFrame.ShopFrame.ScrollingFrameChests.FrameEvent

if EnabledEvent == true then

scrollingeventitems.Visible = true

if SelectedItems == "Halloween" then
scrollingeventitems["+5 Dragon Harpoons"].Visible = true
if IncludeGoldItems == true then
scrollingeventitems.Candle.Visible = true
scrollingeventitems.JackOLantern.Visible = true
end
end
if SelectedItems == "Christmas" then
scrollingeventitems["+5 Duel Harpoons"].Visible = true
scrollingeventitems["+4 Cookie Wheels"].Visible = true
if IncludeGoldItems == true then
scrollingeventitems.MintWheels.Visible = true
scrollingeventitems.ToyBlock.Visible = true
scrollingeventitems.SnowballTurret.Visible = true
end
end
if SelectedItems == "July" then
if IncludeGoldItems == true then
scrollingeventitems.FireworkA.Visible = true
scrollingeventitems.FireworkB.Visible = true
scrollingeventitems.FireworkC.Visible = true
scrollingeventitems.FireworkD.Visible = true
end
end

end

if EnabledEvent == false then

local scrollingeventitems = player.PlayerGui.ShopGui.MainFrame.TabFrame.ShopFrame.ScrollingFrameChests.FrameEvent

scrollingeventitems.Visible = false

scrollingeventitems.FireworkA.Visible = false
scrollingeventitems.FireworkB.Visible = false
scrollingeventitems.FireworkC.Visible = false
scrollingeventitems.FireworkD.Visible = false
scrollingeventitems["+5 Duel Harpoons"].Visible = false
scrollingeventitems["+4 Cookie Wheels"].Visible = false
scrollingeventitems.MintWheels.Visible = false
scrollingeventitems.ToyBlock.Visible = false
scrollingeventitems.SnowballTurret.Visible = false
scrollingeventitems["+5 Dragon Harpoons"].Visible = false
scrollingeventitems.Candle.Visible = false
scrollingeventitems.JackOLantern.Visible = false

end

    end
})
local SelectEventItems = ShopGroup:AddDropdown("SelectEventItems", {
    Text = "Select Blocks Category",
    Values = { "Christmas", "Halloween", "July" },
    Default = "Halloween",
    Multi = false,
    Callback = function(Value)

SelectedItems = Value

    end
})
local IncludeGoldItems = ShopGroup:AddToggle("GoldItems", {
    Text = "Include Gold Items",
    Default = false,
    Callback = function(Value)

IncludeGoldItems = Value

    end
})

local EnableMega = ShopGroup:AddToggle("EnableMega", {
    Text = "Enable Mega Thrusters",
    Default = false,
    Callback = function(Value)

local oldMega = player.PlayerGui.ShopGui.MainFrame.TabFrame.ShopFrame.ScrollingFrameChests.FrameEvent:FindFirstChild("+5 Mega Thrusters")

if Value then
if oldMega then
    oldMega:Destroy()
end

local plr = game.Players.LocalPlayer
local plrgui = plr.PlayerGui

local shopgui = plrgui.ShopGui.MainFrame.TabFrame.ShopFrame.ScrollingFrameChests
local example = shopgui.FrameEvent["+5 Dragon Harpoons"]:Clone()

example.Parent = shopgui.FrameEvent
example.Name = "+5 Mega Thrusters"
example.LimitedImage.Visible = false
example.ReturnText.Visible = false
example.TextLabel.Text = "200"
example.Desc.Value = "Gain 5 Mega Thrusters!"

example.Image = "rbxassetid://1358894694"
example.Visible = true
example.Position = UDim2.new(0, 0, 0, 0)

shopgui.FrameEvent.Visible = true

example.MouseButton1Click:Connect(function()
		local selectedframe = plrgui.ShopGui.MainFrame.TabFrame.ShopFrame.SelectedFrame
		selectedframe.FocusImage.Visible = true
		selectedframe.FocusImage.Image = "rbxassetid://1358894694"
		selectedframe.FocusImage.Quantity.Visible = true
		selectedframe.FocusImage.Quantity.Text = "x5"
		selectedframe.Cost.Visible = true
		selectedframe.Cost.Text = "200 robux"

		selectedframe.FocusImage.Title.Text = "+5 Mega Thrusters"
		selectedframe.TextBox.Text = "Gain 5 Mega Thrusters!"

		selectedframe.BuyFrame.ToggleGiftButton.Visible = false
		selectedframe.BuyFrame.BuyButton.QuantityFrame.Visible = false
		selectedframe.BuyFrame.BuyButton.Visible = true 
end)

else

if oldMega then
    oldMega:Destroy()
end

end

    end
})

local BuyGroup = Tabs.Shop:AddGroupbox({
    Side = "Left",
    Name = "Buy",
    Description = "Purchase items that are available in the store here, with custom quantity.",
    IconName = "handbag",
})

local Item = "Sign"
local Quantity = 1
local Gold = "idk bro"

BuyGroup:AddButton({
    Text = "Buy",
    Risky = false,
    Tooltip = "This may consume/alter the gold balance on your account.",
    DoubleClick = true,

    Func = function()
        local function checkPrice()
            local amount = tonumber(Quantity)

            if not amount or amount <= 0 or amount % 1 ~= 0 then
                notification("Error", "Enter a valid quantity!", 5)
                return
            end

            local remote = workspace:WaitForChild("ItemBoughtFromShop")
            local remaining = amount

            while remaining > 0 do
                local batch = math.min(remaining, 1000)

                local success, result = pcall(function()
                    return remote:InvokeServer(Item, batch)
                end)

                if not success then
                    notification("Error", tostring(result), 5)
                    break
                end

                remaining = remaining - batch

                task.wait(0.1)
            end

            if remaining == 0 then
                notification(
                    "Purchase!",
                    "Requested: " .. amount .. " " .. Item,
                    5
                )
            end
        end

        checkPrice()
    end
})

local BuyGoldText = BuyGroup:AddLabel(
    '<font color="rgb(255, 255, 0)">Gold: </font>',
    true
)

BuyGroup:AddInput("Block", {
	Default = "",
	Numeric = false, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Block:",

	Callback = function(Value)

Item = Value

	end,
})

BuyGroup:AddInput("Quantity", {
	Default = "",
	Numeric = true, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Quantity:",

	Callback = function(Value)

local QuantityGold = nil

Quantity = tonumber(Value) or 0
local scrollingeventitems = player.PlayerGui.ShopGui.MainFrame.TabFrame.ShopFrame.ScrollingFrameChests

for iGold,vGold in ipairs(scrollingeventitems:GetDescendants()) do

if vGold.Name == Item then

QuantityGold = vGold.TextLabel.Text
local itemPrice = tonumber(QuantityGold)

if itemPrice then
    Gold = Quantity * itemPrice
    BuyGoldText:SetText(
        '<font color="rgb(255, 255, 0)">Gold: ' .. tostring(Gold) .. '</font>'
    )
end

end

end

	end,
})

local AutoBuyGroup = Tabs.Shop:AddGroupbox({
    Side = "Right",
    Name = "Auto Buy",
    Description = "Purchase automation.",
    IconName = "shopping-cart-plus",
})

local Interval = nil

local IntervalSlider = AutoBuyGroup:AddSlider("Interval", {
    Text = "Interval:",
    Tooltip = "In seconds! No milliseconds.",
    Default = 2,
    Min = 0.1,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)

Interval = Value

    end
})

local Item2 = "Sign"
local Quantity2 = 1
local Gold2 = "idk bro"

local AutoBuyGold = AutoBuyGroup:AddLabel(
    '<font color="rgb(255, 255, 0)">Gold: </font>',
    true
)

AutoBuyGroup:AddInput("Item", {
	Default = "",
	Numeric = false, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Block:",

	Callback = function(Value)

Item2 = Value

	end,
})

AutoBuyGroup:AddInput("Quantity", {
	Default = "",
	Numeric = true, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Quantity:",

	Callback = function(Value)

local QuantityGold2 = nil

Quantity2 = tonumber(Value) or 0
local scrollingeventitems = player.PlayerGui.ShopGui.MainFrame.TabFrame.ShopFrame.ScrollingFrameChests

for iGold2,vGold2 in ipairs(scrollingeventitems:GetDescendants()) do

if vGold2.Name == Item2 then

QuantityGold2 = vGold2.TextLabel.Text
local itemPrice2 = tonumber(QuantityGold2)

if itemPrice2 then
    Gold2 = Quantity2 * itemPrice2
    AutoBuyGold:SetText(
        '<font color="rgb(255, 255, 0)">Gold: ' .. tostring(Gold2) .. '</font>'
    )
end

end

end

  end

})

local autobuyenabled = false

local AutoBuyToggle = AutoBuyGroup:AddToggle("BuyToggle", {
    Text = "Enable Auto Buy",
    Default = false,
    Callback = function(Value)

autobuyenabled = Value

while autobuyenabled == true and task.wait(Interval) do

        local function checkPrice()
            local amount2 = tonumber(Quantity2)

            if not amount2 or amount2 <= 0 or amount2 % 1 ~= 0 then
                notification("Error", "Enter a valid quantity!", 5)
                return
            end

            local remote2 = workspace:WaitForChild("ItemBoughtFromShop")
            local remaining2 = amount2

            while remaining2 > 0 do
                local batch2 = math.min(remaining2, 1000)

                local success, result = pcall(function()
                    return remote2:InvokeServer(Item2, batch2)
                end)

                if not success then
                    notification("Error", tostring(result), 5)
                    break
                end

                remaining2 = remaining2 - batch2

                task.wait(0.1)
            end

            if remaining2 == 0 then
                notification(
                    "Purchase!",
                    "Requested: " .. amount2 .. " " .. Item2,
                    5
                )
            end
        end

        checkPrice()

end

	end,
})

local RobuxGroup = Tabs.Shop:AddGroupbox({
    Side = "Right",
    Name = "Robux",
    Description = "Purchase robux items instantly!",
    IconName = "circle-dollar-sign",
})

local SelectedRobuxItem = nil

RobuxGroup:AddButton({
    Text = "Buy",
    DoubleClick = true,

    Func = function()

local id = nil

if SelectedRobuxItem == "+5 Dragon Harpoons" then

id = 1109792341

end

if SelectedRobuxItem == "+4 Cookie Wheels" then

id = 1126385328

end

if SelectedRobuxItem == "+5 Dual Harpoons" then

id = 915766549

end

if SelectedRobuxItem == "+3 Ultra Boat Motors" then

id = 944487410

end

if SelectedRobuxItem == "+4 Huge Wheels" then

id = 260358235

end

if SelectedRobuxItem == "+4 Portals" then

id = 811892987

end

if SelectedRobuxItem == "+5 Golden Harpoons" then

id = 641075523

end

if SelectedRobuxItem == "+3 Ultra Jetpacks" then

id = 558757040

end

if SelectedRobuxItem == "+3 Sonic Jet Turbines" then

id = 424770683

end

if SelectedRobuxItem == "+5 Ultra Thrusters" then

id = 534134763

end

if SelectedRobuxItem == "+100 Neon Blocks" then

id = 507954328

end

if SelectedRobuxItem == "+5 Mega Thrusters" then

id = 139121474

end

task.wait(0.2)

local args = {
    [1] = id,
    [2] = "Product"
}

workspace:WaitForChild("PromptRobuxEvent"):InvokeServer(unpack(args))

notification("Donate Purchase!", tostring("Requested: "..SelectedRobuxItem.."!"), 5)

    end
})

local RobuxDropdown = RobuxGroup:AddDropdown("MyDropdown", {
    Text = "Select Robux Item:",
    Values = { "+4 Huge Wheels", "+3 Ultra Boat Motors", "+5 Golden Harpoons", "+3 Sonic Jet Turbines", "+4 Portals", "+3 Ultra Jetpacks", "+5 Ultra Thrusters", "+100 Neon Blocks", "+5 Dragon Harpoons", "+4 Cookie Wheels", "+5 Dual Harpoons", "+5 Mega Thrusters" },
    Default = "+4 Huge Wheels",
    Multi = false,
    Callback = function(Value)

SelectedRobuxItem = Value

    end
})

local OtherGroup = Tabs.Shop:AddGroupbox({
    Side = "Right",
    Name = "Other",
    IconName = "ellipsis-vertical",
})

local CheckName = OtherGroup:AddToggle("CheckName", {
    Text = "Enable Item Checker",
    Tooltip = "When you click on an item in the shop, it displays the item's name as it appears in the game files for Buy or Auto Buy.",
    Default = false,
    Callback = function(Value)

        local name = player.PlayerGui.ShopGui.MainFrame.TabFrame.ShopFrame.SelectedFrame.FocusImage.Title

        if Value == true then
            -- Toggle включён
            if not _G.NameCheckerConnection then
                _G.NameCheckerConnection = name:GetPropertyChangedSignal("Text"):Connect(function()
                    notification("Detect!", "Item name: " .. name.Text .. ".")
                end)
            end
        else
            -- Toggle выключен
            if _G.NameCheckerConnection then
                _G.NameCheckerConnection:Disconnect()
                _G.NameCheckerConnection = nil
            end
        end

    end
})

local hidepopup = false

local HidePopup = OtherGroup:AddToggle("HidePopup", {
    Text = "Hide Reward Popup",
    Default = false,

    Callback = function(Value)
        hidepopup = Value

        if not hidepopup then
            return
        end

        task.spawn(function()
            while hidepopup do
                local playerGui = player:WaitForChild("PlayerGui")

                local template = playerGui:FindFirstChild("Template")

                if template then
                    for _, v in ipairs(template:GetDescendants()) do
                        if v.Name == "ShortShine" and v:IsA("Sound") then
                            v.Volume = 0.5
                        end
                    end
                end

                for _, gui in ipairs(playerGui:GetChildren()) do
                    if gui:IsA("ScreenGui")
                    and (gui.Name == "NoChestAnimation"
                    or gui.Name == "OpenChestAnimation")
                    and gui ~= template then

                        gui.Enabled = false
                        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)

                        for _, v in ipairs(gui:GetDescendants()) do
                            if v.Name == "ShortShine"
                            and v:IsA("Sound") then
                                v.Volume = 0
                            end
                        end
                    end
                end

                task.wait(0.1)
            end
        end)
    end
})

local GoldFarmGroup = Tabs.AutoFarm:AddGroupbox({
    Side = "Left",
    Name = "Auto Farm",
    Description = "Get gold automatically!",
    IconName = "coins",
})

do

_G.FarmEnabled = false
_G.IncludeGoldBlocks = true

local debounce = false
local alt_debounce = false
local characterConnection

local claimriver = workspace.ClaimRiverResultsGold

local stages = workspace.BoatStages.NormalStages

local stage1 = stages.CaveStage1.DarknessPart
local stage2 = stages.CaveStage2.DarknessPart
local stage3 = stages.CaveStage3.DarknessPart
local stage4 = stages.CaveStage4.DarknessPart
local stage5 = stages.CaveStage5.DarknessPart
local stage6 = stages.CaveStage6.DarknessPart
local stage7 = stages.CaveStage7.DarknessPart
local stage8 = stages.CaveStage8.DarknessPart
local stage9 = stages.CaveStage9.DarknessPart
local stage10 = stages.CaveStage10.DarknessPart
local stageend = stages.TheEnd
local chest = stageend.GoldenChest.Trigger

local GoldGained = GoldFarmGroup:AddLabel("Gold Gained: 0", true)
local GoldPerHour = GoldFarmGroup:AddLabel("Gold / Hour: 0", true)
local GoldPerDay = GoldFarmGroup:AddLabel("Gold / 24 Hours: 0", true)
local Gold = player.Data:WaitForChild("Gold")

local TotalGoldGained = 0
local StartGold = Gold.Value
local FarmStartTime = 0
local TrackingGold = false

Gold.Changed:Connect(function(NewValue)

    if not TrackingGold then return end

    local difference = NewValue - StartGold

    if difference > 0 then
        TotalGoldGained += difference
    end

    StartGold = NewValue

    GoldGained:SetText("Gold Gained: " .. TotalGoldGained)

end)

local function StartGoldCounter()

    StartGold = Gold.Value
    TotalGoldGained = 0
    FarmStartTime = os.clock()
    TrackingGold = true

    GoldGained:SetText("Gold Gained: 0")
    GoldPerHour:SetText("Gold / Hour: 0")
    GoldPerDay:SetText("Gold / 24 Hours: 0")

    task.spawn(function()

        while TrackingGold do

            local elapsed = os.clock() - FarmStartTime

            if elapsed > 0 then

                local perHour = TotalGoldGained / elapsed * 3600
                local perDay = perHour * 24

                GoldPerHour:SetText(
                    "Gold / Hour: " .. math.floor(perHour)
                )

                GoldPerDay:SetText(
                    "Gold / 24 Hours: " .. math.floor(perDay)
                )

            end

            task.wait(1)

        end

    end)

end

local function StopGoldCounter()

    TrackingGold = false
    TotalGoldGained = 0

    GoldGained:SetText("Gold Gained: 0")
    GoldPerHour:SetText("Gold / Hour: 0")
    GoldPerDay:SetText("Gold / 24 Hours: 0")

end
GoldFarmGroup:AddDivider("")

local GoldFarm = GoldFarmGroup:AddToggle("GoldFarm", {
    Text = "Gold Farm",
    Default = false,
    Callback = function(Value)

local TweenService = game:GetService("TweenService")

local function claim()
claimriver:FireServer()
end

local function clearchest(stage)
root.Anchored = true
task.wait(0.5)
root.Position = chest.Position+Vector3.new(0,2,-50)
root.Anchored = false
task.wait(0.5)
root.Position = chest.Position
task.wait(0.4)
root.Position = stage.Position
end

local function stopfarm()

alt_debounce = true 
task.wait(2)
alt_debounce = false

end

local function farm()
if debounce == false then
debounce = true
task.wait(0.2)
root.Anchored = true

root.Position = stage1.Position+Vector3.new(0,0,-150)
task.wait(3)
root.Anchored = false
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage1.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage1.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage2.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage2.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage3.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage3.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage4.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage4.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage5.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage5.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
root.Position = stage5.Position
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage6.Position,
}):Play()
task.wait(0.5)
if _G.IncludeGoldBlocks then
clearchest(stage6)
else

end
if humanoid.Health == 0 then
stopfarm()
end
if not root then
stopfarm()
end
if alt_debounce == true then return end
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage6.Position,
}):Play()
task.wait(0.05)
if alt_debounce == true then return end
claim()
task.wait(1)
if alt_debounce == true then return end
claim()
task.wait(0.3)
if alt_debounce == true then return end
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage7.Position,
}):Play()
task.wait(1)
if alt_debounce == true then return end
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage7.Position,
}):Play()
task.wait(0.5)
if alt_debounce == true then return end
claim()
task.wait(0.5)
if alt_debounce == true then return end
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage8.Position,
}):Play()
task.wait(1)
if alt_debounce == true then return end
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage8.Position,
}):Play()
task.wait(0.3)
if alt_debounce == true then return end
claim()
task.wait(0.5)
if alt_debounce == true then return end
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage9.Position,
}):Play()
task.wait(1)
if alt_debounce == true then return end
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage9.Position,
}):Play()
task.wait(0.3)
if alt_debounce == true then return end
claim()
task.wait(0.5)
if alt_debounce == true then return end
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage10.Position,
}):Play()
task.wait(1)
if alt_debounce == true then return end
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage10.Position,
}):Play()
task.wait(0.3)
if alt_debounce == true then return end
claim()
task.wait(0.5)
if alt_debounce == true then return end
stopfarm()
debounce = false
end
end


    _G.FarmEnabled = Value

if Value then
    StartGoldCounter()
else
    StopGoldCounter()
end

    if Value then
        if not characterConnection then
            characterConnection = player.CharacterAdded:Connect(function(character)
                task.wait(0.)
                if _G.FarmEnabled and not debounce then
                    stopfarm()

                    farm()
                end
            end)
        end

        if not debounce then
            stopfarm()
            farm()
        end
    else
        if characterConnection then
            characterConnection:Disconnect()
            characterConnection = nil
        end
    end

    end
})

end

local IncludeGoldBlocks = GoldFarmGroup:AddToggle("IncludeBlock", {
    Text = "Include Gold Blocks",
    Default = true,
    Callback = function(Value)

_G.IncludeGoldBlocks = Value

    end
})

local disablegoldreward = false

local DisableGold = GoldFarmGroup:AddToggle("DisableGold", {
    Text = "Disable Gold Reward Sound",
    Default = false,
    Callback = function(Value)

disablegoldreward = Value

while disablegoldreward == true and task.wait(0.1) do

player.PlayerGui.GoldGainedGui:Wait()

local goldgained = 2
local purchase = 0.5

local sounds_place = player.PlayerGui.GainedGoldGui.Gain
sounds_place.GoldGainedSound.Volume = 0
sounds_place.PurchaseSound1.Volume = 0
sounds_place.PurchaseSound2.Volume = 0
sounds_place.PurchaseSound3.Volume = 0


if disablegoldreward == false then

player.PlayerGui.GoldGainedGui:Wait()

local goldgained = 2
local purchase = 0.5

local sounds_place = player.PlayerGui.GainedGoldGui.Gain

sounds_place.GoldGainedSound.Volume = goldgained
sounds_place.PurchaseSound1.Volume = purchase
sounds_place.PurchaseSound2.Volume = purchase
sounds_place.PurchaseSound3.Volume = purchase

end

end

    end
})

local Disable3DRender = GoldFarmGroup:AddToggle("Disable3DRender", {
    Text = "Disable 3D Rendering",
    Default = false,
    Callback = function(Value)

local rs = game:GetService("RunService")
local setting = not Value
rs:Set3dRenderingEnabled(setting)

    end
})

local EventsGroup = Tabs.AutoFarm:AddGroupbox({
    Side = "Right",
    Name = "Events",
    Description = "Automatically collect candies and much more.",
    IconName = "sparkle"
})

local Event_Text = EventsGroup:AddLabel("Season: Definition...", true)
task.wait(0.1)
local Season = nil
local SeasonModule = require(game.ReplicatedStorage.Scripts.SeasonMS)
Season = SeasonModule.getSeason()
if Season == nil then
Event_Text:SetText("Event: No Event Found!")
else
Event_Text:SetText("Event: "..Season)
end

local HalloweenBox = EventsGroup:AddTabbox({
    Side = "Right", -- case-insensitive
    Name = "Halloween",
    -- MaxHeight = 300,
    -- PopOut = true,
    -- MaxPopOutHeight = 200,
    -- PopOutWidth = 280,
})

local HalloweenTab = HalloweenBox:AddTab("Halloween", "candy")

local autocollect = false
local success = nil 

local Houses_Text = HalloweenTab:AddLabel("Current Houses: I dont know", true)

task.spawn(function()
    while task.wait(0.1) do
        local count = 0

        for _, house in ipairs(workspace:WaitForChild("Houses"):GetChildren()) do
            if house:IsA("Model") and house.Name == "TrickOrTreatHouse" then
                count += 1
                Houses_Text:SetText("Houses: "..count)
            end
        end
    end
end)

local AutoCandy = HalloweenTab:AddToggle("AutoCandy", {
    Text = "Auto Collect Candy",
    Default = false,
    Callback = function(Value)

autocollect = Value

while autocollect == true and task.wait(0.1) do

for i,v in ipairs(workspace:WaitForChild("Houses"):GetDescendants()) do
  local Players = game:GetService("Players")
  local player = Players.LocalPlayer
  local character = player.Character or player.CharacterAdded:Wait()
  local humanoid = character:WaitForChild("Humanoid")
  
  if v.Name == "GiantHand" then
    v:Destroy()
  end

  if v.Name == "DoorInnerTouch" then
      v.Sound.Volume = 0
      v.Transparency = 1
      v.CFrame = character.HumanoidRootPart.CFrame
      success = true
  end
end

if success == true then

game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Options.WalkSpeed.Value

end

end

    end
})

HalloweenTab:AddButton("Collect All Candy at once", function()
    for i,v in ipairs(workspace:WaitForChild("Houses"):GetDescendants()) do
  local Players = game:GetService("Players")
  local player = Players.LocalPlayer
  local character = player.Character or player.CharacterAdded:Wait()
  local humanoid = character:WaitForChild("Humanoid")
  
  if v.Name == "GiantHand" then
    v:Destroy()
  end

  if v.Name == "DoorInnerTouch" then
      v.Sound.Volume = 0
      v.Transparency = 1
      v.CFrame = character.HumanoidRootPart.CFrame
      success = true
  end
end

if success == true then

game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Options.WalkSpeed.Value

end
end)

local DataGroup = Tabs.Inventory:AddGroupbox({
    Side = "Left",
    Name = "Fake Blocks",
    Description = "Generates fake blocks (which cannot be placed)",
    IconName = "box",
})

local DataItem = {}
local DataQuantity = 1

local OriginalValues = {}

for _, v in ipairs(player.Data:GetDescendants()) do
    if v:IsA("IntValue") then
        OriginalValues[v] = v.Value
    end
end


DataGroup:AddButton({
    Text = "Give",
    Risky = false,

    Func = function()
        local Data = player.Data
        local Quantity = tonumber(DataQuantity) or 1

        for ItemName, Selected in pairs(DataItem) do
            if Selected == true then
                local Item = Data:FindFirstChild(ItemName)

                if Item and Item:IsA("IntValue") then
                    Item.Value += Quantity
                end

            elseif type(ItemName) == "number" and type(Selected) == "string" then
                local Item = Data:FindFirstChild(Selected)

                if Item and Item:IsA("IntValue") then
                    Item.Value += Quantity
                end
            end
        end
    end
})

local Values = {}

for _, v in ipairs(player.Data:GetChildren()) do
    if v:IsA("IntValue")
        and v.Name ~= "Gold"
        and not v.Name:match("XY$")
        and not v.Name:match("XZ$")
        and not v.Name:match("YZ$")
        and not v.Name:match("[XYZ]$") then

        table.insert(Values, v.Name)
    end
end

local ItemsDropdown = DataGroup:AddDropdown("ItemsDropdown", {
    Text = "Select Block:",
    Values = Values,
    Default = {},
    Searchable = true,
    Multi = true,
    Callback = function(Value)
        DataItem = Value
    end
})
DataGroup:AddInput("QuantityInput", {
	Default = "",
	Numeric = true, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Select Quantity:",

	Callback = function(Value)

DataQuantity = Value

	end,
})

DataGroup:AddButton({
    Text = "Set all on 99999",
    Risky = false,
    DoubleClick = true,
    Func = function()

for _, v in ipairs(game.Players.LocalPlayer.Data:GetDescendants()) do
    if v:IsA("IntValue") and v.Name ~= "Gold" and v.Name ~= "BindTool" and v.Name ~= "PaintingTool" and v.Name ~= "PropertiesTool" and v.Name ~= "ScalingTool" and v.Name ~= "TrowelTool" then
        v.Value = 99999
    end
end
task.wait(0.3)
humanoid.Health = 0

    end
})

DataGroup:AddButton({
    Text = "Reset to normal values",
    Risky = false,
    DoubleClick = true,
    Func = function()

        for v, value in pairs(OriginalValues) do
            if v and v.Parent then
                v.Value = value
            end
        end

    end
})

local FakeGoldGroup = Tabs.Inventory:AddGroupbox({
    Side = "Left",
    Name = "Fake Gold",
    Description = "Generates fake gold (if buy something resets to normal)",
    IconName = "coins",
})

local DataQuantityF = 0

FakeGoldGroup:AddButton({
    Text = "Give",
    Risky = false,
    Func = function()

local Data = player.Data
Data:WaitForChild("Gold").Value += DataQuantityF

    end
})

FakeGoldGroup:AddInput("QuantityInput", {
	Default = "",
	Numeric = true, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Select Quantity:",

	Callback = function(Value)

DataQuantityF = Value

	end,
})

local text_popuuuu = FakeGoldGroup:AddLabel("You can use 'Reset to normal values' to back normal values of gold.", true)

local FuncGroup = Tabs.Inventory:AddGroupbox({
    Side = "Right",
    Name = "Blocks",
    Description = "Presets for blocks (attaching blocks using firework method) and much more.",
    IconName = "layers",
})

local unanchorfirework = true
local unanchorglue = true

FuncGroup:AddButton("Place Firework Method", function()
    

local function seat()
local args = {
    [1] = "Seat",
    [2] = player.Data.Seat.Value,
    [3] = workspace:WaitForChild("WhiteZone"),
    [4] = CFrame.new(4, 5.600000381469727, -138, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    [5] = true,
    [6] = CFrame.new(-49.56568908691406, -12.399991989135742, -483.5068664550781, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    [7] = false,
    [8] = true
}

game:GetService("Players").LocalPlayer.Character.BuildingTool.RF:InvokeServer(unpack(args))

end
local function firework()
local argsF = {
    [1] = "Firework",
    [2] = player.Data.Firework.Value,
    [3] = workspace:WaitForChild("Blocks"):WaitForChild("ValerikRobJR"):WaitForChild("Seat"):WaitForChild("Union"),
    [4] = CFrame.new(0, 2.6999998092651367, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    [5] = true,
    [6] = CFrame.new(-49.565673828125, -9.699992179870605, -483.5068359375, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    [7] = false,
    [8] = true
}

game:GetService("Players").LocalPlayer.Character.BuildingTool:WaitForChild("RF"):InvokeServer(unpack(argsF))
end
local function seat_delete()
local argsD = {
    [1] = workspace.Blocks[game.Players.LocalPlayer.Name]:WaitForChild("Seat")
}

game:GetService("Players").LocalPlayer.Character.DeleteTool.RF:InvokeServer(unpack(argsD))
end
local function firework_unanchor()
local args = {
    [1] = "Anchored",
    [2] = {
        [1] = workspace:WaitForChild("Blocks")[game.Players.LocalPlayer.Name]:WaitForChild("Firework")
    }
}

game:GetService("Players").LocalPlayer.Character.PropertiesTool.SetPropertieRF:InvokeServer(unpack(args))
end

local tool = "nofinded"

for i,v in ipairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
if v.Name == "BuildingTool" then
tool = "back"
end
end
for i,v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
if v.Name == "BuildingTool" then
tool = "char"
end
end

if tool == "back" then

game.Players.LocalPlayer.Backpack:WaitForChild("BuildingTool").Parent = game.Players.LocalPlayer.Character
task.wait(0.2)
seat()
game.Players.LocalPlayer.Character.HumanoidRootPart.Position = Vector3.new(-49.5656509, -8.86231422, -483.506897, -1, 0, 0, 0, 1, 0, 0, 0, -1)
task.wait(0.6)
firework()
task.wait(0.2)
game.Players.LocalPlayer.Character:WaitForChild("BuildingTool").Parent = game.Players.LocalPlayer.Backpack
game.Players.LocalPlayer.Backpack:WaitForChild("DeleteTool").Parent = game.Players.LocalPlayer.Character
task.wait(0.2)
seat_delete()
task.wait(0.2)
game.Players.LocalPlayer.Character:WaitForChild("DeleteTool").Parent = game.Players.LocalPlayer.Backpack
task.wait(0.1)
if unanchorfirework == true then
game.Players.LocalPlayer.Backpack:WaitForChild("PropertiesTool").Parent = game.Players.LocalPlayer.Character
firework_unanchor()
task.wait(0.2)
game.Players.LocalPlayer.Character:WaitForChild("PropertiesTool").Parent = game.Players.LocalPlayer.Backpack
end

end
if tool == "char" then
task.wait(0.2)
seat()
game.Players.LocalPlayer.Character.HumanoidRootPart.Position = Vector3.new(-49.5656509, -8.86231422, -483.506897, -1, 0, 0, 0, 1, 0, 0, 0, -1)
task.wait(0.6)
firework()
task.wait(0.2)
game.Players.LocalPlayer.Backpack:WaitForChild("DeleteTool").Parent = game.Players.LocalPlayer.Character
task.wait(0.2)
seat_delete()
task.wait(0.2)
game.Players.LocalPlayer.Character:WaitForChild("DeleteTool").Parent = game.Players.LocalPlayer.Backpack
task.wait(0.1)
if unanchorfirework == true then
game.Players.LocalPlayer.Backpack:WaitForChild("PropertiesTool").Parent = game.Players.LocalPlayer.Character
firework_unanchor()
task.wait(0.2)
game.Players.LocalPlayer.Character:WaitForChild("PropertiesTool").Parent = game.Players.LocalPlayer.Backpack
end

end

end)
FuncGroup:AddButton("Place Glue Method", function()
    

local function seat()
local args = {
    [1] = "Seat",
    [2] = 8054,
    [3] = workspace:WaitForChild("WhiteZone"),
    [4] = CFrame.new(4, 5.600000381469727, -138, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    [5] = true,
    [6] = CFrame.new(-49.56568908691406, -12.399991989135742, -483.5068664550781, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    [7] = false,
    [8] = true
}

game:GetService("Players").LocalPlayer.Character.BuildingTool.RF:InvokeServer(unpack(args))

end
local function firework()
local argsF = {
    [1] = "Glue",
    [2] = 1774,
    [3] = workspace:WaitForChild("Blocks"):WaitForChild("ValerikRobJR"):WaitForChild("Seat"):WaitForChild("PPart"),
    [4] = CFrame.new(0, 1.5, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    [5] = true,
    [6] = CFrame.new(-49.56568908691406, -10.899991989135742, -483.5068664550781, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    [7] = false,
    [8] = true
}

game:GetService("Players").LocalPlayer.Character.BuildingTool:WaitForChild("RF"):InvokeServer(unpack(argsF))

end
local function seat_delete()
local argsD = {
    [1] = workspace.Blocks[game.Players.LocalPlayer.Name]:WaitForChild("Seat")
}

game:GetService("Players").LocalPlayer.Character.DeleteTool.RF:InvokeServer(unpack(argsD))
end
local function firework_unanchor()
local args = {
    [1] = "Anchored",
    [2] = {
        [1] = workspace:WaitForChild("Blocks")[game.Players.LocalPlayer.Name]:WaitForChild("Glue")
    }
}

game:GetService("Players").LocalPlayer.Character.PropertiesTool.SetPropertieRF:InvokeServer(unpack(args))
end

local tool = "nofinded"

for i,v in ipairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
if v.Name == "BuildingTool" then
tool = "back"
end
end
for i,v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
if v.Name == "BuildingTool" then
tool = "char"
end
end

if tool == "back" then

game.Players.LocalPlayer.Backpack:WaitForChild("BuildingTool").Parent = game.Players.LocalPlayer.Character
task.wait(0.2)
seat()
game.Players.LocalPlayer.Character.HumanoidRootPart.Position = Vector3.new(-49.5656509, -8.86231422, -483.506897, -1, 0, 0, 0, 1, 0, 0, 0, -1)
task.wait(0.6)
firework()
task.wait(0.2)
game.Players.LocalPlayer.Character:WaitForChild("BuildingTool").Parent = game.Players.LocalPlayer.Backpack
game.Players.LocalPlayer.Backpack:WaitForChild("DeleteTool").Parent = game.Players.LocalPlayer.Character
task.wait(0.2)
seat_delete()
task.wait(0.2)
game.Players.LocalPlayer.Character:WaitForChild("DeleteTool").Parent = game.Players.LocalPlayer.Backpack
task.wait(0.1)
if unanchorglue == true then
game.Players.LocalPlayer.Backpack:WaitForChild("PropertiesTool").Parent = game.Players.LocalPlayer.Character
firework_unanchor()
task.wait(0.2)
game.Players.LocalPlayer.Character:WaitForChild("PropertiesTool").Parent = game.Players.LocalPlayer.Backpack
end

end
if tool == "char" then
task.wait(0.2)
seat()
game.Players.LocalPlayer.Character.HumanoidRootPart.Position = Vector3.new(-49.5656509, -8.86231422, -483.506897, -1, 0, 0, 0, 1, 0, 0, 0, -1)
task.wait(0.6)
firework()
task.wait(0.2)
game.Players.LocalPlayer.Backpack:WaitForChild("DeleteTool").Parent = game.Players.LocalPlayer.Character
task.wait(0.2)
seat_delete()
task.wait(0.2)
game.Players.LocalPlayer.Character:WaitForChild("DeleteTool").Parent = game.Players.LocalPlayer.Backpack
task.wait(0.1)
if unanchorglue == true then
game.Players.LocalPlayer.Backpack:WaitForChild("PropertiesTool").Parent = game.Players.LocalPlayer.Character
firework_unanchor()
task.wait(0.2)
game.Players.LocalPlayer.Character:WaitForChild("PropertiesTool").Parent = game.Players.LocalPlayer.Backpack
end

end

end)
local UnanchorFirework = FuncGroup:AddToggle("UnanchorFirework", {
    Text = "Unanchor Firework",
    Default = true,
    Callback = function(Value)

unanchorfirework = Value

    end
})
local UnanchorGlue = FuncGroup:AddToggle("UnanchorGlue", {
    Text = "Unanchor Glue",
    Default = true,
    Callback = function(Value)

unanchorglue = Value

    end
})

local codes_session = false

local CodesGroup = Tabs.Inventory:AddGroupbox({
    Side = "Right",
    Name = "Codes",
    Description = "Redeem all codes at once.",
    IconName = "ticket",
})

CodesGroup:AddButton("Redeem all codes", function()
if codes_session == false then
codes_session = true
local checkcodefunction = workspace.CheckCodeFunction

local code_1 = "=p"
local code_2 = "hi"
local code_3 = "=d"
local code_4 = "chillthrill709 was here"

notification("Code", "Finded 4 codes.", 5)
task.wait(0.4)
workspace:WaitForChild("CheckCodeFunction"):InvokeServer(code_1)
notification("Code", "Redeemed "..code_1.."!")

task.wait(4)
workspace:WaitForChild("CheckCodeFunction"):InvokeServer(code_2)
notification("Code", "Redeemed "..code_2.."!")
task.wait(4)
workspace:WaitForChild("CheckCodeFunction"):InvokeServer(code_3)
notification("Code", "Redeemed "..code_3.."!")
task.wait(4)
workspace:WaitForChild("CheckCodeFunction"):InvokeServer(code_4)
notification("Code", "Redeemed "..code_4.."!")
task.wait(0.2)
notification("Code", "Redeemed all codes!")

codes_session = false

else

notification("Code", "Codes redeeming right now! Please wait...", 5)

end
end)

local GiftGroup = Tabs.Inventory:AddGroupbox({
    Side = "Right",
    Name = "Fake Gift",
    IconName = "gift",
})

local gifttitle = "🎖 Boat of the week 🎖 bought you a gift!"
local goldreward = 50000
local blockrewards = {}

local function createGift(title, gold, blocks)

    local giftgui = player.PlayerGui.GiftNotification

    giftgui.Frame.Visible = true
    giftgui.Frame.TextLabel.Text = title

    giftgui.Frame.Yes.MouseButton1Click:Wait()

    local data = player.Data
    giftgui.Frame.Visible = false

    data:WaitForChild("Gold").Value += gold

    for blockName, selected in pairs(blocks) do
        if selected then
            local block = data:FindFirstChild(blockName)

            if block then
                block.Value += blockamount
            end
        end
    end
end

GiftGroup:AddButton({
    Text = "Gift",
    Func = function()
        createGift(gifttitle, goldreward, blockrewards)
    end
})

GiftGroup:AddInput("Title", {
    Default = "🎖 Boat of the week 🎖 bought you a gift!",
    Numeric = false,
    Finished = false,
    ClearTextOnFocus = false,
    Text = "Gift Title:",
    Callback = function(Value)
        gifttitle = Value
    end,
})

GiftGroup:AddDivider("Rewards")

GiftGroup:AddInput("GoldReward", {
    Default = 50000,
    Numeric = true,
    Finished = false,
    ClearTextOnFocus = false,
    Text = "Gold Amount:",
    Callback = function(Value)
        goldreward = tonumber(Value) or 0
    end,
})

local ValuesF = {}

for _, v in ipairs(player.Data:GetChildren()) do
    if v:IsA("IntValue")
        and not v.Name:match("XY$")
        and not v.Name:match("XZ$")
        and not v.Name:match("YZ$")
        and not v.Name:match("[XYZ]$") then

        table.insert(ValuesF, v.Name)
    end
end

local Block = GiftGroup:AddDropdown("BlockReward", {
    Text = "Blocks:",
    Values = ValuesF,
    Default = {},
    Searchable = true,
    Multi = true,

    Callback = function(Value)
        blockrewards = Value
    end
})

GiftGroup:AddInput("BlockAmount", {
    Default = 1,
    Numeric = true,
    Finished = false,
    ClearTextOnFocus = false,
    Text = "Block Amount:",
    Callback = function(Value)
        blockamount = tonumber(Value) or 1
    end,
})

local SlotsGroup = Tabs.Inventory:AddGroupbox({
    Side = "Left",
    Name = "Slots",
    IconName = "ethernet-port",
})

local slotsframe = player.PlayerGui.ShopGui.MainFrame.TabFrame.SlotsFrame.ScrollingFrameSlots

local slots = {}
local selectedslot

local EnableStar
local StarColor
local SlotSelect

local slots = {}

for _, slot in ipairs(slotsframe:GetDescendants()) do
    if slot:IsA("ImageButton")
        and slot.Name:match("^BoatSlot")
        and slot.Name ~= "BoatSlot"
        and slot.Name ~= "BoatSlot999+"
        and slot.Name ~= "BoatSlotTemplate" then

        table.insert(slots, slot.Name)
    end
end

    table.sort(slots, function(a, b)
        return (tonumber(a:match("%d+")) or 0) <
               (tonumber(b:match("%d+")) or 0)
    end)

if #slots > 0 then
    selectedslot = slotsframe:FindFirstChild(slots[1])
else

end

SlotSelect = SlotsGroup:AddDropdown("SlotSelect", {
    Text = "Slot:",
    Values = slots,
    Default = "BoatSlot1",
    Multi = false,

Callback = function(Value)
    selectedslot = slotsframe:FindFirstChild(Value)

    if not selectedslot then

        return
    end

    local star = selectedslot:FindFirstChild("StarImage")

    if star then
        star.Visible = EnableStar.Value
        star.ImageColor3 = StarColor.Value
    end
end
})

EnableStar = SlotsGroup:AddToggle("EnableStar", {
    Text = "Enable Star",
    Default = false,

    Callback = function(Value)
        if selectedslot and selectedslot:FindFirstChild("StarImage") then
            selectedslot.StarImage.Visible = Value
        end
    end
})

StarColor = EnableStar:AddColorPicker("StarColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Resizable = true,

    Callback = function(Value)
        if selectedslot and selectedslot:FindFirstChild("StarImage") then
            selectedslot.StarImage.ImageColor3 = Value
        end
    end
})

SlotsGroup:AddButton("Reset Slots", function()

    slots = {}

    for _, slot in ipairs(slotsframe:GetDescendants()) do
        if slot:IsA("ImageButton")
            and slot.Name:match("^BoatSlot")
            and slot.Name ~= "BoatSlot"
            and slot.Name ~= "BoatSlot999+"
            and slot.Name ~= "BoatSlotTemplate" then

            table.insert(slots, slot.Name)
        end
    end

    table.sort(slots, function(a, b)
        return (tonumber(a:match("%d+")) or 0) <
               (tonumber(b:match("%d+")) or 0)
    end)

    SlotSelect:SetValues(slots)

end)

local QuestsGroup = Tabs.Quests:AddGroupbox({
    Side = "Left",
    Name = "Quests",
    Description = "Auto quests and more.",
    IconName = "sticky-note",
})

local questnumber = 1

local questtext = QuestsGroup:AddLabel("Quest: 1", true)

QuestsGroup:AddInput("QuestNumber", {
	Default = "",
	Numeric = true, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Quest Number:",

	Placeholder = "1", -- placeholder text when the box is empty
	-- MaxLength is also an option which is the max length of the text

	Callback = function(Value)

questnumber = Value
questtext:SetText("Quest: "..questnumber)

	end,
})
QuestsGroup:AddDivider("Or")
local QuestName = QuestsGroup:AddDropdown("QuestName", {
    Text = "Quest Name:",
    Values = { "Cloud", "Target", "Soccer", "Ramp", "Find Me", "Dragon", "The Box", "Thin Ice", "The Boss", "Invasion" },
    Default = "Cloud",
    Multi = false,
    Callback = function(Value)

if Value == "Cloud" then
questnumber = 1
end
if Value == "Target" then
questnumber = 2
end
if Value == "Soccer" then
questnumber = 8
end
if Value == "Ramp" then
questnumber = 3
end
if Value == "Find Me" then
questnumber = 4
end
if Value == "Dragon" then
questnumber = 5
end
if Value == "The Box" then
questnumber = 6
end
if Value == "Thin Ice" then
questnumber = 9
end
if Value == "The Boss" then
questnumber = 100
end
if Value == "Invasion" then
questnumber = 101
end

questtext:SetText("Quest: "..questnumber)

    end
})

QuestsGroup:AddButton({
    Text = "Complete Quest",
    Func = function()

local questevent = workspace.QuestMakerEvent

if questnumber == 1 then

questevent:FireServer(questnumber)

task.wait(3)

root.Position = team:WaitForChild("Quest"):WaitForChild("Cloud").Part4.Position
task.wait(0.5)
root.Position = team.Position+Vector3.new(0,20,0)

end

if questnumber == 2 then

questevent:FireServer(questnumber)

task.wait(1)

root.Position = team:WaitForChild("Quest"):WaitForChild("Target").Part.Position
task.wait(0.5)
root.Position = team.Position+Vector3.new(0,20,0)

end

if questnumber == 8 then

questevent:FireServer(questnumber)

task.wait(2)

local qe = team:WaitForChild("Quest"):WaitForChild("Soccer1").SoccerBall
qe.CanCollide = false
notification("Auto Quest", "You can move soccer right now! Complete quest.", 5)

end
if questnumber == 3 then

questevent:FireServer(questnumber)

task.wait(3)

for _,quest in ipairs(team:WaitForChild("Quest"):WaitForChild("Ramp"):GetDescendants()) do
if quest:IsA("MeshPart") then

root.Position = quest.Position
end
end
task.wait(1)
root.Position = team.Position+Vector3.new(0,50,0)

end
if questnumber == 4 then

questevent:FireServer(questnumber)

task.wait(2)

fireclickdetector(team:WaitForChild("Quest"):WaitForChild("Butter").PPart.ClickDetector)
task.wait(2.5)
fireclickdetector(team:WaitForChild("Quest"):WaitForChild("Butter").PPart.ClickDetector)
task.wait(2.5)
fireclickdetector(team:WaitForChild("Quest"):WaitForChild("Butter").PPart.ClickDetector)
task.wait(2.5)
fireclickdetector(team:WaitForChild("Quest"):WaitForChild("Butter").PPart.ClickDetector)
task.wait(2.5)
fireclickdetector(team:WaitForChild("Quest"):WaitForChild("Butter").PPart.ClickDetector)


end
if questnumber == 6 then


questevent:FireServer(questnumber)

task.wait(2)

team:WaitForChild("VoteLaunchRE"):FireServer()
task.wait(0.2)
team:WaitForChild("Quest").MBox.PPart.Anchored = true
team:WaitForChild("Quest").MBox.PPart.Position = Vector3.new(-55.7065125, -358.739624, 9492.35645)
task.wait(0.2)
team:WaitForChild("Quest").MBox.PPart.Anchored = false

end

if questnumber == 9 then

questevent:FireServer(questnumber)

task.wait(3)

team:WaitForChild(
  "VoteLaunchRE"
):FireServer()
task.wait(0.5)

local claimriver = workspace.ClaimRiverResultsGold

local stages = workspace.BoatStages.NormalStages

local stage1 = stages.CaveStage1.DarknessPart
local stage2 = stages.CaveStage2.DarknessPart
local stage3 = stages.CaveStage3.DarknessPart
local stage4 = stages.CaveStage4.DarknessPart
local stage5 = stages.CaveStage5.DarknessPart
local stage6 = stages.CaveStage6.DarknessPart
local stage7 = stages.CaveStage7.DarknessPart
local stage8 = stages.CaveStage8.DarknessPart
local stage9 = stages.CaveStage9.DarknessPart
local stage10 = stages.CaveStage10.DarknessPart
local stageend = stages.TheEnd
local chest = stageend.GoldenChest.Trigger

local TweenService = game:GetService("TweenService")

local function claim()
claimriver:FireServer()
end

task.wait(0.2)
root.Anchored = true

root.Position = stage1.Position+Vector3.new(0,0,-150)
task.wait(3)
root.Anchored = false
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage1.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage1.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage2.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage2.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage3.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage3.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage4.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage4.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage5.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage5.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
root.Position = stage5.Position
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage6.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage6.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.3)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage7.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage7.Position,
}):Play()
task.wait(0.5)
claim()
task.wait(0.5)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage8.Position,
}):Play()
task.wait(1)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage8.Position,
}):Play()
task.wait(0.3)
claim()
task.wait(0.5)
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage9.Position,
}):Play()
task.wait(1)
root.Anchored = true
task.wait(1)
root.Position = stages.TheEnd.GoldenChest.Trigger.Position+Vector3.new(0,0,-50)
root.Anchored = false

end

if questnumber == 5 then

questevent:FireServer(questnumber)

task.wait(0.5)

team:WaitForChild(
  "VoteLaunchRE"
):FireServer()

task.wait(4)

team:WaitForChild("Quest").Dragon.HumanoidRootPart.Anchored = true
notification("Auto Quest", "Dragon anchored, you can kill him now!", 5)

end

    end

})
QuestsGroup:AddButton({
    Text = "Start Quest",
    Func = function()

        if questnumber == 100 then
            notification(
                "Auto Quest",
                "This quest 'The Boss, Fabbi the duck' has been deleted in 2023. NO BREAD :(((",
                8
            )
            return
        end

        if questnumber == 101 then
            local success, season = pcall(function()
                return require(
                    game.ReplicatedStorage.Modules.SeasonMS
                ).getSeason()
            end)

            if not success or season ~= "Christmas" then
                notification(
                    "Auto Quest",
                    "This quest only available on christmas.",
                    8
                )
                return
            end
        end

        workspace.QuestMakerEvent:FireServer(questnumber)

    end
})
QuestsGroup:AddButton({
    Text = "End Quest",
    Func = function()

workspace.QuestMakerEvent:FireServer(
  0
)

    end
})

QuestsGroup:AddDivider("")

local AddInvasion = QuestsGroup:AddToggle("AddInvasion", {
    Text = "Add Invasion Button",
    Default = false,
    Callback = function(Value)

local quests = player.PlayerGui.ShopGui.MainFrame.TabFrame.QuestFrame.ScrollingFrame

quests.Quest101.Visible = Value

    end
})

local AddInvasion = QuestsGroup:AddToggle("AddInvasion", {
    Text = "Add The Boss Button",
    Default = false,
    Callback = function(Value)

local quests = player.PlayerGui.ShopGui.MainFrame.TabFrame.QuestFrame.ScrollingFrame
local queststab = player.PlayerGui.ShopGui.MainFrame.TabFrame.QuestFrame.SelectedFrame

local oldQuest = quests:FindFirstChild("Quest100")

if oldQuest then
    oldQuest:Destroy()
end

local example = quests:WaitForChild("Quest101"):Clone()
example.Parent = quests
example.Name = "Quest100"

example.QuestNum.Value = 100
example.ReturnText.Visible = false
example.QuestImage.Title.Text = "The Boss"
example.Visible = false
example.QuestImage.Image = "rbxassetid://117256246837572"
example.Desc.Value = " "
example.LimitedImage.Visible = false

example.MouseButton1Click:Connect(function()
    queststab.QuestNum.Value = 100

    queststab.RewardsScrollingFrame.Reward:Destroy()
    local reward = queststab.RewardsScrollingFrame:FindFirstChild("Reward")

    if reward then
        reward.Checkmark.Visible = false
        reward.Image = "rbxassetid://2102742548"
        reward.AmountText.Text = "10"
    end

    queststab.FocusImage.Image = "rbxassetid://117256246837572"
    queststab.Description.Text = " "
    queststab.Title.Text = "- The Boss -"
end)

example.Visible = Value

    end
})

local AddRings = QuestsGroup:AddToggle("AddRings", {
    Text = "Add Rings Button",
    Default = false,
    Callback = function(Value)

local quests = player.PlayerGui.ShopGui.MainFrame.TabFrame.QuestFrame.ScrollingFrame
local queststab = player.PlayerGui.ShopGui.MainFrame.TabFrame.QuestFrame.SelectedFrame

local oldQuest = quests:FindFirstChild("Quest50")

if oldQuest then
    oldQuest:Destroy()
end

local example = quests:WaitForChild("Quest101"):Clone()
example.Parent = quests
example.Name = "Quest50"

example.QuestNum.Value = 50
example.ReturnText.Visible = false
example.QuestImage.Title.Text = "The Rings"
example.Visible = false
example.QuestImage.Image = "rbxassetid://85069659224366"
example.Desc.Value = " "
example.LimitedImage.Visible = false

example.MouseButton1Click:Connect(function()
    queststab.QuestNum.Value = 50


    queststab.RewardsScrollingFrame.Reward:Destroy()
    queststab.RewardsScrollingFrame.Reward:Destroy()

    queststab.FocusImage.Image = "rbxassetid://85069659224366"
    queststab.Description.Text = " "
    queststab.Title.Text = "- The Rings -"
end)

example.Visible = Value

    end
})
local AddSecretSoccer = QuestsGroup:AddToggle("AddSecretSoccer", {
    Text = "Add Secret Soccer Button",
    Default = false,
    Callback = function(Value)

local quests = player.PlayerGui.ShopGui.MainFrame.TabFrame.QuestFrame.ScrollingFrame
local queststab = player.PlayerGui.ShopGui.MainFrame.TabFrame.QuestFrame.SelectedFrame

local oldQuest = quests:FindFirstChild("Quest80")

if oldQuest then
    oldQuest:Destroy()
end

local example = quests:WaitForChild("Quest101"):Clone()
example.Parent = quests
example.Name = "Quest80"

example.QuestNum.Value = 80
example.ReturnText.Visible = false
example.QuestImage.Title.Text = "Secret Soccer"
example.Visible = false
example.QuestImage.Image = "rbxassetid://2732318916"
example.Desc.Value = " "
example.LimitedImage.Visible = false

example.MouseButton1Click:Connect(function()
    queststab.QuestNum.Value = 80


    queststab.RewardsScrollingFrame.Reward:Destroy()
    queststab.RewardsScrollingFrame.Reward:Destroy()
    
    queststab.FocusImage.Image = "rbxassetid://2732318916"
    queststab.Description.Text = " "
    queststab.Title.Text = "- Secret Soccer -"
end)

example.Visible = Value

    end
})

local SecretsGroup = Tabs.Quests:AddGroupbox({
    Side = "Right",
    Name = "Secrets",
    IconName = "key",
})

SecretsGroup:AddButton("Neon Blocks", function()
    local stages = workspace.BoatStages.OtherStages
    local stageneon = stages:FindFirstChild("WildWestStage")

    if stageneon then
        local treasure = stageneon:FindFirstChild("Treasure")

        if treasure and treasure:FindFirstChild("PPart") then
            root.Position = treasure.PPart.Position
        else
            notification("Secrets", "Treasure not found!", 5)
        end
    else
        notification("Secrets", "Wild West Stage not spawned!", 5)
    end
end)

SecretsGroup:AddButton("Ultra Thrusters", function()
    local stages = workspace.BoatStages.OtherStages
    local stageneon = stages:FindFirstChild("AcidStage")
    local disableornot = true

    if stageneon then

local lever = stageneon:WaitForChild("TerrainWall2"):WaitForChild("HiddenChest"):WaitForChild("Treasure")
local args = {
	"CannonMount",
	player.Data.CannonMount.Value,
	team,
	CFrame.new(-13, 7.5, -67, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	true,
	CFrame.new(-66.56568908691406, -10.499992370605469, -412.5068664550781, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	false,
	true
}
for i,v in ipairs(player:WaitForChild("Backpack"):GetDescendants()) do
if v:IsA('Tool') then
v.Parent = character
end
end
character:WaitForChild("BuildingTool"):WaitForChild("RF"):InvokeServer(unpack(args))

local function fire(object)
fireclickdetector(object.ClickDetector)
end

fire(workspace.Blocks[player.Name]:WaitForChild("CannonMount"))

game.Players.LocalPlayer.Character.HumanoidRootPart.Position = lever.PPart.Position+Vector3.new(55,7,0)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

notification("Secrets", "Fire at Breakable Wall forward", 5)

task.wait(5)

game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
game.Players.LocalPlayer.Character.HumanoidRootPart.Position = lever.PPart.Position
    else
        notification("Secrets", "Acid Stage not spawned!", 5)
    end
end)
local PlushiesGroup = Tabs.Quests:AddGroupbox({
    Side = "Right",
    Name = "Plushies",
    IconName = "rabbit",
})

PlushiesGroup:AddButton("Chillthrill Plushie", function()

local foreststage = nil
for _,v in ipairs(workspace.BoatStages.NormalStages:WaitForChild("ForestStage"):WaitForChild("TerrainWall1"):GetDescendants()) do

if v.Name == "DirtPart" and v.CFrame == CFrame.new(195.234314, -18.3000031, 1160.39209, 1, 0, 0, 0, 1, 0, 0, 0, 1) then

foreststage = v

end

end

if foreststage == "nil" then
notification("Plushies", "Unknown error occured!", 5)
end

root.Position = foreststage.Position

task.wait(2)

local function clickbook(book)
fireclickdetector(book.ClickDetector)
end
local books = workspace.BoatStages.NormalStages:WaitForChild("ForestStage"):WaitForChild("TheWizardRoom").Books

local redbook, cyanbook, greenbook, pinkbook, yellowbook

for _, book in ipairs(books:GetChildren()) do
    for _, part in ipairs(book:GetDescendants()) do
        if part:IsA("BasePart") then
            local color = part.BrickColor.Name

            if color == "Really red" then
                redbook = book
            elseif color == "Cyan" then
                cyanbook = book
            elseif color == "Lime green" then
                greenbook = book
            elseif color == "Hot pink" then
                pinkbook = book
            elseif color == "Neon green" then
                yellowbook = book
            end
        end
    end
end

clickbook(redbook)
task.wait(0.2)

clickbook(cyanbook)
task.wait(0.2)

clickbook(greenbook)
task.wait(0.2)

clickbook(pinkbook)
task.wait(0.2)

clickbook(yellowbook)

task.wait(1)

root.Position = workspace.BoatStages.NormalStages:WaitForChild("ForestStage"):WaitForChild("TheWizardRoom").Plushie1.PlushieRewardPart.Position
notification("Plushies", "Plushie claimed!", 5)

end)

PlushiesGroup:AddButton("justinnguyen07 Plushie", function()
    local stages = workspace.BoatStages.OtherStages
    local stageneon = stages:FindFirstChild("TribeStage")
    local disableornot = true

    if stageneon then

local lever = stageneon:WaitForChild("Hut2")
        notification("Secrets", "Fire at breakable wall forward.", 5)
game.Players.LocalPlayer.Character.HumanoidRootPart.Position = lever.ChangeMusic.Position+Vector3.new(55,7,0)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

task.wait(5)

game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
game.Players.LocalPlayer.Character.HumanoidRootPart.Position = lever.Plushie2.Plushie2.Position

    else
        notification("Secrets", "Tribe Stage not spawned!", 5)

end
end)

PlushiesGroup:AddButton("Zeg Plushie X1", function()
    local stages = workspace.BoatStages.OtherStages
    local stageneon = stages:FindFirstChild("ArcadeStage")
    local disableornot = true

    if stageneon then

local machines = stageneon:WaitForChild("ArcadeMachines")
local lightstop = machines:WaitForChild("LightStop")

local button = lightstop:WaitForChild("Interface").Buttons.Button
local light = lightstop:WaitForChild("Lights").Light_23

local function fire(object)
fireclickdetector(object.ClickDetector)
end

while disableornot and task.wait(0.) do
if light.BrickColor.Name == "Dark orange" then
fire(button)
disableornot = false
end
end

    else
        notification("Secrets", "Arcade Stage not spawned!", 5)
    end
end)

local MapGroup = Tabs.Teleportation:AddGroupbox({
    Side = "Left",
    Name = "Map",
    Description = "Teleport to stage1, stage2, to golden chest and other.",
    IconName = "map",
})

local stages = workspace.BoatStages.NormalStages

local stage1 = stages.CaveStage1.DarknessPart
local stage2 = stages.CaveStage2.DarknessPart
local stage3 = stages.CaveStage3.DarknessPart
local stage4 = stages.CaveStage4.DarknessPart
local stage5 = stages.CaveStage5.DarknessPart
local stage6 = stages.CaveStage6.DarknessPart
local stage7 = stages.CaveStage7.DarknessPart
local stage8 = stages.CaveStage8.DarknessPart
local stage9 = stages.CaveStage9.DarknessPart
local stage10 = stages.CaveStage10.DarknessPart
local stageend = stages.TheEnd
local chest = stageend.GoldenChest.Trigger

MapGroup:AddButton("Stage 1", function()
    root.Position = stage1.Position
end)

MapGroup:AddButton("Stage 2", function()
    root.Position = stage2.Position
end)

MapGroup:AddButton("Stage 3", function()
    root.Position = stage3.Position
end)

MapGroup:AddButton("Stage 4", function()
    root.Position = stage4.Position
end)

MapGroup:AddButton("Stage 5", function()
    root.Position = stage5.Position
end)

MapGroup:AddButton("Stage 6", function()
    root.Position = stage6.Position
end)

MapGroup:AddButton("Stage 7", function()
    root.Position = stage7.Position
end)

MapGroup:AddButton("Stage 8", function()
    root.Position = stage8.Position
end)

MapGroup:AddButton("Stage 9", function()
    root.Position = stage9.Position
end)

MapGroup:AddButton("Stage 10", function()
    root.Position = stage10.Position
end)

MapGroup:AddButton("Golden Chest", function()
    root.Position = chest.Position+Vector3.new(0,0,-40)
end)

local TeamsGroup = Tabs.Teleportation:AddGroupbox({
    Side = "Right",
    Name = "Teams",
    Description = "Teleport to teams.",
    IconName = "flag-triangle-right",
})

TeamsGroup:AddButton("Return to base/team", function()
    root.Position = team.Position + Vector3.new(0,20,0)
end)

TeamsGroup:AddDivider("Teams")

TeamsGroup:AddButton("White Team", function()
    root.Position = workspace[zones.white].Position + Vector3.new(0,20,0)
end)

TeamsGroup:AddButton("Black Team", function()
    root.Position = workspace[zones.black].Position + Vector3.new(0,20,0)
end)

TeamsGroup:AddButton("Blue Team", function()
    root.Position = workspace[zones.blue].Position + Vector3.new(0,20,0)
end)

TeamsGroup:AddButton("Green Team", function()
    root.Position = workspace[zones.green].Position + Vector3.new(0,20,0)
end)

TeamsGroup:AddButton("Magenta Team", function()
    root.Position = workspace[zones.magenta].Position + Vector3.new(0,20,0)
end)

TeamsGroup:AddButton("Yellow Team", function()
    root.Position = workspace[zones.yellow].Position + Vector3.new(0,20,0)
end)

TeamsGroup:AddButton("Red Team", function()
    root.Position = workspace[zones.red].Position + Vector3.new(0,20,0)
end)

local SubplacesGroup = Tabs.Teleportation:AddGroupbox({
    Side = "Left",
    Name = "Subplaces",
    Description = "Teleport to egg 2021 boss fight, winter boss and other.",
    IconName = "land-plot",
})

SubplacesGroup:AddButton({
    Text = "Inner Cloud [Egg Boss]",
    Tooltip = "You can get Egg Cannons from this.",
    Func = function()
       game:GetService("TeleportService"):Teleport(1930863474,game.Players.LocalPlayer)
    end
})
SubplacesGroup:AddButton({
    Text = "Winter Place [2024 Build]",
    Tooltip = "You can get Chests Blocks from this.",
    Func = function()
      game:GetService("TeleportService"):Teleport(1930866268,game.Players.LocalPlayer)
    end
})
SubplacesGroup:AddButton({
    Text = "Project Zeg",
    Tooltip = "You can get Zeg Plushies from this.",
    Func = function()
      game:GetService("TeleportService"):Teleport(5178049460,game.Players.LocalPlayer)
    end
})
SubplacesGroup:AddButton("The Test Place", function()
    local results = workspace:WaitForChild("IsPrivateServer"):InvokeServer()
    if results == true then
      workspace.ToTestPlace:FireServer()
      else
      notification("Teleportation", "You need Private Server to teleport.", 5)
    end
end)

local StagesGroup = Tabs.Teleportation:AddGroupbox({
    Side = "Right",
    Name = "Stages",
    Description = "Info of every stage spawned right now",
    IconName = "qr-code",
})
local StageInfo = workspace.BoatStages:WaitForChild("StageInfo")

local DefaultImage = "rbxassetid://107765095938421"

task.spawn(function()
    local stages = StageInfo:GetChildren()

    table.sort(stages, function(a, b)
        local numA = tonumber(a.Name:match("%d+")) or 0
        local numB = tonumber(b.Name:match("%d+")) or 0
        return numA < numB
    end)

    for _, stage in ipairs(stages) do
        if stage:IsA("Folder") then
            local icon = stage:WaitForChild("StageIcon")
            local name = stage:WaitForChild("StageName")

            StagesGroup:AddDivider()

            local StageImage = StagesGroup:AddImage("StageImage", {
                Image = DefaultImage,
                Height = 50,
            })

            local StageLabel = StagesGroup:AddLabel("Stage Not Spawned", true)

            local function SafeSetImage(image)
                if typeof(image) ~= "string" or image == "" then
                    image = DefaultImage
                end

                local success = pcall(function()
                    StageImage:SetImage(image)
                end)

                if not success then
                    pcall(function()
                        StageImage:SetImage(DefaultImage)
                    end)
                end
            end

            local function UpdateStage()
                local photo = tostring(icon.Value or "")
                local stageName = tostring(name.Value or "")

                if photo ~= "" and stageName ~= "" then
                    SafeSetImage(photo)
                    StageLabel:SetText(stageName)
                else
                    SafeSetImage(DefaultImage)
                    StageLabel:SetText("Stage Not Spawned")
                end
            end

            UpdateStage()

            icon:GetPropertyChangedSignal("Value"):Connect(UpdateStage)
            name:GetPropertyChangedSignal("Value"):Connect(UpdateStage)
        end
    end
end)

-- UI Settings

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddButton("Play Author's Tag", function()
local url = "https://github.com/Darli17/obertone/raw/refs/heads/main/robloxtag.mp3"

local response = request({
    Url = url,
    Method = "GET"
})

local a = nil

if response.StatusCode == 200 then
    writefile("robloxtag.mp3", response.Body)
else
    notification("Obertone", "Failed to download robloxtag.mp3", 3)
end

local files = listfiles("")

for _, file in ipairs(files) do
    if file == "robloxtag.mp3" then
      a = file
    end
end

local sound = Instance.new("Sound", workspace)
sound.SoundId = getcustomasset(a)
sound.Volume = 1
sound:Play()
end)

MenuGroup:AddToggle("KeybindMenuOpen", {
	Default = Library.KeybindFrame.Visible,
	Text = "Open Keybind Menu",
	Callback = function(value)
		Library.KeybindFrame.Visible = value
	end,
})
MenuGroup:AddToggle("ShowCustomCursor", {
	Text = "Custom Cursor",
	Default = false,
	Callback = function(Value)
		Library.ShowCustomCursor = Value
	end,
})
MenuGroup:AddDropdown("NotificationSide", {
	Values = { "Left", "Right" },
	Default = "Right",

	Text = "Notification Side",

	Callback = function(Value)
		Library:SetNotifySide(Value)
	end,
})
MenuGroup:AddDropdown("DPIDropdown", {
	Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Default = "100%",

	Text = "DPI Scale",

	Callback = function(Value)
		Value = Value:gsub("%%", "")
		local DPI = tonumber(Value)

		Library:SetDPIScale(DPI)
	end,
})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind")
	:AddKeyPicker("MenuKeybind", { Default = "LeftAlt", NoUI = true, Text = "Menu keybind" })

MenuGroup:AddButton("Unload", function()
	Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

local ThemeManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"
))()

task.wait(0.5)

Window:ChangeTitle("Loaded")
print([[

                                                                                                                        
        _____          _____        ______        _____   _________________       _____  _____   ______        ______   
   ____|\    \    ___|\     \   ___|\     \   ___|\    \ /                 \ ____|\    \|\    \ |\     \   ___|\     \  
  /     /\    \  |    |\     \ |     \     \ |    |\    \\______     ______//     /\    \\\    \| \     \ |     \     \ 
 /     /  \    \ |    | |     ||     ,_____/||    | |    |  \( /    /  )/  /     /  \    \\|    \  \     ||     ,_____/|
|     |    |    ||    | /_ _ / |     \--'\_|/|    |/____/    ' |   |   '  |     |    |    ||     \  |    ||     \--'\_|/
|     |    |    ||    |\    \  |     /___/|  |    |\    \      |   |      |     |    |    ||      \ |    ||     /___/|  
|\     \  /    /||    | |    | |     \____|\ |    | |    |    /   //      |\     \  /    /||    |\ \|    ||     \____|\ 
| \_____\/____/ ||____|/____/| |____ '     /||____| |____|   /___//       | \_____\/____/ ||____||\_____/||____ '     /|
 \ |    ||    | /|    /     || |    /_____/ ||    | |    |  |`   |         \ |    ||    | /|    |/ \|   |||    /_____/ |
  \|____||____|/ |____|_____|/ |____|     | /|____| |____|  |____|          \|____||____|/ |____|   |___|/|____|     | /
     \(    )/      \(    )/      \( |_____|/   \(     )/      \(               \(    )/      \(       )/    \( |_____|/ 
      '    '        '    '        '    )/       '     '        '                '    '        '       '      '    )/    
                                       '                                                                          '                                                                                                                                                           

]] .. "VERSION - " .. version .. [[

   LOADED SUCCESSFULLY
]])
notification("Obertone", "Obertone loaded successfully!", 5)

if player.Name == "ValerikRobJR" and player.UserId == 9015172057 then
notification("Obertone", "Welcome Creator, Have a good day!")
end

SaveManager:LoadAutoloadConfig()

task.wait(2)

Window:ChangeTitle("Obertone")
