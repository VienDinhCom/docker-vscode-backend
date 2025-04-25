import { Hono } from 'hono';
import { serve } from '@hono/node-server';
import { serveStatic } from '@hono/node-server/serve-static';
import path from 'node:path';
import process from 'node:process';

const app = new Hono();
const publicDir = path.join(process.cwd(), 'public');

// Serve static files from the 'public' directory for all routes
app.use('/*', serveStatic({ root: 'public' }));

// API route
app.get('/api/hello', (c) => {
  return c.json({ message: 'Hello from Back End!' });
});

// Serve 'index.html' for any unmatched routes
app.get('*', serveStatic({ path: path.join('public', 'index.html') }));

// Start the server
serve({ fetch: app.fetch, port: 8000 }, (info) => {
  console.log(`Server is running on http://localhost:${info.port}`);
});
