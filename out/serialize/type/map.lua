-- Compiled with roblox-ts v2.2.0
local SerializeMapDeclaration = {
	name = "Map",
	id = 5,
	write = function(declaration, bitbuffer)
		bitbuffer.writeString(declaration.properties.name)
		bitbuffer.writeString(declaration.properties.code)
		bitbuffer.writeUInt16(declaration.instance_id)
		bitbuffer.writeString(declaration.properties.description)
		bitbuffer.writeString(declaration.properties.lighting_preset)
		bitbuffer.writeString(declaration.properties.sound_preset)
		bitbuffer.writeUInt16(declaration.properties.lamps.on_time)
		bitbuffer.writeUInt16(declaration.properties.lamps.off_time)
		bitbuffer.writeString(declaration.properties.images.thumbnail_day)
		bitbuffer.writeString(declaration.properties.images.thumbnail_night)
		bitbuffer.writeString(declaration.properties.minimap.image)
		bitbuffer.writeUInt16(declaration.properties.minimap.size)
	end,
	decode = function(modfile, bitbuffer)
		local name = bitbuffer.readString()
		local code = bitbuffer.readString()
		local instance_id = bitbuffer.readUInt16()
		local description = bitbuffer.readString()
		local lighting_preset = bitbuffer.readString()
		local sound_preset = bitbuffer.readString()
		local lamps_on_time = bitbuffer.readUInt16()
		local lamps_off_time = bitbuffer.readUInt16()
		local thumbnail_day = bitbuffer.readString()
		local thumbnail_night = bitbuffer.readString()
		local image = bitbuffer.readString()
		local size = bitbuffer.readUInt16()
		local declaration = {
			properties = {
				name = name,
				code = code,
				description = description,
				lighting_preset = lighting_preset,
				sound_preset = sound_preset,
				lamps = {
					on_time = lamps_on_time,
					off_time = lamps_off_time,
				},
				images = {
					thumbnail_day = thumbnail_day,
					thumbnail_night = thumbnail_night,
				},
				minimap = {
					image = image,
					size = size,
				},
			},
			instance_id = instance_id,
		}
		local _map_declarations = modfile.map_declarations
		local _declaration = declaration
		table.insert(_map_declarations, _declaration)
		return declaration
	end,
}
return {
	SerializeMapDeclaration = SerializeMapDeclaration,
}
