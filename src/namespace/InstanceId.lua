-- Compiled with roblox-ts v2.2.0
local TS = _G[script]
local INSTANCE_ID_TAG = TS.import(script, script.Parent.Parent, "util", "constants").INSTANCE_ID_TAG
local InstanceId = {}
do
	local _container = InstanceId
	local next_instance_id = 0
	local function reset()
		next_instance_id = 0
	end
	_container.reset = reset
	local function mark_instance(model)
		model:SetAttribute(INSTANCE_ID_TAG, next_instance_id)
		local _exp = model:GetDescendants()
		local _arg0 = function(element)
			next_instance_id += 1
			element:SetAttribute(INSTANCE_ID_TAG, next_instance_id)
		end
		for _k, _v in _exp do
			_arg0(_v, _k - 1, _exp)
		end
	end
	_container.mark_instance = mark_instance
	local function advance()
		next_instance_id += 1
	end
	_container.advance = advance
	local function get_next()
		return next_instance_id
	end
	_container.get_next = get_next
end
return {
	InstanceId = InstanceId,
}
