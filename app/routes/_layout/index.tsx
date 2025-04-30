import * as fs  from "node:fs";
import { createFileRoute, useRouter } from "@tanstack/react-router";
import { createServerFn } from "@tanstack/react-start";
import { Button } from "@/components/ui/button";
import { Icons } from "@/components/ui/icons";

export const Route= createFileRoute("/_layout/")({
    component:HomePage
})

function HomePage(){
    const state= Route.useLoaderData();
    const route= useRouter();
    return (
       <section className="flex flex-col gap-4">
        <h1 className="text-4xl font-bold">Solvv</h1>
        <p>A solvv is a quiz platform </p>
        <Button>
            <Icons.github/>
            Continue with Github
        </Button>
       </section>
    )

}