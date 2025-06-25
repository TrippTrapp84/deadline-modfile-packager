-- Compiled with roblox-ts v2.2.0
local TS = _G[script]
local INSTANCE_ID_TAG = TS.import(script, script.Parent.Parent.Parent, "util", "constants").INSTANCE_ID_TAG
local _instance_map = TS.import(script, script.Parent.Parent, "instance_map")
local INSTANCE_CLASS_MAP = _instance_map.INSTANCE_CLASS_MAP
local INSTANCE_PROPERTY_MAP = _instance_map.INSTANCE_PROPERTY_MAP
local _decode_property = TS.import(script, script.Parent.Parent, "property", "decode_property")
local decode_instance_property = _decode_property.decode_instance_property
local write_instance_property = _decode_property.write_instance_property
local InstanceReferenceSerialization = TS.import(script, script.Parent.Parent.Parent, "namespace", "InstanceReferenceSerialization").InstanceReferenceSerialization
local wait_on_cooldown = TS.import(script, script.Parent.Parent.Parent, "util", "cooldown").wait_on_cooldown
local function find_in_map(map, value)
	for index, map_value in map do
		if map_value == value then
			return index
		end
	end
	return nil
end
local function add_instance(data_to_write, declaration)
	wait_on_cooldown()
	local property_map = {}
	local instance = declaration.instance
	local class_name = instance.ClassName
	local _object = {
		Name = "string",
	}
	local _spread = INSTANCE_PROPERTY_MAP[class_name]
	if type(_spread) == "table" then
		for _k, _v in _spread do
			_object[_k] = _v
		end
	end
	local properties_to_write = _object
	if not properties_to_write then
		error("can't serialize: unsupported instance type: " .. instance.ClassName)
	end
	local default_instance = Instance.new(class_name)
	-- optimize: only write properties that are different from the default instance
	for ___index in pairs(properties_to_write) do
		local index = ___index
		local value_to_save = instance[index]
		if value_to_save == default_instance[index] then
			continue
		end
		local existing_cached_value = find_in_map(data_to_write.saved_property_values, value_to_save)
		if existing_cached_value ~= nil then
			property_map[index] = existing_cached_value
		else
			-- ▼ ReadonlyMap.size ▼
			local _size = 0
			for _ in data_to_write.saved_property_values do
				_size += 1
			end
			-- ▲ ReadonlyMap.size ▲
			local new_cached_index = _size
			local _saved_property_values = data_to_write.saved_property_values
			local _new_cached_index = new_cached_index
			_saved_property_values[_new_cached_index] = value_to_save
			local _new_cached_index_1 = new_cached_index
			property_map[index] = _new_cached_index_1
		end
	end
	default_instance:Destroy()
	local _instances = data_to_write.instances
	local _arg0 = {
		declaration = declaration,
		property_map = property_map,
	}
	table.insert(_instances, _arg0)
	for _, value in pairs(instance:GetChildren()) do
		add_instance(data_to_write, {
			position = {
				kind = "child",
				parent_id = declaration.position.instance_id,
				instance_id = value:GetAttribute(INSTANCE_ID_TAG),
			},
			instance = value,
		})
	end
