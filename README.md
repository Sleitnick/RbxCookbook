# RbxCookbook

### CylinderTerrain.lua

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


function DrawCylinder(radius, depth, material)

	assert(radius % RESOLUTION == 0, "Radius must be positive and divisible by " .. RESOLUTION)
	assert(radius >= RESOLUTION, "Radius must be greater or equal to " .. RESOLUTION)
	assert(depth % RESOLUTION == 0, "Depth must be positive and divisible by " .. RESOLUTION)
	assert(depth >= RESOLUTION, "Depth must be greater or equal to " .. RESOLUTION)

	assert(typeof(material) == "EnumItem" and material.EnumType == Enum.Material, "Material must be a Material enum value")

	local AIR = Enum.Material.Air
	local SQRT = math.sqrt

	local region = Region3.new(
		Vector3.new(-radius + 1, 0, -radius + 1),
		Vector3.new(radius, depth, radius)
	):ExpandToGrid(RESOLUTION)

	local size = Vector3.new(radius * 2, depth, radius * 2) / RESOLUTION
	local sx, sy, sz = size.X, size.Y, size.Z

	local materials = Create3DTable(size, AIR)
	local occupancy = Create3DTable(size, 1)

	for x = 1,sx do
		local posX = (-sx * 0.5) + x
		for z = 1,sz do
			local posZ = (-sz * 0.5) + z
			local rad = SQRT((posX * posX) + (posZ * posZ)) * RESOLUTION
			local mat = (rad > radius and AIR or material)
			for y = 1,sy do
				materials[x][y][z] = mat
			end
		end
	end

	workspace.Terrain:WriteVoxels(region, RESOLUTION, materials, occupancy)

	game:GetService("ChangeHistoryService"):SetWaypoint("CylinderTerrain")

end



-- EXAMPLE:
workspace.Terrain:Clear()
DrawCylinder(32, 20, Enum.Material.Water)
```

----------


### LinearInterpolation.lua

```lua
-- Linear Interpolation (AKA Lerp)
-- Interpolate between 'a' and 'b' by 'x' percentage

function Lerp(a, b, x)
	return a + ((b - a) * x)
end
```

----------


### RoundNumbers.lua

```lua
-- Round 'x' to the nearest 'mult'

function Round(x, mult)
	math.floor((x / mult) + 0.5) * mult
end
```
