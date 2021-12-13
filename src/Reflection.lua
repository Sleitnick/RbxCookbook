-- Finding the reflection vector for an incident vector
-- Arguments made for raycast [Origin, RaycastResult.Position, RaycastResult.Normal]

local function Reflection(origin : Vector3,hitpos : Vector3,normal : Vector3)
    return ((hitpos - origin) - 2*((hitpos - origin):Dot(normal) * normal))
end