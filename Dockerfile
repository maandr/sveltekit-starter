# compile application
FROM node:23.4.0-alpine@sha256:d319827b3b99cca0153f6049fb584a5a4a0ae49252b6dda2314ef564f9857cf2 AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:23.4.0-alpine@sha256:d319827b3b99cca0153f6049fb584a5a4a0ae49252b6dda2314ef564f9857cf2 AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
