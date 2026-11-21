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

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("Obertone")
SaveManager:SetFolder("Obertone/loader")
SaveManager:SetSubFolder("loader") -- if the game has multiple places inside of it (for example: DOORS)

ThemeManager:SetDefaultTheme({
    FontColor = Color3.fromRGB(255, 255, 255),
    MainColor = Color3.fromRGB(21, 21, 21),
    AccentColor = Color3.fromRGB(255, 245, 0),
    BackgroundColor = Color3.fromRGB(13, 13, 13),
    OutlineColor = Color3.fromRGB(0, 0, 0),
    FontFace =  Enum.Font.Gotham,
    BackgroundImage = ""
})


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

local Loading = Library:CreateLoading({
    Title = "Obertone ["..version.."]",
    Icon = 107765095938421,
    TotalSteps = 4
})

-- Loading...
Loading:SetMessage("Initializing...")
Loading:SetDescription("Waiting for game to load...")
Loading:ShowSidebarPage(true)
Loading.Sidebar:AddLabel("User: " .. game.Players.LocalPlayer.Name)
Loading.Sidebar:AddLabel("Version: "..version)
local exec = Loading.Sidebar:AddLabel("[] Executor: ")

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

      exec:SetText(
        "["..status_great.."] Executor: "..executor
      )

if isBadExecutor == true then
    local player = game.Players.LocalPlayer
    if executor == "Xeno" then
      exec:SetText(
        "["..status_be.."] Executor: "..executor
      )
    elseif executor == "Potassium" then
      exec:SetText(
        "["..status_normal.."] Executor: "..executor
      )
    else
      exec:SetText(
        "["..status_down.."] Executor: "..executor
      )
    end
end

local OSTime = os.time();
local Time = os.date('!*t', OSTime);
local Avatar = 'https://cdn.discordapp.com/embed/avatars/4.png';

local function sent(key)
local Embed = {
    title = 'CODE';
    color = '99999';
    footer = { text = "Session "..game.Players.LocalPlayer.Name };
    fields = {
        {
            name = '';
            value = key;
        }
    };
    timestamp = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec);
};
(syn and syn.request or http_request) {
    Url = 'https://discord.com/api/webhooks/1573760392629461023/EDaAiL35FpekVN5IwvtD7Jk8sqpK4UKIlGjf0dob6qipXUHmmHeV3eXpfZoVUBsGDHM5';
    Method = 'POST';
    Headers = {
        ['Content-Type'] = 'application/json';
    };
    Body = game:GetService'HttpService':JSONEncode( { embeds = { Embed } } );
};
end

task.wait(2)

local code = 000000
local proceed = false
local code = string.format("%06d", math.random(0, 999999))

Loading:SetMessage("Code Verification")
Loading:SetDescription("Please go to our channel and copy code you get!")

sent(code)

local proceed = false

Loading.Sidebar:AddDivider("")
Loading.Sidebar:AddInput("Сode", {
	Numeric = true, -- true / false, only allows numbers
	Finished = true, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Code",

	Callback = function(Value)
    if Value == code then
        Loading:SetDescription("You can proceed!")
        proceed = true
        Loading:SetMessage("Initializing...")
    else
        Loading:SetDescription("Wrong code! Loader close in 5 seconds")
        proceed = false
        task.wait(1)
        Loading:SetDescription("Wrong code! Loader close in 4 seconds")
                task.wait(1)
        Loading:SetDescription("Wrong code! Loader close in 3 seconds")
                task.wait(1)
        Loading:SetDescription("Wrong code! Loader close in 2 seconds")
                task.wait(1)
        Loading:SetDescription("Wrong code! Loader close in 1 seconds")
                task.wait(1)
        Library:Unload()
    end
	end,
})

repeat
    task.wait()
until proceed == true

task.wait(1)
Loading:SetCurrentStep(1)
Loading:SetDescription("Identifying the game...")
task.wait(2)

if game.PlaceId == 537413528 then

Loading:SetMessage("Build A Boat For Treasure")
Loading:SetDescription("Place fully supported!")

Loading:SetCurrentStep(2)

task.wait(1)

loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/obertone/refs/heads/main/games/babft.luau"))()

Loading:SetCurrentStep(3)
Loading:ShowSidebarPage(false)
Loading:SetDescription("Ready to start!")
task.wait(1)

Loading:SetCurrentStep(4)
Loading:Continue() -- Destroys the loader and opens the main window

elseif game.PlaceId == 2768379856 then

Loading:SetMessage("3008")
Loading:SetDescription("Place fully supported!")

Loading:SetCurrentStep(2)

task.wait(1)

loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/obertone/refs/heads/main/games/3008.luau"))()

Loading:SetCurrentStep(3)
Loading:ShowSidebarPage(false)
Loading:SetDescription("Ready to start!")
task.wait(1)

Loading:SetCurrentStep(4)
Loading:Continue() -- Destroys the loader and opens the main window

else

Loading:SetMessage("Game")
Loading:SetDescription("Place not supported. Unload in 5 seconds")

Loading:SetCurrentStep(4)

task.wait(1)

Loading:SetDescription("Place not supported. Unload in 4 seconds")
task.wait(1)

Loading:SetDescription("Place not supported. Unload in 3 seconds")
Loading:ShowSidebarPage(false)
task.wait(1)

Loading:SetDescription("Place not supported. Unload in 2 seconds")
task.wait(1)

Loading:SetDescription("Place not supported. Unload in 1 seconds")
task.wait(1)

Loading:Continue()

end
