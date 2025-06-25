-- Compiled with roblox-ts v2.2.0
local TS = _G[script]
local HttpService = TS.import(script, TS.getModule(script, "@rbxts", "services")).HttpService
local SerializeLightingPresetDeclaration = {
	name = "Lighting",
	id = 0,
	write = function(declaration, bitbuffer)
		bitbuffer.writeString(declaration.name)
		bitbuffer.writeString(HttpService:JSONEncode(declaration.data))
	end,
	decode = function(modfile, bitbuffer)
		local _lighting_preset_declarations = modfile.lighting_preset_declarations
		local _arg0 = {
			name = bitbuffer.readString(),
			data = HttpService:JSONDecode(bitbuffer.readString()),
		}
		table.insert(_lighting_preset_declarations, _arg0)
	end,
}
return {
	SerializeLightingPresetDeclaration = SerializeLightingPresetDeclaration,
}
