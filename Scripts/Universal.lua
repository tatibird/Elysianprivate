local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/tatibird/Elysianprivate/main/gui.library", true))()

local LocalPlayer = game.Players.LocalPlayer

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
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health == 0 then
        return
    end
    
    local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        return
    end
    
    workspace.Gravity = flygravityb.Value
    humanoid.WalkSpeed = flyspeedb.Value
    
    local UserInputService = game:GetService("UserInputService")
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
    ["Window"] = "Utility",
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
