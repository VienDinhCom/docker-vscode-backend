# Docker VSCode for Back End Development

A Docker workspace for `backend` development using `VSCode Server` on `Alpine Linux` containers. It ensures a consistent development process from `development` to `production` and provides a uniform environment for `backend` developers.

- 🐳 **Just Docker**—no local dependencies
- 🖥️ **VSCode in browser**—run and code, no setup
- 🚀 **Effortless dev-to-prod workflow**—deploy what you build
- ⚡ **Consistent environments**—no more `it works on my machine`

Perfect for fast, reliable, and collaborative backend development!

You can also include this project as a module in [Docker VSCode for Full Stack Development](https://github.com/VienDinhCom/docker-vscode-fullstack), allowing you to integrate it with the `frontend` and other related services.

## Installation

Before using this project, make sure you have `Docker CLI` version `1.27.0` or higher, with built-in `compose` support.

```
git clone https://github.com/VienDinhCom/docker-vscode-backend.git
```

The command above clones the project into the `docker-vscode-backend` folder. You can navigate to it and check out the scenarios below.

## Production

Build the production image and run it.

```
docker compose -f docker/production.yml up --build
```

Open [http://localhost:8000](http://localhost:8000) to view it in your browser.

## Development

Build the development image and run it with the host's `UID` and `GID`.

```
UID=$(id -u) GID=$(id -g) docker compose -f docker/development.yml up --build
```

Open [http://localhost:58000](http://localhost:58000) to develop inside the container with Visual Studio Code directly in your browser.

Install project dependencies.

```
npm install
```

Run the app in the development mode.

```
npm run dev
```

Open [http://localhost:8000/api/](http://localhost:8000/api/) to view it in your browser.

## Related Projects

- [Docker VSCode for Front End Development](https://github.com/VienDinhCom/docker-vscode-frontend)
- [Docker VSCode for Full Stack Development](https://github.com/VienDinhCom/docker-vscode-fullstack)
