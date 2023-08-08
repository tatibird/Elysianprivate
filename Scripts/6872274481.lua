local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/tatibird/Elysianprivate/main/gui.library", true))()
local entity = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua", true))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character.Humanoid

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
local itemtab = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.item["item-meta"]).getItemMeta, 1)
local CombatConstant = require(game:GetService("ReplicatedStorage").TS.combat["combat-constant"]).CombatConstant
local ShopItems = debug.getupvalue(debug.getupvalue(require(replicatedStorageService.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 1), 2),


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

local Distance = {Value = 15}
local AttackSpeed = {Value = 18}
GuiLibrary.MakeButton({
	["Name"] = "KillAura",
	["Window"] = "Combat",
	["Function"] = function(v)
         if v then
            spawn(function()
                repeat
                    for i,v in pairs(game.Players:GetChildren()) do
                        wait(0.01)
                        if v.Character and v.Name ~= LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
                            local mag = (v.Character.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                            if mag <= Distance.Value and v.Team ~= LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                                task.wait(1/AttackSpeed.Value)
                                --if getEquipped()["Type"] == "sword" then 
                                    SwordController:swingSwordAtMouse()
                                --end
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
	["Window"] = "Movement",
	["Function"] = function(v)
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
	["Name"] = "512xPack.",
	["Window"] = "Visuals",
	["Function"] = function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/tatibird/Elysianprivate/main/512xPack"))()
				end,
})

local Speedeb = {Value = 23}
GuiLibrary.MakeButton({
	["Name"] = "Speed",
	["Window"] = "Movement",
	["Function"] = function(v)
		if v == true then
             LocalPlayer.Character.Humanoid.WalkSpeed = Speedeb["Value"]
        else
             LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
 
	end,
})

local highjumpforce = {Value = 25}
GuiLibrary.MakeButton({
	["Name"] = "HighJump",
	["Window"] = "Utility",
	["Function"] = function(v)
		local highjumpval = v
            if highjumpval then
                LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                task.wait()
                workspace.Gravity = 5
                spawn(function()
                    for i = 1, highjumpforce["Value"] do
                        wait()
                        if (not highjumpval) then return end
                        LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                    end
                end)
                spawn(function()
                    for i = 1, highjumpforce["Value"] / 28 do
                        task.wait(0.1)
                        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                        task.wait(0.1)
                        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
                highjump:silentToggle()
            else
                workspace.Gravity = 196.19999694824
                return
            end
       end
})

local flygravityb = {Value = 0}
local flyspeedb = {Value = 23}
local FlyStudTP = {Value = 5}
local flyenabled = false

local function flyLogic()
    if not flyenabled then
        return
    end
    
    local character = LocalPlayer.Character
    if not character then
        return
    end
    
    if not Humanoid or Humanoid.Health == 0 then
        return
    end
    
    local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        return
    end
    
    workspace.Gravity = flygravityb.Value
    Humanoid.WalkSpeed = flyspeedb.Value
    
    local SpaceHeld = UserInputService:IsKeyDown(Enum.KeyCode.Space)
    local ShiftHeld = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
    
    if SpaceHeld then
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, FlyStudTP.Value, 0)
    end
    
    if ShiftHeld then
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -FlyStudTP.Value, 0)
    end
end

GuiLibrary.MakeButton({
    ["Name"] = "Fly",
    ["Window"] = "Movement",
    ["Function"] = function(v)
        flyenabled = v
        if flyenabled then
            spawn(function()
                while flyenabled do
                    flyLogic()
                    wait()
                end
            end)
        else
            if LocalPlayer.Character then
                LocalPlayer.Character.Humanoid.WalkSpeed = flyspeedb.Value
            end
            workspace.Gravity = 196
        end
 
    end,
})

local testtogttt = {Value = 20}
GuiLibrary.MakeButton({
    ["Name"] = "AutoClicker",
    ["Window"] = "Combat",
    ["Function"] = function(v) 
        if v then
            local holding = false
            ACC1 = UserInputService.InputBegan:connect(function(input, gameProcessed)
                if gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 then
                    holding = true
                end
            end)
            ACC2 = UserInputService.InputEnded:connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    holding = false
                end
            end)
            spawn(function()
                repeat
                    task.wait(1/testtogttt["Value"])
                    if holding then
                        if holding == false then return end
                        if getEquipped()["Type"] == "sword" then 
                            if holding == false then return end
                            SwordCont:swingSwordAtMouse()
                        end
                    end
                until (not v)
            end)
        else
            ACC1:Disconnect()
            ACC2:Disconnect()
            return
        end
    end
})

GuiLibrary.MakeButton({
    ["Name"] = "NoClickDelay",
    ["Window"] = "Combat",
    ["Function"] = function(v) 
        spawn(function()
            if v and entity.isAlive then
                for i2,v2 in pairs(itemtable) do
                    if type(v2) == "table" and rawget(v2, "sword") then
                        v2.sword.attackSpeed = 0.000000001
                    end
                    SwordCont.isClickingTooFast = function() return false end
                end
            else
            end
        end)
    end
})

local reachvalue = {Value = 18}
GuiLibrary.MakeButton({
    ["Name"] = "Reach",
    ["Window"] = "Combat",
    ["Function"] = function(v) 
        if v then
            CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = reachvalue["Value"]
        else
            CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = 14.4
        end

    end
})

local stats = LocalPlayer.leaderstats
local StatsUpdateDelay = {Value = 0.5}
GuiLibrary.MakeButton({
	["Name"] = "Stats Info",
	["Window"] = "Visuals",
	["Function"] = function(v)
if v == true then
	a = game:GetService("CoreGui"):FindFirstChild("MatchA_StateB")
   if a then
	  a.Enabled = true
   else

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Kills = Instance.new("TextLabel")


ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.132478639, 0, 0.359183669, 0)
Frame.Size = UDim2.new(0, 186, 0, 85)

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(-0.00160832563, 0, 0.225570142, 0)
Frame_2.Size = UDim2.new(0, 186, 0, 1)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(-0.022332469, 0, -0.0172869507, 0)
TextLabel.Size = UDim2.new(0, 193, 0, 20)
TextLabel.Font = Enum.Font.FredokaOne
TextLabel.Text = "Elysian"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000

Kills.Name = "Kills"
Kills.Parent = Frame
Kills.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Kills.BackgroundTransparency = 1.000
Kills.BorderColor3 = Color3.fromRGB(0, 0, 0)
Kills.BorderSizePixel = 0
Kills.Position = UDim2.new(-0.416643709, 0, 0.235294119, 0)
Kills.Size = UDim2.new(0, 186, 0, 20)
Kills.Font = Enum.Font.FredokaOne
Kills.Text = "Kills:"
Kills.TextColor3 = Color3.fromRGB(255, 255, 255)
Kills.TextSize = 14.000

while wait(StatsUpdateDelay["Value"]) do
	Kills_label.Text = "Kills: ".. stats.Kills.Value
	Bed_label.Text = "Bed: ".. stats.Bed.Value
	Skulls_label.Text = "Skulls: ".. stats.Skulls.Value
end

end
else
game:GetService("CoreGui"):FindFirstChild("MatchA_StateB").Enabled = false
end
end
})

do
local tiered = {}
local nexttier = {}

for i,v in pairs(bedwars.ShopItems) do
	if type(v) == "table" then 
		if v.tiered then
			tiered[v.itemType] = v.tiered
		end
		if v.nextTier then
			nexttier[v.itemType] = v.nextTier
		end
	end
end

GuiLibrary.MakeButton({
    ["Name"] = "ShopTierBypass",
    ["Window"] = "Utility",
    ["Function"] = function(v) 
        if v then
		for i,v in pairs(ShopItems) do
			if type(v) == "table" then 
				v.tiered = nil
				v.nextTier = nil
			end
		end
	else
	for i,v in pairs(ShopItems) do
		if type(v) == "table" then 
			if tiered[v.itemType] then
				v.tiered = tiered[v.itemType]
			end
			if nexttier[v.itemType] then
				v.nextTier = nexttier[v.itemType]
			end
		end
	end
 end

    end
})
end
