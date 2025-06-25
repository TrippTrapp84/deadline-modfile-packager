export declare namespace InstanceReferenceSerialization {
    const reset_instance_cache: () => void;
    const add_instance_to_cache: (instance: Instance, id: number) => Map<number, Instance>;
    const schedule_instance_set: (instance: Instance, index: string, id: number) => void;
    const set_instance_ids: () => void;
}
