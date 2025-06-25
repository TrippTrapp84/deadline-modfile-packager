/// <reference types="@rbxts/types" />
/// <reference types="@rbxts/types" />
/// <reference types="@rbxts/compiler-types" />
/// <reference types="@rbxts/types" />
export declare namespace Deadline {
    type attachmentClassData = {
        name: string;
    };
    type attachmentProperties = {
        name: string;
    };
    type runtimeAttachmentProperties = {
        name: string;
    };
    type gameMapProperties = {
        description: string;
        images: {
            thumbnail_day: string;
            thumbnail_night: string;
        };
        lamps: {
            off_time: number;
            on_time: number;
        };
        lighting_preset: string;
        minimap: {
            image: string;
            size: number;
        };
        name: string;
        code: string;
        sound_preset: string;
    };
}
export declare namespace Modfile {
    type properties = {
        [index: string]: string;
    };
    type file = {
        info?: Modfile.metadataDeclaration;
        version: string;
        map_declarations: Modfile.mapDeclaration[];
        class_declarations: Modfile.classDeclaration[];
        instance_declarations: Modfile.instanceDeclaration[];
        script_declarations: Modfile.scriptDeclaration[];
        lighting_preset_declarations: Modfile.lightingPreset[];
        terrain_declarations: Modfile.terrainDeclaration[];
    };
    type lightingPreset = {
        name: string;
        data: unknown;
    };
    type metadataDeclaration = {
        name: string;
        description: string;
        author: string;
        image: string;
    };
    type classDeclaration = {
        properties: Deadline.attachmentClassData;
        attachments: Modfile.attachmentDeclaration[];
    };
    type instanceDeclaration = {
        position: {
            kind: "attachment_root";
            parent_id: number;
            instance_id: number;
        } | {
            kind: "child";
            parent_id: number;
            instance_id: number;
        };
        instance: Instance;
    };
    type attachmentDeclaration = {
        instance_id: number;
        parent_class: string;
        properties: Deadline.attachmentProperties;
        runtime_properties: Deadline.runtimeAttachmentProperties;
    };
    type scriptDeclaration = {
        source: string;
    };
    type terrainDeclaration = {
        region: Region3;
        occupancies: Array<Array<Array<number>>>;
        materials: Array<Array<Array<Enum.Material>>>;
    };
    type mapDeclaration = {
        instance_id: number;
        properties: Deadline.gameMapProperties;
    };
    type compiledClass = {
        name: string;
    };
}
export declare namespace ModfilePackager {
    const PACKAGER_FORMAT_VERSION = "0.24.0";
    const PLUGIN_VERSION = "1.0.0";
    function encode(model: Instance): string;
    function decode_to_modfile(input: string): string | Modfile.file;
}
export declare namespace ModfileProvider {
    const LOADED_MODS: string[];
    const load_file: (file: string) => void;
}
