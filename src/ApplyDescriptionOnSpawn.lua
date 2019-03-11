-- Dawgra, 2019
-- This method doesn't cause an error when spawning a character and applying a description.

local players = game:GetService("Players")
local descriptionExample = players:GetHumanoidDescriptionFromUserId(261) -- Shedletsky

local function ApplyDescOnSpawn(character)
	if not character.Parent then
		character.AncestryChanged:Wait()
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid and humanoid.Health > 0 then
		humanoid:ApplyDescription(descriptionExample)
	end
end

local function PlayerAdded(player)
	player.CharacterAdded:Connect(ApplyDescOnSpawn)
	if player.Character then ApplyDescOnSpawn(player.Character) end
end

players.PlayerAdded:Connect(PlayerAdded)
