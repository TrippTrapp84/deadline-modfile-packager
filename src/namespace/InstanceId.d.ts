/// <reference types="@rbxts/types" />
export declare namespace InstanceId {
    function reset(): void;
    function mark_instance(model: Instance): void;
    function advance(): void;
    function get_next(): number;
}
