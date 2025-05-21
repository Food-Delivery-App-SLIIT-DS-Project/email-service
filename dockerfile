# ---------- development stage ---------------
FROM node:alpine AS development

WORKDIR /usr/src/app 

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npx prisma generate

RUN npm run build


# ---------- production stage ---------------
FROM node:alpine AS production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY proto ./proto

COPY --from=development /usr/src/app/dist ./dist
COPY --from=development /usr/src/app/prisma ./prisma 

# Optional: generate Prisma client again just to be safe
RUN npx prisma generate

EXPOSE 50055

CMD ["node", "dist/src/main"]

