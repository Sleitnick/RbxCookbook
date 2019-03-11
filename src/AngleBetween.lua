-- Find angle between two vectors:

local function AngleBetween(vectorA, vectorB)
	return math.acos(math.clamp(vectorA.Unit:Dot(vectorB.Unit), -1, 1))
end