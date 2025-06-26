/// <reference types="@rbxts/types" />
/// <reference types="bitbuffer" />
import BitBuffer from "@rbxts/bitbuffer";
export declare namespace Encode {
    function attachments(attachments: Instance, buffer: BitBuffer): void;
    function maps(maps: Instance, buffer: BitBuffer): void;
    function lighting_presets(lighting: Instance, buffer: BitBuffer): void;
}
