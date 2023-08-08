local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/tatibird/Elysianprivate/main/gui.library", true))()
local entity = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua", true))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

local KnitClient = debug.getupvalue(require(LocalPlayer.PlayerScripts.TS.knit).setup, 6)

local SwordController = require(LocalPlayer.PlayerScripts.TS.controllers.global.combat.sword["sword-controller"]).SwordController
local SprintController = require(LocalPlayer.PlayerScripts.TS.controllers.global.sprint["sprint-controller"]).SprintController
local kbtable = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1)
local InventoryUtil = require(ReplicatedStorage.TS.inventory["inventory-util"]).InventoryUtil
local itemtablefunc = require(ReplicatedStorage.TS.item["item-meta"]).getItemMeta
local itemtable = debug.getupvalue(itemtablefunc, 1)
local matchend = require(LocalPlayer.PlayerScripts.TS.controllers.game.match["match-end-controller"]).MatchEndController
local matchstate = require(ReplicatedStorage.TS.match["match-state"]).MatchState
local KnitClient = debug.getupvalue(require(LocalPlayer.PlayerScripts.TS.knit).setup, 6)
local ballooncontroller = KnitClient.Controllers.BalloonController
--local queuemeta = require(ReplicatedStorage.TS.game["queue-meta"]).QueueMeta
local clntstorehandlr = require(LocalPlayer.PlayerScripts.TS.ui.store).ClientStore
local matchState = clntstorehandlr:getState().Game.matchState
local itemmeta = require(ReplicatedStorage.TS.item["item-meta"])
local itemstuff = debug.getupvalue(require(ReplicatedStorage.TS.item["item-meta"]).getItemMeta, 1)


local function getEquipped()
    local typetext = ""
    local obj = (entity.isAlive and LocalPlayer.Character:FindFirstChild("HandInvItem") and LocalPlayer.Character.HandInvItem.Value or nil)
    if obj then
        if obj.Name:find("sword") or obj.Name:find("blade") or obj.Name:find("baguette") or obj.Name:find("scythe") or obj.Name:find("dao") then
            typetext = "sword"
        end
        if obj.Name:find("wool") or itemtab[obj.Name]["block"] then
            typetext = "block"
        end
        if obj.Name:find("bow") then
            typetext = "bow"
        end
    end
    return {["Object"] = obj, ["Type"] = typetext}
end

local Distance = {Value = 10}
local AttackSpeed = {Value = 15}
GuiLibrary.MakeButton({
	["Name"] = "KillAura",
	["Window"] = "Combat",
	["Function"] = function(v)
         if v then
                spawn(function()
                    repeat
                        for i,v in pairs(game.Players:GetChildren()) do
                            wait(0.01)
                            if v.Character and v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
                                local mag = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                if mag <= Distance.Value and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                                    task.wait(1/AttackSpeed["Value"])
                                    if getEquipped()["Type"] == "sword" then 
                                    SwordController:swingSwordAtMouse()
                                    end
                                end
                            end
                        end                    
                    until (not v)
                end)
            end
	end,
})
GuiLibrary.MakeButton({
	["Name"] = "Texture Pack",
	["Window"] = "Visuals",
	["Function"] = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/tatibird/Elysian/main/Texture%20packs"))()
	end,
})

GuiLibrary.MakeButton({
	["Name"] = "Sprint",
	["Window"] = "Utility",
	["Function"] = function()
        sprint = v
        if sprint then
            spawn(function()
                repeat
                    wait()
                    if (not sprint) then return end
                    if SprintController.sprinting == false then
                	SprintController:startSprinting()
                    end
                until (not sprint)
            end)
        else
            SprintController:stopSprinting()
        end
    end
})

GuiLibrary.MakeButton({
	["Name"] = "Velocity",
	["Window"] = "Combat",
	["Function"] = function()
        getgenv().veloval = v
            spawn(function()
                if getgenv().veloval then
                    if not Humanoid then return end
                    if Humanoid then
                        kbtable["kbDirectionStrength"] = 0
                        kbtable["kbUpwardStrength"] = 0
                    end
                else
                    kbtable["kbDirectionStrength"] = 100
                    kbtable["kbUpwardStrength"] = 100
                    return
                end
            end)
	end,
})

GuiLibrary.MakeButton({
	["Name"] = "512xPack",
	["Window"] = "Visuals",
	["Function"] = function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/tatibird/Elysianprivate/main/512xPack"))()
				end,
})
