# compile application
FROM node:23.8.0-alpine@sha256:0a29d8a047149079bf48dab598f287815e39867d547e8f3935cfdece0a4379cc AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:23.8.0-alpine@sha256:0a29d8a047149079bf48dab598f287815e39867d547e8f3935cfdece0a4379cc AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
