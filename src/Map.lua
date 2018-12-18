-- Remap 'n' from the old range (oldMin, oldMax) to the new range (min, max)

local function Map(n, oldMin, oldMax, min, max)
	return (min + ((max - min) * ((n - oldMin) / (oldMax - oldMin))))
end