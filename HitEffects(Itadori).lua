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
                    local comboValue = tonumber(character:GetAttribute("Combo")) or 2
                    local attachTarget = Instance.new("Attachment", targetRoot)
                    local toClean = {attachTarget}

                    if comboValue == 5 then
                        local l1 = Instance.new("ParticleEmitter", attachTarget)
                        l1.Name = "Lightning"
                        l1.Texture = "rbxassetid://16836633376"
                        l1.Color = ColorSequence.new(Color3.new(1,0,0))
                        l1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(0.056,5.437,4.188),NumberSequenceKeypoint.new(0.133,7.812,5.031),NumberSequenceKeypoint.new(0.362,9.125,4.639),NumberSequenceKeypoint.new(1,10,4.472)})
                        l1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(0.661,0,0),NumberSequenceKeypoint.new(1,1,0)})
                        l1.ZOffset = 2
                        l1.EmissionDirection = Enum.NormalId.Top
                        l1.Lifetime = NumberRange.new(0.7)
                        l1.Rate = 100
                        l1.Speed = NumberRange.new(0.001,10)
                        l1.Rotation = NumberRange.new(0,360)
                        l1.SpreadAngle = Vector2.new(360,360)
                        l1.Drag = 3
                        l1.LockedToPart = true
                        l1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                        l1.Shape = Enum.ParticleEmitterShape.Box
                        l1.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
                        l1.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
                        l1.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                        l1.FlipbookFramerate = NumberRange.new(20,40)
                        l1.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                        l1.Brightness = 5
                        l1.Enabled = false
                        l1:Emit(50)

                        local s1 = Instance.new("ParticleEmitter", attachTarget)
                        s1.Name = "Sparks2"
                        s1.Texture = "rbxassetid://17547405831"
                        s1.Color = ColorSequence.new(Color3.new(1,0,0))
                        s1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,2,1),NumberSequenceKeypoint.new(1,0,0)})
                        s1.EmissionDirection = Enum.NormalId.Front
                        s1.Lifetime = NumberRange.new(0.7)
                        s1.Rate = 400
                        s1.Speed = NumberRange.new(20,150)
                        s1.Rotation = NumberRange.new(0,360)
                        s1.RotSpeed = NumberRange.new(-300,300)
                        s1.SpreadAngle = Vector2.new(360,360)
                        s1.Acceleration = Vector3.new(0,5,0)
                        s1.Drag = 7
                        s1.Orientation = Enum.ParticleOrientation.VelocityParallel
                        s1.Shape = Enum.ParticleEmitterShape.Box
                        s1.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
                        s1.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
                        s1.Brightness = 15
                        s1.Enabled = false
                        s1:Emit(50)

                        local s2 = Instance.new("ParticleEmitter", attachTarget)
                        s2.Name = "Sparks"
                        s2.Texture = "rbxassetid://15407518755"
                        s2.Color = ColorSequence.new(Color3.new(1,0,0))
                        s2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,2,1),NumberSequenceKeypoint.new(1,0,0)})
                        s2.EmissionDirection = Enum.NormalId.Front
                        s2.Lifetime = NumberRange.new(0.7)
                        s2.Rate = 100
                        s2.Speed = NumberRange.new(80,150)
                        s2.Rotation = NumberRange.new(90,90)
                        s2.SpreadAngle = Vector2.new(360,360)
                        s2.Drag = 10
                        s2.Orientation = Enum.ParticleOrientation.VelocityParallel
                        s2.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(0.3,3,0),NumberSequenceKeypoint.new(1,0,0)})
                        s2.Shape = Enum.ParticleEmitterShape.Box
                        s2.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
                        s2.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
                        s2.FlipbookMode = Enum.ParticleFlipbookMode.Loop
                        s2.Brightness = 15
                        s2.Enabled = false
                        s2:Emit(50)

                        local w1 = Instance.new("ParticleEmitter", attachTarget)
                        w1.Name = "Wind2"
                        w1.Texture = "rbxassetid://1053548563"
                        w1.Color = ColorSequence.new(Color3.new(1,0,0))
                        w1.Size = NumberSequence.new(80)
                        w1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,1,0)})
                        w1.EmissionDirection = Enum.NormalId.Top
                        w1.Lifetime = NumberRange.new(0.7)
                        w1.Rate = 100
                        w1.Speed = NumberRange.new(0.01)
                        w1.Rotation = NumberRange.new(-360,360)
                        w1.SpreadAngle = Vector2.new(360,360)
                        w1.LightEmission = 1
                        w1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                        w1.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0,-3,0),NumberSequenceKeypoint.new(1,0,0)})
                        w1.Shape = Enum.ParticleEmitterShape.Box
                        w1.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
                        w1.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
                        w1.FlipbookMode = Enum.ParticleFlipbookMode.Loop
                        w1.Brightness = 3
                        w1.Enabled = false
                        w1:Emit(50)
                    end

                    local leftLimb = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm")
                    local rightLimb = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
                    local handAttachments = {}

                    if leftLimb then
                        local attLeft = Instance.new("Attachment", leftLimb)
                        attLeft.CFrame = leftLimb.Name:match("Arm") and CFrame.new(0, -1, 0) or CFrame.new(0, -0.6, 0)
                        table.insert(handAttachments, attLeft)
                        table.insert(toClean, attLeft)
                    end
                    
                    if rightLimb then
                        local attRight = Instance.new("Attachment", rightLimb)
                        attRight.CFrame = rightLimb.Name:match("Arm") and CFrame.new(0, -1, 0) or CFrame.new(0, -0.6, 0)
                        table.insert(handAttachments, attRight)
                        table.insert(toClean, attRight)
                    end

                    for _, att in ipairs(handAttachments) do
                        local e3 = Instance.new("ParticleEmitter", att)
                        e3.Name = "Shockreal"
                        e3.Texture = "rbxassetid://124692159307028"
                        e3.Color = ColorSequence.new(Color3.new(0.2235294133424759,0.3019607961177826,1))
                        e3.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.05,0),NumberSequenceKeypoint.new(0.106,0.54,0.1),NumberSequenceKeypoint.new(1,0.92,0)})
                        e3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.065,0,0),NumberSequenceKeypoint.new(0.430,0.070,0),NumberSequenceKeypoint.new(0.663,0.118,0),NumberSequenceKeypoint.new(0.830,0.177,0),NumberSequenceKeypoint.new(1,1,0)})
                        e3.ZOffset = 2
                        e3.EmissionDirection = Enum.NormalId.Front
                        e3.Lifetime = NumberRange.new(0.244,0.274)
                        e3.Rate = 7.29
                        e3.Speed = NumberRange.new(0.0002)
                        e3.Rotation = NumberRange.new(-360,360)
                        e3.RotSpeed = NumberRange.new(-145.8,145.8)
                        e3.SpreadAngle = Vector2.new(40,40)
                        e3.Drag = 0.729
                        e3.LockedToPart = true
                        e3.Orientation = Enum.ParticleOrientation.FacingCamera
                        e3.Shape = Enum.ParticleEmitterShape.Box
                        e3.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
                        e3.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
                        e3.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                        e3.FlipbookFramerate = NumberRange.new(0.729)
                        e3.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                        e3.Brightness = 15
                        
                        local eAura = Instance.new("ParticleEmitter", att)
                        eAura.Name = "Aura"
                        eAura.Texture = "rbxassetid://9285330517"
                        eAura.Color = ColorSequence.new(Color3.new(0.33725491166114807,0.7137255072593689,1))
                        eAura.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,2.4,0.4),NumberSequenceKeypoint.new(0.360,0.8,0.3),NumberSequenceKeypoint.new(0.706,0.6,0.2),NumberSequenceKeypoint.new(0.868,0.4,0.1),NumberSequenceKeypoint.new(1,0.25,0)})
                        eAura.ZOffset = 1
                        eAura.EmissionDirection = Enum.NormalId.Top
                        eAura.Lifetime = NumberRange.new(0.1,0.2)
                        eAura.Rate = 35
                        eAura.Speed = NumberRange.new(0, 5)
                        eAura.Rotation = NumberRange.new(-360,360)
                        eAura.Acceleration = Vector3.new(0, 2, 0)
                        eAura.LockedToPart = true
                        eAura.Orientation = Enum.ParticleOrientation.FacingCamera
                        eAura.Shape = Enum.ParticleEmitterShape.Box
                        eAura.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
                        eAura.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
                        eAura.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                        eAura.FlipbookFramerate = NumberRange.new(1)
                        eAura.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                        eAura.Brightness = 4

                        e3:Emit(50)
                        eAura:Emit(50)
                    end

                    task.delay(1.5, function()
                        for _, obj in ipairs(toClean) do
                            if obj and obj.Parent then
                                obj:Destroy()
                            end
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
