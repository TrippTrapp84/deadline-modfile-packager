-- Compiled with roblox-ts v2.2.0
local scheduled_instance_property_changes = {}
local instance_map = {}
local InstanceReferenceSerialization = {}
do
	local _container = InstanceReferenceSerialization
	local reset_instance_cache = function()
		table.clear(scheduled_instance_property_changes)
		table.clear(instance_map)
	end
	_container.reset_instance_cache = reset_instance_cache
	local add_instance_to_cache = function(instance, id)
		local _id = id
		local _instance = instance
		instance_map[_id] = _instance
		return instance_map
	end
	_container.add_instance_to_cache = add_instance_to_cache
	local schedule_instance_set = function(instance, index, id)
		local _arg0 = {
			id = id,
			index = index,
			instance = instance,
		}
		table.insert(scheduled_instance_property_changes, _arg0)
	end
	_container.schedule_instance_set = schedule_instance_set
	local set_instance_ids = function()
		for _, value in pairs(scheduled_instance_property_changes) do
			local _id = value.id
			local target_instance = instance_map[_id]
			if not target_instance then
				error("failed to set instance." .. (value.index .. (" to instance id " .. tostring(value.id))))
			end
			(value.instance)[value.index] = target_instance
		end
	end
	_container.set_instance_ids = set_instance_ids
end
return {
	InstanceReferenceSerialization = InstanceReferenceSerialization,
}
