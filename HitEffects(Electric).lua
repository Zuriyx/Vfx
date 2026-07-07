local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HeartbeatConnections = {}
local CharacterAddedConnections = {}
local enabled = true

local function PlaySound(assetId, volume)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. assetId
    sound.Volume = volume
    sound.Parent = LocalPlayer:WaitForChild("PlayerGui")
    sound:Play()
    sound.Ended:Wait()
    sound:Destroy()
end

if HeartbeatConnections[26] then HeartbeatConnections[26]:Disconnect() end
if CharacterAddedConnections[26] then CharacterAddedConnections[26]:Disconnect() end
if HeartbeatConnections[36] then HeartbeatConnections[36]:Disconnect() end
if CharacterAddedConnections[36] then CharacterAddedConnections[36]:Disconnect() end

if enabled and LocalPlayer then
    local soundData = {
        [2] = {{id = "13064223399", volume = 2}},
        [3] = {{id = "13064223291", volume = 2}},
        [4] = {{id = "13064223483", volume = 2}},
        [5] = {
            {id = "13064442279", volume = 2},
            {id = "12244488581", volume = 2},
            {id = "17173355584", volume = 0.5},
            {id = "17173354974", volume = 0.5}
        }
    }
    
    local function setupM1Sounds()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        HeartbeatConnections[26] = character:GetAttributeChangedSignal("LastM1Hitted"):Connect(function()
            local comboValue = tonumber(character:GetAttribute("Combo"))
            if soundData[comboValue] then
                for _, soundInfo in ipairs(soundData[comboValue]) do
                    PlaySound(soundInfo.id, soundInfo.volume)
                    task.wait(0.05)
                end
            end
        end)
    end
    
    local function setupParticles()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        
        HeartbeatConnections[36] = character:GetAttributeChangedSignal("LastM1Hitted"):Connect(function()
            local attributeValue = character:GetAttribute("LastM1Hitted")
            if not attributeValue then return end
            
            local targetName = attributeValue:match("([^;]+)")
            local targetModel = nil
            
            if Players:FindFirstChild(targetName) and Players[targetName].Character then
                targetModel = Players[targetName].Character
            elseif workspace:FindFirstChild("Live") and workspace.Live:FindFirstChild(targetName) then
                targetModel = workspace.Live:FindFirstChild(targetName)
            else
                for _, desc in ipairs(workspace:GetDescendants()) do
                    if desc:IsA("Model") and desc.Name == targetName and desc:FindFirstChild("Humanoid") then
                        targetModel = desc
                        break
                    end
                end
            end
            
            if targetModel then
                local targetRoot = targetModel:FindFirstChild("HumanoidRootPart") or targetModel:FindFirstChild("Torso")
                
                if targetRoot then
                    local attachTarget = Instance.new("Attachment", targetRoot)
                    
                    local e2 = Instance.new("ParticleEmitter", attachTarget)
                    e2.Name = "Dusty Impact"
                    e2.Texture = "rbxassetid://10198439352"
                    e2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0.45490196347236633,0.572549045085907,1)),ColorSequenceKeypoint.new(1,Color3.new(0.45490196347236633,0.572549045085907,1))})
                    e2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,2.5990726947784424,0),NumberSequenceKeypoint.new(1,2.5990726947784424,0)})
                    e2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
                    e2.ZOffset = 2
                    e2.EmissionDirection = Enum.NormalId.Top
                    e2.Lifetime = NumberRange.new(0.1, 0.1)
                    e2.Rate = 10
                    e2.Speed = NumberRange.new(0.025990726426243782, 0.025990726426243782)
                    e2.Rotation = NumberRange.new(-360, 360)
                    e2.RotSpeed = NumberRange.new(0, 0)
                    e2.SpreadAngle = Vector2.new(-360, 360)
                    e2.Acceleration = Vector3.new(0, 0, 0)
                    e2.Drag = 0
                    e2.LockedToPart = true
                    e2.LightEmission = -1
                    e2.LightInfluence = 0
                    e2.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    e2.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
                    e2.Shape = Enum.ParticleEmitterShape.Box
                    e2.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
                    e2.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
                    e2.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                    e2.FlipbookFramerate = NumberRange.new(1, 1)
                    e2.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                    e2.TimeScale = 1
                    e2.Brightness = 5
                    
                    e2:Emit(50)

                    local leftLimb = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm")
                    local rightLimb = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
                    local handAttachments = {}

                    if leftLimb then
                        local attLeft = Instance.new("Attachment", leftLimb)
                        attLeft.CFrame = leftLimb.Name:match("Arm") and CFrame.new(0, -1, 0) or CFrame.new(0, -0.4, 0)
                        table.insert(handAttachments, attLeft)
                    end
                    
                    if rightLimb then
                        local attRight = Instance.new("Attachment", rightLimb)
                        attRight.CFrame = rightLimb.Name:match("Arm") and CFrame.new(0, -1, 0) or CFrame.new(0, -0.4, 0)
                        table.insert(handAttachments, attRight)
                    end

                    for _, att in ipairs(handAttachments) do
                        local e1 = Instance.new("ParticleEmitter", att)
                        e1.Name = "Circular Smack"
                        e1.Texture = "rbxassetid://18140248952"
                        e1.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0.45490196347236633,0.572549045085907,1)),ColorSequenceKeypoint.new(1,Color3.new(0.45490196347236633,0.572549045085907,1))})
                        e1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,1.2,0),NumberSequenceKeypoint.new(1,1.2,0)})
                        e1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
                        e1.ZOffset = 2
                        e1.EmissionDirection = Enum.NormalId.Top
                        e1.Lifetime = NumberRange.new(0.1, 0.2)
                        e1.Rate = 10
                        e1.Speed = NumberRange.new(0.025990726426243782, 0.025990726426243782)
                        e1.Rotation = NumberRange.new(-360, 360)
                        e1.RotSpeed = NumberRange.new(0, 0)
                        e1.SpreadAngle = Vector2.new(-360, 360)
                        e1.Acceleration = Vector3.new(0, 0, 0)
                        e1.Drag = 0
                        e1.LockedToPart = true
                        e1.LightEmission = -1
                        e1.LightInfluence = 0
                        e1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                        e1.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
                        e1.Shape = Enum.ParticleEmitterShape.Box
                        e1.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
                        e1.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
                        e1.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                        e1.FlipbookFramerate = NumberRange.new(1, 1)
                        e1.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                        e1.TimeScale = 1
                        e1.Brightness = 5

                        local e3 = Instance.new("ParticleEmitter", att)
                        e3.Name = "Shockreal"
                        e3.Texture = "rbxassetid://124692159307028"
                        e3.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0.2235294133424759,0.3019607961177826,1)),ColorSequenceKeypoint.new(1,Color3.new(0.2235294133424759,0.3019607961177826,1))})
                        e3.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.1,0),NumberSequenceKeypoint.new(0.106,1.08,0.2),NumberSequenceKeypoint.new(1,1.85,0)})
                        e3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.06491885334253311,0,0),NumberSequenceKeypoint.new(0.42990654706954956,0.06989246606826782,0),NumberSequenceKeypoint.new(0.662513017654419,0.11827957630157471,0),NumberSequenceKeypoint.new(0.829698920249939,0.17741936445236206,0),NumberSequenceKeypoint.new(1,1,0)})
                        e3.ZOffset = 2
                        e3.EmissionDirection = Enum.NormalId.Front
                        e3.Lifetime = NumberRange.new(0.24400000274181366,0.27399998903274536)
                        e3.Rate = 7.2900004386901855
                        e3.Speed = NumberRange.new(0.00020094422507099807,0.00020094422507099807)
                        e3.Rotation = NumberRange.new(-360,360)
                        e3.RotSpeed = NumberRange.new(-145.8000030517578,145.8000030517578)
                        e3.SpreadAngle = Vector2.new(40,40)
                        e3.Acceleration = Vector3.new(0,0,0)
                        e3.Drag = 0.7289999723434448
                        e3.LockedToPart = true
                        e3.LightEmission = -1
                        e3.LightInfluence = 0
                        e3.Orientation = Enum.ParticleOrientation.FacingCamera
                        e3.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
                        e3.Shape = Enum.ParticleEmitterShape.Box
                        e3.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
                        e3.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
                        e3.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                        e3.FlipbookFramerate = NumberRange.new(0.7289999723434448,0.7289999723434448)
                        e3.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                        e3.TimeScale = 1
                        e3.Brightness = 15

                        e1:Emit(50)
                        e3:Emit(50)
                    end

                    task.delay(1, function()
                        if attachTarget then attachTarget:Destroy() end
                        for _, att in ipairs(handAttachments) do
                            if att then att:Destroy() end
                        end
                    end)
                end
            end
        end)
    end
    
    setupM1Sounds()
    CharacterAddedConnections[26] = LocalPlayer.CharacterAdded:Connect(setupM1Sounds)
    
    setupParticles()
    CharacterAddedConnections[36] = LocalPlayer.CharacterAdded:Connect(setupParticles)
end
