import { NOT_AUTHENTICATED } from '@/constants'
import { createFileRoute } from '@tanstack/react-router'
import { SignIn } from './signin'

export const Route = createFileRoute('/_authenticated')({
    beforeLoad:({context})=>{
        console.log("context",context)
        if(!context.user) {
           throw new Error(NOT_AUTHENTICATED)
        }
    },
    errorComponent:({error})=>{
        if(error.message === NOT_AUTHENTICATED) {
            return <SignIn/>
        }
        throw error
    }
})