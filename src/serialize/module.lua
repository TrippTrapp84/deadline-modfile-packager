-- Compiled with roblox-ts v2.2.0
local TS = _G[script]
local SerializeAttachmentDeclaration = TS.import(script, script.Parent, "type", "attachment").SerializeAttachmentDeclaration
local SerializeClassDeclaration = TS.import(script, script.Parent, "type", "class").SerializeClassDeclaration
local SerializeInstanceDeclaration = TS.import(script, script.Parent, "type", "instance").SerializeInstanceDeclaration
local SerializeMetadataDeclaration = TS.import(script, script.Parent, "type", "metadata").SerializeMetadataDeclaration
local SerializeMapDeclaration = TS.import(script, script.Parent, "type", "map").SerializeMapDeclaration
local SerializeScriptDeclaration = TS.import(script, script.Parent, "type", "script").SerializeScriptDeclaration
local SerializeLightingPresetDeclaration = TS.import(script, script.Parent, "type", "lighting_preset").SerializeLightingPresetDeclaration
local serializers = { SerializeAttachmentDeclaration, SerializeClassDeclaration, SerializeMetadataDeclaration, SerializeInstanceDeclaration, SerializeMapDeclaration, SerializeScriptDeclaration, SerializeLightingPresetDeclaration }
local function WRITE_MODULE(module, buffer, data)
	buffer.writeUnsigned(4, module.id)
	module.write(data, buffer)
end
local function DECODE_MODULE(file, buffer)
	local id = buffer.readUnsigned(4)
	if id == nil then
		return nil
	end
	local _arg0 = function(value)
		return value.id == id
	end
	-- ▼ ReadonlyArray.find ▼
	local _result
	for _i, _v in serializers do
		if _arg0(_v, _i - 1, serializers) == true then
			_result = _v
			break
		end
	end
	-- ▲ ReadonlyArray.find ▲
	local serializer = _result
	if not serializer then
		error("invalid module ID " .. tostring(id))
	end
	serializer.decode(file, buffer)
	return true
end
return {
	WRITE_MODULE = WRITE_MODULE,
	DECODE_MODULE = DECODE_MODULE,
}
