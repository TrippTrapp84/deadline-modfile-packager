import BitBuffer from "@rbxts/bitbuffer";
export type supportedEncoderValueType = "string" | "boolean" | "number" | "CFrame" | "EnumItem" | "Vector3" | "Instance" | "UDim2" | "Color3" | "Vector2" | "NumberSequence" | "ColorSequence" | "NumberRange";
export type forceIndex<T> = {
    [index: string]: T;
};
export declare const write_instance_property: (buffer: BitBuffer, value: unknown) => void;
export declare const decode_instance_property: (buffer: BitBuffer) => unknown;
