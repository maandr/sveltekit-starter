# compile application
FROM node:23.2.0-alpine@sha256:5898cf83b437e8757d8790d9b1a70b798db83fd4c7a78a8f4053039c6c46c498 AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:23.2.0-alpine@sha256:5898cf83b437e8757d8790d9b1a70b798db83fd4c7a78a8f4053039c6c46c498 AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
