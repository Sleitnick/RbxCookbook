# RbxCookbook

Feel free to submit a pull request with your own contributions!

### Snippets

 - [AngleBetween.lua](#anglebetween)
 - [GammaColorTransition.lua](#gammacolortransition)
 - [LinearInterpolation.lua](#linearinterpolation)
 - [Map.lua](#map)
 - [ModelCFramer.lua](#modelcframer)
 - [Reflection.lua](#reflection)
 - [RoundNumbers.lua](#roundnumbers)

### AngleBetween
[`AngleBetween.lua`](src/AngleBetween.lua)

```lua
-- Find angle between two vectors:

local function AngleBetween(vectorA: Vector3, vectorB: Vector3): number
	return math.atan2(vectorA:Cross(vectorB).Magnitude, vectorA:Dot(vectorB))
end
```

----------


### GammaColorTransition
[`GammaColorTransition.lua`](src/GammaColorTransition.lua)

```lua
-- Allows for linear interpolation between two colors using a specified Gamma value.

-- Utility function to apply a power to Color3
local function PowColor3(color: Color3, pow: number): Color3
    return Color3.new(math.pow(color.R, pow), math.pow(color.G, pow), math.pow(color.B, pow))
end

-- Interpolate between 'ColorA' and 'ColorB' by 'Frac' percentage with an optional 'Gamma' value. 
-- Typical gamma values range from 1.8 to 2.2. The default value is 2.0.
local function LerpColor(colorA: Color3, colorB: Color3, frac: number, gamma: number): Color3
    gamma = gamma or 2.0
    local ca = PowColor3(colorA, gamma)
    local cb = PowColor3(colorB, gamma)
    return PowColor3(ca:Lerp(cb, frac), 1 / gamma)
end
```

----------


### LinearInterpolation
[`LinearInterpolation.lua`](src/LinearInterpolation.lua)

```lua
-- Linear Interpolation (AKA Lerp)
-- Interpolate between 'a' and 'b' by 'x' percentage

local function Lerp(a: number, b: number, x: number)
	return a + ((b - a) * x)
end
```

----------


### Map
[`Map.lua`](src/Map.lua)

```lua
-- Remap 'n' from the old range (oldMin, oldMax) to the new range (min, max)

local function Map(n: number, oldMin: number, oldMax: number, min: number, max: number): number
	return (min + ((max - min) * ((n - oldMin) / (oldMax - oldMin))))
end
```

----------


### ModelCFramer
[`ModelCFramer.lua`](src/ModelCFramer.lua)

```lua
-- SetPrimaryPartCFrame but avoids float errors via caching

-- ExampleSetterFunction = ModelCFramer(workspace.Model)
-- ExampleSetterFunction(CFrame.new(0, 5, 0))


local function ModelCFramer(model: Model): (cframe: CFrame) -> nil
	local primary = model.PrimaryPart
	local primaryCf = primary.CFrame
	local cache = {}
	for _,child in ipairs(model:GetDescendants()) do
		if (child:IsA("BasePart") and child ~= primary) then
			cache[child] = primaryCf:ToObjectSpace(child.CFrame)
		end
	end
	return function(desiredCf: CFrame)
		primary.CFrame = desiredCf
		for part,offset in pairs(cache) do
			part.CFrame = desiredCf * offset
		end
	end
end
```

----------


### Reflection
[`Reflection.lua`](src/Reflection.lua)

```lua
-- Finding the reflection vector for an incident vector
-- Arguments made for raycast [Origin, RaycastResult.Position, RaycastResult.Normal]

local function Reflection(origin : Vector3,hitpos : Vector3,normal : Vector3)
    return ((hitpos - origin) - 2*((hitpos - origin):Dot(normal) * normal))
end
```

----------


### RoundNumbers
[`RoundNumbers.lua`](src/RoundNumbers.lua)

```lua
-- Round 'x' to the nearest 'mult'

local function Round(x: number, mult: number): number
	return math.round(x / mult) * mult
end
```
