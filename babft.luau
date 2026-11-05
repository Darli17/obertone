local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false 
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = false

local Window = Library:CreateWindow({
	Title = " ",
	Footer = "Obertone v1.0 [RELEASE]",
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
  Inventory = Window:AddTab("Inventory", "brick-wall"),
  Quests = Window:AddTab("Quests", "scroll-text"),
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

local Dialog
local Key
Dialog = Window:AddDialog("DialogueIdx", {
    Title = "Beta Version Key",
    Description = "You need to enter key to proceed.",
    AutoDismiss = false,
    OutsideClickDismiss = false,
    FooterButtons = {
        Cancel = {
            Title = "Cancel",
            Variant = "Destructive",
            Order = 1,
            Callback = function()
                Library:Unload()
            end
        },
        Confirm = {
            Title = "Confirm",
            Variant = "Primary",
            WaitTime = 3, -- 3 seconds minimum wait
            Order = 2,
            Callback = function(self)
                if Key ~= "BETA-3591" then
                    notification("Obertone", "Key is No Valid, Enter right key to enter script.")
                    else
                    notification("Obertone", "Key is Valid! You can proceed.")
                    Dialog:Dismiss()
                end
            end
        }
    }
})
Dialog:AddInput("InputTest", {
    Text = "Key:",
    Callback = function(value) Key = value  end
})

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character.HumanoidRootPart

local function updateCharacter(character)
    character = character or player.Character
    root = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
    tag = root:WaitForChild("GroupLabel").TextLabel
end

updateCharacter(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(function(character)
    updateCharacter(character)
end)

-- Modifiers

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

local noclip = false

local Noclip = PlayerGroup:AddToggle("Noclip", {
    Text = "Noclip",
    Default = false,
    Callback = function(Value)

noclip = Value

while noclip == true and task.wait(0.) do

character:WaitForChild("LowerTorso").CanCollide = false
character:WaitForChild("UpperTorso").CanCollide = false
character:WaitForChild("HumanoidRootPart").CanCollide = false

if noclip == false then

character:WaitForChild("LowerTorso").CanCollide = true
character:WaitForChild("UpperTorso").CanCollide = true
character:WaitForChild("HumanoidRootPart").CanCollide = true

end

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

local WorldGroup = Tabs.Modifiers:AddGroupbox({
    Side = "Right",
    Name = "World",
    Description = "Change the sky, the fog. Whatever you’d like!",
    IconName = "earth",
})

WorldGroup:AddDivider("World/Sky")

local SkyId = nil
local OriginalSky = nil
local CustomSky = nil

WorldGroup:AddInput("SkyID", {
    Default = "",
    Numeric = false,
    Finished = true,
    ClearTextOnFocus = false,
    Text = "Sky ID:",
    Placeholder = "rbxassetid://123456789",

    Callback = function(Value)
        SkyId = Value
        print("Sky ID:", SkyId)
    end,
})

WorldGroup:AddToggle("EnableSky", {
    Text = "Enable Custom Sky",
    Default = false,

    Callback = function(Value)
        local lighting = game:GetService("Lighting")

        if Value then
            if not SkyId or SkyId == "" then
                warn("Please enter a Sky ID first")
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
                warn("Failed to load Sky:", result)

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

WorldGroup:AddDivider("Fog")

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
print(SelectedItems)

    end
})
local IncludeGoldItems = ShopGroup:AddToggle("GoldItems", {
    Text = "Include Gold Items",
    Default = false,
    Callback = function(Value)

IncludeGoldItems = Value
print(IncludeGoldItems)

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

local BuyGold = BuyGroup:AddLabel("Gold: ", false)

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
    BuyGold:SetText("Gold: " .. Gold)
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

local AutoBuyGold = AutoBuyGroup:AddLabel("Gold: ", false)

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
    AutoBuyGold:SetText("Gold: " .. Gold2)
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

_G.FarmEnabled = false

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
task.wait(1)
clearchest(stage6)
if humanoid.Health == 0 then
stopfarm()
end
if not root then
stopfarm()
end
task.wait(0.5)
if alt_debounce == true then return end
TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {
  Position = stage6.Position,
}):Play()
task.wait(0.3)
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

local disablegoldreward = false

local DisableGold = GoldFarmGroup:AddToggle("DisableGold", {
    Text = "Disable Gold Reward Sound",
    Default = false,
    Callback = function(Value)

disablegoldreward = Value

while disablegoldreward == true and task.wait(0.1) do

local goldgained = 2
local purchase = 0.5

local sounds_place = player.PlayerGui.GainedGoldGui.Gain
sounds_place.GoldGainedSound.Volume = 0
sounds_place.PurchaseSound1.Volume = 0
sounds_place.PurchaseSound2.Volume = 0
sounds_place.PurchaseSound3.Volume = 0


if disablegoldreward == false then

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
    IconName = "sparkle",
})

local Event_Text = EventsGroup:AddLabel("Season: Definition...", false)
task.wait(0.1)
local Season = nil
local SeasonModule = require(game.ReplicatedStorage.Scripts.SeasonMS)
Season = SeasonModule.getSeason()
if Season == nil then
Event_Text:SetText("Event: No Event Found!")
else
Event_Text:SetText("Event: "..Season)
end

EventsGroup:AddDivider("Halloween")

local autocollect = false
local success = nil 

local Func_Text = EventsGroup:AddLabel("You can use Buy/Auto Buy", false)
local Houses_Text = EventsGroup:AddLabel("Current Houses: I dont know", false)

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

local AutoCandy = EventsGroup:AddToggle("AutoCandy", {
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

EventsGroup:AddDivider("Christmas")

local Status_Text = EventsGroup:AddLabel("No functions for", false)
local Status2_Text = EventsGroup:AddLabel("this Season/Event", false)
local Func_Text = EventsGroup:AddLabel("You can use Buy/Auto Buy", false)

EventsGroup:AddDivider("July")

local Status_Text = EventsGroup:AddLabel("No functions for", false)
local Status2_Text = EventsGroup:AddLabel("this Season/Event", false)
local Func_Text = EventsGroup:AddLabel("You can use Buy/Auto Buy", false)


local DataGroup = Tabs.Inventory:AddGroupbox({
    Side = "Left",
    Name = "Data",
    Description = "Give fake items, gold and other.",
    IconName = "box",
})

Tabs.Inventory:UpdateWarningBox({
    Title = "WARNING",
    Text = "It's manipulating you DATA FOLDER, IF BABFT CAN'T LOAD YOU SAVE DON'T PANIC. ITS OKAY.",
    IsNormal = false, -- Error Box = false, Normal Box = true
    Visible = true,
    LockSize = true,
})
--[[
Tabs.Inventory:UpdateWarningBox({
    Title = "ADDITIONAL INFO",
    Text = "After applying the Give or Give all 99999, functions you will no longer be able to place the block/blocks for which you modified the value.",
    IsNormal = true, -- Error Box = false, Normal Box = true
    Visible = true,
    LockSize = true,
})
]]

local DataItem = nil
local DataQuantity = 1

DataGroup:AddButton({
    Text = "Give",
    Risky = true,
    DoubleClick = true,
    Func = function()

local Data = player.Data
Data[DataItem].Value += DataQuantity

    end
})

local Values = {}

for _, v in ipairs(player.Data:GetChildren()) do
    if v:IsA("IntValue") then
        table.insert(Values, v.Name)
    end
end

local ItemsDropdown = DataGroup:AddDropdown("ItemsDropdown", {
    Text = "Select Item:",
    Values = Values,
    Default = "WoodBlock",
    Multi = false,
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

	Placeholder = "1", 

	Callback = function(Value)

DataQuantity = Value

	end,
})

DataGroup:AddButton({
    Text = "Set all on 99999",
    Risky = true,
    DoubleClick = true,
    Func = function()

for _, v in ipairs(game.Players.LocalPlayer.Data:GetDescendants()) do
    if v:IsA("IntValue") and v.Name ~= "Gold" and v.Name ~= "BindTool" and v.Name ~= "PaintingTool" and v.Name ~= "PropertiesTool" and v.Name ~= "ScalingTool" and v.Name ~= "TrowelTool" then
        v.Value = 99999
    end
end
task.wait(0.3)
player.Humanoid:TakeDamage(300)

    end
})

local FuncGroup = Tabs.Inventory:AddGroupbox({
    Side = "Right",
    Name = "Functions",
    Description = "Custom place blocks and other.",
    IconName = "rocket",
})

local disablelimitdata = false

FuncGroup:AddDivider("Data Blocks")

local DisableBlocksData = FuncGroup:AddToggle("DisableBlocksData", {
    Text = "Disable deleting Data Blocks [BETA]",
    Tooltip = "All blocks provided via DATA can be placed, they will not be removed. [BETA]",
    Default = false,
    Callback = function(Value)

disablelimitdata = Value

    end
})

workspace.ChildAdded:Connect(function(v2x)


 if disablelimitdata == true then

    task.wait(0.02)
    if v2x:IsA("Model") then

local clone = v2x:Clone()
clone.Parent = workspace.Blocks[player.Name]

    for _,model in ipairs(v2x:GetDescendants()) do
       if model:IsA("Part") or model:IsA("MeshPart") or model:IsA("UnionOperation") or model:IsA("WedgePart") then
          model.Transparency = 0
      end
    end

   end

   else

   tostring("disabled")

 end

end)

FuncGroup:AddDivider("Attach block Methods")

local unanchorfirework = true
local unanchorglue = true

FuncGroup:AddButton("Place Firework Method", function()
    

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
    [1] = "Firework",
    [2] = 1,
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

FuncGroup:AddDivider("Codes")

FuncGroup:AddButton("Redeem all codes", function()
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
end)

local QuestsGroup = Tabs.Quests:AddGroupbox({
    Side = "Left",
    Name = "Quests",
    Description = "Auto quest and other.",
    IconName = "sticky-note",
})

local questnumber = 1

local questtext = QuestsGroup:AddLabel("Quest: 1", false)

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
print("yesssss")
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

local FunGroup = Tabs.Quests:AddGroupbox({
    Side = "Right",
    Name = "Fun",
    Description = "Just fun :)",
    IconName = "sticky-note-check",
})

local AddInvasion = FunGroup:AddToggle("AddInvasion", {
    Text = "Add Invasion Button",
    Default = false,
    Callback = function(Value)

local quests = player.PlayerGui.ShopGui.MainFrame.TabFrame.QuestFrame.ScrollingFrame

quests.Quest101.Visible = Value

    end
})

local AddInvasion = FunGroup:AddToggle("AddInvasion", {
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

local AddRings = FunGroup:AddToggle("AddRings", {
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
local AddSecretSoccer = FunGroup:AddToggle("AddSecretSoccer", {
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

            local StageLabel = StagesGroup:AddLabel("Stage Not Spawned", false)

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

Window:ChangeTitle("Obertone")

SaveManager:LoadAutoloadConfig()
