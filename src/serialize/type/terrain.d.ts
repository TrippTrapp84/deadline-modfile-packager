/// <reference types="@rbxts/types" />
/// <reference types="@rbxts/compiler-types" />
/// <reference types="@rbxts/types" />
import { Serializer } from "../module";
export declare const SerializeTerrainDeclaration: Serializer<{
    region: Region3;
    occupancies: ReadVoxelsArray<number>;
    materials: ReadVoxelsArray<Enum.Material>;
}>;
