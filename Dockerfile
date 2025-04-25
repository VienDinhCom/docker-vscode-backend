FROM node:22-alpine AS base

ARG UID=1000
ARG GID=1000
ARG USR=backend

RUN apk add --no-cache shadow

# Nonroot User
RUN getent passwd ${UID} && userdel $(getent passwd ${UID} | cut -d: -f1)
RUN getent group ${GID} || groupadd --gid ${GID} ${USR}
# RUN useradd --uid ${UID} --gid ${GID} -m ${USR}

# WORKDIR /home/${USR}/project


# # TARGET: DEVELOPMENT
# ##################################################################
# FROM base AS development

# ENV NODE_ENV=development
# ENV DATABASE_URL=postgresql://user:pass@host:5432/mydb

# # Fish Shell
# RUN apk add fish
# RUN chsh -s $(which fish) ${USR}

# # SSH Server 
# RUN apk add openssh
# RUN ssh-keygen -A
# RUN passwd -d ${USR}
# RUN echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config

# # Dev Tools
# RUN apk add git

# EXPOSE 8000 22

# USER root

# CMD ["/usr/sbin/sshd", "-D"]


# # TARGET: BUILD 
# ##################################################################
# FROM base AS build

# ENV NODE_ENV=development

# COPY package*.json ./
# RUN npm install

# COPY . .

# RUN npm run build


# # TARGET: PRODUCTION 
# ##################################################################
# FROM base AS production

# ENV NODE_ENV=production
# ENV DATABASE_URL=postgresql://user:pass@host:5432/mydb

# COPY package*.json ./
# RUN npm install

# COPY --from=build /home/${USR}/project/dist ./dist
# COPY --from=build /home/${USR}/project/public ./public

# RUN chown -R ${UID}:${UID} /home/${USR}/project

# EXPOSE 8000

# USER ${USR}

# CMD ["node", "dist/main.js"]