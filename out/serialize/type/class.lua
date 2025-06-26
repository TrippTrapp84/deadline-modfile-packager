-- Compiled with roblox-ts v2.2.0
local SerializeClassDeclaration = {
	name = "Class",
	id = 2,
	write = function(declaration, bitbuffer)
		bitbuffer.writeString(declaration.properties.name)
	end,
	decode = function(modfile, buffer)
		local name = buffer.readString()
		local declaration = {
			attachments = {},
			properties = {
				name = name,
			},
		}
		local _class_declarations = modfile.class_declarations
		local _declaration = declaration
		table.insert(_class_declarations, _declaration)
		return declaration
	end,
}
return {
	SerializeClassDeclaration = SerializeClassDeclaration,
}
