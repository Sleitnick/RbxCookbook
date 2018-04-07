-- Linear Interpolation (AKA Lerp)
-- Interpolate between 'a' and 'b' by 'x' percentage

function Lerp(a, b, x)
	return a + ((b - a) * x)
end