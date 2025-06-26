/// <reference types="bitbuffer" />
import BitBuffer from "@rbxts/bitbuffer";
import { Modfile } from "..";
export type Serializer<T> = {
    write: (arg: T, buffer: BitBuffer) => void;
    decode: (data: Modfile.file, buffer: BitBuffer) => void;
    name: string;
    id: number;
};
export declare function WRITE_MODULE<T>(module: Serializer<T>, buffer: BitBuffer, data: T): void;
export declare function DECODE_MODULE<T>(file: Modfile.file, buffer: BitBuffer): boolean | undefined;
