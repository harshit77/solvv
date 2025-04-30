import { createFileRoute,Outlet } from "@tanstack/react-router";



export const Route= createFileRoute("/_layout")({
    component: RouteComponent
})


function RouteComponent() {
 return (<main className="flex justify-center items-center container mx-auto min-h-screen"><Outlet/></main>)
}