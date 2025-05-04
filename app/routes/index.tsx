import { buttonVariants } from "@/components/ui/button";
import { createFileRoute, Link } from "@tanstack/react-router";

export const Route= createFileRoute("/")({
    component:HomePage
})

function HomePage(){
    return (
        <main className="container min-h-screen flex justify-center items-center mx-auto">
       <section className="flex flex-col gap-4">
        <h1 className="text-4xl font-bold">Solvv</h1>
        <p>A solvv is a quiz platform </p>
        <Link className={buttonVariants({variant:"outline"})} to="/signin">Getting Started with Solvv</Link>
       </section>
       </main>
    )

}