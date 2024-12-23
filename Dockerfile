# compile application
FROM node:23.5.0-alpine@sha256:c61b6b12a3c96373673cd52d7ecee2314e82bca5d541eecf0bc6aee870c8c6f7 AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:23.5.0-alpine@sha256:c61b6b12a3c96373673cd52d7ecee2314e82bca5d541eecf0bc6aee870c8c6f7 AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
