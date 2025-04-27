FROM alpine:3.21 AS base

ARG UID=1000
ARG GID=1000
ARG USR=backend

RUN apk add --no-cache shadow

# Nonroot User
RUN getent passwd ${UID} && userdel $(getent passwd ${UID} | cut -d: -f1) || true
RUN getent group ${GID} || groupadd --gid ${GID} ${USR}
RUN useradd --uid ${UID} --gid ${GID} -m ${USR}

# Production Dependencies
RUN apk add --no-cache nodejs npm

WORKDIR /home/${USR}/project


# TARGET: DEVELOPMENT
##################################################################
FROM base AS development

ENV NODE_ENV=development
ENV DATABASE_URL=postgresql://user:pass@host:5432/mydb

# Fish Shell
RUN apk add fish
RUN chsh -s $(which fish) ${USR}

# VSCode CLI 
RUN apk add --no-cache musl libgcc libstdc++ gcompat
RUN wget -q https://vscode.download.prss.microsoft.com/dbazure/download/stable/17baf841131aa23349f217ca7c570c76ee87b957/vscode_cli_alpine_x64_cli.tar.gz \
    && tar -xzf vscode_cli_alpine_x64_cli.tar.gz \
    && mv code /usr/bin/ \
    && rm vscode_cli_alpine_x64_cli.tar.gz

# Development Dependencies
RUN apk add --no-cache coreutils findutils openssh-client curl git

EXPOSE 3000 53000 

USER ${USR}

CMD ["sh", "-c", "code serve-web --host 0.0.0.0 --port 53000 --accept-server-license-terms --without-connection-token --server-data-dir ${HOME}/${PROJECT}/.vscode/server"]


# TARGET: BUILD 
##################################################################
FROM base AS build

ENV NODE_ENV=development

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build


# TARGET: PRODUCTION 
##################################################################
FROM base AS production

ENV NODE_ENV=production
ENV DATABASE_URL=postgresql://user:pass@host:5432/mydb

COPY package*.json ./
RUN npm install

COPY --from=build /home/${USR}/project/dist ./dist
COPY --from=build /home/${USR}/project/public ./public

RUN chown -R ${UID}:${UID} /home/${USR}/project

EXPOSE 8000

USER ${USR}

CMD ["node", "dist/main.js"]