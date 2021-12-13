-- Find angle between two vectors:

local function AngleBetween(vectorA: Vector3, vectorB: Vector3): number
	return math.atan2(vectorA:Cross(vectorB).Magnitude, vectorA:Dot(vectorB))
end
