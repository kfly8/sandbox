import { Hono } from 'hono'
import { cors } from 'hono/cors'
import { componentRenderer } from './components/renderer'
import { Components, createComponentProps } from './components'

const app = new Hono()

app.use('/api/*', cors())
app.get('/api/components/*', componentRenderer)

app.get('/api/components/:component', (c) => {
  const name = c.req.param('component')
  const Component = Components[name as keyof typeof Components]

  if (!Component) {
    return c.text('Component not found', 404)
  }

  const createProps = createComponentProps[name as keyof typeof Components]
  const params = new URL(c.req.url).searchParams
  const props = createProps(params)

  return c.render(<Component {...props} />)
});

export default app
