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
SaveManager:SetFolder("Obertone/3008")
SaveManager:SetSubFolder("3008") -- if the game has multiple places inside of it (for example: DOORS)

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
  Visuals = Window:AddTab("Visuals", "eye"),
  Functions = Window:AddTab("Functions", "box"),
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

local function updateCharacter(newCharacter)
    character = newCharacter or player.Character

    root = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
end

updateCharacter(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(function(character)
    updateCharacter(character)
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
    local player = player
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
ClientGroup:AddLabel("Game: 3008")

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

local PlayersInfo = PlayerBox:AddTab("Players", "user-round")
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

local PlayerLabels = {}
local ValueConnections = {}

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

    PlayerLabels[plr] = Label
end

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


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local walkspeedvalue = 12
local jumppowervalue = 40

local walkspeedenabled = true
local jumppowerenabled = true

local PlayerGroup = Tabs.Modifiers:AddGroupbox({
    Side = "Left",
    Name = "Player",
    Description = "Adjust character speed, jump height and much more.",
    IconName = "user-round",
})

PlayerGroup:AddButton("Unload", function()
    Library:Unload()
end)

local WalkSpeed = PlayerGroup:AddSlider("WalkSpeed", {
    Text = "WalkSpeed:",
    Default = 12,
    Min = 12,
    Max = 500,
    Rounding = 0,

    Callback = function(Value)
        walkspeedvalue = Value
    end
})

-- JumpPower
local JumpPower = PlayerGroup:AddSlider("JumpPower", {
    Text = "JumpPower:",
    Default = 40,
    Min = 40,
    Max = 1000,
    Rounding = 0,

    Callback = function(Value)
        jumppowervalue = Value
    end
})

task.spawn(function()
    while true do
        if humanoid then
            if walkspeedenabled and walkspeedvalue >= 13 then
                humanoid.WalkSpeed = walkspeedvalue
            end

            if jumppowerenabled and jumppowervalue >= 41 then
                humanoid.JumpPower = jumppowervalue
            end
        end

        task.wait(0.1)
    end
end)

local FOV = PlayerGroup:AddSlider("FOV", {
    Text = "Field Of View:",
    Default = player.PlayerGui.PlayerInfo.Settings:GetAttribute("FieldOfView"),
    Min = 70,
    Max = 300,
    Rounding = 0,
    Callback = function(Value)

game.Workspace.CurrentCamera.FieldOfView = Value

    end
})

local speeds = 1
local nowe = nil

local Fly = PlayerGroup:AddToggle("Fly", {
    Text = "Fly",
    Default = false,
    Callback = function(Value)

local speaker = game:GetService("Players").LocalPlayer

local chr = player.Character
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
				local chr = player.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
		player.Character.Animate.Disabled = true
		local Char = player.Character
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



		local plr = player
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
			--	player.Character.Animate.Disabled = true
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		player.Character.Animate.Disabled = false
		tpwalking = false




	else
		local plr = player
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
		player.Character.Animate.Disabled = false
		tpwalking = false



	end


game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
	wait(0.7)
	player.Character:WaitForChild("Humanoid").PlatformStand = false
	player.Character:WaitForChild("Animate").Disabled = false

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
				local chr = player.Character
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
    Default = "Y",
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

PlayerGroup:AddDivider("")

local throwpoweren = false
local throwpower = 0

local ThrowPowerMultiplier = PlayerGroup:AddToggle("MyToggle", {
    Text = "Throw Power Multiplier",
    Default = false,
    Callback = function(Value)

throwpoweren = Value
while throwpoweren and task.wait(0.1) do
player.PlayerScripts.source.client.PickupSystem.System.ThrowValue.Value = throwpower
end

    end
})
local PowerMultiplier = PlayerGroup:AddSlider("Sensitivity", {
    Text = "Power Multiplier",
    Default = 0,
    Min = 0,
    Max = 100000,
    Rounding = 0,
    Callback = function(Value)

throwpower = Value

    end
})

local StatsGroup = Tabs.Modifiers:AddGroupbox({
    Side = "Right",
    Name = "Stats",
    Description = "Adjust hunger, health, energy.",
    IconName = "pencil",
})

local inf_hunger = false
local inf_energy = false
local inf_health = false


local InfiniteHealth = StatsGroup:AddToggle("Health", {
    Text = "Godmode",
    Default = false,
    Callback = function(Value)

inf_health = Value

if inf_health == true then
local Event = character.System.Event
Event:FireServer(
    "FallDamage",
    {
        Sliding = false,
        OriginalDamage = -math.huge+math.huge,
        Sound = "LR^SS",
        Softened = true,
        Broken = false,
        Model = workspace.GameObjects.Physical.Map.Floor["Play Plot"],
        Range = 19,
        Damage = -math.huge+math.huge
    }
)
else
local Dialog
Dialog = Window:AddDialog("ResetCharacter?", {
    Title = "Obertone",
    Description = "To disable godmode, you need reset you character.",
    AutoDismiss = false,
    OutsideClickDismiss = false,
    FooterButtons = {
        Cancel = {
            Title = "Cancel",
            Variant = "Ghost",
            Order = 2,
            Callback = function()
                Dialog:Dismiss()
            end
        },
        Confirm = {
            Title = "Confirm",
            Variant = "Primary",
            WaitTime = 1,
            Order = 1,
            Callback = function(self)
                character.Humanoid.Health = inf
                Dialog:Dismiss()
            end
        }
    }
})

end

    end
})


local InfiniteHunger = StatsGroup:AddToggle("Hunger", {
    Text = "Infinite Hunger",
    Default = false,
    Callback = function(Value)

inf_hunger = Value

while inf_hunger == true and task.wait(0.) do

local args = {
	"DecreaseStat",
	{
		Stats = {
			Hunger = -999
		}
	}
}
character:WaitForChild("System"):WaitForChild("Event"):FireServer(unpack(args))

end

    end
})

local InfiniteEnergy = StatsGroup:AddToggle("Energy", {
    Text = "Infinite Energy",
    Default = false,
    Callback = function(Value)

inf_energy = Value

while inf_energy == true and task.wait(0.) do

local args = {
	"DecreaseStat",
	{
		Stats = {
			Energy = -999
		}
	}
}
character:WaitForChild("System"):WaitForChild("Event"):FireServer(unpack(args))

end

    end
})

StatsGroup:AddDivider("")

local falldamage = false

local db_autorespawn = false
local autorespawn = false

local NoFallDamage = StatsGroup:AddToggle("FallDamage", {
    Text = "No Fall Damage",
    Default = false,

    Callback = function(Value)
        falldamage = Value

        if Value then
            task.spawn(function()
                while falldamage do
                    if character and character:FindFirstChild("FallDamage") then
                        character.FallDamage.Enabled = false
                    end
                    if falldamage == false then
                        character.FallDamage.Enabled = true
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})
local AutoRespawn = StatsGroup:AddToggle("Respawn", {
    Text = "Auto Respawn",
    Default = false,
    Callback = function(Value)

autorespawn = Value

while autorespawn == true and task.wait(0.) do
if character.Humanoid.Health == 0 and db_autorespawn == false then
db_autorespawn = true
task.wait(0.5)
local args = {
	"Respawn",
	{}
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Communication"):FireServer(unpack(args))

task.wait(2)

db_autorespawn = false
player.PlayerGui.DeathScreen.DeathMusic.Playing = false

end
end

    end
})

local InstantInteract = false
local OriginalNames = {}
local Connections = {}
local WatchedFolders = {}

local GameObjects = workspace:WaitForChild("GameObjects")
local Physical = GameObjects:WaitForChild("Physical")

local Items1 = Physical:WaitForChild("Items")
local Floor = Physical:WaitForChild("Map"):WaitForChild("Floor")

local function RenameItem(item)
    if not item:IsA("Model") and not item:IsA("BasePart") then
        return
    end

    if OriginalNames[item] == nil then
        OriginalNames[item] = item.Name
    end

    item.Name = "Banana"
end

local function ProcessItems(folder)
    for _, item in ipairs(folder:GetChildren()) do
        RenameItem(item)
    end
end

local function RestoreAll()
    for item, originalName in pairs(OriginalNames) do
        if item.Parent then
            item.Name = originalName
        end
    end

    table.clear(OriginalNames)
end

local function WatchFolder(folder)
    if WatchedFolders[folder] then
        return
    end

    WatchedFolders[folder] = true

    table.insert(Connections, folder.ChildAdded:Connect(function(item)
        if InstantInteract then
            RenameItem(item)
        end
    end))

    if InstantInteract then
        ProcessItems(folder)
    end
end

local function WatchFloorModel(model)
    local items = model:FindFirstChild("Items")

    if items then
        WatchFolder(items)
    end

    table.insert(Connections, model.ChildAdded:Connect(function(child)
        if child.Name == "Items" then
            WatchFolder(child)
        end
    end))
end

WatchFolder(Items1)

for _, model in ipairs(Floor:GetChildren()) do
    WatchFloorModel(model)
end

table.insert(Connections, Floor.ChildAdded:Connect(function(model)
    WatchFloorModel(model)
end))

local function SetInstantInteract(state)
    InstantInteract = state

    if state then

        ProcessItems(Items1)

        for _, model in ipairs(Floor:GetChildren()) do
            local items = model:FindFirstChild("Items")

            if items then
                ProcessItems(items)
            end
        end
    else
        RestoreAll()
    end
end

StatsGroup:AddToggle("InstantInteract", {
    Text = "Instant Interact",
    Default = false,

    Callback = function(Value)
        SetInstantInteract(Value)
    end
})

local ShoveEnabled = false
local Employees = workspace
    :WaitForChild("GameObjects")
    :WaitForChild("Physical")
    :WaitForChild("Employees")
local function shove(hum)
    local args = {
        "ShoveEmployee",
        {
            Humanoid = hum
        }
    }

    character:WaitForChild("System")
        :WaitForChild("Action")
        :InvokeServer(unpack(args))
end

local ShoveEmployees = StatsGroup:AddToggle("ShoveEmployees", {
    Text = "Auto Shove Employees",
    Default = false,

    Callback = function(Value)
        ShoveEnabled = Value

        if Value then
            task.spawn(function()
                while ShoveEnabled do
                    for _, employee in ipairs(Employees:GetChildren()) do
                        local enemy = employee:FindFirstChild("Enemy")

                        if enemy and enemy:IsA("Humanoid") then
                            shove(enemy)
                        end
                    end

                    task.wait(0.1)
                end
            end)
        end
    end
})

if player:FindFirstChild("Permissions"):GetAttribute("Broadcast") == true then

local InfiniteCapacity = StatsGroup:AddToggle("InfiniteCapacity", {
    Text = "Infinite Inventory",
    Default = false,
    Callback = function(Value)

if Value == true then
local args = {
	"UpdatePlayerProperties",
	{
		ToPlayer = player,
		Properties = {
			MaxInventorySpace = 999
		}
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Vip"):FireServer(unpack(args))
else
local args = {
	"UpdatePlayerProperties",
	{
		ToPlayer = player,
		Properties = {
			MaxInventorySpace = 16
		}
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Vip"):FireServer(unpack(args))

end

    end
})

end

local OtherGroup = Tabs.Modifiers:AddGroupbox({
    Side = "Right",
    Name = "Other",
    IconName = "loader-pinwheel",
})

OtherGroup:AddButton("Respawn", function()

humanoid.Health = inf

end)

OtherGroup:AddButton("Rejoin", function()

game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId)

end)

OtherGroup:AddButton("Leave", function()

game:GetService("Players").LocalPlayer:Destroy()
game:Shutdown()

end)

local WorldGroup = Tabs.Visuals:AddGroupbox({
    Side = "Right",
    Name = "World",
    Description = "Fullbright, no fog.",
    IconName = "earth",
})

local Lighting = game:GetService("Lighting")

local originalSettings = {}

local DaySettings = {
    Ambient = Color3.fromRGB(0, 0, 0),
    Brightness = 1,
    ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
    ColorShift_Top = Color3.fromRGB(0, 0, 0),
    EnvironmentDiffuseScale = 0.4,
    EnvironmentSpecularScale = 0.6,
    OutdoorAmbient = Color3.fromRGB(120, 120, 120),
}

local NightSettings = {
    Ambient = Color3.fromRGB(35, 35, 35),
    Brightness = 0.66,
    ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
    ColorShift_Top = Color3.fromRGB(0, 0, 0),
    EnvironmentDiffuseScale = 0.4,
    EnvironmentSpecularScale = 0.6,
    OutdoorAmbient = Color3.fromRGB(59, 59, 59),
}

local function SaveSettings()
    originalSettings = {
        ClockTime = Lighting.ClockTime,
        Ambient = Lighting.Ambient,
        Brightness = Lighting.Brightness,
        ColorShift_Bottom = Lighting.ColorShift_Bottom,
        ColorShift_Top = Lighting.ColorShift_Top,
        EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        GlobalShadows = Lighting.GlobalShadows,
    }
end

local function ApplySettings(settings)
    for property, value in pairs(settings) do
        Lighting[property] = value
    end
end

local function RestoreSettings()
    ApplySettings(originalSettings)
end

WorldGroup:AddToggle("Fullbright", {
    Text = "Fullbright",
    Default = false,

    Callback = function(Value)
        if Value then
            SaveSettings()

            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false

            ApplySettings(DaySettings)
        else
            RestoreSettings()
        end
    end
})

local originalFog = {}

WorldGroup:AddToggle("No Fog", {
    Text = "No Fog",
    Default = false,

    Callback = function(Value)
        if Value then
            originalFog.FogStart = Lighting.FogStart
            originalFog.FogEnd = Lighting.FogEnd

            Lighting.FogStart = 1000000
            Lighting.FogEnd = 1000000
        else
            Lighting.FogStart = originalFog.FogStart or 15
            Lighting.FogEnd = originalFog.FogEnd or 300
        end
    end
})

local PlayerOGroup = Tabs.Visuals:AddGroupbox({
    Side = "Right",
    Name = "Player",
    IconName = "user-round",
})

local CameraShake = PlayerOGroup:AddToggle("CameraShake", {
    Text = "Disable Camera Shake",
    Default = false,

    Callback = function(Value)
        player.PlayerGui.PlayerInfo.Settings:SetAttribute("CameraShake", not Value)
    end
})
local unlocktp = false

local UnlockThirdPerson = PlayerOGroup:AddToggle("ThirdPerson", {
    Text = "Unlock Third Person",
    Default = false,
    Callback = function(Value)

unlocktp = Value
if unlocktp == true then
player.CameraMode = Enum.CameraMode.Classic
else
player.CameraMode = Enum.CameraMode.LockFirstPerson
end

    end
})
local MaxZoom = PlayerOGroup:AddSlider("MaxZoom", {
    Text = "Maximum Zoom",
    Default = 20,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)

player.CameraMaxZoomDistance = Value

    end
})
local MinZoom = PlayerOGroup:AddSlider("MinZoom", {
    Text = "Minimum Zoom",
    Default = 5,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)

player.CameraMMinZoomDistance = Value

    end
})

PlayerOGroup:AddDivider("")

local ClockVisible = false

local TimeSettings = game:GetService("ReplicatedStorage").ServerSettings.TimeSettings
local t = {
    Parent = player.PlayerGui.MainGui.TopBar,
    Gui = player.PlayerGui.MainGui.TopBar.Calendar.Gamepass_Clock
}

function toMS(arg1)
    if arg1 >= 3600 then
        return string.format("%02i:%02i:%02i", arg1 / 60 / 60 % 24, arg1 / 60 % 60, arg1 % 60)
    end

    if arg1 >= 60 then
        return string.format("%02i:%02i", arg1 / 60 % 60, arg1 % 60)
    end

    return string.format("%02i", arg1)
end

function HideClock()
    TweenService:Create(t.Parent.Calendar, TweenInfo.new(0.3,Enum.EasingStyle.Quad), {
      Position = UDim2.fromScale(0.5, 0)
    }):Play()
    TweenService:Create(t.Parent.Menus, TweenInfo.new(0.3,Enum.EasingStyle.Quad), {
      Position = UDim2.new(0.5, 0, 0, 30)
    }):Play()
end

function ShowClock()
    TweenService:Create(t.Parent.Calendar, TweenInfo.new(0.3,Enum.EasingStyle.Quad), {
      Position = UDim2.new(0.5, 0, 0, 24)
    }):Play()
    TweenService:Create(t.Parent.Menus, TweenInfo.new(0.3,Enum.EasingStyle.Quad), {
      Position = UDim2.new(0.5, 0, 0, 54)
    }):Play()
end

TimeSettings.TimeLeft.Changed:Connect(function()
    t.Gui.Text = toMS(TimeSettings.TimeLeft.Value)

    if t.Gui.Text == "05" and t.Gui.Visible then
        t.Gui.Countdown:Play()
    end
end)

t.Gui.Visible = true

local FakeWatch = PlayerOGroup:AddToggle("FakeWatch", {
    Text = "Enable Watch",
    Default = false,
    Callback = function(Value)

      ClockVisible = Value
      if ClockVisible then
        ShowClock()
      else
        HideClock()
      end

    end
})

local DeathWaypoint = PlayerOGroup:AddToggle("DeathWaypoint", {
    Text = "Death Waypoint",
    Default = false,
    Callback = function(Value)

death_w = Value

while death_w == true and task.wait(0.1) do

if humanoid.Health == 0 and death_db == false then

    death_db = true
    local waypoint = game:GetObjects("rbxassetid://100649460917288")[1]
    local waypoints_gui = player.PlayerGui:FindFirstChild("Waypoints")

    waypoint.Name = "Death5gfaxk123kxglasS"..player.Name

    waypoint.ImageRectOffset = Vector2.new(0,0)
    waypoint.ImageRectSize = Vector2.new(0,0)
    waypoint.Outline.Image = "rbxassetid://12296859753"
    waypoint.Image = "rbxassetid://12296859753"
    waypoint.WaypointName.Text = "Death Point"
    waypoint.Parent = waypoints_gui
    waypoint:SetAttribute("SetPosition", root.Position)

    

end

if humanoid.Health == 100 then
    death_db = false
end

end

    end
})

PlayerOGroup:AddButton("Teleport to Death Waypoint", function()
    local waypoints_gui = player.PlayerGui:FindFirstChild("Waypoints")

    if not waypoints_gui:FindFirstChild("Death5gfaxk123kxglasS"..player.Name) then
      return
    end

    player.Character:WaitForChild("HumanoidRootPart"):PivotTo(CFrame.new(waypoints_gui:FindFirstChild("Death5gfaxk123kxglasS"..player.Name):GetAttribute("SetPosition")))
end)

PlayerOGroup:AddButton("Delete Death Waypoint", function()
    local waypoints_gui = player.PlayerGui:FindFirstChild("Waypoints")

    if not waypoints_gui:FindFirstChild("Death5gfaxk123kxglasS"..player.Name) then
      return
    end

    waypoints_gui:FindFirstChild("Death5gfaxk123kxglasS"..player.Name):Destroy()
end)

local WaypointsGroup = Tabs.Visuals:AddGroupbox({
    Side = "Right",
    Name = "Waypoints",
    IconName = "waypoints",
})

local Waypoints = {}
local SelectedWaypoint = nil

local Waypoint_DefName = "Waypoint"
local Waypoint_Name = "Waypoint"
local Waypoint_Icon = "rbxassetid://8322146497"
local Waypoint_Color = Color3.fromRGB(255,255,255)

local WaypointsDropdown = WaypointsGroup:AddDropdown("WaypointDropdown", {
    Text = "Select Waypoint",
    Values = {},
    Callback = function(Value)
        SelectedWaypoint = nil

        for _, waypoint in ipairs(Waypoints) do
            if waypoint.Name == Value then
                SelectedWaypoint = waypoint
                break
            end
        end
    end
})

local function Waypoint_UpdateDropdown()
    local values = {}

    for _, waypoint in ipairs(Waypoints) do
        table.insert(values, waypoint.Name)
    end

    WaypointsDropdown:SetValues(values)
end
local function Waypoint_Create(name, pos)
    if not name or name == "" or not pos then
        return
    end

    local waypoint = game:GetObjects("rbxassetid://100649460917288")[1]
    local waypoints_gui = player.PlayerGui:FindFirstChild("Waypoints")

    if not waypoint or not waypoints_gui then
        return
    end

    waypoint.Name = name
    waypoint.WaypointName.Text = name
    waypoint.Parent = waypoints_gui
    waypoint:SetAttribute("SetPosition", pos)

    table.insert(Waypoints, waypoint)

    Waypoint_UpdateDropdown()
end

local function Waypoint_Delete()
    if not SelectedWaypoint then
        return
    end

    local index = table.find(Waypoints, SelectedWaypoint)

    if index then
        table.remove(Waypoints, index)
    end

    SelectedWaypoint:Destroy()
    SelectedWaypoint = nil

    Waypoint_UpdateDropdown()
end

WaypointsGroup:AddInput("NewWaypointName", {
    Default = "Waypoint",
    Numeric = false,
    Finished = false,
    ClearTextOnFocus = false,
    Text = "New Waypoint Name",

    Callback = function(Value)
        Waypoint_DefName = Value
    end,
})

WaypointsGroup:AddButton("Create Waypoint", function()
    Waypoint_Create(Waypoint_DefName, root.Position)
end)

WaypointsGroup:AddButton("Delete Waypoint", function()
    Waypoint_Delete(SelectedWaypoint)
end)

WaypointsGroup:AddDivider("")

WaypointsGroup:AddInput("WaypointName", {
	Default = "Waypoint",
	Numeric = false, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Name",
	Callback = function(Value)

Waypoint_Name = Value

	end,
})
local WaypointIcon = WaypointsGroup:AddInput("WaypointIcon", {
	Default = "rbxassetid://8322146497",
	Numeric = false, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Icon",
  Placeholder = "rbxassetid://...",
	Callback = function(Value)

Waypoint_Icon = Value

	end,
})
local WaypointColorLabel = WaypointsGroup:AddLabel("Waypoint Color", false)
local WaypointColor = WaypointColorLabel:AddColorPicker("WaypointColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "Waypoint Color",
    Resizable = true,
    Callback = function(Value)

Waypoint_Color = Value

    end
})

local function Waypoint_Update(obj, name, icon, color)
    if not obj then
        return
    end

    local image = obj:FindFirstChild("Outline")
    local waypointName = obj:FindFirstChild("WaypointName")
    local distance = obj:FindFirstChild("Distance")

    if not image then
        return
    end

    if image:IsA("ImageLabel") or image:IsA("ImageButton") then
        image.Image = icon
        image.ImageColor3 = color
    end

    if waypointName then
        waypointName.Text = name
        waypointName.TextColor3 = color
    end

    if distance then
        distance.TextColor3 = color
    end
end

WaypointsGroup:AddButton("Update Waypoint", function()
    if not SelectedWaypoint then
        return
    end

    Waypoint_Update(
        SelectedWaypoint,
        Waypoint_Name,
        Waypoint_Icon,
        Waypoint_Color
    )
end)

local ESP = Tabs.Visuals:AddGroupbox({
    Side = "Left",
    Name = "ESP",
    IconName = "eye-dashed",
})

local playersenabled = false
local employeesenabled = false
local foodenabled = false

-- colors

local playerscolor = Color3.fromRGB(255,0,0)
local employeescolor = Color3.fromRGB(0,255,0)
local foodcolor = Color3.fromRGB(128,0,128)

local esp_module = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/ESP/Better_ESP/Source.lua"))()

local Workspace = game:GetService("Workspace")

local GameObjects = Workspace:WaitForChild("GameObjects")
local Physical = GameObjects:WaitForChild("Physical")

local PlayersFolder = Physical:WaitForChild("Players")
local EmployeesFolder = Physical:WaitForChild("Employees")

local Map = Physical:WaitForChild("Map")
local Floor = Map:WaitForChild("Floor")

local function OnPlayerDetected(model)
    if not playersenabled then return end
    esp_module:Add(model:FindFirstChild("HumanoidRootPart"), {
        Name = model.Name,
        Color = playerscolor,
        HighlightFocus = model,
    }, {
        Health = function()
            return model.Humanoid.Health, model.Humanoid.MaxHealth
        end
    })
end

local function OnPlayerLost(model)
    if not playersenabled then return end
    esp_module:Remove(model:FindFirstChild("HumanoidRootPart"))
end

local function OnEmployeeDetected(model)
    if not employeesenabled then return end
    esp_module:Add(model:FindFirstChild("HumanoidRootPart"), {
        Name = model.Name,
        Color = employeescolor,
        HighlightFocus = model,
    }, {
        Health = function()
            return model.Enemy.Health, model.Enemy.MaxHealth
        end
    })
end

local function OnEmployeeLost(model)
    if not employeesenabled then return end
    esp_module:Remove(model:FindFirstChild("HumanoidRootPart"))
end

local function OnItemAdded(item)
    if not foodenabled then return end
    esp_module:Add(item.Root, {
        Name = item.Name,
        Color = foodcolor,
        HighlightFocus = item
    })
end

local function OnItemRemoved(item)
    if not foodenabled then return end
    esp_module:Remove(item:FindFirstChild("Root"))
end

local function OnItemRootAppeared(item)

end

local function OnItemRootLost(item)

end

local function TrackPart(model, partName, onAppeared, onLost)

    local connections = {}
    local exists = false

    local function Check()
        local part = model:FindFirstChild(partName, true)
        local newState = part ~= nil and part:IsA("BasePart")

        if newState == exists then
            return
        end

        exists = newState

        if exists then
            onAppeared(model)
        else
            onLost(model)
        end
    end

    table.insert(connections, model.DescendantAdded:Connect(function(obj)
        if obj.Name == partName then
            Check()
        end
    end))

    table.insert(connections, model.DescendantRemoving:Connect(function(obj)
        if obj.Name == partName then
            task.defer(Check)
        end
    end))

    Check()

    return function()
        if exists then
            exists = false
            onLost(model)
        end

        for _, connection in connections do
            connection:Disconnect()
        end
    end
end


local function WatchCharacters(folder, onAppeared, onLost)
    local tracked = {}

    local function AddModel(model)

        if not model:IsA("Model") then return end
        if tracked[model] then return end

        local state = false
        local connections = {}

        local function Check()

            local root = model:FindFirstChild("HumanoidRootPart")
            local found = root ~= nil and root:IsA("BasePart")

            if state == found then return end

            state = found

            if found then
                onAppeared(model)
            else
                onLost(model)
            end
        end

        tracked[model] = connections

        connections[#connections + 1] =
            model.ChildAdded:Connect(function(child)
                if child.Name == "HumanoidRootPart" then
                    Check()
                end
            end)

        connections[#connections + 1] =
            model.ChildRemoved:Connect(function(child)
                if child.Name == "HumanoidRootPart" then
                    Check()
                end
            end)

        Check()
    end

    local function RemoveModel(model)

        local connections = tracked[model]
        if not connections then return end

        if state then

        end

        local root = model:FindFirstChild("HumanoidRootPart")

        if root then
            onLost(model)
        end

        for _, connection in connections do
            connection:Disconnect()
        end

        tracked[model] = nil
    end

    for _, model in folder:GetChildren() do
        AddModel(model)
    end

    folder.ChildAdded:Connect(AddModel)
    folder.ChildRemoved:Connect(RemoveModel)
end


WatchCharacters(
    PlayersFolder,
    OnPlayerDetected,
    OnPlayerLost
)

WatchCharacters(
    EmployeesFolder,
    OnEmployeeDetected,
    OnEmployeeLost
)

local food_names = {
    ["2 Litre Dr. Bub"] = true,
    ["Apple"] = true,
    ["Banana"] = true,
    ["Beans"] = true,
    ["Bloxy Soda"] = true,
    ["Burger"] = true,
    ["Cake"] = true,
    ["Candy Corn"] = true,
    ["Chips"] = true,
    ["Chocolate"] = true,
    ["Cinnamon Roll"] = true,
    ["Cookie"] = true,
    ["Dr. Bub Soda"] = true,
    ["Fish Crackers"] = true,
    ["Gingerbread Cookie"] = true,
    ["Glass Shard"] = true,
    ["Hotdog"] = true,
    ["Ice Cream"] = true,
    ["Lemon"] = true,
    ["Lemon Slice"] = true,
    ["Meatballs"] = true,
    ["Pizza"] = true,
    ["Striped Donut"] = true,
    ["Water"] = true
}

local function WatchItems(itemsFolder)
    local tracked = {}
    local FoundItems = {}
local function AddItem(item)

    if not item:IsA("Model") then return end
    if not food_names[item.Name] then return end
    if FoundItems[item] then return end

    FoundItems[item] = true

    tracked[item] = TrackPart(
        item,
        "Root",

        function(model)
            OnItemAdded(model)
            OnItemRootAppeared(model)
        end,

        function(model)
            OnItemRootLost(model)
        end
    )
end

    local function RemoveItem(item)

        if not FoundItems[item] then return end

        if tracked[item] then
            tracked[item]()
            tracked[item] = nil
        end

        FoundItems[item] = nil


        OnItemRemoved(item)
    end

    itemsFolder.ChildAdded:Connect(AddItem)
    itemsFolder.ChildRemoved:Connect(RemoveItem)

    for _, item in itemsFolder:GetChildren() do
        AddItem(item)
    end
end

local function WatchFloorModel(floorModel)

    if not floorModel:IsA("Model") then
        return
    end

    local function FindItems()
        local items = floorModel:FindFirstChild("Items")

        if items and items:IsA("Folder") then
            WatchItems(items)
            return true
        end

        return false
    end

    if not FindItems() then
        local connection

        connection = floorModel.ChildAdded:Connect(function(child)
            if child.Name == "Items" and child:IsA("Folder") then
                connection:Disconnect()
                WatchItems(child)
            end
        end)
    end
end


for _, floorModel in Floor:GetChildren() do
    WatchFloorModel(floorModel)
end

Floor.ChildAdded:Connect(WatchFloorModel)

local PlayersESP = ESP:AddToggle("plrESP", {
    Text = "Players ESP",
    Default = false,
    Callback = function(Value)

playersenabled = Value
WatchCharacters(
    PlayersFolder,
    OnPlayerDetected,
    OnPlayerLost
)

    end
}):AddColorPicker("ColorPicker1", {
    Default = Color3.fromRGB(0,255,0),
    Resizable = true,
    Callback = function(Value)

playerscolor = Value

    end
})

local EmployeesESP = ESP:AddToggle("empESP", {
    Text = "Employees ESP",
    Default = false,
    Callback = function(Value)

employeesenabled = Value

WatchCharacters(
    EmployeesFolder,
    OnEmployeeDetected,
    OnEmployeeLost
)

    end
}):AddColorPicker("ColorPicker1", {
    Default = Color3.fromRGB(255,0,0),
    Resizable = true,
    Callback = function(Value)

employeescolor = Value

    end
})

local FoodESP = ESP:AddToggle("foodESP", {
    Text = "Food ESP",
    Default = false,
    Callback = function(Value)

foodenabled = Value
WatchItems(ItemsFolder)

    end
}):AddColorPicker("ColorPicker1", {
    Default = Color3.fromRGB(128,0,128),
    Resizable = true,
    Callback = function(Value)

foodcolor = Value

    end
})

local VIPGroup = Tabs.Visuals:AddGroupbox({
    Side = "Left",
    Name = "Admin Panel",
    IconName = "shield-check",
})

local EnableCodeTab = VIPGroup:AddToggle("EnableCodeTab", {
    Text = "Enable Code Tab",
    Default = false,
    Disabled = true,
    Tooltip = "This toggle can be used only on private/vip servers.",
    Callback = function(Value)

player:FindFirstChild("Permissions"):SetAttribute("Code", Value)

    end
})

local TagGroup = Tabs.Visuals:AddGroupbox({
    Side = "Left",
    Name = "Tags",
    IconName = "tag",
})

local playerlist = player.PlayerGui.Playerlist.Playerlist[player.Name].Icons
local selectedtag = nil

local TagDropdown = TagGroup:AddDropdown("TagDropdown", {
    Text = "Select Tag:",
    Values = { "Chicken", "Cool", "Friend", "Moderator", "Owner", "Premium", "VIPOwner" },
    Multi = false,
    Default = "Cool",
    Callback = function(Value)

selectedtag = Value

    end
})
TagGroup:AddButton("Set Tag", function()

for _,v in ipairs(playerlist:GetChildren()) do

if v:IsA("ImageLabel") then
v.Visible = false
end

end

playerlist[selectedtag].Visible = true

end)

if player:FindFirstChild("Permissions"):GetAttribute("Broadcast") == true then

EnableCodeTab:SetDisabled(false)

end

local Teleport = Tabs.Functions:AddGroupbox({
    Side = "Left",
    Name = "Teleportation",
    IconName = "telescope",
})

local employee_objects = {}
local player_objects = {}
local food_objects = {}

local sel_employee = nil
local sel_player = nil
local sel_food = nil

local food_names = {
    ["2 Litre Dr. Bub"] = true,
    ["Apple"] = true,
    ["Banana"] = true,
    ["Beans"] = true,
    ["Bloxy Soda"] = true,
    ["Burger"] = true,
    ["Cake"] = true,
    ["Candy Corn"] = true,
    ["Chips"] = true,
    ["Chocolate"] = true,
    ["Cinnamon Roll"] = true,
    ["Cookie"] = true,
    ["Dr. Bub Soda"] = true,
    ["Fish Crackers"] = true,
    ["Gingerbread Cookie"] = true,
    ["Glass Shard"] = true,
    ["Hotdog"] = true,
    ["Ice Cream"] = true,
    ["Lemon"] = true,
    ["Lemon Slice"] = true,
    ["Meatballs"] = true,
    ["Pizza"] = true,
    ["Striped Donut"] = true,
    ["Water"] = true
}


local EmployeeList = Teleport:AddDropdown("EmployeeList", {
    Text = "Employee List",
    Values = {},
    Multi = false,

    Callback = function(Value)
        sel_employee = employee_objects[Value]
    end
})
local PlayerList = Teleport:AddDropdown("PlayerList", {
    Text = "Player List",
    Values = {},
    Multi = false,

    Callback = function(Value)
        sel_player = player_objects[Value]
    end
})

local FoodList = Teleport:AddDropdown("FoodList", {
    Text = "Food List",
    Values = {},
    Multi = false,

    Callback = function(Value)
        sel_food = food_objects[Value]
    end
})

local function get_physical()
    local gameObjects = workspace:FindFirstChild("GameObjects")
    if not gameObjects then return nil end

    return gameObjects:FindFirstChild("Physical")
end

local function add_object(object, values, objects, index)
    if object:IsA("Folder") then return end

    local key = tostring(index) .. "_" .. object:GetFullName()

    values[key] = object.Name
    objects[key] = object
end

local function update_employees()
    local physical = get_physical()
    if not physical then return end

    local folder = physical:FindFirstChild("Employees")
    if not folder then return end

    local values = {}
    table.clear(employee_objects)

    for i, employee in ipairs(folder:GetChildren()) do
        if employee:IsA("Model") then
            add_object(employee, values, employee_objects, i)
        end
    end

    EmployeeList:SetValues(values)
end

local function update_players()
    local physical = get_physical()
    if not physical then return end

    local folder = physical:FindFirstChild("Players")
    if not folder then return end

    local values = {}
    table.clear(player_objects)

    for i, player in ipairs(folder:GetChildren()) do
        if player:IsA("Model") then
            add_object(player, values, player_objects, i)
        end
    end

    PlayerList:SetValues(values)
end

local function update_food()
    local physical = get_physical()
    if not physical then return end

    local values = {}
    table.clear(food_objects)

    local added = {}
    local index = 0

    local function scan_items(items_folder)
        if not items_folder then return end

        for _, item in ipairs(items_folder:GetDescendants()) do
            if food_names[item.Name]
                and not item:IsA("Folder")
                and not added[item] then

                index += 1
                added[item] = true

                add_object(item, values, food_objects, index)
            end
        end
    end

    local main_items = physical:FindFirstChild("Items")
    scan_items(main_items)

    local map = physical:FindFirstChild("Map")

    if map then
        local floor = map:FindFirstChild("Floor")

        if floor then
            for _, obj in ipairs(floor:GetDescendants()) do
                if obj.Name == "Items" then
                    scan_items(obj)
                end
            end
        end
    end

    FoodList:SetValues(values)
end

local function teleport_to(target)
    if not target or not target.Parent then
        return
    end

    if not root then
        return
    end

    local targetCFrame

    if target:IsA("Model") then
        targetCFrame = target:GetPivot()

    elseif target:IsA("BasePart") then
        targetCFrame = target.CFrame

    else
        local part = target:FindFirstChildWhichIsA(
            "BasePart", true
        )

        if part then
            targetCFrame = part.CFrame
        end
    end

    if not targetCFrame then
        return
    end

    root:PivotTo(targetCFrame)
end

local old_pos_bring = nil
local dropfood = true

local function bring_item(target)

player.Character:FindFirstChild("HumanoidRootPart").Anchored = true
old_pos_bring = player.Character:GetPivot()
player.Character:PivotTo(target:GetPivot())

task.wait(math.random(1,2))

player.Character:FindFirstChild("HumanoidRootPart").Anchored = false

task.wait(0.5)

local argsStore = {
	"Store",
	{
		Model = target
	}
}
game:GetService("Players").LocalPlayer.Character:WaitForChild("System"):WaitForChild("Action"):InvokeServer(unpack(argsStore))

task.wait(math.random(1,2))

player.Character:PivotTo(old_pos_bring)

task.wait(0.5)

if dropfood then
local argsDrop = {
	"Inventory_Drop",
	{
		Tool = target.Name
	}
}
game:GetService("Players").LocalPlayer.Character:WaitForChild("System"):WaitForChild("Action"):InvokeServer(unpack(argsDrop))

end

end

Teleport:AddButton("Refresh Employees", function()
    update_employees()
end)

Teleport:AddButton("Refresh Players", function()
    update_players()
end)

Teleport:AddButton("Refresh Food", function()
    update_food()
end)

Teleport:AddDivider("")

Teleport:AddButton("Teleport to Employee", function()
    teleport_to(sel_employee)
end)

Teleport:AddButton("Teleport to Player", function()
    teleport_to(sel_player)
end)

Teleport:AddButton("Teleport to Food", function()
    teleport_to(sel_food)
end)

Teleport:AddDivider("")

Teleport:AddButton("Bring Food", function()
    bring_item(sel_food)
end)

local Drop = Teleport:AddToggle("Drop", {
    Text = "Drop bringed food",
    Default = true,
    Callback = function(Value)

dropfood = Value

    end
})

update_employees()
update_players()
update_food()

local PlayerFGroup = Tabs.Functions:AddGroupbox({
    Side = "Right",
    Name = "Player",
    IconName = "user-round",
})

local med_oldpos = nil

local automedkit = false
local medkitdb = false

local health_val = 30
local medkit_count = 1

local AutoMedkit = PlayerFGroup:AddToggle("AutoMedkit", {
    Text = "Auto Self-Medkit",
    Default = false,

    Callback = function(Value)
        automedkit = Value
    end
})

task.spawn(function()
    while task.wait(0.25) do

        if automedkit
            and humanoid
            and humanoid.Health < health_val
            and not medkitdb then

            medkitdb = true

            med_oldpos = player.Character:GetPivot()

            local found = false

          for i = 1, medkit_count do


            for _, v in ipairs(
                workspace.GameObjects.Physical:GetDescendants()
            ) do

                if v.Name == "Medkit"
                    and (v:IsA("Model") or v:IsA("BasePart")) then

                    found = true

                    local success, err = pcall(function()

                        local cf = v:GetPivot()

                        root:PivotTo(cf)

                        task.wait(0.5)

                        local args = {
                            "Store",
                            {
                                Model = v
                            }
                        }

                         player.Character:FindFirstChild("System").Action:InvokeServer(unpack(args))

                        task.wait(0.3)

                        local args2 = {
                            "Inventory_Consume",
                            {
                                Tool = "Medkit"
                            }
                        }

                        player.Character:FindFirstChild("System").Action:InvokeServer(unpack(args2))

                    end)

                    if not success then
                        warn("AutoMedkit error:", err)
                    end

                    break
                end
            end


              task.wait(2)
          end

            medkitdb = false
            task.wait(0.2)
            player.Character:PivotTo(med_oldpos)

            if not found then
                task.wait(1)
            end
        end
    end
end)

local Activationthreshold = PlayerFGroup:AddSlider("Threshold", {
    Text = "Health Threshold",
    Default = 30,
    Min = 2,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)

health_val = Value

    end
})

local Medcount = PlayerFGroup:AddSlider("Medcount", {
    Text = "Medkit Count",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(Value)

medkit_count = Value

    end
})

PlayerFGroup:AddDivider("")

local playerselected = nil
local playerwhistenabled = false
local whistleviewport = player.PlayerGui:FindFirstChild("MainGui"):FindFirstChild("WhistleViewport")

local players_whist = {}

local TeleportToWhistle = PlayerFGroup:AddToggle("Whistle", {
    Text = "Auto Teleport to Player Whistle",
    Default = false,
    Callback = function(Value)
        playerwhistenabled = Value
    end
})

local TeleportToDropdown = PlayerFGroup:AddDropdown("TeleportToDropdown", {
    Text = "Select Player",
    Values = {},
    Multi = false,
    Callback = function(Value)
        playerselected = Value
    end
})

local function UpdatePlayersDropdown()
    local playerNames = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end

    TeleportToDropdown:SetValues(playerNames)

    if playerselected and not Players:FindFirstChild(playerselected) then
        playerselected = nil
    end
end

local function CheckWhistle()
    if not playerwhistenabled or not playerselected then
        return
    end

    local selectedPlayer = Players:FindFirstChild(playerselected)
    if not selectedPlayer or not selectedPlayer.Character then
        return
    end

    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then return end

    local mainGui = playerGui:FindFirstChild("MainGui")
    if not mainGui then return end

    local whistleviewport = mainGui:FindFirstChild("WhistleViewport")
    if not whistleviewport then return end

    for _, image in ipairs(whistleviewport:GetChildren()) do
        if image.Name == tostring(selectedPlayer.UserId) .. "_WhistleIcon" then
            local character = player.Character

            if character then
                character:PivotTo(selectedPlayer.Character:GetPivot())
            end

            return
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    UpdatePlayersDropdown()
end)

Players.PlayerRemoving:Connect(function(player)
    UpdatePlayersDropdown()
end)

UpdatePlayersDropdown()

task.spawn(function()
    while true do
        if playerwhistenabled then
                local teleported = false

                while playerwhistenabled and not teleported do
                    if CheckWhistle() then
                        teleported = true
                    end

                    task.wait(5)
                end
        end

        task.wait(0.2)
    end
end)

local PlacesGroup = Tabs.Functions:AddGroupbox({
    Side = "Right",
    Name = "Places",
    IconName = "earth",
})

local teleportService = game:GetService("TeleportService")

PlacesGroup:AddDivider("Archived")

PlacesGroup:AddButton("Version 1.4", function()
    teleportService:Teleport(12146577494, player)
end)
PlacesGroup:AddButton("Version 2.1", function()
    teleportService:Teleport(12146583406, player)
end)
PlacesGroup:AddButton("Version 2.2", function()
    teleportService:Teleport(12146572337, player)
end)
PlacesGroup:AddButton("Version 2.3", function()
    teleportService:Teleport(12146562770, player)
end)
PlacesGroup:AddButton("Version 2.4", function()
    teleportService:Teleport(12146559508, player)
end)
PlacesGroup:AddButton("Version 2.5", function()
    teleportService:Teleport(12146555326, player)
end)
PlacesGroup:AddButton("Version 2.7", function()
    teleportService:Teleport(12146548680, player)
end)

PlacesGroup:AddDivider("Numbers")

PlacesGroup:AddButton("3008 - 4122", function()
    teleportService:Teleport(16988606884, player)
end)
PlacesGroup:AddButton("3008 - 4123", function()
    teleportService:Teleport(13003089266, player)
end)
PlacesGroup:AddButton("3008 - 4124", function()
    teleportService:Teleport(16988541929, player)
end)
PlacesGroup:AddButton("3008 - 4125", function()
    teleportService:Teleport(127222215565383, player)
end)

PlacesGroup:AddDivider("Other")

PlacesGroup:AddButton("Discontinued Singleplayer", function()
    teleportService:Teleport(2898101897, player)
end)
PlacesGroup:AddButton("Singleplayer", function()
    teleportService:Teleport(3824662112, player)
end)
PlacesGroup:AddButton("daveburger0's Place Number: 210", function()
    teleportService:Teleport(9247524041, player)
end)
PlacesGroup:AddButton("####", function()
    teleportService:Teleport(9247524234, player)
end)
PlacesGroup:AddButton("Voice Only", function()
    teleportService:Teleport(11614543894, player)
end)

local ObjectsGroup = Tabs.Functions:AddGroupbox({
    Side = "Left",
    Name = "Objects",
    IconName = "box",
})

local uis = game:GetService("UserInputService")

local deleteobjectenabled = false
local deleteobjectkeybind = Enum.KeyCode.V

local DeleteObject = ObjectsGroup:AddToggle("DeleteObject", {
    Text = "FE Delete Object",
    Default = false,

    Callback = function(Value)
        if falldamage then
          deleteobjectenabled = Value
        else
        notification("Obertone", "To use this function you need to enable 'No Fall Damage' ", 5)
        end
    end
})

ObjectsGroup:AddInput("DeleteObjectKeybind", {
    Default = "V",
    Numeric = false,
    Finished = false,
    ClearTextOnFocus = false,
    MaxLength = 1,

    Text = "Delete Object Keybind",

    Callback = function(Value)
        local key = Value:upper()

        if Enum.KeyCode[key] then
            deleteobjectkeybind = Enum.KeyCode[key]

        else

        end
    end,
})

uis.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if not deleteobjectenabled then
        return
    end

    if input.KeyCode ~= deleteobjectkeybind then
        return
    end


    if not character then
        return
    end

    local delete_oldpos = nil

delete_oldpos = character:GetPivot()
character:PivotTo(CFrame.new(806.7000122070312, 1755.8499755859375, 8.399999618530273, 1, 0, 0, 0, 1, 0, 0, 0, 1))
task.wait(0.3)
local args = {
	"Drop",
	{
		EndCFrame = CFrame.new(806.7000122070312, 1755.8499755859375, 8.399999618530273, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		CameraCFrame = vector.create(0.8630911111831665, -0.5018275380134583, 0.056946542114019394),
		Throw = true,
		ThrowPower = 0.018419502303004265
	}
}
character:WaitForChild("System"):WaitForChild("Action"):InvokeServer(unpack(args))
character:PivotTo(delete_oldpos)
if workspace.CurrentCamera:FindFirstChild("ReplicatedModel") then
workspace.CurrentCamera:FindFirstChild("ReplicatedModel"):Destroy()
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

MenuGroup:AddToggle("ShowRobloxCursor", {
	Text = "Hide Roblox Cursor",
	Default = true,
	Callback = function(Value)

local uis = game:GetService("UserInputService")
uis.MouseIconEnabled = not Value

	end,
})

local uis = game:GetService("UserInputService")
uis.MouseIconEnabled = false

Library.Cursor:ChangeIcon("rbxassetid://79308084057456")

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
;  DELETEOBJECT VERSION - 1.0
   LOADED SUCCESSFULLY
]])
notification("Obertone", "Obertone loaded successfully!", 5)

if player.Name == "ValerikRobJR" and player.UserId == 9015172057 then
notification("Obertone", "Welcome Creator, Have a good day!")
end

SaveManager:LoadAutoloadConfig()

task.wait(2)

Window:ChangeTitle("Obertone")
