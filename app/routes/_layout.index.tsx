import * as fs  from "node:fs";
import { createFileRoute, useRouter } from "@tanstack/react-router";
import { createServerFn } from "@tanstack/react-start";

const filePath="count.txt"

async function readCount(){
    return parseInt(await fs.promises.readFile(filePath,"utf-8").catch(()=>"0"))
}

const getCount= createServerFn({method:"GET"}).handler(()=>{
    return readCount();
});

const updateCount= createServerFn({method:"POST"}).validator((d:number)=>d).handler(async({data})=>{
    const count= await readCount();
    return fs.promises.writeFile(filePath,`${count+data}`)
})

export const Route= createFileRoute("/_layout/")({
    component:HomePage,
    loader: async()=> await getCount()
})

type FormDataTest={
    name: string,
    age: string
}

const greet= createServerFn({method:"POST"}).validator((data:FormData):FormDataTest=>{
    if(!(data instanceof FormData)) {
        throw new Error("Invalid type")
    }
    const name= data.get("name");
    const age= data.get("age")
    if(!name || !age)
        throw new Error("Must be required")
    return {name:name.toString(),age:age.toString()}

}).handler(({data})=> `Hello ${data.name}`)


function FormDataTest(){
    const handleSubmit=async(event)=>{
        event.preventDefault();
        const formData= new FormData(event.currentTarget);
        const response= await greet({data:formData})
        console.log(response)
    }
    return (
        <form onSubmit={handleSubmit}>
            <input name="name"/>
            <input name="age"/>
            <button type="submit">Submit</button>
        </form>
    )
}


function HomePage(){
    const state= Route.useLoaderData();
    const route= useRouter();
    return (
        <>
        <button type="button"onClick={()=>{
            updateCount({data:1}).then(()=>route.invalidate())
        }}>
            Add 1 to {state} ? 
        </button>
        <FormDataTest/>
        </>
    )

}