-- Compiled with roblox-ts v2.2.0
local TS = _G[script]
local HttpService = TS.import(script, TS.getModule(script, "@rbxts", "services")).HttpService
-- serializes the metadata about an attachment declaration
local SerializeAttachmentDeclaration = {
	name = "Attachment",
	id = 1,
	write = function(declaration, bitbuffer)
		bitbuffer.writeString(declaration.properties.name)
		bitbuffer.writeString(declaration.parent_class)
		bitbuffer.writeUInt16(declaration.instance_id)
		local properties = HttpService:JSONEncode(declaration.properties)
		local runtime_properties = HttpService:JSONEncode(declaration.runtime_properties)
		bitbuffer.writeString(properties)
		bitbuffer.writeString(runtime_properties)
	end,
	decode = function(_param, buffer)
		local class_declarations = _param.class_declarations
		local name = buffer.readString()
		local parent = buffer.readString()
		local instance_id = buffer.readUInt16()
		local properties = buffer.readString()
		local runtime_properties = buffer.readString()
		local attachment_declaration = {
			parent_class = parent,
			instance_id = instance_id,
			properties = HttpService:JSONDecode(properties),
			runtime_properties = HttpService:JSONDecode(runtime_properties),
		}
		local _arg0 = function(_param_1)
			local properties = _param_1.properties
			return properties.name == parent
		end
		-- ▼ ReadonlyArray.find ▼
		local _result
		for _i, _v in class_declarations do
			if _arg0(_v, _i - 1, class_declarations) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local class_declaration = _result
		if not class_declaration then
			error("attachment " .. (name .. " has no parent class declared"))
		end
		local _attachments = class_declaration.attachments
		local _attachment_declaration = attachment_declaration
		table.insert(_attachments, _attachment_declaration)
	end,
}
return {
	SerializeAttachmentDeclaration = SerializeAttachmentDeclaration,
}
