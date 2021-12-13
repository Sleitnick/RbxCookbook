-- Round 'x' to the nearest 'mult'

local function Round(x: number, mult: number): number
	return math.round(x / mult) * mult
end
