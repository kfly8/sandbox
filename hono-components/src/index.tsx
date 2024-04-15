import { Hono } from 'hono'
import { renderer } from './renderer'

import { Button } from './components/Button'

const app = new Hono()

app.use(renderer)

app.get('/', (c) => {
  return c.render(
    <>
      <h1>Hello!</h1>
      <Button size="large">Click me!</Button>
    </>
  )
})

export default app
