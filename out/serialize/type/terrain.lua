-- Compiled with roblox-ts v2.2.0
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
			local x_occ = declaration.occupancies[x + 1]
			local x_mat = declaration.materials[x + 1]
			for y = 0, #x_occ - 1 do
				local y_occ = x_occ[y + 1]
				local y_mat = x_mat[y + 1]
				for z = 0, #y_occ - 1 do
					local occupancy = y_occ[z + 1]
					local material = y_mat[z + 1]
					bitbuffer.writeUInt32(material.Value)
					bitbuffer.writeFloat64(occupancy)
				end
			end
		end
	end,
	decode = function(modfile, buffer)
		local region = buffer.readRegion3()
		local x_size = buffer.readUInt32()
		local y_size = buffer.readUInt32()
		local z_size = buffer.readUInt32()
		local occupancies = table.create(x_size)
		local materials = table.create(x_size)
		for x = 0, x_size - 1 do
			local y_occ = table.create(y_size)
			local y_mat = table.create(y_size)
			occupancies[x + 1] = y_occ
			materials[x + 1] = y_mat
			for y = 0, y_size - 1 do
				local z_occ = table.create(z_size)
				local z_mat = table.create(z_size)
				y_occ[y + 1] = z_occ
				y_mat[y + 1] = z_mat
				for z = 0, z_size - 1 do
					local material = buffer.readUInt32()
					local occupancy = buffer.readFloat64()
					z_occ[z + 1] = occupancy
					z_mat[z + 1] = INT_TO_MATERIAL[material]
				end
			end
		end
		local declaration = {
			region = region,
			occupancies = occupancies,
			materials = materials,
		}
		table.insert(modfile.terrain_declarations, declaration)
		return declaration
	end,
}
return {
	SerializeTerrainDeclaration = SerializeTerrainDeclaration,
}
