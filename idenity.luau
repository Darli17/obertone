local repo = "https://raw.githubusercontent.com/Darli17/obertone/"
local repoLib = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repoLib .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repoLib .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repoLib .. "addons/SaveManager.lua"))()

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

if game.PlaceId == 537413528 then
loadstring(game:HttpGet(repo.."refs/heads/main/loader.luau"))()
elseif game.PlaceId == 1930866268 then
loadstring(game:HttpGet(repo.."refs/heads/main/loader.luau"))()
elseif game.PlaceId == 1930863474 then
loadstring(game:HttpGet(repo.."refs/heads/main/loader.luau"))()
elseif game.PlaceId == 1930665568 then
loadstring(game:HttpGet(repo.."refs/heads/main/loader.luau"))()

else

notification("Obertone", "Only BABFT Supported! Join BABFT to use script!", 5)

end
