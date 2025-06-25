-- Compiled with roblox-ts v2.2.0
local TS = _G[script]
local Workspace = TS.import(script, TS.getModule(script, "@rbxts", "services")).Workspace
local _exp = Enum.Material:GetEnumItems()
local _arg0 = function(material)
	return { material, material.Value }
end
-- ▼ ReadonlyArray.map ▼
local _newValue = table.create(#_exp)
for _k, _v in _exp do
	_newValue[_k] = _arg0(_v, _k - 1, _exp)
end
-- ▲ ReadonlyArray.map ▲
local _map = {}
for _, _v in _newValue do
	_map[_v[1]] = _v[2]
end
local MATERIAL_TO_INT = _map
local _exp_1 = Enum.Material:GetEnumItems()
local _arg0_1 = function(material)
	return { material.Value, material }
end
-- ▼ ReadonlyArray.map ▼
local _newValue_1 = table.create(#_exp_1)
for _k, _v in _exp_1 do
	_newValue_1[_k] = _arg0_1(_v, _k - 1, _exp_1)
end
-- ▲ ReadonlyArray.map ▲
local _map_1 = {}
for _, _v in _newValue_1 do
	_map_1[_v[1]] = _v[2]
end
local INT_TO_MATERIAL = _map_1
local SerializeTerrainDeclaration = {
	name = "Terrain",
	id = 7,
	write = function(declaration, bitbuffer)
		bitbuffer.writeRegion3(declaration.region)
		bitbuffer.writeUInt32(#declaration.occupancies)
		local _fn = bitbuffer
		local _result = declaration.occupancies[1]
		if _result ~= nil then
			_result = #_result
		end
		local _condition = _result
		if _condition == nil then
			_condition = 0
		end
		_fn.writeUInt32(_condition)
		local _fn_1 = bitbuffer
		local _result_1 = declaration.occupancies[1]
		if _result_1 ~= nil then
			_result_1 = _result_1[1]
			if _result_1 ~= nil then
				_result_1 = #_result_1
			end
		end
		local _condition_1 = _result_1
		if _condition_1 == nil then
			_condition_1 = 0
		end
		_fn_1.writeUInt32(_condition_1)
		for x = 0, #declaration.occupancies - 1 do
			local xOcc = declaration.occupancies[x + 1]
			local xMat = declaration.materials[x + 1]
			for y = 0, #xOcc - 1 do
				local yOcc = xOcc[y + 1]
				local yMat = xMat[y + 1]
				for z = 0, #yOcc - 1 do
					local occupancy = yOcc[z + 1]
					local material = yMat[z + 1]
					bitbuffer.writeUInt32(material.Value)
					bitbuffer.writeFloat64(occupancy)
				end
			end
		end
	end,
	decode = function(modfile, buffer)
		local region = buffer.readRegion3()
		local xSize = buffer.readUInt32()
		local ySize = buffer.readUInt32()
		local zSize = buffer.readUInt32()
		local occupancies = table.create(xSize)
		local materials = table.create(xSize)
		for x = 0, xSize - 1 do
			local yOcc = table.create(ySize)
			local yMat = table.create(ySize)
			occupancies[x + 1] = yOcc
			materials[x + 1] = yMat
			for y = 0, ySize - 1 do
				local zOcc = table.create(zSize)
				local zMat = table.create(zSize)
				yOcc[y + 1] = zOcc
				yMat[y + 1] = zMat
				for z = 0, zSize - 1 do
					local material = buffer.readUInt32()
					local occupancy = buffer.readFloat64()
					zOcc[z + 1] = occupancy
					zMat[z + 1] = INT_TO_MATERIAL[material]
				end
			end
		end
		local declaration = {
			region = region,
			occupancies = occupancies,
			materials = materials,
		}
		Workspace.Terrain:WriteVoxels(region, 4, materials, occupancies)
		table.insert(modfile.terrain_declarations, declaration)
		return declaration
	end,
}
return {
	SerializeTerrainDeclaration = SerializeTerrainDeclaration,
}
