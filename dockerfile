# ---------- development stage ---------------
FROM node:alpine AS development

WORKDIR usr/src/app

# Installion of dev dependencies
COPY package.json ./

COPY package-lock.json ./

RUN npm install

COPY . .

# Do the production build inside the base image
RUN npm run build

# ---------- production stage ---------------
FROM node:alpine AS production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR usr/src/app

COPY package.json ./

COPY package-lock.json ./

COPY proto ./proto

RUN npm install

COPY --from=development /usr/src/app/dist ./dist

EXPOSE 50058

CMD ["node", "dist/main"]

