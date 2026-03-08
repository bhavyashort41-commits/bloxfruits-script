-- Simple Blox Fruits Mobile Auto Farm (Delta Friendly)

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local lp = Players.LocalPlayer

local AUTO_FARM = false

-- Find closest enemy
function getMob()
    local dist = math.huge
    local target = nil

    for _,v in pairs(Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
            if v.Humanoid.Health > 0 then

                local mag = (lp.Character.HumanoidRootPart.Position -
                v.HumanoidRootPart.Position).Magnitude

                if mag < dist then
                    dist = mag
                    target = v
                end
            end
        end
    end

    return target
end

-- Attack mob
function attack(mob)

    repeat task.wait()

        lp.Character.HumanoidRootPart.CFrame =
        mob.HumanoidRootPart.CFrame * CFrame.new(0,5,3)

        local tool = lp.Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end

    until mob.Humanoid.Health <= 0 or not AUTO_FARM

end

-- Auto farm loop
spawn(function()

    while task.wait(0.5) do

        if AUTO_FARM then
            local mob = getMob()

            if mob then
                attack(mob)
            end
        end

    end

end)

-- Simple GUI
local gui = Instance.new("ScreenGui", game.CoreGui)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,200,0,100)
frame.Position = UDim2.new(0.7,0,0.2,0)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
frame.Active = true
frame.Draggable = true

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0,180,0,40)
btn.Position = UDim2.new(0,10,0,30)
btn.Text = "Auto Farm : OFF"
btn.TextSize = 20
btn.BackgroundColor3 = Color3.fromRGB(50,50,80)
btn.TextColor3 = Color3.new(1,1,1)

btn.MouseButton1Click:Connect(function()

    AUTO_FARM = not AUTO_FARM

    btn.Text = "Auto Farm : "..(AUTO_FARM and "ON" or "OFF")

end)
