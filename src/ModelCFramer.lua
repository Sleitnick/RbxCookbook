-- SetPrimaryPartCFrame but avoids float errors via caching

-- ExampleSetterFunction = ModelCFramer(workspace:WaitForChild("Model"))
-- ExampleSetterFunction(CFrame.new(0, 5, 0))


local function ModelCFramer(Model)
	local Primary = Model.PrimaryPart or error("Model has no PrimaryPart")
	local PrimaryCF = Primary.CFrame
	local Cache = {}
	for _, Desc in next, Model:GetDescendants() do
		if Desc ~= Primary and Desc:IsA("BasePart") then
			Cache[Desc] = PrimaryCF:toObjectSpace(Desc.CFrame)
		end
	end
	return function(DesiredCFrame)
		Primary.CFrame = DesiredCFrame
		for Part, Offset in next, Cache do
			Part.CFrame = DesiredCFrame * Offset
		end
	end
end
