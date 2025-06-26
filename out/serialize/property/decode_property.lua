-- Compiled with roblox-ts v2.2.0
local TS = _G[script]
local ENCODE_VALUE_IDS = TS.import(script, script.Parent, "decoding_properties").ENCODE_VALUE_IDS
local INSTANCE_ID_TAG = TS.import(script, script.Parent.Parent.Parent, "util", "constants").INSTANCE_ID_TAG
local write_cframe = TS.import(script, script.Parent, "util", "write_cframe").write_cframe
local string_is_encode_id = function(value)
	local _value = value
	local _condition = type(_value) == "string"
	if _condition then
		_condition = ENCODE_VALUE_IDS[value] ~= nil
	end
	return _condition
end
local ENCODING_FUNCTIONS = {
	string = { function(value)
		local _value = value
		return type(_value) == "string"
	end, function(buffer, value)
		return buffer.writeString(value)
	end, function(buffer)
		return buffer.readString()
	end },
	boolean = { function(value)
		local _value = value
		return type(_value) == "boolean"
	end, function(buffer, value)
		return buffer.writeBits(if value ~= 0 and (value == value and (value ~= "" and value)) then 1 else 0)
	end, function(buffer)
		return if buffer.readBits(1)[1] == 1 then true else false
	end },
	number = { function(value)
		local _value = value
		return type(_value) == "number"
	end, function(buffer, value)
		return buffer.writeFloat16(value)
	end, function(buffer)
		return buffer.readFloat16()
	end },
	CFrame = { function(value)
		local _value = value
		return typeof(_value) == "CFrame"
	end, function(buffer, value)
		write_cframe.write(buffer, value)
	end, function(buffer)
		return write_cframe.read(buffer)
	end },
	UDim2 = { function(value)
		local _value = value
		return typeof(_value) == "UDim2"
	end, function(buffer, value)
		return buffer.writeUDim2(value)
	end, function(buffer)
		return buffer.readUDim2()
	end },
	EnumItem = { function(value)
		local _value = value
		return typeof(_value) == "EnumItem"
	end, function(buffer, value)
		return buffer.writeEnum(value)
	end, function(buffer)
		return buffer.readEnum()
	end },
	Vector3 = { function(value)
		local _value = value
		return typeof(_value) == "Vector3"
	end, function(buffer, value)
		return buffer.writeVector3(value)
	end, function(buffer)
		return buffer.readVector3()
	end },
	Vector2 = { function(value)
		local _value = value
		return typeof(_value) == "Vector2"
	end, function(buffer, value)
		return buffer.writeVector2(value)
	end, function(buffer)
		return buffer.readVector2()
	end },
	Color3 = { function(value)
		local _value = value
		return typeof(_value) == "Color3"
	end, function(buffer, value)
		local color = value
		buffer.writeUInt8(math.round(color.R * 255))
		buffer.writeUInt8(math.round(color.G * 255))
		buffer.writeUInt8(math.round(color.B * 255))
	end, function(buffer)
		return Color3.new(buffer.readUInt8() / 255, buffer.readUInt8() / 255, buffer.readUInt8() / 255)
	end },
	Instance = { function(value)
		local _value = value
		return typeof(_value) == "Instance"
	end, function(buffer, value)
		local instance = value
		local instance_id = instance:GetAttribute(INSTANCE_ID_TAG)
		if instance_id == nil then
			error("no instance id found when serialziing")
		end
		local _instance_id = instance_id
		if not (type(_instance_id) == "number") then
			error("invalid instance id when serializing")
		end
		buffer.writeUInt32(instance_id)
	end, function(buffer)
		return {
			__IS_INSTANCE = buffer.readUInt32(),
		}
	end },
	NumberSequence = { function(value)
		local _value = value
		return typeof(_value) == "NumberSequence"
	end, function(buffer, value)
		local sequence = value
		buffer.writeNumberSequence(sequence)
	end, function(buffer)
		return buffer.readNumberSequence()
	end },
	ColorSequence = { function(value)
		local _value = value
		return typeof(_value) == "ColorSequence"
	end, function(buffer, value)
		local sequence = value
		buffer.writeColorSequence(sequence)
	end, function(buffer)
		return buffer.readColorSequence()
	end },
	NumberRange = { function(value)
		local _value = value
		return typeof(_value) == "NumberRange"
	end, function(buffer, value)
		local range = value
		buffer.writeFloat16(range.Min)
		buffer.writeFloat16(range.Max)
	end, function(buffer)
		local min = buffer.readFloat16()
		local max = buffer.readFloat16()
		return NumberRange.new(min, max)
	end },
}
local write_instance_property = function(buffer, value)
	local encode_function
	local encode_id
	for index, data in pairs(ENCODING_FUNCTIONS) do
		if data[1](value) then
			encode_function = data
			encode_id = ENCODE_VALUE_IDS[index]
			break
		end
	end
	if not encode_function or encode_id == nil then
		local _exp = tostring(value)
		local _value = value
		warn("can't encode value '" .. (_exp .. ("' (" .. (typeof(_value) .. ")"))))
		return nil
	end
	local _binding = encode_function
	local test_integrity = _binding[1]
	local write = _binding[2]
	local read = _binding[3]
	buffer.writeUInt8(encode_id)
	write(buffer, value)
end
local decode_instance_property = function(buffer)
	local id = buffer.readUInt8()
	local value_id = ""
	for index, value in pairs(ENCODE_VALUE_IDS) do
		if value ~= id then
			continue
		end
		value_id = index
		break
	end
	if not (value_id ~= "" and value_id) then
		error("invalid property ID " .. (tostring(id) .. ", buffer is out of order"))
	end
	if not string_is_encode_id(value_id) then
		error("invalid property ID " .. (tostring(id) .. (" (" .. (value_id .. "), buffer is out of order"))))
	end
	local encode_function = ENCODING_FUNCTIONS[value_id]
	if not encode_function then
		error("can't decode value of type " .. (value_id .. ", buffer is out of order"))
	end
	return encode_function[3](buffer)
end
return {
	write_instance_property = write_instance_property,
	decode_instance_property = decode_instance_property,
}
