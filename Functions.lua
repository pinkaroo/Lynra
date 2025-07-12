 local lynra = {}

 if getgenv().lynra then return end

 local Players = game.Players
 local LocalPlayer = Players.LocalPlayer

 lynra.teleport = function(vector3)
     local char = LocalPlayer.Character
     if char then
         char:PivotTo(CFrame.new(vector3))
     end
 end

 lynra.remote_spy = function()
     loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua'))()
 end

 lynra.dex = function()
     loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
 end

 lynra.infinite_yield = function()
     loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
 end

 getgenv().lynra = lynra
