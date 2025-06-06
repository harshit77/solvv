// app/routes/__root.tsx
import type { ReactNode } from 'react'
import {
  Outlet,
  createRootRoute,
  HeadContent,
  Scripts,
} from '@tanstack/react-router'

import appCss from "@/styles/app.css?url"
import { createServerFn } from '@tanstack/react-start'
import { getSupabaseServerClient } from '@/utlis/supabase/server'


const fetchUser= createServerFn().handler(async()=>{
  const supabase= getSupabaseServerClient();
  const {data}= await supabase.auth.getUser();
  if(!data.user?.email) {
    return null
  }
  return {
   email: data.user.email
  }
})

export const Route = createRootRoute({
  head: () => ({
    meta: [
      {
        charSet: 'utf-8',
      },
      {
        name: 'viewport',
        content: 'width=device-width, initial-scale=1',
      },
      {
        title: 'TanStack Start Starter',
      },
    ],
    links:[{
      rel:"stylesheet",
      href:appCss
    }]
  }),
  beforeLoad: async()=>{
    const user= await fetchUser();
    return {
      user
    }
  },
  component: RootComponent,
})

function RootComponent() {
  return (
    <RootDocument>
      <Outlet />
    </RootDocument>
  )
}

function RootDocument({ children }: Readonly<{ children: ReactNode }>) {
  return (
    <html suppressHydrationWarning>
      <head>
        <HeadContent />
      </head>
      <body>
        {children}
        <Scripts />
      </body>
    </html>
  )
}