-- Compiled with roblox-ts v2.2.0
local function require_script_as(root, name)
	local module = root:FindFirstChild(name)
	if not module then
		error("Error while requiring " .. (name .. (" inside " .. (root:GetFullName() .. " (it doesn't exist)"))))
	end
	if not module:IsA("ModuleScript") then
		error("Error while requiring " .. (name .. (" inside " .. (root:GetFullName() .. " (it's not a modulescript)"))))
	end
	return require(module)
end
return {
	require_script_as = require_script_as,
}
