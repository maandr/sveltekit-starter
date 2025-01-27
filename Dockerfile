# compile application
FROM node:23.6.1-alpine@sha256:15b885c5e195296ba49bab32681b478e92eb0f255078a84ad29020b87b0bdcc6 AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:23.6.1-alpine@sha256:15b885c5e195296ba49bab32681b478e92eb0f255078a84ad29020b87b0bdcc6 AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
