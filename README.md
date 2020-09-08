# RbxCookbook

Feel free to submit a pull request with your own contributions!

### Snippets

 - [AngleBetween.lua](#anglebetween)
 - [GammaColorTransition.lua](#gammacolortransition)
 - [LinearInterpolation.lua](#linearinterpolation)
 - [Map.lua](#map)
 - [ModelCFramer.lua](#modelcframer)
 - [RoundNumbers.lua](#roundnumbers)

### AngleBetween
[`AngleBetween.lua`](src/AngleBetween.lua)

```lua
-- Find angle between two vectors:

local function AngleBetween(vectorA, vectorB)
	return math.acos(math.clamp(vectorA.Unit:Dot(vectorB.Unit), -1, 1))
end
```

----------


### GammaColorTransition
[`GammaColorTransition.lua`](src/GammaColorTransition.lua)

```lua
-- Allows for linear interpolation between two colors using a specified Gamma value.

-- Utility function to apply a power to Color3
function PowColor3(Color, Pow)
    return Color3.new(math.pow(Color.r, Pow), math.pow(Color.g, Pow), math.pow(Color.b, Pow))
end

-- Interpolate between 'ColorA' and 'ColorB' by 'Frac' percentage with an optional 'Gamma' value. 
-- Typical gamma values range from 1.8 to 2.2. The default value is 2.0.
function LerpColor(ColorA, ColorB, Frac, Gamma)
    local Gamma = Gamma or 2.0
    
    local CA = PowColor3(ColorA, Gamma)
    local CB = PowColor3(ColorB, Gamma)
    return PowColor3(CA:lerp(CB, Frac), 1/Gamma)
end

```

----------


### LinearInterpolation
[`LinearInterpolation.lua`](src/LinearInterpolation.lua)

```lua
-- Linear Interpolation (AKA Lerp)
-- Interpolate between 'a' and 'b' by 'x' percentage

local function Lerp(a, b, x)
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

-- ExampleSetterFunction = ModelCFramer(workspace.Model)
-- ExampleSetterFunction(CFrame.new(0, 5, 0))


local function ModelCFramer(model)
	local primary = model.PrimaryPart
	local primaryCf = primary.CFrame
	local cache = {}
	for _,child in ipairs(model:GetDescendants()) do
		if (child:IsA("BasePart") and child ~= primary) then
			cache[child] = primaryCf:ToObjectSpace(child.CFrame)
		end
	end
	return function(desiredCf)
		primary.CFrame = desiredCf
		for part,offset in pairs(cache) do
			part.CFrame = desiredCf * offset
		end
	end
end

```

----------


### RoundNumbers
[`RoundNumbers.lua`](src/RoundNumbers.lua)

```lua
-- Round 'x' to the nearest 'mult'

local function Round(x, mult)
	return math.round(x / mult) * mult
end
```
