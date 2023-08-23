repeat task.wait() until game:IsLoaded()

local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
local LocalPlayer = game.Players.LocalPlayer
local PlaceID = game.PlaceId or 123456789

LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/tatibird/Elysianprivate/main/MainScript.lua'))()")
    end
end)
if PlaceID == 6872274481 or PlaceID == 8560631822 or PlaceID == 8444591321 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tatibird/Elysianprivate/main/Bedwars"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tatibird/Elysianprivate/main/Scripts/Universal.lua"))()
end
