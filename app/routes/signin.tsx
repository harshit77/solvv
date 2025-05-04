import { createFileRoute, useRouter } from "@tanstack/react-router";
import Auth from "@/components/Auth"
import { createServerFn, useServerFn } from "@tanstack/react-start";
import {z} from "zod"
import { getSupabaseServerClient } from "@/utlis/supabase/server";
import { useMutation } from "@/hooks/useMutation";
import {USER_NOT_FOUND,SOMETHING_WENT_WRONG_WHILE_SIGN_IN} from "@/constants"
import { signUpFn } from "./signup";
import { Button } from "@/components/ui/button";

export const AuthSchema=z.object({
    email:z.string(),
    password:z.string()
});

export type AuthSchemaType=z.infer<typeof AuthSchema>

export const Route= createFileRoute("/signin")({
    component:SignIn
})

export const signInFn= createServerFn().validator((auth:AuthSchemaType)=> AuthSchema.parse(auth)).handler(async({data})=>{
    const {email,password}= data;
    const supbase = getSupabaseServerClient();
    const {error:signInError}= await supbase.auth.signInWithPassword({
            email,
            password
        });
    if(signInError) {
        return {
            error:true,
            message:SOMETHING_WENT_WRONG_WHILE_SIGN_IN
        }
    }
})




export function SignIn() {
    const router= useRouter();
    const signInServerFn= useServerFn(signInFn)
    const signUpServerFn= useServerFn(signUpFn)
    const signUpMutation= useMutation({
        fn:signUpServerFn
    })
    const signInMutation= useMutation({
        fn:signInServerFn,
        onSuccess: async(ctx)=>{
            if(!ctx.data?.error) {
                await router.invalidate();
                router.navigate({to:"/app"})
                return
            }
        }
})

const handleSubmit=(event:React.FormEvent<HTMLFormElement>)=>{
   const formData= new FormData(event.target as HTMLFormElement );
   const email= formData.get("email") as string;
   const password= formData.get("password") as string;

   signInMutation.mutate({
    data:{
    email,
    password
   }
})
}
    return (
    <div className="flex min-h-svh flex-col items-center justify-center bg-muted p-6 md:p-10">
      <div className="w-full max-w-sm md:max-w-3xl">
        <Auth actionText="SignIn" status={signInMutation.status} onSubmit={handleSubmit} afterSubmit={signInMutation?.data ? <>
            <div className="text-red-400">{signInMutation.data?.message}
            {/* {signInMutation.data?.error &&
            signInMutation.data?.message === USER_NOT_FOUND ? (
       
                <Button size="lg"

                  onClick={(e) => {
                    const formData = new FormData(
                      (e.target as HTMLButtonElement).form!,
                    )

                    signUpMutation.mutate({
                      data: {
                        email: formData.get('email') as string,
                        password: formData.get('password') as string,
                      },
                    })
                  }}
                  type="button"
                >
                  Sign up instead?
                </Button>
            
            ) : null} */}
            </div></>:null }/>
        </div>
    </div>)
}