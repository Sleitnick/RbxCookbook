# RbxCookbook

Feel free to submit a pull request with your own contributions!

### Snippets

 - [CreateSignal.lua](#createsignal)
 - [CylinderTerrain.lua](#cylinderterrain)
 - [LinearInterpolation.lua](#linearinterpolation)
 - [Map.lua](#map)
 - [ModelCFramer.lua](#modelcframer)
 - [RoundNumbers.lua](#roundnumbers)

### CreateSignal
[`CreateSignal.lua`](src/CreateSignal.lua)

```lua
-- Lightweight signal class that avoids the table-copying behavior of BindableEvents

local function CreateSignal()
	local Signal, Arguments = {}, {}
	local Bindable = Instance.new("BindableEvent")
	function Signal:Connect(Callback)
		return Bindable.Event:Connect(function()
			Callback(unpack(Arguments, 1, Arguments[0]))
		end)
	end
	function Signal:Wait()
		Bindable.Event:Wait()
		return unpack(Arguments, 1, Arguments[0])
	end
	function Signal:Fire(...)
		Arguments = {[0] = select("#", ...); ...}
		Bindable:Fire()
		Arguments = nil
	end
	function Signal:Destroy()
		Bindable:Destroy()
		Bindable = nil
		Arguments = nil
		Signal = nil
	end
	return Signal
end

```

----------


### CylinderTerrain
[`CylinderTerrain.lua`](src/CylinderTerrain.lua)

```lua
-- Make cylinder terrain

-- DrawCylinder(radius, depth, material)


local RESOLUTION = 4


function Create3DTable(size, defaultValue)
	local sx = size.X
	local sy = size.Y
	local sz = size.Z
	local t = {}
	for x = 1,sx do
		local tx = {}
		t[x] = tx
		for y = 1,sy do
			local ty = {}
			tx[y] = ty
			for z = 1,sz do
				ty[z] = defaultValue
			end
		end
	end
	return t
end


function DrawCylinder(radius, depth, depthOffset, material, overrideExisting)

	assert(radius % RESOLUTION == 0, "Radius must be positive and divisible by " .. RESOLUTION)
	assert(radius >= RESOLUTION, "Radius must be greater or equal to " .. RESOLUTION)
	assert(depth % RESOLUTION == 0, "Depth must be positive and divisible by " .. RESOLUTION)
	assert(depth >= RESOLUTION, "Depth must be greater or equal to " .. RESOLUTION)

	assert(typeof(material) == "EnumItem" and material.EnumType == Enum.Material, "Material must be a Material enum value")

	local AIR = Enum.Material.Air
	local SQRT = math.sqrt

	local region = Region3.new(
		Vector3.new(-radius + 1, depthOffset, -radius + 1),
		Vector3.new(radius, depth + depthOffset, radius)
	):ExpandToGrid(RESOLUTION)

	local size = Vector3.new(radius * 2, depth, radius * 2) / RESOLUTION
	local sx, sy, sz = size.X, size.Y, size.Z

	local materials = Create3DTable(size, AIR)
	local occupancy = Create3DTable(size, 1)

	local curMaterials, curOccupancy = workspace.Terrain:ReadVoxels(region, RESOLUTION)

	for x = 1,sx do
		local posX = (-sx * 0.5) + x
		for z = 1,sz do
			local posZ = (-sz * 0.5) + z
			local rad = SQRT((posX * posX) + (posZ * posZ)) * RESOLUTION
			local mat = (rad > radius and AIR or material)
			for y = 1,sy do
				materials[x][y][z] = mat
				if (not overrideExisting and rad > radius) then
					materials[x][y][z] = curMaterials[x][y][z]
					occupancy[x][y][z] = curOccupancy[x][y][z]
				end
			end
		end
	end

	workspace.Terrain:WriteVoxels(region, RESOLUTION, materials, occupancy)

	game:GetService("ChangeHistoryService"):SetWaypoint("CylinderTerrain")

end



-- EXAMPLE:
-- Clear
workspace.Terrain:Clear()

-- Water and bedrock:
DrawCylinder(2048, 4, 0, Enum.Material.Rock, true)
for i = 0,20,8 do
	DrawCylinder(2048, 8, i + 4, Enum.Material.Water, i > 4)
end

-- Island
DrawCylinder(512, 16, 4, Enum.Material.Rock, false)
DrawCylinder(512, 8, 20, Enum.Material.Sand, false)
DrawCylinder(500, 8, 28, Enum.Material.Grass, false)
```

----------


### LinearInterpolation
[`LinearInterpolation.lua`](src/LinearInterpolation.lua)

```lua
-- Linear Interpolation (AKA Lerp)
-- Interpolate between 'a' and 'b' by 'x' percentage

function Lerp(a, b, x)
	return a + ((b - a) * x)
end
```

----------


### Map
[`Map.lua`](src/Map.lua)

```lua
-- Remap 'n' from the old range (oldMin, oldMax) to the new range (min, max)

local function Map(n, oldMin, oldMax, min, max)
	return (min + ((max - min) * ((n - oldMin) / (oldMax - oldMin))))
end
```

----------


### ModelCFramer
[`ModelCFramer.lua`](src/ModelCFramer.lua)

```lua
-- SetPrimaryPartCFrame but avoids float errors via caching

-- ExampleSetterFunction = ModelCFramer(workspace:WaitForChild("Model"))
-- ExampleSetterFunction(CFrame.new(0, 5, 0))


local function ModelCFramer(Model)
	local Primary = Model.PrimaryPart or error("Model has no PrimaryPart")
	local PrimaryCF = Primary.CFrame
	local Cache = {}
	for _, Desc in next, Model:GetDescendants() do
		if Desc ~= Primary and Desc:IsA("BasePart") then
			Cache[Desc] = PrimaryCF:toObjectSpace(Desc.CFrame)
		end
	end
	return function(DesiredCFrame)
		Primary.CFrame = DesiredCFrame
		for Part, Offset in next, Cache do
			Part.CFrame = DesiredCFrame * Offset
		end
	end
end

```

----------


### RoundNumbers
[`RoundNumbers.lua`](src/RoundNumbers.lua)

```lua
-- Round 'x' to the nearest 'mult'

function Round(x, mult)
	return math.floor((x / mult) + 0.5) * mult
end
```
