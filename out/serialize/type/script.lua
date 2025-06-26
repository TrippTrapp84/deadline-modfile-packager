-- Compiled with roblox-ts v2.2.0
-- serializes the metadata about an attachment declaration
local SerializeScriptDeclaration = {
	name = "AutorunScript",
	id = 6,
	write = function(declaration, bitbuffer)
		bitbuffer.writeString(declaration.source)
	end,
	decode = function(modfile, buffer)
		local _script_declarations = modfile.script_declarations
		local _arg0 = {
			source = buffer.readString(),
		}
		table.insert(_script_declarations, _arg0)
		return modfile
	end,
}
return {
	SerializeScriptDeclaration = SerializeScriptDeclaration,
}
