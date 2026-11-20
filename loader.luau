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

Loading:Continue() -- Destroys the loader and opens the main window

end
