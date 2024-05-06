# compile application
FROM node:22.1.0-alpine@sha256:487dc5d5122d578e13f2231aa4ac0f63068becd921099c4c677c850df93bede8 AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:22.1.0-alpine@sha256:487dc5d5122d578e13f2231aa4ac0f63068becd921099c4c677c850df93bede8 AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
