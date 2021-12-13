-- Remap 'n' from the old range (oldMin, oldMax) to the new range (min, max)

local function Map(n: number, oldMin: number, oldMax: number, min: number, max: number): number
	return (min + ((max - min) * ((n - oldMin) / (oldMax - oldMin))))
end
