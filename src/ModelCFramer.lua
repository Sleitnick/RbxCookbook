-- SetPrimaryPartCFrame but avoids float errors via caching

-- ExampleSetterFunction = ModelCFramer(workspace.Model)
-- ExampleSetterFunction(CFrame.new(0, 5, 0))


local function ModelCFramer(model: Model): (cframe: CFrame) -> nil
	local primary = model.PrimaryPart
	local primaryCf = primary.CFrame
	local cache = {}
	for _,child in ipairs(model:GetDescendants()) do
		if (child:IsA("BasePart") and child ~= primary) then
			cache[child] = primaryCf:ToObjectSpace(child.CFrame)
		end
	end
	return function(desiredCf: CFrame)
		primary.CFrame = desiredCf
		for part,offset in pairs(cache) do
			part.CFrame = desiredCf * offset
		end
	end
end
