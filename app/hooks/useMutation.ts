import React,{useCallback, useState} from "react";

export type Status = "idle" | "pending" | "success" |"error"

export function useMutation<TVariable,TData,TError=Error>(options:{
    fn:(variables:TVariable)=> Promise<TData>,
    onSuccess?:(ctx:{data:TData})=> void | Promise<void>
}) {
    const [status,setStatus]= useState<Status>("idle");
    const [data,setData]= useState<TData | undefined>();
    const [variables,setVariables]= useState<TVariable | undefined>();
    const [error,setError]= useState<TError | undefined>();

    const mutate= useCallback(async(variables:TVariable): Promise<TData | undefined>=>{
        setStatus("pending");
        setVariables(variables);
        try {
        const data= await options.fn(variables);
        await options.onSuccess?.({data})
        setStatus("success");
        setError(undefined)
        setData(data);
        return data
        }
        catch(error:any) {
        setStatus("error");
        setError(error)
        }
    },[options.fn]);

    return {
        mutate,
        data,
        status,
        error,
        variables,
    }
}