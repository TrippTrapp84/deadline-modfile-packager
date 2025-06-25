-- Compiled with roblox-ts v2.2.0
local TS = _G[script]
local BitBuffer = TS.import(script, TS.getModule(script, "@rbxts", "bitbuffer").src.roblox)
local _module = TS.import(script, script, "serialize", "module")
local DECODE_MODULE = _module.DECODE_MODULE
local WRITE_MODULE = _module.WRITE_MODULE
local SerializeMetadataDeclaration = TS.import(script, script, "serialize", "type", "metadata").SerializeMetadataDeclaration
local InstanceReferenceSerialization = TS.import(script, script, "namespace", "InstanceReferenceSerialization").InstanceReferenceSerialization
local Zlib = TS.import(script, TS.getModule(script, "@rbxts", "zlib").out).Zlib
local SerializeScriptDeclaration = TS.import(script, script, "serialize", "type", "script").SerializeScriptDeclaration
local require_script_as = TS.import(script, script, "util", "require_script_as").require_script_as
local InstanceId = TS.import(script, script, "namespace", "InstanceId").InstanceId
local Encode = TS.import(script, script, "namespace", "Encode").Encode
local wait_on_cooldown = TS.import(script, script, "util", "cooldown").wait_on_cooldown
-- declared by the game itself
-- incomplete types
-- modfile format spec
local ModfilePackager = {}
do
	local _container = ModfilePackager
	-- modifying binary data to change the version may have side effects, reexport your mods with the new version instead
	local PACKAGER_FORMAT_VERSION = "0.24.0"
	_container.PACKAGER_FORMAT_VERSION = PACKAGER_FORMAT_VERSION
	local PLUGIN_VERSION = "1.0.0"
	_container.PLUGIN_VERSION = PLUGIN_VERSION
	local function encode(model)
		InstanceId.reset()
		local encode_buffer = BitBuffer("")
		encode_buffer.writeString(PACKAGER_FORMAT_VERSION)
		local properties = require_script_as(model, "info")
		local _object = {}
		local _left = "name"
		local _condition = properties.name
		if not (_condition ~= "" and _condition) then
			_condition = "No name"
		end
		_object[_left] = _condition
		local _left_1 = "description"
		local _condition_1 = properties.description
		if not (_condition_1 ~= "" and _condition_1) then
			_condition_1 = "No description"
		end
		_object[_left_1] = _condition_1
		local _left_2 = "author"
		local _condition_2 = properties.author
		if not (_condition_2 ~= "" and _condition_2) then
			_condition_2 = "No author"
		end
		_object[_left_2] = _condition_2
		local _left_3 = "image"
		local _condition_3 = properties.image
		if not (_condition_3 ~= "" and _condition_3) then
			_condition_3 = "No image"
		end
		_object[_left_3] = _condition_3
		WRITE_MODULE(SerializeMetadataDeclaration, encode_buffer, _object)
		local attachments = model:FindFirstChild("attachments")
		if attachments then
			Encode.attachments(attachments, encode_buffer)
		end
		local maps = model:FindFirstChild("maps")
		if maps then
			Encode.maps(maps, encode_buffer)
		end
		local presets = model:FindFirstChild("lighting_presets")
		if presets then
			Encode.lighting_presets(presets, encode_buffer)
		end
		local autorun = model:FindFirstChild("autorun")
		if autorun then
			-- wtf
			WRITE_MODULE(SerializeScriptDeclaration, encode_buffer, {
				source = autorun.Source,
			})
		end
		local compressed = Zlib.Compress(encode_buffer.dumpString(), {
			level = 9,
		})
		local export_buffer = BitBuffer(compressed)
		return export_buffer.dumpBase64()
	end
	_container.encode = encode
	local set_instance_parents
	local function decode_to_modfile(input)
		local import_buffer = BitBuffer()
		import_buffer.writeBase64(input)
		local contents = Zlib.Decompress(import_buffer.dumpString())
		local decode_buffer = BitBuffer(contents)
		local file = {
			version = decode_buffer.readString(),
			class_declarations = {},
			instance_declarations = {},
			map_declarations = {},
			script_declarations = {},
			lighting_preset_declarations = {},
			terrain_declarations = {},
		}
		if file.version ~= PACKAGER_FORMAT_VERSION then
			return "invalid package version. imported mod is version " .. (file.version .. (", but packager uses " .. (PACKAGER_FORMAT_VERSION .. ". The mod you're using is likely too outdated to be used in deadline as-is. Look for a newer version.")))
		end
		InstanceReferenceSerialization.reset_instance_cache()
		while DECODE_MODULE(file, decode_buffer) and decode_buffer.getLength() - decode_buffer.getPointer() > 8 do
			wait_on_cooldown()
		end
		set_instance_parents(file)
		InstanceReferenceSerialization.set_instance_ids()
		return file
	end
	_container.decode_to_modfile = decode_to_modfile
	function set_instance_parents(modfile)
		local _binding = modfile
		local instance_declarations = _binding.instance_declarations
		-- instance, children
		local target_parents = {}
		for _, parent in pairs(instance_declarations) do
			local _instance_id = parent.position.instance_id
			local _instance = parent.instance
			target_parents[_instance_id] = _instance
		end
		for _, child in pairs(instance_declarations) do
			if child.position.kind == "attachment_root" then
				continue
			end
			wait_on_cooldown()
			local _parent_id = child.position.parent_id
			local instance = target_parents[_parent_id]
			if instance and instance ~= child.instance then
				child.instance.Parent = instance
			end
		end
	end
end
local ModfileProvider = {}
do
	local _container = ModfileProvider
	local LOADED_MODS = {}
	_container.LOADED_MODS = LOADED_MODS
	local load_file = function(file)
		local _file = file
		table.insert(LOADED_MODS, _file)
	end
	_container.load_file = load_file
end
--[[
	
	    specification info for deadline mods
	    for details on reading types, see @rbxts/bitbuffer implementation
	
	    Mods start with a string
	
]]
return {
	ModfilePackager = ModfilePackager,
	ModfileProvider = ModfileProvider,
}
