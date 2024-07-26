import { Hono } from 'hono'
import { renderer } from './renderer'

const app = new Hono()

app.use(renderer)

type Hoge = {
  a: string
  b: number
}

app.get('/', (c) => {
  const a = c.req.json<Hoge>()
  console.log(a.then((a) => a.c));

  return c.render(<h1>Hello!</h1>)
})

app.routes.shift();


export default app
