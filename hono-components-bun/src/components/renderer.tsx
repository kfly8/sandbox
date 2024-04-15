import { jsxRenderer } from 'hono/jsx-renderer'
import { Style } from 'hono/css'

export const componentRenderer = jsxRenderer(({ children }) => {
  return (
    <html>
      <head>
        <Style />
      </head>
      <body>{children}</body>
    </html>
  )
})
