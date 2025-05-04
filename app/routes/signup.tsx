import { createFileRoute,redirect } from '@tanstack/react-router'
import { createServerFn, useServerFn } from '@tanstack/react-start'
import {type AuthSchemaType,AuthSchema  } from "./signin"
import { getSupabaseServerClient } from '@/utlis/supabase/server'
import { useMutation } from '@/hooks/useMutation'
import Auth from '@/components/Auth'

export const Route = createFileRoute('/signup')({
  component: SignUp,
})

export const signUpFn= createServerFn().validator((auth:AuthSchemaType)=> AuthSchema.parse(auth)).handler(async({data})=>{
    const {email,password}= data;
    const supbase= getSupabaseServerClient();
  const {error}=  await supbase.auth.signUp({
        email,
        password
    });
    if(error) {
        return {
            error:true,
            message:error.message
        }
    }
    throw redirect({
      to: '/app',
    })
})

function SignUp() {
    const signUpServerFn= useServerFn(signUpFn);
    const signUpMutation= useMutation({
        fn:signUpServerFn,
    })

    const handleSubmit= async(event:React.FormEvent<HTMLFormElement>) =>{
        const formData= new FormData(event.target as HTMLFormElement)
        const email= formData.get("email") as string;
        const password= formData.get("password") as string;
       signUpMutation.mutate({
        data:{
            email,
            password
        }
       })
    }


  return (
    <div className="flex min-h-svh flex-col items-center justify-center bg-muted p-6 md:p-10">
        <div className="w-full max-w-sm md:max-w-3xl">
          <Auth actionText="SignUp" status={signUpMutation.status} onSubmit={handleSubmit} afterSubmit={signUpMutation.data?.error ? <div className="text-red-500">{signUpMutation.data.message}</div>:null}>
          </Auth>
        </div>
    </div>)
}

