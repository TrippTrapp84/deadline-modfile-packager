-- Compiled with roblox-ts v2.2.0
local SerializeMetadataDeclaration = {
	name = "Metadata",
	id = 3,
	write = function(declaration, buffer)
		buffer.writeString(declaration.name)
		buffer.writeString(declaration.description)
		buffer.writeString(declaration.author)
		buffer.writeString(declaration.image)
	end,
	decode = function(modfile, buffer)
		local declaration = {
			name = buffer.readString(),
			description = buffer.readString(),
			author = buffer.readString(),
			image = buffer.readString(),
		}
		modfile.info = declaration
		return declaration
	end,
}
return {
	SerializeMetadataDeclaration = SerializeMetadataDeclaration,
}
