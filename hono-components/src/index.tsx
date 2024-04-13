import { Hono } from 'hono'
import { cors } from 'hono/cors'
import { componentRenderer } from './components/renderer'
import { Components } from './components'

const app = new Hono()

app.use('/api/*', cors())
app.get('/api/components/*', componentRenderer)

app.get('/api/components/:component', (c) => {
  const name = c.req.param('component')
  const Component = Components[name as keyof typeof Components]

  if (Component) {
    return c.render(<Component />)
  }
  else {
    return c.text('Component not found')
  }
});

export default app
