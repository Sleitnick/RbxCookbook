-- Linear Interpolation (AKA Lerp)
-- Interpolate between 'a' and 'b' by 'x' percentage

local function Lerp(a, b, x)
	return a + ((b - a) * x)
end