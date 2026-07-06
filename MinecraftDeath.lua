local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local function setupDeathEffect(character)
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")
	local isDead = false

	humanoid.Died:Connect(function()
		if isDead then return end
		isDead = true

		local deathPosition = rootPart.Position
		local lookVector = rootPart.CFrame.LookVector
		
		local flatLook = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
		local targetCFrame = CFrame.lookAt(deathPosition, deathPosition + flatLook)

		task.wait(0.9)

		for _, object in ipairs(character:GetDescendants()) do
			if object:IsA("BasePart") or object:IsA("Decal") then
				object.Transparency = 1
			elseif object:IsA("Accessory") or object:IsA("Shirt") or object:IsA("Pants") then
				object:Destroy()
			end
		end

		local p = Instance.new('Part')
		p.Anchored = true
		p.CanCollide = false
		p.Transparency = 1
		p.CFrame = targetCFrame * CFrame.new(0, 0, -5)
		p.Parent = workspace

		local a0 = Instance.new('Attachment', p)
		local e1 = Instance.new('ParticleEmitter', a0)
		
		e1.Name = 'Break'
		e1.Texture = 'rbxassetid://8733226116'
		e1.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),ColorSequenceKeypoint.new(1,Color3.new(1,1,1))})
		e1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,2,2),NumberSequenceKeypoint.new(1,2,2)})
		e1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.09354838728904724,0.25624996423721313,0),NumberSequenceKeypoint.new(0.4048387110233307,0.1875,0),NumberSequenceKeypoint.new(0.7048386931419373,0.4375,0),NumberSequenceKeypoint.new(1,1,0)})
		e1.ZOffset = 3
		e1.EmissionDirection = Enum.NormalId.Right
		e1.Lifetime = NumberRange.new(1,1.5)
		e1.Rate = 0
		e1.Enabled = false
		e1.Speed = NumberRange.new(0,10)
		e1.Rotation = NumberRange.new(0,0)
		e1.RotSpeed = NumberRange.new(0,0)
		e1.SpreadAngle = Vector2.new(360,360)
		e1.Acceleration = Vector3.new(0,-4,0)
		e1.Drag = 1
		e1.LockedToPart = false
		e1.LightEmission = 0
		e1.LightInfluence = 1
		e1.Orientation = Enum.ParticleOrientation.FacingCamera
		e1.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
		e1.Shape = Enum.ParticleEmitterShape.Box
		e1.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
		e1.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
		e1.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
		e1.FlipbookFramerate = NumberRange.new(50,300)
		e1.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
		e1.TimeScale = 1
		e1.Brightness = 20
		
		e1:Emit(20)

		task.wait(2)
		p:Destroy()
	end)
end

if Player.Character then
	setupDeathEffect(Player.Character)
end

Player.CharacterAdded:Connect(setupDeathEffect)
