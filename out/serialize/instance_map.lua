-- Compiled with roblox-ts v2.2.0
-- MASSIVE TODO
-- This map was made originally because I didn't want to include additional dependencies
-- and to have control over what gets exported for security
-- but it's getting kind of annoying
-- https://pastebin.com/raw/TFSU2s5e todo
-- TODO do this procedurally
local GUI_OBJECT = {
	Position = "UDim2",
	Size = "UDim2",
	AnchorPoint = "Vector2",
	BackgroundColor3 = "Color3",
	BackgroundTransparency = "number",
}
local BASEPART = {
	Transparency = "number",
	Reflectance = "number",
	Material = "EnumItem",
	Anchored = "boolean",
	CFrame = "CFrame",
	Color = "Color3",
	CollisionGroup = "string",
	CanQuery = "boolean",
	CanTouch = "boolean",
	CanCollide = "boolean",
	Locked = "boolean",
	Size = "Vector3",
	CastShadow = "boolean",
}
local LIGHT = {
	Brightness = "number",
	Color = "Color3",
	Range = "number",
}
local INSTANCE_CLASS_MAP = { "SpecialMesh", "Model", "Folder", "Part", "WedgePart", "Motor6D", "SurfaceGui", "Frame", "CanvasGroup", "ImageLabel", "TextLabel", "Texture", "Attachment", "UICorner", "WeldConstraint", "PointLight", "SpotLight", "SurfaceLight", "ParticleEmitter", "Trail", "Beam", "Fire", "Decal", "BlockMesh", "Sound", "StringValue", "IntValue", "BoolValue" }
local _object = {
	SpecialMesh = {
		TextureId = "string",
		MeshId = "string",
		MeshType = "EnumItem",
		Offset = "Vector3",
		Scale = "Vector3",
		VertexColor = "Color3",
	},
	BlockMesh = {
		VertexColor = "Color3",
		Offset = "Vector3",
		Scale = "Vector3",
	},
	Model = {},
	Folder = {},
}
local _left = "Part"
local _object_1 = {}
for _k, _v in BASEPART do
	_object_1[_k] = _v
end
_object_1.Shape = "EnumItem"
_object[_left] = _object_1
local _left_1 = "WedgePart"
local _object_2 = {}
for _k, _v in BASEPART do
	_object_2[_k] = _v
end
_object[_left_1] = _object_2
_object.Motor6D = {
	C0 = "CFrame",
	C1 = "CFrame",
	Part0 = "Instance",
	Part1 = "Instance",
}
_object.StringValue = {
	Value = "string",
}
_object.BoolValue = {
	Value = "boolean",
}
_object.IntValue = {
	Value = "number",
}
_object.SurfaceGui = {
	ZOffset = "number",
	Face = "EnumItem",
	PixelsPerStud = "number",
	LightInfluence = "number",
	SizingMode = "EnumItem",
	AlwaysOnTop = "boolean",
	Active = "boolean",
	Adornee = "Instance",
	Enabled = "boolean",
	MaxDistance = "number",
}
local _left_2 = "Frame"
local _object_3 = {}
for _k, _v in GUI_OBJECT do
	_object_3[_k] = _v
end
_object[_left_2] = _object_3
local _left_3 = "CanvasGroup"
local _object_4 = {}
for _k, _v in GUI_OBJECT do
	_object_4[_k] = _v
end
_object[_left_3] = _object_4
local _left_4 = "ImageLabel"
local _object_5 = {}
for _k, _v in GUI_OBJECT do
	_object_5[_k] = _v
end
_object_5.ImageColor3 = "Color3"
_object_5.Image = "string"
_object[_left_4] = _object_5
local _left_5 = "TextLabel"
local _object_6 = {}
for _k, _v in GUI_OBJECT do
	_object_6[_k] = _v
end
_object_6.TextColor3 = "Color3"
_object_6.Text = "string"
_object_6.TextSize = "number"
_object_6.TextWrapped = "boolean"
_object_6.TextScaled = "boolean"
_object[_left_5] = _object_6
_object.Texture = {
	Color3 = "Color3",
	OffsetStudsU = "number",
	OffsetStudsV = "number",
	StudsPerTileU = "number",
	StudsPerTileV = "number",
	Texture = "string",
	Transparency = "number",
	ZIndex = "number",
	Face = "EnumItem",
}
local _left_6 = "PointLight"
local _object_7 = {}
for _k, _v in LIGHT do
	_object_7[_k] = _v
end
_object[_left_6] = _object_7
local _left_7 = "SpotLight"
local _object_8 = {}
for _k, _v in LIGHT do
	_object_8[_k] = _v
end
_object_8.Face = "EnumItem"
_object_8.Angle = "number"
_object[_left_7] = _object_8
local _left_8 = "SurfaceLight"
local _object_9 = {}
for _k, _v in LIGHT do
	_object_9[_k] = _v
end
_object_9.Face = "EnumItem"
_object_9.Angle = "number"
_object[_left_8] = _object_9
_object.Decal = {
	Color3 = "Color3",
	Texture = "string",
	Face = "EnumItem",
	Transparency = "number",
	ZIndex = "number",
}
_object.Attachment = {
	Visible = "boolean",
	CFrame = "CFrame",
}
_object.UICorner = {}
_object.WeldConstraint = {
	Part0 = "Instance",
	Part1 = "Instance",
}
_object.Beam = {}
_object.Fire = {}
_object.ParticleEmitter = {
	Brightness = "number",
	FlipbookFramerate = "NumberRange",
	FlipbookMode = "EnumItem",
	FlipbookStartRandom = "boolean",
	Color = "ColorSequence",
	LightEmission = "number",
	LightInfluence = "number",
	Orientation = "EnumItem",
	Size = "NumberSequence",
	Squash = "NumberSequence",
	Texture = "string",
	Transparency = "NumberSequence",
	ZOffset = "number",
	EmissionDirection = "EnumItem",
	Enabled = "boolean",
	Lifetime = "NumberSequence",
	Rate = "number",
	Rotation = "NumberRange",
	RotSpeed = "NumberRange",
	Speed = "NumberRange",
	SpreadAngle = "NumberRange",
	Shape = "EnumItem",
	ShapeInOut = "EnumItem",
	ShapeStyle = "EnumItem",
	FlipbookLayout = "EnumItem",
	Acceleration = "Vector3",
	Drag = "number",
	LockedToPart = "boolean",
	TimeScale = "number",
	VelocityInheritance = "number",
	WindAffectsDrag = "boolean",
}
_object.Trail = {
	Color = "ColorSequence",
	LightEmission = "number",
	LightInfluence = "number",
	Texture = "string",
	TextureLength = "number",
	TextureMode = "EnumItem",
	ZOffset = "number",
	Enabled = "boolean",
	Lifetime = "NumberRange",
	MinLength = "number",
	MaxLength = "number",
	WidthScale = "NumberSequence",
	VelocityScale = "number",
}
_object.Sound = {
	SoundId = "string",
	RollOffMaxDistance = "number",
	RollOffMinDistance = "number",
	RollOffMode = "EnumItem",
	Looped = "boolean",
	PlaybackRegionsEnabled = "boolean",
	PlaybackSpeed = "number",
	Playing = "boolean",
	TimePosition = "number",
	Volume = "number",
}
local INSTANCE_PROPERTY_MAP = _object
return {
	INSTANCE_CLASS_MAP = INSTANCE_CLASS_MAP,
	INSTANCE_PROPERTY_MAP = INSTANCE_PROPERTY_MAP,
}
