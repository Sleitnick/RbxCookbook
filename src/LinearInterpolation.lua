-- Linear Interpolation (AKA Lerp)
-- Interpolate between 'a' and 'b' by 'x' percentage

local function Lerp(a: number, b: number, x: number)
	return a + ((b - a) * x)
end
