-- Compiled with roblox-ts v2.2.0
local TS = _G[script]
local WRITE_MODULE = TS.import(script, script.Parent.Parent, "serialize", "module").WRITE_MODULE
local SerializeAttachmentDeclaration = TS.import(script, script.Parent.Parent, "serialize", "type", "attachment").SerializeAttachmentDeclaration
local SerializeClassDeclaration = TS.import(script, script.Parent.Parent, "serialize", "type", "class").SerializeClassDeclaration
local SerializeInstanceDeclaration = TS.import(script, script.Parent.Parent, "serialize", "type", "instance").SerializeInstanceDeclaration
local SerializeMapDeclaration = TS.import(script, script.Parent.Parent, "serialize", "type", "map").SerializeMapDeclaration
local INSTANCE_ID_TAG = TS.import(script, script.Parent.Parent, "util", "constants").INSTANCE_ID_TAG
local require_script_as = TS.import(script, script.Parent.Parent, "util", "require_script_as").require_script_as
local InstanceId = TS.import(script, script.Parent, "InstanceId").InstanceId
local SerializeLightingPresetDeclaration = TS.import(script, script.Parent.Parent, "serialize", "type", "lighting_preset").SerializeLightingPresetDeclaration
local SerializeTerrainDeclaration = TS.import(script, script.Parent.Parent, "serialize", "type", "terrain").SerializeTerrainDeclaration
local Workspace = TS.import(script, TS.getModule(script, "@rbxts", "services")).Workspace
local function isAxisAligned(part)
	if part.Orientation.X % 90 ~= 0 then
		return false
	end
	if part.Orientation.Y % 90 ~= 0 then
		return false
	end
	if part.Orientation.Z % 90 ~= 0 then
		return false
	end
	return true
end
local Encode = {}
do
	local _container = Encode
	local function attachments(attachments, buffer)
		local attachment_classes = attachments:GetChildren()
		local _arg0 = function(folder)
			print("attachments/" .. folder.Name)
			WRITE_MODULE(SerializeClassDeclaration, buffer, {
				attachments = {},
				properties = {
					name = folder.Name,
				},
			})
			local _exp = folder:GetChildren()
			local _arg0_1 = function(attachment)
				print("attachments/" .. (folder.Name .. ("/" .. attachment.Name)))
				local model = attachment:FindFirstChild("model")
				if not model then
					error(attachment.Name .. " is missing a model")
				end
				local properties = require_script_as(attachment, "properties")
				local runtime_properties = require_script_as(attachment, "runtime_properties")
				-- autofilled by the game
				properties.name = attachment.Name
				InstanceId.mark_instance(model)
				local instance_id = model:GetAttribute(INSTANCE_ID_TAG)
				WRITE_MODULE(SerializeAttachmentDeclaration, buffer, {
					instance_id = instance_id,
					parent_class = folder.Name,
					properties = properties,
					runtime_properties = runtime_properties,
				})
				WRITE_MODULE(SerializeInstanceDeclaration, buffer, {
					position = {
						kind = "attachment_root",
						instance_id = instance_id,
						parent_id = InstanceId.get_next(),
					},
					instance = model,
				})
				InstanceId.advance()
			end
			for _k, _v in _exp do
				_arg0_1(_v, _k - 1, _exp)
			end
		end
		for _k, _v in attachment_classes do
			_arg0(_v, _k - 1, attachment_classes)
		end
	end
	_container.attachments = attachments
	local function maps(maps, buffer)
		local map_data = maps:GetChildren()
		local _arg0 = function(folder)
			print("maps/" .. folder.Name)
			local data = folder:FindFirstChild("data")
			if not data then
				error(folder.Name .. " is missing a data model")
			end
			InstanceId.mark_instance(folder)
			local data_id = data:GetAttribute(INSTANCE_ID_TAG)
			WRITE_MODULE(SerializeMapDeclaration, buffer, {
				attachments = {},
				instance_id = data_id,
				properties = require_script_as(folder, "properties"),
				instance = data,
			})
			WRITE_MODULE(SerializeInstanceDeclaration, buffer, {
				position = {
					kind = "attachment_root",
					instance_id = data_id,
					parent_id = InstanceId.get_next(),
				},
				instance = data,
			})
			local terrainZones = folder:FindFirstChild("terrain")
			if terrainZones ~= nil then
				local terrainRegion = terrainZones:FindFirstChildWhichIsA("BasePart")
				if terrainRegion ~= nil then
					if not isAxisAligned(terrainRegion) then
						warn("Terrain region " .. (terrainRegion:GetFullName() .. " is not aligned to the X, Y and Z axes! This will be skipped for terrain reading!"))
					else
						terrainRegion.Position = terrainRegion.Size / 2
						local _exp = (terrainRegion.Position)
						local _position = terrainRegion.Position
						local _arg0_1 = terrainRegion.Size / 2
						local voxelRegion = Region3.new(_exp, _position + _arg0_1):ExpandToGrid(4)
						local materials, occupancies = Workspace.Terrain:ReadVoxels(voxelRegion, 4)
						WRITE_MODULE(SerializeTerrainDeclaration, buffer, {
							region = voxelRegion,
							materials = materials,
							occupancies = occupancies,
						})
					end
				end
			end
		end
		for _k, _v in map_data do
			_arg0(_v, _k - 1, map_data)
		end
	end
	_container.maps = maps
	local function lighting_presets(lighting, buffer)
		local preset_data = lighting:GetChildren()
		local _arg0 = function(module)
			print("lighting/presets/" .. module.Name)
			if not module:IsA("ModuleScript") then
				error(module.Name .. " is not a ModuleScript")
			end
			local data = require_script_as(lighting, module.Name)
			WRITE_MODULE(SerializeLightingPresetDeclaration, buffer, {
				name = module.Name,
				data = data,
			})
		end
		for _k, _v in preset_data do
			_arg0(_v, _k - 1, preset_data)
		end
	end
	_container.lighting_presets = lighting_presets
end
return {
	Encode = Encode,
}
