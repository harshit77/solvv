import { createBrowserClient } from "@supabase/ssr";


export function createClient() {
    return createBrowserClient(
        process.env.SUPBASE_URL!,
        process.env.SUPABASE_ANON_URL!
    )
}