end
local SerializeInstanceDeclaration = {
	name = "Instance",
	id = 4,
	write = function(start_declaration, buffer)
		-- optimization: write everything to a reference list to save space on duplicate data
		local data_to_write = {
			saved_property_values = {},
			instances = {},
		}
		add_instance(data_to_write, start_declaration)
		local _fn = buffer
		-- ▼ ReadonlyMap.size ▼
		local _size = 0
		for _ in data_to_write.saved_property_values do
			_size += 1
		end
		-- ▲ ReadonlyMap.size ▲
		_fn.writeUInt32(_size)
		do
			local i = 0
			local _shouldIncrement = false
			while true do
				if _shouldIncrement then
					i += 1
				else
					_shouldIncrement = true
				end
				local _exp = i
				-- ▼ ReadonlyMap.size ▼
				local _size_1 = 0
				for _ in data_to_write.saved_property_values do
					_size_1 += 1
				end
				-- ▲ ReadonlyMap.size ▲
				if not (_exp < _size_1) then
					break
				end
				local _exp_1 = buffer
				local _saved_property_values = data_to_write.saved_property_values
				local _i = i
				write_instance_property(_exp_1, _saved_property_values[_i])
			end
		end
		buffer.writeUInt32(#data_to_write.instances)
		for _, _binding in pairs(data_to_write.instances) do
			local declaration = _binding.declaration
			local property_map = _binding.property_map
			local _binding_1 = declaration
			local instance = _binding_1.instance
			local position = _binding_1.position
			-- write id
			buffer.writeBits(if position.kind == "attachment_root" then 1 else 0)
			buffer.writeUInt16(position.parent_id)
			buffer.writeUInt16(position.instance_id)
			-- optimization: index to the class instead of the class itself
			local _arg0 = function(value)
				return value == instance.ClassName
			end
			-- ▼ ReadonlyArray.findIndex ▼
			local _result = -1
			for _i, _v in INSTANCE_CLASS_MAP do
				if _arg0(_v, _i - 1, INSTANCE_CLASS_MAP) == true then
					_result = _i - 1
					break
				end
			end
			-- ▲ ReadonlyArray.findIndex ▲
			local class_uint8 = _result
			if class_uint8 == -1 then
				error("can't serialize: unsupported instance type: " .. instance.ClassName)
			end
			buffer.writeUInt8(class_uint8)
			-- write attributes
			local attributes = instance:GetAttributes()
			local attribute_count = 0
			for key in attributes do
				if key == INSTANCE_ID_TAG then
					continue
				end
				attribute_count += 1
			end
			-- cba to support anything other than string
			buffer.writeUnsigned(5, attribute_count)
			for key, value in attributes do
				if key == INSTANCE_ID_TAG then
					continue
				end
				buffer.writeString(key)
				write_instance_property(buffer, value)
			end
			-- write tags
			local tags = instance:GetTags()
			buffer.writeUnsigned(5, #tags)
			for _, tag in tags do
				buffer.writeString(tag)
			end
			local _fn_1 = buffer
			-- ▼ ReadonlyMap.size ▼
			local _size_1 = 0
			for _ in property_map do
				_size_1 += 1
			end
			-- ▲ ReadonlyMap.size ▲
			_fn_1.writeUnsigned(5, _size_1)
			for key, value in pairs(property_map) do
				buffer.writeString(key)
				buffer.writeUInt16(value)
			end
		end
	end,
	decode = function(modfile, buffer)
		local data_to_read = {
			saved_property_values = {},
			instances = {},
		}
		local saved_size = buffer.readUInt32()
		do
			local i = 0
			local _shouldIncrement = false
			while true do
				if _shouldIncrement then
					i += 1
				else
					_shouldIncrement = true
				end
				if not (i < saved_size) then
					break
				end
				wait_on_cooldown()
				local value = decode_instance_property(buffer)
				local _saved_property_values = data_to_read.saved_property_values
				local _i = i
				local _value = value
				_saved_property_values[_i] = _value
			end
		end
		local size = buffer.readUInt32()
		do
			local i = 0
			local _shouldIncrement = false
			while true do
				if _shouldIncrement then
					i += 1
				else
					_shouldIncrement = true
				end
				if not (i < size) then
					break
				end
				wait_on_cooldown()
				-- read id
				local _binding = buffer.readBits(1)
				local parent_type = _binding[1]
				local parent_id = buffer.readUInt16()
				local instance_id = buffer.readUInt16()
				-- read class
				local class_name_index = buffer.readUInt8()
				local class_name = INSTANCE_CLASS_MAP[class_name_index + 1]
				-- read attributes
				local attribute_count = buffer.readUnsigned(5)
				local attributes = {}
				do
					local i = 0
					local _shouldIncrement_1 = false
					while true do
						if _shouldIncrement_1 then
							i += 1
						else
							_shouldIncrement_1 = true
						end
						if not (i < attribute_count) then
							break
						end
						local key = buffer.readString()
						local value = decode_instance_property(buffer)
						attributes[key] = value
					end
				end
				-- read tags
				local tags = {}
				local tag_count = buffer.readUnsigned(5)
				do
					local i = 0
					local _shouldIncrement_1 = false
					while true do
						if _shouldIncrement_1 then
							i += 1
						else
							_shouldIncrement_1 = true
						end
						if not (i < tag_count) then
							break
						end
						local _tags = tags
						local _arg0 = buffer.readString()
						table.insert(_tags, _arg0)
					end
				end
				-- read properties
				local property_map = {}
				local property_count = buffer.readUnsigned(5)
				do
					local i = 0
					local _shouldIncrement_1 = false
					while true do
						if _shouldIncrement_1 then
							i += 1
						else
							_shouldIncrement_1 = true
						end
						if not (i < property_count) then
							break
						end
						local key = buffer.readString()
						local value = buffer.readUInt16()
						local _property_map = property_map
						local _key = key
						local _value = value
						_property_map[_key] = _value
					end
				end
				local instance = Instance.new(class_name)
				for key, value in pairs(attributes) do
					instance:SetAttribute(key, value)
				end
				for _, value in pairs(tags) do
					instance:AddTag(value)
				end
				for index, value in pairs(property_map) do
					local saved_value = data_to_read.saved_property_values[value]
					local _saved_value = saved_value
					local _condition = type(_saved_value) == "table"
					if _condition then
						_condition = (saved_value.__IS_INSTANCE) ~= nil
					end
					if _condition then
						InstanceReferenceSerialization.schedule_instance_set(instance, index, saved_value.__IS_INSTANCE)
					else
						instance[index] = saved_value
					end
				end
				InstanceReferenceSerialization.add_instance_to_cache(instance, instance_id)
				local position = {
					instance_id = instance_id,
					parent_id = parent_id,
					kind = if parent_type ~= 0 and (parent_type == parent_type and parent_type) then "attachment_root" else "child",
				}
				instance:SetAttribute("__kind", position.parent_id)
				instance:SetAttribute("__instance_id", position.instance_id)
				instance:SetAttribute("__parent_id", position.parent_id)
				local _instance_declarations = modfile.instance_declarations
				local _arg0 = {
					instance = instance,
					position = position,
				}
				table.insert(_instance_declarations, _arg0)
			end
		end
	end,
}
return {
	SerializeInstanceDeclaration = SerializeInstanceDeclaration,
}
