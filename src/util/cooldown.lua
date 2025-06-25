-- Compiled with roblox-ts v2.2.0
local RunService = game:GetService("RunService")
local next_yield_time = tick() + 1
local function wait_on_cooldown()
	if tick() > next_yield_time then
		-- large mods cause timeout
		next_yield_time = tick() + 1
		RunService.Heartbeat:Wait()
	end
end
return {
	wait_on_cooldown = wait_on_cooldown,
}
