import { Hono } from 'hono';
import { serve } from '@hono/node-server';
import { serveStatic } from '@hono/node-server/serve-static';

const app = new Hono();

app.use('/*', serveStatic({ root: 'public' }));

app.get('/api/hello', (c) => {
  return c.json({ message: 'Hello from Back End!' });
});

app.get('*', (c) => {
  return c.json({message: 'Welcome to Back End!'})
})

serve({ fetch: app.fetch, port: 8000 }, (info) => {
  console.log(`Server is running on http://localhost:${info.port}`);
});
