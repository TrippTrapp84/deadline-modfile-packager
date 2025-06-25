import { supportedEncoderValueType } from "./property/decode_property";
type propertyData = {
    [index: string]: supportedEncoderValueType;
} | undefined;
export declare const INSTANCE_CLASS_MAP: readonly ["SpecialMesh", "Model", "Folder", "Part", "WedgePart", "Motor6D", "SurfaceGui", "Frame", "CanvasGroup", "ImageLabel", "TextLabel", "Texture", "Attachment", "UICorner", "WeldConstraint", "PointLight", "SpotLight", "SurfaceLight", "ParticleEmitter", "Trail", "Beam", "Fire", "Decal", "BlockMesh", "Sound", "StringValue", "IntValue", "BoolValue"];
export type instanceClass = (typeof INSTANCE_CLASS_MAP)[number];
export declare const INSTANCE_PROPERTY_MAP: {
    [index in instanceClass]: propertyData;
};
export {};
